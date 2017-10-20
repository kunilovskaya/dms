# python2
# coding: utf-8
# calculate frequencies of individual items from prof tmx (filenames come from prop!)
# and calculate translationally distictive items from comparison with the nfreqs from the reference corpus(arg4)
# (based on wilkoxon ranksum test)


from __future__ import division
import sys,codecs,os
import numpy as np
import scipy.stats as stats
import re
from xml.dom import minidom
import csv

arg1 = '/home/masha/birmingham/data/EM_profmedia.tmx' #sys.argv[1]
arg2 = '/home/masha/birmingham/searchlists/en_EMs.ls' #sys.argv[2] # separate lists for each lang to avoid looping over lang on top of all else
arg3 = '/home/masha/birmingham/searchlists/ru_EMs.ls' #sys.argv[2]
arg4 = '/home/masha/birmingham/data/rnc/EM' #reference corpus for wilk ranksum

doc = minidom.parse(arg1)
tus = doc.getElementsByTagName("tu") #возвращает список tu (элемента, содержащего tuvs)

# loop over all tuvs in tus to create a list of keys (=fn) in the statistics and restore_text dics; these dics have lists of values for each key
errors = 0

restore_texts = {}

for tu in tus:
    props = tu.getElementsByTagName("prop")
    if len(props)==0:
        errors +=1
        continue
    prop0 = props[0]
    fn = prop0.childNodes[-1].data #fnpair in prop
    try:
	fnpair = fn.split('-')
    except: 
	continue
   
    en_fn = fnpair[0].strip()
    ru_fn = fnpair[1].strip()
    
    if not en_fn in restore_texts:
	restore_texts[en_fn] = []
    if not ru_fn in restore_texts:
	restore_texts[ru_fn] = []
	
	
    tuvs = tu.getElementsByTagName("tuv")  
    
    for tuv in tuvs:	
	seg = tuv.getElementsByTagName("seg")
	if len(seg)==0:
	    continue
		
	seg0 = seg[0]
	if len(seg0.childNodes) == 0:
	    continue
	text = seg0.childNodes[-1].data
	text = text.strip()
	
	lang = tuv.getAttributeNode('xml:lang').nodeValue
	if lang == 'EN':	
	    restore_texts[en_fn].append(text)
	if lang == 'RU':	
	    restore_texts[ru_fn].append(text)	
statistics = {fn :{} for fn in restore_texts.keys()}

# produce number of sentences for each file, which can be accessed as restore_segs[fn]

for fn, segs in restore_texts.items():
    num_SENTs = 0
    for seg in segs: #this replace obviously did not work
        SENTs = seg.count('_SENT_')
        num_SENTs += SENTs
    #print fn, '\t', num_SENTs
    statistics[fn]['SENTs'] = num_SENTs


# count freqs of tagged items - CONNs and EMs, 
# calculate their normalized freqs using stats from statistics and append

en_queries = set([item.strip() for item in codecs.open(arg2, 'r', 'utf-8').readlines()])
ru_queries = set([item.strip() for item in codecs.open(arg3, 'r', 'utf-8').readlines()])
print 'Number of search items: ', 'EN: ', len(en_queries), 'RU: ',len(ru_queries),'\n'

en_total_hits = {item : [] for item in en_queries}
en_nfreqs = {item : [] for item in en_queries}

for item in en_queries:
#     count_item = 0 # counter for freq of all items in this fn
    for fn, segs in restore_texts.items(): # segs is a list
        string = " ".join(seg for seg in segs) #convert list of segs to a string to avoid yet another loop
        '''
        Despite "The method count() returns count of how many times obj occurs in list," 
        count() does not work with seg list!
        !!!why does it skip the first list element? (EAEM_becertain) Works if the list starts with a blank line
        '''
        hits = string.count(item) # why did I have .find() here?!! 
        en_total_hits[item].append(hits)
        en_nfreqs[item].append(hits/statistics[fn]['SENTs']*100) # list of normalized freq for each text
    #print item.encode('utf-8'), sum(en_total_hits[item])

print 'Number of fns', len(en_nfreqs[item]),'\n' # number of files is twice as big as necessary, because the list includes both sources and targets!

ru_total_hits = {item : [] for item in ru_queries}
ru_nfreqs = {item : [] for item in ru_queries}
for item in ru_queries:
#     count_item = 0 # counter for freq of all items in this fn
    for fn, segs in restore_texts.items(): # segs is a list
        string = " ".join(seg for seg in segs) #convert list of segs to a string to avoid yet another loop
        hits = string.count(item) # why did I have .find() here?!! 
        ru_total_hits[item].append(hits)
        ru_nfreqs[item].append(hits/statistics[fn]['SENTs']*100) # list of normalized freq for each text
    #print item.encode('utf-8'), sum(ru_total_hits[item])

'''
read and calculate ref data to detect translationally distictive items thru wilk ranksum comparison with reference
'''
ref_nfreqs = {item :[] for item in ru_queries}#список частот в текстах корпуса2
ref_files = [f for f in os.listdir(arg4) if f.endswith('.em')] #ADJUST!!!
count = 0
hits = {item :[] for item in ru_queries}

for f in ref_files:
    text = codecs.open(arg4+'/'+f,'r','utf-8').read()
    txt = codecs.open(arg4+'/'+f,'r','utf-8').readlines()
    sents = len(txt)
    #print sents
    count +=1
    for item in ru_queries:
        hits[item].append(text.count(item))
        ref_nfreq = text.count(item)/len(txt)*100#normalized to no. of sents
        ref_nfreqs[item].append(ref_nfreq)

'''
print contrastive results for tmx
'''

print 'lemma', '\t', 'test_total', '\t', 'ref_av_nfreq*100', '\t', 'ref_total', '\t','ref_av_nfreq', '\t', 'wilk_p', '\t', 'res'
for item in ru_queries:
    ru_total = sum(ru_total_hits[item])
    ru_av_nfreq = round(np.mean(ru_nfreqs[item])*2,3) # mean normalized frequency of the item over all texts (*2 accounts for bi-lingual char of the format)
    
    '''
    detect translationally distictive items thru wilk ranksum comparison with reference
    '''
    
    res = None
    ref_total = sum(hits[item])
    ref_av_nfreq = round(np.mean(ref_nfreqs[item]), 3)   
    p = stats.ranksums(ru_nfreqs[item], ref_nfreqs[item])[1] 
    if ru_av_nfreq > ref_av_nfreq:
        res = '+'
    
        print item.encode('utf-8'), '\t', ru_total, '\t', ru_av_nfreq, '\t', ref_total, '\t', ref_av_nfreq, '\t', p,'\t',res
    else:
        res = '-'    
        print item.encode('utf-8'), '\t', ru_total, '\t', ru_av_nfreq, '\t', ref_total, '\t', ref_av_nfreq, '\t', p,'\t',res

print '\n'
for item in en_queries:
    en_total = sum(en_total_hits[item])
    en_av_nfreq = round(np.mean(en_nfreqs[item])*2,3) # mean normalized frequency of the item over all texts (*2 accounts for bi-lingual char of the format)
    print item.encode('utf-8'), '\t', en_total, '\t', en_av_nfreq

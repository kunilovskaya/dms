#!/usr/bin/python2
# coding: utf-8
# этот скрипт - для стандартных TMX с профессиональными переводами (для учебных переводов другой скрипт, определяющий файл источник по данным в атрибуте filesource, поскольку prop в rusltc ненадежны из-за множественности)
# извлекаем из tmx частотность размеченных единиц (СONN, EM) по списку, считаем количество предложений=сегментов в tmx на этом языке для расчета нормализованной частоты; в общем проверяем насколько данные в tmx воспроизводят количественные характеристики txt-архива. 
#pulls out text-identifying filenames from prop tag (!!) for each tu, extracts and collects of text-strings belonging to one text (from segs), counts number of sents + item counts per text
# modified Sept 19, 2017
#DIRTY BUT WORKING Oct 04, 2017

from __future__ import division
import sys, codecs
import re
from xml.dom import minidom
import numpy as np
import scipy.stats as stats
 
arg1 = '/home/masha/birmingham/data/CONN_profmedia.tmx' #sys.argv[1]
arg2 = '/home/masha/birmingham/searchlists/bi-ling_CONNs.ls' #sys.argv[2]#список поисковых запросов

queries = codecs.open(arg2, 'r', 'utf-8').readlines()
doc = minidom.parse(arg1)

alltuvs = {}
tus = doc.getElementsByTagName("tu") #возвращает список tu (элемента, содержащего анализируемые prop)

def en_list_fntuvs(doc): #возвращает дедуплицированный список имен файлов из проп
	en_fnlst = []
	errors = 0
	for tu in tus:
		props = tu.getElementsByTagName("prop")
				
		#нет prop
		if len(props)==0:
			errors +=1
			continue
				
		prop0 = props[0]
		#print prop0
		fn = prop0.childNodes[-1].data #fnpair in prop
		#print fn, errors
				
		try:
			fn = fn.split('-')
		except: 
			continue
		en_fn = fn[0]
		#print en_fn

		en_fnlst.append(en_fn)

	en_fnlst = set(en_fnlst) #deduplicate
	#print len(en_fnlst)
	return en_fnlst # a list of 200 names

def ru_list_fntuvs(doc): #возвращает дедуплицированный список имен переводов
	ru_fnlst = []
	errors = 0
	for tu in tus:
		props = tu.getElementsByTagName("prop")
		
		#нет prop
		if len(props)==0:
			errors +=1
			continue
				
		prop0 = props[0]
		fn = prop0.childNodes[-1].data #имя файла в prop в структуре обрабатываемого tu
		
		try:
			fn = fn.split('-')
		except: 
			continue

		ru_fn = fn[1]
		#print fn
		ru_fnlst.append(ru_fn)#создает список имен исходных файлов из prop каждого tu (если есть), его надо дедуплицировать
	ru_fnlst = set(ru_fnlst)
	return ru_fnlst # a list of 200 names

def pulldoms_by_lang(lst, lang, alltuvs):
	for tu in tus:				
		props = tu.getElementsByTagName("prop")
		if len(props)==0:
			continue
					
		prop0 = props[0]
	
		fnpair = prop0.childNodes[-1].data
		fnpair = fnpair.strip()
		for fn_short in lst:
			if fn_short in fnpair:
				#print fn
				tuvs = tu.getElementsByTagName("tuv")
				for tuv in tuvs:
					languag = tuv.getAttributeNode('xml:lang').nodeValue
					if languag == lang:
						#print lang
						alltuvs[fn_short].append(tuv)
					else: continue
	#print len(alltuvs[fn_short])						
	return alltuvs #словарь с именами файлов (ключи) и списком tuv (value)
				
def extract_text(tuv):
		
	segs = tuv.getElementsByTagName("seg")

	if len(segs)==0:
		return None
		
	seg0 = segs[0]
	if len(seg0.childNodes) == 0:
		return None #None # I don't understand why sometimes continue is ok and sometimes itis not, I don't understand this None-proxy
		
	text = seg0.childNodes[-1].data
	#print text
	return text			

def dom2txt(fn, dic): 
		
	fntuvs = dic[fn] # this is a list of dom for each fn
	texts = {fn:[]}
	fn_totSENTs = 0
	tokens = 0
	
	
	for fntuv in fntuvs:
		
		fntuv = extract_text(fntuv)#this is content of each seg from tuvs on the list for each fn
		#print fntuv.encode('utf-8')
		#print type(fntuv)
		if fntuv == None:
			print >> sys.stderr, fn
			continue
		fn_totSENTs += fntuv.count('_SENT_')
		tokens += len(fntuv.split())
		texts[fn].append(fntuv)
				
	return texts, fn_totSENTs, tokens	# this contains a DIC which has fn as keys and lists of textedsents as values

def count_sents(fn, dic): #see ru_pickled_sents.py 

	countSENTs = 0
	count_under4 = 0
	allsents = dic[fn]# this is a list of all sentences attributed to one fn
	for text in allsents:
		#print text
			
		if text == None:
			count_under4 +=1
			continue
		if len(text.split())<= 3:
			count_under4 +=1
			#print >> sys.stderr, text #>> sys.stderr,
			continue					
					
		SENTs= text.count('_SENT_') #it should return exactly 1 because text is a list of SENTENCES already after split
			
		countSENTs = countSENTs + SENTs	
		#print countSENTs
	return old_countSENTs, count_under4 

def extract_each_item(fn, texted):
	count_item = 0
	allsents = texted[fn]
	for text in allsents:
	
		#print text,'\n'
		#text = text.split()
		for item in queries:
			item=item.strip()
			#print item
			freq = text.find(item)
				
			if -1==freq: # if conn is nothing
				continue
			else: 
				#print fn, item
				count_item +=1
	return count_item

	
#print 'running my functions'
ens = en_list_fntuvs(doc)
en_alltuvs = {fn_short.strip(): [] for fn_short in ens}
en_alldoms = pulldoms_by_lang(ens, "EN", en_alltuvs)

rus = ru_list_fntuvs(doc)
ru_alltuvs = {fn_short.strip(): [] for fn_short in rus}
ru_alldoms = pulldoms_by_lang(rus, "RU", ru_alltuvs)

print 'filename', '\t', 'tuvs', '\t', 'SENTs', '\t', 'wc',  '\t', 'ITEMs', '\t', 'normed_freq', '\n' #,'\t', 'under4', '\n'
count_totenitems = 0
count_totruitems = 0
en_size = 0
ru_size = 0
en_totsents = 0
ru_totsents = 0
tot_en_nfreq = []
tot_ru_nfreq = []

for en in ens:
		
	en_alltuvs_texted, en_sents, en_tokens = dom2txt(en, en_alldoms)
	#print type(en_alltuvs_texted)
	#old_en_sents, under4 = count_sents(en, en_alltuvs_texted)
	en_items = extract_each_item(en, en_alltuvs_texted)
	count_totenitems = count_totenitems + en_items
	en_size += en_tokens
	en_totsents += en_sents
	en_nfreq = en_items/en_sents*100
	tot_en_nfreq.append(en_nfreq)
	
	print en, '\t', len(en_alldoms[en]), '\t', en_sents, '\t',en_tokens,  '\t',en_items, '\t', en_nfreq, '\n' #	under4

for ru in rus:
	ru_alltuvs_texted, ru_sents, ru_tokens = dom2txt(ru, ru_alldoms)		
	#old_ru_sents, under4 = count_sents(ru, ru_alltuvs_texted)
	ru_items = extract_each_item(ru, ru_alltuvs_texted)
	count_totruitems = count_totruitems + ru_items
	ru_size += ru_tokens
	ru_totsents += ru_sents
	ru_nfreq = ru_items/ru_sents*100
	tot_ru_nfreq.append(ru_nfreq)
	
	print ru, '\t', len(ru_alldoms[ru]), '\t', ru_sents, '\t', ru_tokens,  '\t', ru_items, '\t', ru_nfreq, '\n' # under4

print '\t', 'Sources: ', '\t', 'profTargets: '
print 'Corpus size (', arg1.split('/')[-1], ')', '\t', en_size, '\t', ru_size
print 'Number of all hits: ', '\t', count_totenitems, '\t', count_totruitems
print 'No. of sents: ', '\t', en_totsents, '\t', ru_totsents
print 'Mean for normalized freqs: ', '\t', np.mean(tot_en_nfreq), '\t', np.mean(tot_ru_nfreq)
print 'Standard deviation for normalized freqs: ', '\t', np.std(tot_en_nfreq), '\t', np.std(tot_ru_nfreq)
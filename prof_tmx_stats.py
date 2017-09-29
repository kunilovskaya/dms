#!/usr/bin/python
# coding: utf-8
# извлекаем из tmx частотность размеченных единиц (СONN, EM) по списку, считаем количество предложений=сегментов в tmx на этом языке для расчета нормализованной частоты; в общем проверяем насколько данные в tmx воспроизводят количественные характеристики txt-архива. 
#pulls out text-identifying filenames from Filesource attribute (!!) for each lang, extracts and collects of text-strings belonging to one text (from segs), counts number of sents + item counts per text
# modified Sept 19, 2017

import sys
import re
from xml.dom import minidom

import sys, codecs
from xml.dom import minidom

import numpy as np
import scipy.stats as stats
# проверяем число имен файлов в profTMX (для учебных переводов другой скрипт, определяющий файл источник по данным в атрибуте filesource, поскольку prop в rusltc ненадежны из-за множественности) и сколько в каждом файле текстовых сегментов (для того, чтоб посчитать колво-предложений надо тегировать корпус и считать SENT)
#<tu creationdate="20170310T003108Z" creationid="y"><prop type="Txt::Note">en_010-ru_010</prop>
#<tuv xml:lang="EN"><seg>I_PP_I started_VBD_start launching_VBG_launch businesses_NNS_business at_IN_at a_DT_a very_RB_very young_JJ_young age_NN_age (_(_( I_PP_I 'm_VBP_be 25_RB_@card@ now_RB_now )_)_) ._SENT_.
#</seg></tuv>
#<tuv xml:lang="RU"><seg>Я_P-1-snn_я занимаюсь_Vmip1s-m-e_заниматься бизнесом_Ncmsin_бизнес с_Sp-g_с очень_R_очень раннего_Afpmsgf_ранний возраста_Ncmsgn_возраст (_-_( сейчас_P-----r_сейчас мне_P-1-sdn_я 25_Mc---d_25 лет_Ncmpgn_год )_-_) ._SENT_.
#</seg></tuv> </tu>

arg1 = '/home/masha/birmingham/data/profEM_tagged.tmx' #sys.argv[1]#test_uniqConn.tagged.tmx /home/masha/birmingham/data/new2_uniq240mass-media.tmx
arg2 = '/home/masha/birmingham/bi-ling_EMs.ls' #sys.argv[2]#список поисковых запросов
#arg3 = '/home/masha/birmingham/data/description/all_uniq_fnpairs.txt' #list of content in <prop type="Txt::Note">EN_1_265-RU_1_265_1</prop> #that caused errors because props contained pairs EN_1_265.txt-RU_1_265_2.txt (mind the last number!!!)

queries = codecs.open(arg2, 'r', 'utf-8').readlines()
doc = minidom.parse(arg1)

alltuvs = {}
tus = doc.getElementsByTagName("tu") #возвращает список tu (элемента, содержащего анализируемые prop)

def en_list_fntuvs(doc): #возвращает дедуплицированный список имен файлов 
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
	return alltuvs
				
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
	size = []
	
	for fntuv in fntuvs:
		fntuv = extract_text(fntuv)#this produces a list of sents in a seg
		if fntuv == None:
			continue
		fntuv = fntuv.replace('?_SENT_?', '._SENT_. SPLIT')
		fntuv = fntuv.replace('!_SENT_!', '._SENT_. SPLIT')
		fntuv = fntuv.replace('._SENT_.', '._SENT_. SPLIT')
		fntuv = fntuv.split('SPLIT')
		
		for sent in fntuv:
			sent_size = len(sent.split())
			if sent_size == 0:
				continue
			texts[fn].append(sent) # creates a list of all text strings which equal to a SENT
			
			size.append(sent_size)
	filesize = sum(size)
	#print filesize
				
	return texts, filesize	# this contains a DIC which has fn as keys and lists of textedsents as values



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
					
		SENTs= text.count('._SENT_.')
			
		countSENTs = countSENTs + SENTs	
		#print countSENTs
	return countSENTs, count_under4 

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

print 'filename', '\t', 'tokens', '\t', 'SENTs', '\t', 'ITEMs','\t', 'under4', '\n'
count_totenitems = 0
count_totruitems = 0
for en in ens:
		
	en_alltuvs_texted, en_tokens = dom2txt(en, en_alldoms)
	#print type(en_alltuvs_texted)
	en_sents, under4 = count_sents(en, en_alltuvs_texted)
	en_items = extract_each_item(en, en_alltuvs_texted)
	count_totenitems = count_totenitems + en_items
	print en, '\t',en_tokens, '\t', en_sents, '\t',en_items, '\t', 	under4
print '\t','\t','\t',count_totenitems, '\n'
for ru in rus:
	ru_alltuvs_texted, ru_tokens = dom2txt(ru, ru_alldoms)		
	ru_sents, under4 = count_sents(ru, ru_alltuvs_texted)
	ru_items = extract_each_item(ru, ru_alltuvs_texted)
	count_totruitems = count_totruitems + ru_items
	print ru, '\t', ru_tokens, '\t', ru_sents, '\t', ru_items, '\t', under4
print '\t','\t','\t',count_totruitems, '\n'

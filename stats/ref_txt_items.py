#!/bin/python
# coding: utf-8
#this is the third attempt to find a fair way to represent statistics for connectives. They are all non-normally distributed, in texts of different sizes
# usage: masha@MAK:~/birmingham/data/rnc/EM$ python ~/py/range_CONN_freqs.py ~/birmingham/searchlists/ru_EMs.ls ./ > ~/birmingham/stats/itemEM_rnc.tsv


from __future__ import division #по умолчанию при делении 2/345 выдаем нецелые числа (хотя для этого есть float())
import sys,codecs,os
import numpy as np
import scipy.stats as stats
import math


argument1 = '/home/masha/birmingham/searchlists/ru_EMs.ls' #sys.argv[1]#list of search terms # /home/masha/valencia/ru_CONNs.ls
argument2 = '/home/masha/birmingham/data/rnc/EM' #sys.argv[2]#corpus #'/home/masha/valencia/pop/ref/EM/4SENT/'

CONN = set([w.strip() for w in codecs.open(argument1,'r','utf-8').readlines()])

afreq_dict = {word:[] for word in CONN}
nfreq_dict = {word:[] for word in CONN}

files_corpus1 = [f for f in os.listdir(argument2) if f.endswith('.em')]
corp_size = 0
count = 0
allsents = 0

for f in files_corpus1:
    text = codecs.open(argument2+'/'+f,'r','utf-8').read()
    corp_size = corp_size + len(text.split())
    txt = codecs.open(argument2+'/'+f,'r','utf-8').readlines()
    sents = len(txt)
    allsents = allsents+sents #total sentences in corpus
    #print sents
    count +=1
    for word in CONN:
        afreq = text.count(word)
        nfreq = float(text.count(word)/len(txt)*100)#normalized to no. of sents
        afreq_dict[word].append(afreq)
        nfreq_dict[word].append(nfreq)

print 'EM_lemma\t total\t crude ips \t average/oversents\t range\n'
allhits = 0
allnormfreqs = 0 
for word in CONN:
#aaverage не имеет смысла для корпусов, в которых длина текста существенно варьирует
    total = sum(afreq_dict[word])
    aaverage = float("{0:.5f}".format(np.mean(afreq_dict[word])))
    naverage = round(np.mean(nfreq_dict[word]),8)#дак и это среднее не имеет смысла, поскольку длина текстов разная!!! потому и получается, что в BNC, где в один контейнер упакована куча мелких текстов низкая частотность, нет? сумма этих частот теоретически должна дать среднюю частоту коннектроров в корпусе, совпадающую с той, что мы рассчитываем на документ в coh скриптах
    allnormfreqs +=naverage
    allhits +=total
    coverage =0
    for v in afreq_dict[word]:
        if v > 0:
            coverage +=1 
    intext = coverage/count*100
    ips = sum(afreq_dict[word])/allsents*100

    print word.encode('utf-8')+'\t', total,'\t', ips, '\t', naverage,'\t',intext
print argument2, 'Corpus size is ','\t', corp_size
print 'Number of texts: ','\t', count
#if p-value is >0.05 all the research can say is 'I cannot reject the hypothesis that the sample comes from a population which has a normal distribution", not "it is normaly distributed". Make QQplots to visually estimate the sample. 
# при открытии документов в кальк там обнаруживается какой-то апостроф, который не дает складывать цифры! Поэтому печатаю sum of absolute freqs(hits) и sum of normalizes freqs per conn here:
    

print >> sys.stderr, 'Total hits for all listitems: ','\t', allhits

print >> sys.stderr, 'Sum of all normalized freqs of listitems: ','\t', allnormfreqs

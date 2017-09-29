#!/usr/bin/python
# coding: utf-8
'''
get rid of unwanted/unlisted files, using files_sources.txt, which has a list of filenames like EN_6_3
produces multiple translations tmx
'''


import sys, codecs
from xml.dom import minidom


arg1 = sys.argv[1] #rltc.tmx
arg2 = sys.argv[2] #список искомых файлов massmedia_bham_sources.txt (files_sources.txt)


doc = minidom.parse(arg1)
tus = doc.getElementsByTagName("tu") #возвращает список tu (элемента, содержащего анализируемые prop)

def get_fn(tu):
    """
    возвращает текст prop-элемента
    """
    props = tu.getElementsByTagName("prop")

    #нет prop
    if len(props)==0:
        return None

    prop0 = props[0]
    fn = prop0.childNodes[-1].data # -1 is reference to last element of the list [n-1]

    return fn # имя файла в prop в структуре обрабатываемого tu

list = [w.strip() for w in codecs.open(arg2,'r','utf-8').readlines()]
bad = []
count = 0
for tu in tus:
    try:
        fn = get_fn(tu).split('-')
    except: 
        continue
    fn = fn[0]
   
    if fn not in list:
        count = count + 1#печатаем в stdout имена
        print fn.encode('utf8')
        tu.parentNode.removeChild(tu)
print count#и количество исключенных файлов
ofile = codecs.open('customRusLTC.tmx','wb','utf8')#the resulting cleaned (customized) tmx is in the argv folder
ofile.write(doc.toxml())

ofile.close()



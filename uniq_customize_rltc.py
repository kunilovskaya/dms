# limit rltc.tmx to segments from specified files 
# and to only one translation from the first (ex. RU_1_34_1.txt) translation file
# rltc.tmx has sentences from other files. An input <tu> can contain more that one translation.
# the filenames should be extracted from <tuv filesource="EN_6_3.head.txt", not <prop> 

# Sept 24, 2017 this is a working version
# this is a copy of the jupyter notebook uniq_customize.ipynb

import sys, codecs
from xml.dom import minidom

arg1 = sys.argv[1] #'/home/masha/birmingham/data/rltc.tmx' 
arg2 = sys.argv[2] #'/home/masha/birmingham/data/heads_massmedia_rltc.txt' of type EN_1_88.head.txt-RU_1_88_1.head.txt

# produce a list of tus
doc = minidom.parse(arg1)
body = doc.childNodes[1].childNodes[3] # equals body = doc.getElementsByTagName("body")[0]


# make a list of fnpairs of type EN_6_3.head.txt-RU_6_3_1.head.txt
list = [w.strip() for w in codecs.open(arg2,'r','utf-8').readlines()]

# produce separate lists of fns for sources and targets to test tuvs' filesources
source_fn = []
target_fn = []
for i in list:
    fns = i.split('-')
    source_fn.append(fns[0])
    target_fn.append(fns[1])
#print 'The first three source filenames are: ', source_fn[0:3]
#print 'Their pairs from the list : ', target_fn[:3]

# remove whole tus if the filename in tuv with Source attribute is not on the list of allowed sources
non_list = 0
empty = 0
tus = body.getElementsByTagName("tu")
print len(tus)
for tu in tus:
    #print type(tu.parentNode)
    tuvs = tu.getElementsByTagName("tuv")
    for tuv in tuvs:
        
        tuv_type = tuv.getAttribute('type') # this works around empty attuibutes (type="")
        if tuv_type == 'Source':
            fls = tuv.getAttribute('filesource')
        # this does the matching with the lists and prints only one translation for sources on the list
            if fls.strip() in source_fn: # occasionally says NameError: name 'fls' is not defined
                continue
            else:
                #print 'Non-list items:', fls
                non_list +=1
                tu.parentNode.removeChild(tu)
        break

print 'We have dealt with ', non_list, 'unmatching source filenames, but not empty types'    

# get and remove Translations from files NOT on the list of targets wanted
unwanted_targets = 0
tus = body.getElementsByTagName("tu")
print len(tus)
for tu in tus:
    tuvs = tu.getElementsByTagName("tuv")
    for tuv in tuvs:
        tuv_type = tuv.getAttribute('type')
        if tuv_type == 'Source':
            continue
        elif tuv_type == 'Translation':
            trt_fls = tuv.getAttribute('filesource')
        # this does the matching with the lists and prints on-list translation for sources on the list 
        # sometimes more than one _1 is found!! sometimes none is found!
            if trt_fls.strip() in target_fn:
                #print 'List items:', trt_fls
                continue
        # this removes translations from non _1 target files
            else:
                #print 'Non-list items:', trt_fls
                unwanted_targets +=1
                this_tu = tuv.parentNode
                this_tu.removeChild(tuv)
                
        else:
            empty +=1
            if tu.parentNode is not None:
                tu.parentNode.removeChild(tu)
            else: # this is done to identify the problematic point in TMX in the absence of filesource metadata
                props = tu.getElementsByTagName("prop")
                if len(props)>0:
                    prop0 = props[0]
                    if len(prop0.childNodes)>0:
                        fn = prop0.childNodes[-1].data
                        # print fn
        
print 'TMX has ', non_list, 'tus from non-list sources and ', empty, 'cases of empty type (all deleted)'   
print 'There are ', unwanted_targets, 'unwanted targets'


# get rid of erroneous extra _1.head.txt in one tu and other non _1 translations
del_over2 = 0
tus = body.getElementsByTagName("tu")
print len(tus)
for tu in tus:
    tuvs = tu.getElementsByTagName("tuv")
    for tuv in tuvs:
        tuv_type = tuv.getAttribute('type') 
        if tuv_type == 'Source':
            src_fls = tuv.getAttribute('filesource')
            #print src_fls
        if tuv_type == 'Translation':
            trt_fls = tuv.getAttribute('filesource')
            #print trt_fls
            
            if src_fls.lstrip('EN').rstrip('.head.txt') != trt_fls.lstrip('RU').rstrip('_1.head.txt'):
                #print src_fls.lstrip('EN').rstrip('.head.txt'), '\t', trt_fls.lstrip('RU').rstrip('_1.head.txt')
                del_over2 += 1
                tuv.parentNode.removeChild(tuv)
            
print del_over2

# get rid of the special cases remaining when one tu has more than one translation from the same file (how is it even possible in rltc.tmx?)
more_del_over2 = 0
tus = body.getElementsByTagName("tu")
for tu in tus:
    tuvs = tu.getElementsByTagName("tuv")
    n = len(tuvs)
    for k in reversed(range(2,n)): # loop thru el backwards; otherwise on has to do with changed index
        el = tuvs[k]
        tu.removeChild(el)
        more_del_over2 += 1

print more_del_over2

# get rid of tus with < 2 tuvs
del_under2 = 0
tus = body.getElementsByTagName("tu")
for tu in tus:
    tuvs = tu.getElementsByTagName("tuv")
    if len(tuvs) >= 2:
        continue
    else:
        del_under2 += 1
        tu.parentNode.removeChild(tu)
print del_under2



# print the resulting body to a new file
ofile = codecs.open('/home/masha/birmingham/data/fin_filtered_rltc.tmx','wb','utf8')#the resulting cleaned (customized) tmx is in the argv folder
ofile.write(doc.toxml())
ofile.close()
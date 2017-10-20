import sys,codecs,os
from xml.dom import minidom

'''
ATTENTION! to run this sctip 1) put the tmx-to-be-tagged into this TreeTagger folder 2) change names of input and output as well as names of shell scripts to glue CONN or EM
it can be useful to check permissions of the shell scripts, too
'''
#adds standard pos tags to en and ru segs in a tmx and re-difines tags for connectives on the basis of a shell script

tmp_in = 'temp/tf_in.txt.split'
tmp_out_en = 'temp/tf_in.txt.split.tags'
tmp_out_ru = 'temp/tf_in.txt.split.tags.known'

xml_fname = 'my_uniq200.tmx'#input file 5pop-sci1-14_ku.tmx
xml_fname_out = 'temp/en.tmx.tagged'
xml_fname_out2 = 'temp/CONN_my_uniq200.tmx' #CONN_my_uniq200


def write_tmp(s):
    f=codecs.open(tmp_in,"w","utf-8")
    f.write(s)
    f.close()
    
def read_tmp_en():
    f=codecs.open(tmp_out_en,"r","utf-8")
    s = f.read()
    f.close()
    return s

def read_tmp_ru():
    f=codecs.open(tmp_out_ru,"r","utf-8")
    s = f.read()
    f.close()
    return s

def exec_tmp_en():
    os.chdir('temp')
    #cmd = 'echo sdf > {0}'.format(tmp_out)
    cmd = '../new_en_2ttagged_tmx.sh'
    os.system(cmd)
    cmd = '../en_CONNglue.sh'
    os.system(cmd)    
    os.chdir('../')
def exec_tmp_ru():
    os.chdir('temp')
    cmd = '../new_ru_2ttagged_tmx.sh'
    os.system(cmd)
    cmd = '../ru_CONNglue.sh'
    os.system(cmd) 
    os.chdir('../')
def process_str(s, lang):
    write_tmp(s)
    
    if lang == 'EN':    
        exec_tmp_en()
        s2 = read_tmp_en()
        return s2        
    elif lang == 'RU':
        exec_tmp_ru()    
        s2 = read_tmp_ru()
        return s2               
    
    return ''


def process_tmx(fname_in, fname_out, slang):
    doc = minidom.parse(fname_in)
    #punct =('.', '!', '?') # preprocessing is done at in the tagging script now
    node = doc.documentElement
    translation_units = doc.getElementsByTagName("tu")
    
    for tu in translation_units:
        tuvs = tu.getElementsByTagName("tuv")
        segments = []
        for tuv in tuvs:
            
            segs = tuv.getElementsByTagName('seg')
            if len(segs)==0:
                continue
            
            seg0 = segs[0]
            
            if len(seg0.childNodes)==0:
                continue
            
            text = seg0.childNodes[-1].data
	    
	    #if not text.endswith(punct): # preprocessing is done at in the tagging script now
		#text = text+'.'
            lang = tuv.getAttributeNode('xml:lang').nodeValue
            #st = tuv.getAttributeNode('type').nodeValue    
     
            if lang != slang:#not in ['EN', 'RU']:
                continue
            
            text_tagged = process_str(text, lang)
            
            seg0.childNodes[-1].data = text_tagged
            
            print(text_tagged)
            
            
    doc.writexml( codecs.open(fname_out,"w","utf-8") )

process_tmx(xml_fname,xml_fname_out,'EN')
process_tmx(xml_fname_out,xml_fname_out2,'RU')

#sout = process_str(sss, 'EN')
#print(sout)


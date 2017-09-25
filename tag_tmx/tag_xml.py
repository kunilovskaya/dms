import sys,codecs,os
from xml.dom import minidom
import time
#adds standard pos tags to en and ru segs in a tmx and re-difines tags for connectives on the basis of a shell script
#create temp dir
tmp_in = '/home/masha/temp/tf_in.txt.split'
tmp_out_en = '/home/masha/temp/tf_in.txt.split.tags'
tmp_out_ru = '/home/masha/temp/tf_in.txt.split.tags.known'

xml_fname = '/home/masha/birmingham/data/fin_filtered_rltc.tmx'#input file 
xml_fname_out = '/home/masha/temp/en.tmx.tagged'
xml_fname_out2 = '/home/masha/temp/my_uniqCONN.tagged.tmx' # don't forget to adjust glue scripts!

start_time = time.time()

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
    os.chdir('/home/masha/temp/')
    #cmd = 'echo sdf > {0}'.format(tmp_out)
    cmd = '/home/masha/py/tag_tmx/en_2ttagged.sh'
    os.system(cmd)
    cmd = '/home/masha/py/tag_tmx/en_CONNglue.sh'
    os.system(cmd)    

def exec_tmp_ru():
    os.chdir('/home/masha/temp/')
    #cmd = 'echo sdf > {0}'.format(tmp_out)
    cmd = '/home/masha/py/tag_tmx/ru_2ttagged.sh'
    os.system(cmd)
    cmd = '/home/masha/py/tag_tmx/ru_CONNglue.sh'
    os.system(cmd) 
    
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
print("%f seconds" % (time.time() - start_time))
print("DONE")
#sout = process_str(sss, 'EN')
#print(sout)


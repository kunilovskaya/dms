#!/bin/sh
#вариант скрипта для потока операций по POS разметке, адаптированный для разметки tmx (July 07, 2017)

sed -i -re 's/”//g' *.split

for i in *.split
    do
	echo $i
	sh /home/masha/TreeTagger/cmd/tree-tagger-english < $i >$i.tags
done
#if you want to represent texts as sequences of lemmas of pos-tags stop here
#for English pipeline the cst-lemma step is skipped; tree-tagger-english is set to return -no-unknown 
#transform to hashed format
sed -i -e 's/\t/_/g' *.tags
sed -i -E ':a;N;/SENT_./!ba;s/\n/ /g' *.tags #заменяет новую строку после каждого слова в формате TreeTagger на пробел, увы, в том числе после SENT_. (упоминание этого выражения в команде является исключением для последнего предложения в тексте - не удалять новую строку в конце документа. Поэтому нужна команда, которая восстановит членение на предложения (см. ниже)

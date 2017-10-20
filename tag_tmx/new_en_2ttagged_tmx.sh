#!/bin/sh
#вариант скрипта для потока операций по POS разметке, адаптированный для разметки tmx (July 07, 2017)
# preprocess English
sed -i -E  "s/don\'t/do not/g" *.split
sed -i -E  "s/isn\'t/is not/g" *.split
sed -i -E  "s/aren\'t/are not/g" *.split
sed -i -E  "s/didn\'t/did not/g" *.split
sed -i -E  "s/hasn\'t/has not/g" *.split
sed -i -E  "s/haven\'t/have not/g" *.split
sed -i -E  "s/wouldn\'t/would not/g" *.split
sed -i -E  "s/I\'m/I am/g" *.split
sed -i -E  "s/we\'re/we are/g" *.split
sed -i -E  "s/they\'re/they are/g" *.split
sed -i -E  "s/he\'s/he is/g" *.split
sed -i -E  "s/He\'s/He is/g" *.split
sed -i -E  "s/He\'s got/He has got/g" *.split
sed -i -E  "s/he\'s got/he has got/g" *.split
#надо бы удалить все интернет адреса!
#нормализация конца предложения
sed -i -E  's/\.\.\.$/./g' *.split 
sed -i -E  's/\($//g' *.split
sed -i -E  's/\)$//g' *.split # 's/\)$/./g' if there is a dot before the braket it leads to duplication of end of SENT
sed -i -E  's/\[$//g' *.split
sed -i -E  's/\]$//g' *.split
sed -i -E  's/”$//g' *.split
sed -i -E  's/»$//g' *.split
sed -i -E  's/«//g' *.split
sed -i -E  's/\"$//g' *.split
sed -i -E  "s/'$//g" *.split
sed -i -E  's/I\.$/I ./g' *.split
sed -i -E  's/etc\.$/etc. ./g' *.split # аналогичным образом надо прописывать все аббревиатуры, которые встречаются в конце предложения н.э., г., с., et. al., в., рис., см. долл., млрд., млн., don't, there is'n't (эти надо нормализовывать еще раньше!!!
sed -i -E  's/et\.al\.$/et. al. ./g' *.split
sed -i -E  's/m\.$/m. ./g' *.split
sed -i -E  's/\!\!\!/!/g' *.split
sed -i -E  's/\?\!\!/?/g' *.split
sed -i -E  's/\?\!/?/g' *.split
sed -i -E  's/\?\?\?/?/g' *.split
sed -i -E  's/\?\?/?/g' *.split
sed -i -E  '/.$/!/$/./g' *.split
sed -i -E  's/[^.!?]$/&./g' *.split #this is a catch all for all no-end-of-sent punct (which is useful after deleting the above brackets)
sed -i -E  '/^[0-9]\./ {s/\.//;}' *.split

for i in *.split
    do
	echo $i
	sh /home/masha/TreeTagger/cmd/tree-tagger-english < $i >$i.tags
done
#if you want to represent texts as sequences of lemmas of pos-tags stop here
#for English pipeline the cst-lemma step is skipped; tree-tagger-tnglish is set to return -no-unknown 
#transform to hashed format
sed -i -E 's/\t/_/g' *.tags

sed -i -E ':a;N;/SENT_/!ba;s/\n/ /g' *.tags #заменяет новую строку после каждого слова в формате TreeTagger на пробел, увы, в том числе после SENT_ (упоминание этого выражения в команде является исключением для последнего предложения в тексте - не удалять новую строку в конце документа).

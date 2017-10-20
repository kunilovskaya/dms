#!/bin/sh
#вариант скрипта для потока операций по POS разметке, адаптированный для разметки tmx (July 07, 2017)
# normalize text to avoid tagging mistakes
sed -i -E  's/\.\.\.$/./g' *.split
sed -i -E  's/\($//g' *.split
sed -i -E  's/\)$//g' *.split # 's/\)$/./g' if there is a dot before the braket it leads to duplication of end of SENT
sed -i -E  's/\[$//g' *.split
sed -i -E  's/\]$//g' *.split
sed -i -E  's/”$//g' *.split
sed -i -E  "s/'$//g" *.split
sed -i -E  's/»//g' *.split
sed -i -E  's/«//g' *.split
sed -i -E  's/\"//g' *.split
sed -i -E  's/я\.$/я ./g' *.split # helps to avoid weird end-of-line ^я._Afpmpaf_я.\n , ^etc._FW_etc.\n, 1930х_Mo-pld_1930х гг._Afpmpaf_гг.
sed -i -E  's/гг\.$/гг. ./g' *.split # аналогичным образом надо прописывать все аббревиатуры, которые встречаются в конце предложения н.э., г., с., et. al., в., рис., см. долл., млрд., млн., don't, there is'n't (эти надо нормализовывать еще раньше!!!
sed -i -E  's/г\.$/г. ./g' *.split
sed -i -E  's/см\.$/см. ./g' *.split
sed -i -E  's/млн\.$/млн. ./g' *.split
sed -i -E  's/млрд\.$/млрд. ./g' *.split
sed -i -E  's/н\.э\.$/н.э. ./g' *.split
sed -i -E  's/долл\.$/долл. ./g' *.split
sed -i -E  's/тыс\.$/тыс. ./g' *.split
sed -i -E  's/рис\.$/рис. ./g' *.split
sed -i -E  's/м\.$/м. ./g' *.split
sed -i -E  's/ в\.$/ в. ./g' *.split
sed -i -E  's/ с\.$/ с. ./g' *.split
sed -i -E  's/т\.д\.$/т.д. ./g' *.split
sed -i -E  's/т\.п\.$/т.п. ./g' *.split
sed -i -E  's/\!\!\!/!/g' *.split
sed -i -E  's/\?\!\!/?/g' *.split
sed -i -E  's/\?\!/?/g' *.split
sed -i -E  's/\?\?\?/?/g' *.split
sed -i -E  's/\?\?/?/g' *.split
sed -i -E  's/[^.!?]$/&./g' *.split #matches no-period at the end of line ex. <seg>The way you work is going to change</seg>; (which is useful after deleting the above brackets)
sed -i -E  '/^[0-9]\./ {s/\.//;}' *.split #deletes periods in lists, which otherwise produce extra SENTs ex. <seg>3. Results</seg>


for i in *.split
    do
	echo $i
	sh /home/masha/TreeTagger/cmd/tree-tagger-russian < $i >$i.tags
done

for i in *.tags
    do
	echo $i
	perl /home/masha/TreeTagger/lemma-ru/lemmatiser.pl  --lex /home/masha/TreeTagger/lemma-ru/msd-ru-lemma.lex.gz --c /home/masha/TreeTagger/lemma-ru/cstlemma --p /home/masha/TreeTagger/lemma-ru/wform2011.ptn1 < $i > $i.known
done
sed -i -E  's/\t/_/g' *.known
sed -i -E  ':a;N;/SENT_/!ba;s/\n/ /g' *.known #заменяет новую строку после каждого слова в формате TreeTagger на пробел, восстанавливает членение на предложения. Эта команда в структуре tmx не работает, если в конце сегмента нет SENT
#удаляем служебную инфо cst-lemma <guessed>
sed -i -E  's/_<guessed>//g' *.known


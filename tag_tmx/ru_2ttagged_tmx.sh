#!/bin/sh
#вариант скрипта для потока операций по POS разметке, адаптированный для разметки tmx (July 07, 2017)

sed -i -re 's/”//g' *.split

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
sed -i -e 's/\t/_/g' *.known
sed -i -E ':a;N;/SENT_/!ba;s/\n/ /g' *.known #заменяет новую строку после каждого слова в формате TreeTagger на пробел, увы, в том числе после SENT_. (упоминание этого выражения в команде является исключением - не удалять новую строку в конце документа. Поэтому нужна команда, которая восстановит членение на предложения (см. ниже) Эта команда в структуре tmx не работает, если в конце сегмента нет SENT
#удаляем служебную инфо cst-lemma <guessed>
sed -i -E 's/_<guessed>//g' *.known


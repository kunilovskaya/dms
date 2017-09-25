#!/bin/sh
#does tokenization (and lemmatization, i.e. accounts for grammatic variation) of epistemic markers in Russian. The initial list includes 83 in 4 structural/lexico-grammatical types: 28 oneword markers (mostly particles and adverbs: возможно, похоже, вроде), 28 MWE (скорее всего, по всей видимости), 18 1st person (sg+pl) forms of epistemic verbs (знать, считать, полагать, включая уверен, убежден + combinations with modal and phase auxiliaries) and 9 epistemic nouns and adjectives in several types of constructions which introduce that-clause
#перестаю учитывать орфографию первой буквы - просто заменяю так чтоб исходный токен вписался (вообще-то это похоже делается опцией -i!!!)
## this version of the script is customized for tagging tmx (the difference is the file extention: en tmx pipe requires tags, not tagged, while ru tmx pipe needs known)

#предпроцессинг (удаление двойных кавычек-ёлочек) для сокращения ошибок токенизации и лемматизации «Кажется_Vmip3s-m-e_«кажется ,_,_, которые не извлекаются по общему правилу: sed -i -re 's/_Vmip3s-m-e_кажется ,_,_,/_EVEM_кажется ,_,_,/g' *.known
#sed -i -re 's/«//g' *.known
#sed -i -re 's/»//g' *.known


#multiword (MWEM)
sed -i -re 's/_Sp-g_без сомнения_Ncnsgn_сомнение/_MWEM_безсомнения/g' *.known
sed -i -re 's/_Sp-g_без доли_Ncfsgn_доля сомнения_Ncnsgn_сомнение/_MWEM_безсомнения/g' *.known
sed -i -re 's/_Sp-g_вне всякого_P--nsga_всякий сомнения_Ncnsgn_сомнение/_MWEM_внесомнения/g' *.known
sed -i -re 's/_Sp-g_без всякого_P--nsga_всякий сомнения_Ncnsgn_сомнение/_MWEM_безсомнения/g' *.known
sed -i -re 's/_Vmn----a-e_быть может_Vmip3s-a-e_мочь/_MWEM_бытьможет/g' *.known
sed -i -re 's/_R_должно быть_Vmn----a-e_быть ,_,_,/_MWEM_должнобыть ,_,_,/g' *.known
#не менять последовательность операций!
# APR for aproximation
sed -i -re 's/_R_едва ли_Q_ли не_Q_не/_APR_НЕедвалине/g' *.known
sed -i -re 's/_R_едва ли_Q_ли/_MWEM_едвали/g' *.known
sed -i -re 's/_C_как видно_R_видно ,_,_,/_MWEM_каквидно ,_,_,/g' *.known


sed -i -re 's/,_,_, как_C_как предполагается_Vmip3s-m-e_предполагаться ,_,_,/_MWEM_какпредполагается/g' *.known
sed -i -re 's/_P-----r_как ожидается_Vmip3s-m-e_ожидаться ,_,_,/_MWEM_какожидается/g' *.known
sed -i -re 's/,_,_, может_Vmip3s-a-e_мочь быть_Vmn----a-e_быть ,_,_,/,_,_, можетбыть_MWEM_можетбыть ,_,_,/g' *.known
sed -i -re 's/Может_Vmip3s-a-e_мочь быть_Vmn----a-e_быть ,_,_,/_MWEM_можетбыть ,_,_,/g' *.known
sed -i -re 's/_R_навряд ли_Q_ли/_MWEM_наврядли/g' *.known
sed -i -re 's/_Sp-a_на (мой_P--msaa_мой|наш_P--msaa_наш) взгляд_Ncmsan_взгляд/_MWEM_намойвзгляд/g' *.known
sed -i -re 's/_Afpmsdf_по-видимому/_MWEM_повидимому/g' *.known
sed -i -re 's/_Sp-d_по всей_P--fsda_весь вероятности_Ncfsdn_вероятность/_MWEM_повсейвероятности/g' *.known
sed -i -re 's/_Sp-d_по всей_P--fsda_весь видимости_Ncfsdn_видимость/_MWEM_повсейвидимости/g' *.known
sed -i -re 's/_R_по-моему/_MWEM_помоему/g' *.known
sed -i -re 's/_Afpmsif_по-моему ,_,_,/_MWEM_помоему ,_,_,/g' *.known
sed -i -re 's/_Ncfsan_по-моему ,_,_,/_MWEM_помоему ,_,_,/g' *.known
sed -i -re 's/_Sp-d_по (моему_P--nsda_мой|нашему_P--nsda_наш) мнению_Ncnsdn_мнение/_MWEM_помоемумнению/g' *.known

sed -i -re 's/_Sp-d_по (моему_P--nsda_мой|нашему_P--nsda_наш) глубокому_Afpnsdf_глубокий убеждению_Ncnsdn_убеждение/_MWEM_помоемуубеждению/g' *.known
#орфографическая разметка повлияла на автоматическую разметку - мы увидели это в наших данных и добавили правило для этой окказии
sed -i -re 's/_Afpnsdf_по-моему глубокому_Afpnsdf_глубокий убеждению_Ncnsdn_убеждение/_MWEM_помоемуубеждению/g' *.known

sed -i -re 's/_P--nsna_сам собой_P----in_себя разумеется_Vmip3s-m-e_разуметься ,_,_,/_MWEM_самособойразумеется ,_,_,/g' *.known
sed -i -re 's/само_P--nsna_сам собой_P----in_себя ,_,_,/_MWEM_самособой ,_,_,/g' *.known
sed -i -re 's/_Sp-g_с (моей_P--fsga_мой|нашей_P--fsga_наш) точки_Ncfsgn_точка зрения_Ncnsgn_зрение/_MWEM_смоейточкизрения/g' *.known
# не менять последовательность команд
#IA=interaction
sed -i -re 's/_Q_не так_P-----r_так ли_Q_ли ?_SENT_?/_IE_нетакли ?_SENT_?/g' *.known
sed -i -re 's/_P-----r_так ли_Q_ли/_MWEM_такли/g' *.known
#list of nouns and adj
# IF = conditional used to compensate for lack of negative lookahead (токенизируем не-наши примеры)
sed -i -re 's/_C_то (с_Sp-i_с|со_Sp-i_со) (\S+[^_]\S+[^\s]){,2} долей_Ncfsin_доля уверенности_Ncfsgn_уверенность можно_R_можно/_IF_тосуверенностьюможноV/g' *.known
sed -i -re 's/_C_то можно_R_можно с_Sp-i_с уверенностью_Ncfsin_уверенность \b\S+_V\S+\b/_IF_тосуверенностьюможноV/g' *.known
#сначала токенизируем конструкции с прилагательными (доля уверенности бывает определенная, большая, высокая - в псевдо-лемме этот признак не отражается, т.е. от теряется в тексте с переопределенными тегами, при необходимости можно обратиться к тем же текстам в стандартной разметке) 

sed -i -re 's/_Sp-i_с (\b\S+_Afp\S+\b ){,2}уверенностью_Ncfsin_уверенность (можно_R_можно|могу_Vmip1s-a-e_мочь|можем_Vmip1p-a-e_мочь)/_ENEM_суверенностьюможноV/g' *.known
sed -i -re 's/(_R_можно|_Vmip1s-a-e_мочь|_Vmip1p-a-e_мочь) с_Sp-i_с (\S+[^_]\S+[^\s] ){,2}уверенностью_Ncfsin_уверенность (\b\S+_V\S+\b )/_ENEM_суверенностьюможноV/g' *.known
sed -i -re 's/_Sp-i_с (\b\S+_Afp\S+\b)?долей_Ncfsin_доля уверенности_Ncfsgn_уверенность можно_R_можно \b\S+_V\S+\b/_ENEM_суверенностьюможноV/g' *.known

sed -i -re 's/_C_если нет_R_нет уверенности_Ncfsgn_уверенность/_IF_еслинетуверенности/g' *.known
sed -i -re 's/нет_R_нет уверенности_Ncfsgn_уверенность/_ENEM_нетуверенности/g' *.known


sed -i -re 's/(_P-1-snn_я исхожу_Vmip1s-a-e_исходить|_P-1-pnn_мы исходим_Vmip1p-a-e_исходить) из_Sp-g_из предположения_Ncnsgn_предположение о_Sp-l_о том_P--nsln_то ,_,_,/_ENEM_изпредположениячто/g' *.known
sed -i -re 's/_P-1-pnn_мы высказали_Vmis-p-a-p_высказать предположение_Ncnsan_предположение ,_,_, что_C_что/_ENEM_высказалипредположение/g' *.known
sed -i -re 's/_Vmip3s-a-e_вызывать предположение_Ncnsan_предположение ,_,_, что_C_что/_ENEM_Xвызываетпредположениечто/g' *.known
sed -i -re 's/_Vmip3s-a-e_быть предположение_Ncnsnn_предположение ,_,_,/_ENEM_естьпредположениечто/g' *.known
sed -i -re 's/(_P-1-snn_я исхожу_Vmip1s-a-e_исходить|_P-1-pnn_мы исходим_Vmip1p-a-e_исходить) из_Sp-g_из предположения_Ncnsgn_предположение ,_,_,/_ENEM_исходимизпредположениячто ,_,_,/g' *.known


sed -i -re 's/_R_нет сомнения_Ncnpnn_сомнение ,_,_, что_C_что/_ENEM_нетсомнениячто/g' *.known
sed -i -re 's/_R_нет сомнения_Ncnpnn_сомнение в_Sp-l_в том_P--nsln_то ,_,_,/_ENEM_нетсомнениячто ,_,_,/g' *.known
sed -i -re 's/_Q_не должно_Afpnsns_должен быть_Vmn----a-e_быть никакого_P--nsga_никакой сомнения_Ncnsgn_сомнение ,_,_,/_ENEM_нетсомнениячто ,_,_,/g' *.known
sed -i -re 's/(_Sp-d_по моему_P--nsda_мой|_Sp-d_по нашему_P--nsda_наш) мнению_Ncnsdn_мнение/_ENEM_помоемумнению/g' *.known

sed -i -re 's/_Sp-d_по (моему_P--nsda_мой|нашему_P--nsda_наш) \S+[^_]\S+[^\s] мнению_Ncnsdn_мнение/_ENEM_помоемумнению/g' *.known

sed -i -re 's/(_P-1-pnn_мы) (\S+[^_]\S+[^\s])?убеждены_Afpmpns_убежденный/убеждены_EAEM_убежден/g' *.known
sed -i -re 's/_P-1-snn_я (\S+[^_]\S+[^\s])?убеждена_Afpfsns_убежденный/убеждена_EAEM_убежден/g' *.known
sed -i -re 's/_P-1-snn_я (\S+[^_]\S+[^\s])?убежден_Afpmsns_убежденный/убежден_EAEM_убежден/g' *.known

sed -i -re 's/(_P-1-pnn_мы) (\S+[^_].\S+[^\s])?не_Q_не убеждены_Afpmpns_убежденный/неубеждены_EAEM_неубежден/g' *.known
sed -i -re 's/_P-1-snn_я (\S+[^_]\S+[^\s])?не_Q_не убеждена_Afpfsns_убежденный/неубеждена_EAEM_неубежден/g' *.known
sed -i -re 's/_P-1-snn_я (\S+[^_]\S+[^\s])?не_Q_не убежден_Afpmsns_убежденный/неубежден_EAEM_неубежден/g' *.known


sed -i -re 's/_P-1-snn_я (\S+[^_]\S+[^\s])?не_Q_не уверен_Afpmsns_уверенный в_Sp-l_в том_P--nsln_то/неуверен_EAEM_неуверен/g' *.known
sed -i -re 's/_P-1-snn_я (\S+[^_]\S+[^\s])?уверен_Afpmsns_уверенный  в_Sp-l_в том_P--nsln_то/уверен_EAEM_уверен/g' *.known

sed -i -re 's/_P-1-snn_я (\S+[^_]\S+[^\s])?не_Q_не уверена_Afpfsns_уверенный в_Sp-l_в том_P--nsln_то/неуверена_EAEM_неуверен/g' *.known
sed -i -re 's/_P-1-snn_я (\S+[^_]\S+[^\s])?уверена_Afpfsns_уверенный в_Sp-l_в том_P--nsln_то/уверена_EAEM_уверен/g' *.known

sed -i -re 's/_P-1-pnn_мы (\S+[^_]\S+[^\s])?уверены_Afpmpns_уверенный в_Sp-l_в том_P--nsln_то/уверен_EAEM_уверен/g' *.known

sed -i -re 's/_P-1-pnn_мы (\S+[^_].\S+[^\s])?не_Q_не уверены_Afpmpns_уверенный в_Sp-l_в том_P--nsln_то/неуверен_EAEM_неуверен/g' *.known

sed -i -re 's/_P-1-snn_я (\S+[^_]\S+[^\s])?не_Q_не уверен_Afpmsns_уверенный ,_,_,/_EAEM_неуверен ,_,_,/g' *.known
sed -i -re 's/_P-1-snn_я (\S+[^_]\S+[^\s])?уверен_Afpmsns_уверенный ,_,_,/_EAEM_уверен ,_,_,/g' *.known

sed -i -re 's/_P-1-snn_я (\S+[^_]\S+[^\s])?не_Q_не уверена_Afpfsns_уверенный ,_,_,/неуверена_EAEM_неуверен ,_,_,/g' *.known
sed -i -re 's/_P-1-snn_я (\S+[^_]\S+[^\s])?уверена_Afpfsns_уверенный ,_,_,/уверена_EAEM_уверен ,_,_,/g' *.known

sed -i -re 's/_P-1-pnn_мы (\S+[^_]\S+[^\s])?не_Q_не уверены_Afpmpns_уверенный  ,_,_,/неуверены_EAEM_неуверен ,_,_,/g' *.known

sed -i -re 's/_P-1-pnn_мы (\S+[^_]\S+[^\s])?уверены_Afpmpns_уверенный ,_,_,/уверены_EAEM_уверен ,_,_,/g' *.known
#epistemic verbs
sed -i -re 's/_Q_не верю_Vmip1s-a-e_верить ,_,_,/неверю_EVEM_неверю ,_,_,/g' *.known
sed -i -re 's/_Vmip1s-a-e_верить :_-_:/_EVEM_верю :_-_:/g' *.known
sed -i -re 's/_Vmip1s-a-e_верить ,_,_,/_EVEM_верю ,_,_,/g' *.known
sed -i -re 's/_P-1-pnn_мы догадываемся_Vmip1p-m-e_догадываться ,_,_,/догадываемся_EVEM_догадываюсь ,_,_,/g' *.known
sed -i -re 's/_P-1-snn_я догадываюсь_Vmip1s-m-e_догадываться ,_,_,/догадываюсь_EVEM_догадываюсь ,_,_,/g' *.known
sed -i -re 's/,_,_, допускаю_Vmip1s-a-e_допускать ,_,_,/допускаю_EVEM_допускаю ,_,_,/g' *.known
sed -i -re 's/Допускаю_Vmip1s-a-e_допускать ,_,_,/допускаю_EVEM_допускаю ,_,_,/g' *.known
sed -i -re 's/_P-1-snn_я (\S+[^_]\S+[^\s])?допускаю_Vmip1s-a-e_допускать ,_,_,/допускаю_EVEM_допускаю ,_,_,/g' *.known
sed -i -re 's/мы (\S+[^_]\S+[^\s])?допускаем_Vmip1p-a-e_допускать/допускаем_EVEM_допускаю ,_,_,/g' *.known
#sed -i -re 's/,_,_, допустим_Vmm-1p-a-p_допустить ,_,_,/допустим_EVEM_допустим ,_,_,/g' *.known #это в другом списке 

sed -i -re 's/_Vmip1s-a-e_думать ,_,_,/думаю_EVEM_думаю ,_,_,/g' *.known
sed -i -re 's/_Q_не думаем_Vmip1p-a-e_думать ,_,_,/недумаем_EVEM_думаю ,_,_,/g' *.known
sed -i -re 's/_Vmip1p-a-e_думать ,_,_,/думаем_EVEM_думаю ,_,_,/g' *.known
sed -i -re 's/_R_можно думать_Vmn----a-e_думать ,_,_,/можнодумать_EVEM_можнодумать ,_,_,/g' *.known
sed -i -re 's/_R_надо думать_Vmn----a-e_думать ,_,_,/надодумать_EVEM_надодумать ,_,_,/g' *.known
sed -i -re 's/_Vmip3s-m-e_думаться ,_,_,/думается_EVEM_думается ,_,_,/g' *.known
sed -i -re 's/_P-1-sdn_я думается_Vmip3s-m-e_думаться ,_,_,/думается_EVEM_думается ,_,_,/g' *.known


#вводные кажется
sed -i -re 's/,_,_, кажется_R_кажется ,_,_,/,_,_, кажется_OWEM_кажется ,_,_,/g' *.known
sed -i -re 's/Кажется_R_кажется ,_,_,/Кажется_OWEM_кажется ,_,_,/g' *.known
#эксплицитно МНЕ/НАМ кажется
sed -i -re 's/(мне_P-1-sdn_я|нам_P-1-pdn_мы) (\S+[^_]\S+[^\s] )?не_Q_не кажется_Vmip3s-m-e_казаться ,_,_,/\1 кажется_EVEM_мнеНЕкажетсячто/g' *.known
sed -i -re 's/(мне_P-1-sdn_я|нам_P-1-pdn_мы) (\S+[^_]\S+[^\s] )?кажется_Vmip3s-m-e_казаться/\1 кажется_EVEM_LINKмнекажется/g' *.known
#кажется третьему лицу
sed -i -re 's/(ему_P-3msdn_он|ей_P-3fsdn_она|им_P-3-pdn_они|вам_P-2-pdn_вы|тебе_P-2-sdn_ты) (\S+[^_]\S+[^\s] )?кажется_Vmip3s-m-e_казаться ,_,_, что_C_что/\1 кажется_EVEM_мнеНЕкажетсячто/g' *.known
sed -i -re 's/(ему_P-3msdn_он|ей_P-3fsdn_она|им_P-3-pdn_они|вам_P-2-pdn_вы|тебе_P-2-sdn_ты) (\S+[^_]\S+[^\s] )?кажется_Vmip3s-m-e_казаться/\1 кажется_EVEM_мнеНЕкажется/g' *.known

sed -i -re "s/\b\S+_Nc\S\Sdy\S+\b (\S+[^_]\S+[^\s] )?кажется_Vmip3s-m-e_казаться ,_,_, что_C_что/кажется_notmeEVEM_кажетсячто/g" *.known
sed -i -re "s/\b\S+_Nc\S\Sdy\S+\b (\S+[^_]\S+[^\s] )?кажется_Vmip3s-m-e_казаться/кажется_notmeEVEM_кажется/g" *.known

#все остальные кажется (неопределенно-личные и безличные)
sed -i -re "s/кажется_Vmip3s-m-e_казаться ,_,_,/кажется_EVEM_кажетсячто/g" *.known
sed -i -re "s/кажется_Vmip3s-m-e_казаться/кажется_EVEM_LINKкажется/g" *.known


sed -i -re 's/,_,_, как_C_как ожидается_Vmip3s-m-e_ожидаться ,_,_,/,_,_, какожидается_EVEM_какожидается ,_,_,/g' *.known

sed -i -re 's/_P-----r_как ожидается_Vmip3s-m-e_ожидаться ,_,_,/_EVEM_какожидается ,_,_,/g' *.known
sed -i -re 's/_Vmip1s-a-e_полагаю ,_,_,/_EVEM_полагаю ,_,_,/g' *.known
#не менять порядок
sed -i -re 's/_Vmip1p-a-e_полагать ,_,_,/полагаем_EVEM_полагаю ,_,_,/g' *.known
sed -i -re 's/полагаю_Vmip1s-a-e_полагать ,_,_,/полагаю_EVEM_полагаю ,_,_,/g' *.known
sed -i -re 's/\(_-_\( полагаю_Vmip1s-a-e_полагать ,_,_,/\(_-_\( полагаю_EVEM_полагаю ,_,_,/g' *.known
sed -i -re 's/полагаю_Vmip1s-a-e_полагать ,_,_,/полагаю_EVEM_полагаю ,_,_,/g' *.known
sed -i -re 's/_Vmip1p-a-e_полагать необходимым_Afpnsif_необходимый/полагаемнеобходимым_EVEM_полагаюнеобходимым/g' *.known
sed -i -re 's/_Vmip1s-a-e_полагать необходимым_Afpnsif_необходимый/полагаюнеобходимым_EVEM_полагаюнеобходимым/g' *.known
sed -i -re 's/_P-1-snn_я (\S+[^_]\S+[^\s] )?полагаю_Vmip1s-a-e_полагать (\S+[^_]\S+[^\s] )?необходимым_Afpnsif_необходимый/полагаюнеобходимым_EVEM_полагаюнеобходимым/g' *.known
sed -i -re 's/_R_надо полагать_Vmn----a-e_полагать ,_,_,/_EVEM_надополагать ,_,_,/g' *.known
sed -i -re 's/_Vmip1s-a-e_предполагать ,_,_,/предполагаю_EVEM_предполагаю  ,_,_,/g' *.known
sed -i -re 's/Vmip1p-a-e_предполагать ,_,_,/предполагаем_EVEM_предполагаю  ,_,_,/g' *.known
sed -i -re 's/_R_можно предположить_Vmn----a-p_предположить ,_,_,/_EVEM_можнопредположить ,_,_,/g' *.known
sed -i -re 's/,_,_, как_C_как предполагается_Vmip3s-m-e_предполагаться ,_,_,/,_,_, какпредполагается_EVEM_какпредполагается ,_,_,/g' *.known
sed -i -re 's/,_,_, как_C_как (\S+[^_]\S+[^\s] )?представляется_Vmif3s-m-p_представляться ,_,_,/,_,_, какпредставляется_EVEM_какпредставляется ,_,_,/g' *.known
sed -i -re 's/_Vmif3s-m-p_представляться ,_,_,/_EVEM_представляется ,_,_,/g' *.known
sed -i -re 's/,_,_, не_Q_не сомневаюсь_Vmip1s-m-e_сомневаться ,_,_,/несомневаюсь_EVEM_несомневаюсь ,_,_,/g' *.known
sed -i -re 's/Не_Q_не сомневаюсь_Vmip1s-m-e_сомневаться ,_,_,/Несомневаюсь_EVEM_несомневаюсь ,_,_,/g' *.known
sed -i -re 's/:_-_: не_Q_не сомневаюсь_Vmip1s-m-e_сомневаться в_Sp-l_в том_P--nsln_то ,_,_,/несомневаюсь_EVEM_несомневаюсь ,_,_,/g' *.known
sed -i -re 's/и_C_и (\S+[^_]\S+[^\s] )?не_Q_не сомневаюсь_Vmip1s-m-e_сомневаться ,_,_,/несомневаюсь_EVEM_несомневаюсь ,_,_,/g' *.known
sed -i -re 's/_P-1-pnn_мы сомневаемся_Vmip1p-m-e_сомневаться ,_,_,/мысомневаемся_EVEM_несомневаюсь ,_,_,/g' *.known
sed -i -re 's/_R_можно (\S+[^_]\S+[^\s] )?не_Q_не сомневаться_Vmn----m-e_сомневаться (.*_.*_.*)\?,_,_,/_EVEM_можнонесомневаться ,_,_,/g' *.known
sed -i -re 's/_R_можно (\S+[^_]\S+[^\s] )?не_Q_не сомневаться_Vmn----m-e_сомневаться (.*_.*_.*)\?:_-_:/_EVEM_можнонесомневаться :_-_:/g' *.known
sed -i -re 's/_Q_не считаю_Vmip1s-a-e_считать ,_,_,/несчитаю_EVEM_несчитаю ,_,_,/g' *.known
sed -i -re 's/_P-1-snn_я (\S+[^_]\S+[^\s] )?считаю_Vmip1s-a-e_считать ,_,_,/,_,_, считаю_EVEM_считаю ,_,_,/g' *.known
sed -i -re 's/_P-1-pnn_мы считаем_Vmip1p-a-e_считать ,_,_,/считаем_EVEM_считаю ,_,_,/g' *.known
sed -i -re 's/_Q_не считаем_Vmip1p-a-e_считать ,_,_,/несчитаем_EVEM_несчитаю ,_,_,/g' *.known
sed -i -re 's/_P-----r_поэтому (\S+[^_]\S+[^\s] )?считаем_Vmip1p-a-e_считать ,_,_,/считаем_EVEM_считаю ,_,_,/g' *.known
sed -i -re 's/считаем_Vmip1p-a-e_считать ,_,_,/считаем_EVEM_считаю ,_,_,/g' *.known
sed -i -re 's/считаем_Vmip1p-a-e_считать --_-_--/считаем_EVEM_считаю --_-_--/g' *.known
sed -i -re 's/_R_можно (\S+[^_]\S+[^\s] )?утверждать_Vmn----a-e_утверждать ,_,_,/_EVEM_можноутверждать ,_,_,/g' *.known
sed -i -re 's/_P-1-snn_я утверждаю_Vmip1s-a-e_утверждать ,_,_,/_EVEM_утверждаю ,_,_,/g' *.known
sed -i -re 's/_P-1-pnn_мы утверждаем_Vmip1p-a-e_утверждать ,_,_,/_EVEM_утверждаю ,_,_,/g' *.known
#oneword(OWEM)
sed -i -re 's/_R_безусловно/_OWEM_безусловно/g' *.known
sed -i -re 's/_R_бесспорно/_OWEM_бесспорно/g' *.known
sed -i -re 's/_R_вероятно/_OWEM_вероятно/g' *.known
sed -i -re 's/_R_видимо/_OWEM_видимо/g' *.known
sed -i -re 's/_R_возможно/_OWEM_возможно/g' *.known
sed -i -re 's/_Q_вроде/_OWEM_вроде/g' *.known
sed -i -re 's/_R_конечно/_OWEM_конечно/g' *.known
sed -i -re 's/Маловероятно_Afpnsns_маловероятный ,_,_,/Маловероятно_OWEM_маловероятный ,_,_,/g' *.known
sed -i -re 's/_R_наверно/_OWEM_наверно/g' *.known
sed -i -re 's/_R_наверное/_OWEM_наверное/g' *.known
sed -i -re 's/_R_наверняка/_OWEM_наверняка/g' *.known
sed -i -re 's/_R_небось/_OWEM_небось/g' *.known
sed -i -re 's/_Q_неужели/_OWEM_неужели/g' *.known
sed -i -re 's/_Q_неужто/_OWEM_неужто/g' *.known
sed -i -re 's/_R_очевидно/_OWEM_очевидно/g' *.known
sed -i -re 's/_R_пожалуй/_OWEM_пожалуй/g' *.known
sed -i -re 's/_Q_разве/_OWEM_разве/g' *.known
sed -i -re 's/,_,_, разумеется_R_разумеется/,_,_, разумеется_OWEM_разумеется ,_,_,/g' *.known
sed -i -re 's/_Q_якобы/_OWEM_якобы/g' *.known

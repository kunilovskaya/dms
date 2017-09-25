#!/bin/sh
#does tokenization (and lemmatization, i.e. accounts for grammatic variation) of epistemic markers in English
#применять к размеченным TreeTagger корпусам
#multiword (EMWEM)

#preprocessing: normalize texts to avoid multiple promlems with apostrophe and dollar signs
sed -i -re "s/'s_VBZ_be/is_VBZ_be/g" *.tags
sed -i -re "s/'re_VBP_be/are_VBP_be/g" *.tags
sed -i -re "s/'s_VBZ_have/has_VBZ_have/g" *.tags
sed -i -re "s/'ve_VBP_have/have_VBZ_have/g" *.tags
sed -i -re "s/'m_VBP_be/am_VBP_be/g" *.tags

sed -i -re 's/my_PP$_my/my_PP_my/g' *.tags
sed -i -re 's/our_PP$_our/our_PP_our/g' *.tags

sed -i -re "s/'ll_MD_will/will_MD_will/g" *.tags
sed -i -re "s/'d_MD_will/would_MD_will/g" *.tags
sed -i -re "s/ca_MD_ca/can_MD_can/g" *.tags

sed -i -re "s/n't_RB_n't/not_RB_not/g" *.tags



#main code

sed -i -re 's/_RB_sure enough_RB_enough ,_,_,/_MWEM_sureenough ,_,_,/g' *.tags

sed -i -re 's/Looks_NNS_look like_IN_like/Looks_MWEM_looklike/g' *.tags
sed -i -re 's/It_PP_it looks_VBZ_look like_IN_like/Itlooks_MWEM_looklike/g' *.tags
#рабочий вариант отрицания
sed -i -re 's/_PP_it looks_VBZ_look like_IN_like (this_DT_this|that_DT_that|it_PP_it|._SENT_.)/_notMWEM_looklike/g' *.tags
sed -i -re 's/_PP_it looks_VBZ_look like_IN_like/looks_MWEM_looklike/g' *.tags

sed -i -re 's/_PP_it looks_VBZ_look like_IN_like it_PP_it/_MWEM_looklike it_PP_it/g' *.tags

sed -i -re 's/_EX_there (could_MD_could|can_MD_can) be_VB_be no_DT_no doubt_NN_doubt/_ENEM_therenodoubt/g' *.tags
sed -i -re 's/_EX_there \S+_VBZ_be no_DT_no doubt_NN_doubt/_ENEM_therenodoubt/g' *.tags
sed -i -re 's/_EX_there \S+_VBZ_be (\S+[^_]\S+[^\s])?doubt_NN_doubt/_ENEM_theredoubt/g' *.tags
sed -i -re "s/_EX_there is_VBZ_be no_RB_no doubting_VBG_doubt/_ENEM_therenodoubt/g" *.tags
sed -i -re 's/_PP_(I|we) have_VBP_have no_DT_no doubts_NNS_doubt/_ENEM_havenodoubt/g' *.tags
sed -i -re 's/_PP_(I|we) have_VBP_have not_RB_not (\S+[^_]\S+[^\s])?doubt_NN_doubt/_ENEM_havenodoubt/g' *.tags
sed -i -re 's/_PP_(I|we) have_VBP_have (\S+[^_]\S+[^\s])?doubts_NNS_doubt/_ENEM_havenodoubt/g' *.tags
sed -i -re 's/_PP_(I|we) have_VBP_have (\S+[^_]\S+[^\s])?doubt_NN_doubt/_ENEM_havedoubt/g' *.tags

sed -i -re 's/--_:_-- no_DT_no doubt_NN_doubt/--_:_-- nodoubt_MWEM_nodoubt/g' *.tags
sed -i -re 's/,_,_, no_DT_no doubt_NN_doubt/,_,_, nodoubt_MWEM_nodoubt/g' *.tags
sed -i -re 's/No_DT_no doubt_NN_doubt/Nodoubt_MWEM_nodoubt/g' *.tags
sed -i -re 's/No_DT_no doubts_NNS_doubt/Nodoubt_MWEM_nodoubt/g' *.tags
sed -i -re 's/_IN_beyond (\S+[^_]\S+[^\s] ){,2}doubt_NN_doubt/_MWEM_beyonddoubt/g' *.tags


sed -i -re "s/_(VBP|VB|VBZ)_be not_RB_not (\S+[^_]\S+[^\s] ){,2}certain_JJ_certain to_TO_to/_EAEM_benotcertainto/g" *.tags
sed -i -re "s/_(VBP|VB)_be not_RB_not (\S+[^_]\S+[^\s] ){,2}certain_JJ_certain/_EAEM_benotcertain/g" *.tags
sed -i -re "s/_(VBP|VB|VBZ)_be (\S+[^_]\S+[^\s] ){,2}certain_JJ_certain to_TO_to/_EAEM_becertainto/g" *.tags
sed -i -re "s/_(VBP|VB)_be (\S+[^_]\S+[^\s] ){,2}certain_JJ_certain/_EAEM_becertain/g" *.tags

sed -i -re 's/_IN_in my_PP_my view_NN_view/_MWEM_inmyview/g' *.tags
sed -i -re 's/_IN_in my_PP_my opinion_NN_opinion/_MWEM_inmyopinion/g' *.tags
sed -i -re 's/_IN_of course_NN_course/_MWEM_ofcourse/g' *.tags
sed -i -re 's/_IN_from (my_PP_my|our_PP_our) point_NN_point of_IN_of view_NN_view/_MWEM_frommypointofview/g' *.tags
sed -i -re 's/(_PP_I|_PP_we) would_MD_would say_VB_say/_MWEM_iwouldsay/g' *.tags
sed -i -re "s/_IN_for sure_JJ_sure/_MWEM_forsure/g" *.tags
sed -i -re "s/_RB_as for_IN_for me_PP_me/_MWEM_asforme/g" *.tags
sed -i -re "s/_RB_as to_TO_to me_PP_me/_MWEM_astome/g" *.tags
sed -i -re "s/_PP_it goes_VBZ_go without_IN_without saying_VBG_say/_MWEM_goeswithoutsaying/g" *.tags
sed -i -re 's/_TO_To my_PP_my mind_NN_mind/_MWEM_tomymind/g' *.tags
sed -i -re 's/In_IN_in my_PP_my eyes_NNS_eye ,_,_,/Inmyeyes_MWEM_inmyeyes ,_,_,/g' *.tags
sed -i -re 's/,_,_, in_IN_in my_PP_my eyes_NNS_eye ,_,_,/,_,_, inmyeyes_MWEM_inmyeyes ,_,_,/g' *.tags

#list of nouns and adj

sed -i -re 's/_DT_that is_VBZ_be my_PP_my belief_NN_belief ._SENT_./is_notENEM_mybelief/g' *.tags

sed -i -re 's/_PP_it is_VBZ_be my_PP_my belief_NN_belief/is_ENEM_mybelief/g' *.tags

#a one-liner for CAPs, modification adverbs (even, at all), boosters (very, absolutely) на расстоянии от 0-3-х слов, contractions are taken care of above
sed -i -re 's/_PP_it is_VBZ_be not_RB_not (\S+[^_]\S+[^\s] ){,2}clear_JJ_clear/_EAEM_itisnotclear/g' *.tags
sed -i -re 's/_PP_it is_VBZ_be (\S+[^_]\S+[^\s] ){,3}clear_JJ_clear/_EAEM_itisclear/g' *.tags

sed -i -re "s/_PP_(I|we) (am_VBP_be|are_VBP_be) not_RB_not (\S+[^_]\S+[^\s] ){,2}convinced_VBN_convince/_EAEM_benotconvinced/g" *.tags
sed -i -re "s/_PP_(I|we) (am_VBP_be|are_VBP_be) (\S+[^_]\S+[^\s] ){,2}convinced_VBN_convince/_EAEM_beconvinced/g" *.tags


sed -i -re 's/_PP_(I|we) have_VBP_have a_DT_a feeling_NN_feeling that_IN_that/_ENEM_havefeeling/g' *.tags
sed -i -re 's/_EX_there \S+_VBZ_be the_DT_the feeling_NN_feeling that_IN_that/_ENEM_therefeelingthat that_IN_that/g' *.tags

sed -i -re 's/my_PP_my guess_NN_guess is_VBZ_be/myguessis_ENEM_myquessis/g' *.tags
#что вот это извлекает? this is not about certainty and doubt
#sed -i -re 's/(my_PP_my|our_PP_our) knowledge_NN_knowledge that_IN_that/knowledgethat_ENEM_myknowledgethat/g' *.tags

sed -i -re 's/_JJS_good of_IN_of (my_PP_my|our_PP_our) knowledge_NN_knowledge/_ENEM_bestofmyknowledge/g' *.tags

sed -i -re "s/_(VBP|VB|VBZ)_be not_RB_not (\S+[^_]\S+[^\s] ){,2}likely_JJ_likely to_TO_to/_EAEM_benotlikelyto/g" *.tags
sed -i -re "s/_(VBZ)_be not_RB_not (\S+[^_]\S+[^\s] ){,2}likely_JJ_likely that_IN_that/_EAEM_benotlikelythat/g" *.tags
sed -i -re "s/_(VBP|VB)_be not_RB_not (\S+[^_]\S+[^\s] ){,2}likely_JJ_likely/_EAEM_benotlikely/g" *.tags
sed -i -re 's/(\b\S+_RB\S+\b ){,2}likely_JJ_likely to_TO_to/\1 likely_EAEM_likelyto/g' *.tags
sed -i -re 's/(\b\S+_RB\S+\b ){,2}likely_JJ_likely that_IN_that/\1 likely_EAEM_likelythat/g' *.tags
sed -i -re 's/(\b\S+_RB\S+\b ){,2}likely_JJ_likely/\1 likely_EAEM_likely/g' *.tags
sed -i -re "s/_PP_it is_VBZ_be not_RB_not unlikely_JJ_unlikely/_EAEM_notunlikely/g" *.tags
sed -i -re "s/_PP_it is_VBZ_be (\S+[^_]\S+[^\s] ){,2}unlikely_JJ_unlikely/_EAEM_unlikely/g" *.tags

sed -i -re 's/_PP_(I|we) can_MD_can not_RB_not (\S+[^_]\S+[^\s] ){,2}be_VB_be sure_JJ_sure/_EAEM_benotsure/g' *.tags
sed -i -re 's/_PP_(I|we) can_MD_can be_VB_be (\S+[^_]\S+[^\s] ){,2}sure_JJ_sure/_EAEM_besure/g' *.tags
sed -i -re "s/_PP_(I|we) (am_VBP_be|are_VBP_be) not_RB_not (\S+[^_]\S+[^\s] ){,2}sure_JJ_sure/_EAEM_benotsure/g" *.tags
sed -i -re "s/_PP_(I|we) (am_VBP_be|are_VBP_be) (\S+[^_]\S+[^\s] ){,2}sure_JJ_sure/_EAEM_besure/g" *.tags

sed -i -re 's/,_,_, sure_RB_sure/,_,_, sure_OWEM_OWEMsure/g' *.tags
sed -i -re 's/So_RB_so sure_RB_sure ,_,_,/So_OWEM_OWEMsure ,_,_,/g' *.tags

sed -i -re "s/_PP_it is_VBZ_be probable_JJ_probable/_EAEM_beprobable/g" *.tags

sed -i -re "s/_PP_it is_VBZ_be possible_JJ_possible (to_TO_to|that_IN_that)/_EAEM_bepossible \1/g" *.tags
sed -i -re 's/_VBZ_be it_PP_it possible_JJ_possible (to_TO_to|that_IN_that)/_EAEM_bepossible \1/g' *.tags
sed -i -re 's/_WRB_how is_VBZ_be it_PP_it possible_JJ_possible that_IN_that/_EAEM_bepossible that_IN_that/g' *.tags

sed -i -re "s/_PP_it is_VBZ_be obvious_JJ_obvious/_EAEM_beobvious/g" *.tags

sed -i -re "s/_PP_it is_VBZ_be natural_JJ_natural/_EAEM_benatural/g" *.tags

#oneword

sed -i -re 's/_RB_apparently/_OWEM_OWEMapparently/g' *.tags
sed -i -re 's/_RB_arguably/_OWEM_OWEMarguably/g' *.tags

sed -i -re 's/_RB_certainly/_OWEM_OWEMcertainly/g' *.tags

sed -i -re 's/_RB_decidedly/_OWEM_OWEMdecidedly/g' *.tags

sed -i -re 's/_RB_definitely/_OWEM_OWEMdefinitely/g' *.tags

sed -i -re 's/_RB_maybe/_OWEM_OWEMmaybe/g' *.tags

sed -i -re 's/_RB_naturally ,_,_,/_OWEM_OWEMnaturally ,_,_,/g' *.tags

sed -i -re 's/_RB_obviously/_OWEM_OWEMobviously/g' *.tags

sed -i -re 's/_RB_perhaps/_OWEM_OWEMperhaps/g' *.tags

sed -i -re 's/_RB_possibly/_OWEM_OWEMpossibly/g' *.tags

sed -i -re 's/_RB_presumably/_OWEM_OWEMpresumably/g' *.tags

sed -i -re 's/_RB_probably/_OWEM_OWEMprobably/g' *.tags

sed -i -re 's/_OWEM_evidently/_OWEM_OWEMevidently/g' *.tags

#epistemic verbs - mind negative positives
sed -i -re 's/_PP_(I|we) think_VBP_think of_IN_of/_notEVEM_ithinkof/g' *.tags
sed -i -re 's/_PP_(I|we) think_VBP_think about_IN_about/_notEVEM_ithinkof/g' *.tags
sed -i -re 's/_PP_(I|we) think_VBP_think/_EVEM_ithink/g' *.tags

sed -i -re 's/_PP_(I|we) feel_VBP_feel that_IN_that/_EVEM_ifeel/g' *.tags
# эта функция реализуется только в форме наст времени и только с местоим ед ч.
sed -i -re 's/_PP_(I|we) guess_VBP_guess/_EVEM_iguess/g' *.tags

sed -i -re 's/appear_VBP_appear to_TO_to/appearto_EVEM_appearto/g' *.tags
sed -i -re 's/appears_VBZ_appear to_TO_to/appearto_EVEM_appearto/g' *.tags
sed -i -re 's/appear_VBP_appear that_IN_that/appearthat_EVEM_appearthat/g' *.tags
sed -i -re 's/appears_VBZ_appear that_IN_that/appearthat_EVEM_appearthat/g' *.tags

sed -i -re "s/_PP_(I|we) would_MD_will argue_VB_argue/_EVEM_arguethat/g" *.tags
sed -i -re "s/_IN_in order_NN_order to_TO_to argue_VB_argue that_IN_that/_EVEM_arguethat/g" *.tags
sed -i -re 's/_PP_it can_MD_can be_VB_be argued_VBN_argue/_EVEM_canbeargued/g' *.tags

sed -i -re 's/seems_VBZ_seem to_TO_to (me_PP_me|us_PP_us)/seemsto_EVEM_seemtome/g' *.tags
sed -i -re 's/seem_VBP_seem to_TO_to (me_PP_me|us_PP_us)/seemto_EVEM_seemtome/g' *.tags
# это не позволяет исключить из выборки it seems to John, но в нашем корпусе такие случаи не встретились
sed -i -re 's/seem_VBP_seem to_TO_to (\b\S+_PP\S+\b )?/seemto_notmePPEVEM_seemto/g' *.tags
sed -i -re 's/seems_VBZ_seem to_TO_to (\b\S+_PP\S+\b )?/seemsto_notmePPEVEM_seemto/g' *.tags
sed -i -re 's/seems_VBZ_seem to_TO_to/seemsto_EVEM_seemto/g' *.tags
sed -i -re 's/seem_VBP_seem to_TO_to/seemto_EVEM_seemto/g' *.tags
#не исключает теоретические варианты To John it seems un real
sed -i -re 's/seem_VBP_seem that_IN_that/seemthat_EVEM_seemthat/g' *.tags
sed -i -re 's/seems_VBZ_seem that_IN_that/seemsthat_EVEM_seemthat/g' *.tags
#собираем все оставшиеся it seems simple, but и which seem strange (тоже редко в контексте с to him/to clients)
sed -i -re 's/seem_VBP_seem/seem_EVEM_LINKseem/g' *.tags
sed -i -re 's/seems_VBZ_seem/seems_EVEM_LINKseems/g' *.tags


sed -i -re 's/_PP_(I|we) assume_VBP_assume/_EVEM_iassume/g' *.tags
sed -i -re 's/_VBG_assume that_IN_that/_EVEM_assumingthat/g' *.tags


sed -i -re 's/_PP_(I|we) I_PP_I believe_VBP_believe ,_,_,/_EVEM_ibelieve/g' *.tags

sed -i -re 's/_PP_(I|we) (\S+[^_]\S+[^\s])?believe_VBP_believe that_IN_that/_EVEM_ibelievethat/g' *.tags
#исключаем редкие примеры с предлогом в непосредственной правой дистрибуции
sed -i -re 's/_PP_(I|we) believe_VBP_believe \b\S+_IN\S+\b/_notEVEM_ibelieve/g' *.tags

sed -i -re "s/_PP_(I|we) do_VBP_do not_RB_not (\S+[^_]\S+[^\s] ){,2}believe_VB_believe/dontbelieve_EVEM_dontbelieve/g" *.tags
sed -i -re 's/_PP_(I|we)(\S+[^_]\S+[^\s] ){,2}believe_VBP_believe/_EVEM_ibelieve/g' *.tags
sed -i -re 's/_PP_(I|we)(\S+[^_]\S+[^\s] ){,2}believe_VBP_believe/_EVEM_ibelieve/g' *.tags

sed -i -re 's/made_VBN_make (me_PP_me|us_PP_us) doubt_VBP_doubt that_IN_that/doubtthat_EVEM_doubtthat/g' *.tags
sed -i -re 's/_PP_(I|we) (\S+[^_]\S+[^\s] )?doubt_VBP_doubt that_IN_that/doubtthat_EVEM_doubtthat/g' *.tags
sed -i -re 's/_PP_(I|we) do_VBP_do not_RB_not (\S+[^_]\S+[^\s] )?doubt_VBP_doubt that_IN_that/doubtthat_EVEM_doubtthat/g' *.tags
# в научных лекциях часто используется для представления результатов исследования We_PP_we find_VBP_find there_EX_there are_VBP_be more_RBR_more neural_JJ_neural stem_NN_stem cells_NNS_cell that_WDT_that make_VBP_make new_JJ_new neurons_NNS_neuron
sed -i -re 's/_PP_(I|we) find_VBP_find that_IN_that/_EVEM_ifindthat/g' *.tags
sed -i -re 's/_PP_(I|we) find_VBP_find myself_PP_myself/_notEVEM_ifind/g' *.tags
sed -i -re 's/_PP_(I|we) find_VBP_find out_RP_out/_notEVEM_ifind/g' *.tags
sed -i -re 's/_PP_(I|we) find_VBP_find \S+_IN_\S+/_notEVEM_ifind/g' *.tags
# в значении мнения часто имеет в правой дистрибуции наречие+прилагательное: I find smth (a lot more) interesting
sed -i -re 's/_PP_(I|we) find_VBP_find \b\S+_(RB.?|JJ.?)\S+\b/_EVEM_ifind/g' *.tags #what we find so sexy about math
sed -i -re 's/_PP_(I|we) find_VBP_find \b\S+_(NN.?|PP)\S+\b(\b\S+_(RB.?|JJ.?)\S+\b ){,1}/_EVEM_ifind/g' *.tags #I find him/travel (so) sexy
sed -i -re 's/_PP_(I|we) guess_VBP_guess/_EVEM_iguess/g' *.tags

#предпроцессинг (удаление двойных кавычек-ёлочек) для сокращения ошибок токенизации и лемматизации «Кажется_Vmip3s-m-e_«кажется ,_,_, которые не извлекаются по общему правилу: sed -i -re 's/_Vmip3s-m-e_кажется ,_,_,/_EVEM_кажется ,_,_,/g' *.known
sed -i -re 's/«//g' *.known
sed -i -re 's/»//g' *.known


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

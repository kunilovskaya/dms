#!/bin/sh
#does tokenization (and lemmatization, i.e. accounts for grammatic variation) of epistemic markers in English
#применять к размеченным TreeTagger корпусам
#multiword (MWEM)
## this version of the script is customized for tagging tmx (the difference is the file extention: en tmx pipe requires tags, not tagged, while ru tmx pipe needs known)

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

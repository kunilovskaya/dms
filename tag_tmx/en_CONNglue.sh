#!/bin/sh
#updated July 2017 (список включает 120 лемм)
#preprocessing: normalize texts to avoid multiple promlems with apostrophe and dollar signs
#учитывая внесенные изменения (одно выражение для начала и середины предложения, в разных пунктуационных условиях и с учетом вариативности) поисковой список надо формировать из последовательности CONN_connlemma, а не connlemma_CONN, т.е. настоящая лемма - после тега!
# не менять последовательность команд! см пояснения к except
# this version of the script is customized for tagging tmx (the difference is the file extention: en tmx pipe requires tags, not tagged, while ru tmx pipe needs known)

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


#main code which prints matching lines for expressions

sed -i -e 's/_IN_ all_DT_all/all_CONN_aboveall/g' *.tags
sed -i -e 's/_IN_above all_PDT_all/all_CONN_aboveall/g' *.tags
sed -i -e 's/_IN_above all_RB_all/all_CONN_aboveall/g' *.tags

sed -i -e 's/,_,_, accordingly_RB_accordingly ,_,_,/,_,_, accordingly_CONN_accordingly ,_,_,/g' *.tags
sed -i -e 's/;_:_; accordingly_RB_accordingly ,_,_,/;_:_; accordingly_CONN_accordingly ,_,_,/g' *.tags
sed -i -e 's/Accordingly_RB_accordingly/accordingly_CONN_accordingly/g' *.tags

sed -i -e 's/_RB_actually ,_,_,/_CONN_actually ,_,_,/g' *.tags # it is in contrast and the contract is either with ideas expressed in text or expected by the speaker
sed -i -e 's/_RB_actually ._SENT_./_CONN_actually ._SENT_./g' *.tags

sed -i -e 's/Additionally_RB_additionally ,_,_,/additionally_CONN_additionally ,_,_,/g' *.tags
sed -i -e 's/_IN_after all_DT_all ,_,_,/all_CONN_afterall ,_,_,/g' *.tags
sed -i -e 's/_IN_after all_DT_all )_)_)/all_CONN_afterall )_)_)/g' *.tags
sed -i -e 's/after_IN_after all_DT_all ?_SENT_?/afterall_CONN_afterall ?_SENT_?/g' *.tags
sed -i -e 's/after_IN_after all_DT_all ._SENT_./afterall_CONN_afterall ._SENT_./g' *.tags
sed -i -e 's/_IN_after all_RB_all ,_,_,/all_CONN_afterall ,_,_,/g' *.tags

sed -i -e 's/_DT_all in_IN_in all_DT_all ,_,_,/inall_CONN_allinall ,_,_,/g' *.tags
sed -i -e 's/_RB_all in_IN_in all_PDT_all/inall_CONN_allinall/g' *.tags

sed -i -e 's/All_DT_all that_WDT_that said_VBD_say ,_,_,/thatsaid_CONN_thatsaid ,_,_,/g' *.tags

sed -i -e 's/_DT_all things_NNS_thing considered_VBN_consider/thingsconsidered_CONN_allthingsconsidered/g' *.tags

sed -i -e 's/_RB_also/_CONN_also/g' *.tags

sed -i -e 's/alternatively_RB_alternatively/alternatively_CONN_alternatively/g' *.tags # can this be used adverbially, not as a sentence adverb?
sed -i -e 's/Alternatively_RB_alternatively/alternatively_CONN_alternatively/g' *.tags

sed -i -e 's/,_,_, altogether_RB_altogether ,_,_,/,_,_, altogether_CONN_altogether ,_,_,/g' *.tags
sed -i -e 's/;_:_; altogether_RB_altogether ,_,_,/;_:_; altogether_CONN_altogether ,_,_,/g' *.tags
sed -i -e 's/Altogether_RB_altogether ,_,_,/altogether_CONN_altogether ,_,_,/g' *.tags

sed -i -e 's/and_CC_and finally_RB_finally ,_,_,/finally_CONN_finally ,_,_,/g' *.tags
sed -i -e 's/And_CC_and finally_RB_finally ,_,_,/finally_CONN_finally ,_,_,/g' *.tags
sed -i -e 's/_RB_finally ,_,_,/_CONN_finally/g' *.tags

sed -i -e 's/And_CC_and for_IN_for all_PDT_all that_DT_that ,_,_,/forallP_CONN_forallP/g' *.tags

sed -i -e 's/and_CC_and still_RB_still/still_CONN_still/g' *.tags
sed -i -e 's/And_CC_and still_RB_still/still_CONN_still/g' *.tags

sed -i -e 's/and_CC_and thus_RB_thus/thus_CONN_thus/g' *.tags
sed -i -e 's/And_CC_and thus_RB_thus/thus_CONN_thus/g' *.tags

sed -i -e 's/And_CC_and to_TO_to cap_VB_cap it_PP_it all_DT_all/tocapitall_CONN_tocapitall/g' *.tags


sed -i -e 's/,_,_, and_CC_and yet_RB_yet/,_,_, yet_CONN_yet/g' *.tags
sed -i -e 's/;_:_; and_CC_and yet_RB_yet/;_:_; yet_CONN_yet/g' *.tags
sed -i -e 's/And_CC_and yet_RB_yet/yet_CONN_yet/g' *.tags

sed -i -e 's/_RB_anyway/_CONN_anyway/g' *.tags 

sed -i -e 's/_IN_as a_DT_a consequence_NN_consequence ,_,_,/aconsequence_CONN_asaconsequence ,_,_,/g' *.tags

sed -i -e 's/_IN_as a_DT_a result_NN_result ,_,_,/aresult_CONN_asaresult ,_,_,/g' *.tags

sed -i -e 's/_RB_as opposed_VBN_oppose to_TO_to that_DT_that ,_,_,/opposedtothat_CONN_asopposedtoP ,_,_,/g' *.tags
sed -i -e 's/_RB_as opposed_VBN_oppose to_TO_to this_DT_this ,_,_,/opposedtothis_CONN_asopposedtoP ,_,_,/g' *.tags

sed -i -e 's/_IN_at any_DT_any rate_NN_rate ,_,_,/atanyrate_CONN_atanyrate ,_,_,/g' *.tags

sed -i -e 's/At_IN_at least_JJS_least ,_,_,/atleast_CONN_atleast ,_,_,/g' *.tags

sed -i -e 's/_IN_at the_DT_the same_JJ_same time_NN_time/thesametime_CONN_atthesametime/g' *.tags

# testing new items on the list
sed -i -e 's/_RB_instead ,_,_,/_CONN_instead ,_,_,/g' *.tags #comma helps to exclude uses with norminalized arguments such as 'Instead_RB_instead of_IN_of importing_VBG_import', не указываем заглавную имя в виду So_RB_so instead_RB_instead ,_,_, ; теряем recall на случаях типа But_CC_but ,_,_, if_IN_if he_PP_he instead_RB_instead acted_VBD_act out_RP_out of_IN_of a_DT_a delusional_JJ_delusional fantasy_NN_fantasy ,_,_, (можно учесть указав negative lookbehind, исключающий фразы с of)
sed -i -e 's/And_CC_and indeed_RB_indeed ,_,_,/indeed_CONN_indeed ,_,_,/g' *.tags # неначальные сочетания без зпт соединяют не пропозиции, а фразы: they_PP_they were_VBD_be not_RB_not fatal_JJ_fatal and_CC_and indeed_RB_indeed caused_VBD_cause no_DT_no permanent_JJ_permanent damage_NN_damage whatsoever_RB_whatsoever ._SENT_. into_IN_into South_NP_South Africa_NP_Africa and_CC_and indeed_RB_indeed ,_,_, into_IN_into the_DT_the entire_JJ_entire African_JJ_African continent_NN_continent ._SENT_. добавляя полноты/расширяя референт(у). 
sed -i -e 's/Indeed_RB_indeed/indeed_CONN_indeed/g' *.tags

sed -i -e 's/Separately_RB_separately ,_,_,/Separately_CONN_separately ,_,_,/g' *.tags

#sed -i -e 's/_IN_although/_CONN_although/g' *.tags #is a conj rather than a connector: Islamic State's Egypt affiliate is waging an insurgency in parts of the Sinai, although mostly far from the tourist resorts along its Red Sea coast. Counter-terror experts have agreed that although wars in the Middle East and north Africa have increased the flow of weapons into Europe, most terror suspects and perpetrators have been УhomegrownФ radicals and sympathizers.

sed -i -e 's/in_IN_in actual_JJ_actual fact_NN_fact/infact_CONN_infact/g' *.tags
sed -i -e 's/Still_RB_still ,_,_,/Still_CONN_still ,_,_,/g' *.tags

sed -i -e 's/_RB_meanwhile ,_,_,/_CONN_meanwhile ,_,_,/g' *.tags
# решила исключить все номинализированные аргументы, включая местоименные, после коннекторов, поскольку такое употребление переводит их в разряд предлогов, формирующих фразы, а не связывающих пропозиции, это не исключает такие выражения из числа элементов обеспечивающих связность текста, особенно если они оказываются грамматикализованными. Получается не надо исключать... Оставлю только в начале предложения и только с зпт?
#sed -i -e 's/because_IN_because of_IN_of that_DT_that ,_,_,/becauseofDT_CONN_becauseofDT ,_,_,/g' *.tags
sed -i -e 's/Because_IN_because of_IN_of that_DT_that ,_,_,/becauseofthat_CONN_becauseofP ,_,_,/g' *.tags
#sed -i -e 's/because_IN_because of_IN_of this_DT_this ,_,_,/becauseofDT_CONN_becauseofDT ,_,_,/g' *.tags

sed -i -e 's/Because_IN_because of_IN_of this_DT_this ,_,_,/becauseofthis_CONN_becauseofP ,_,_,/g' *.tags
sed -i -e 's/_RB_besides ,_,_,/_CONN_besides ,_,_,/g' *.tags

sed -i -e 's/_RBR_well still_RB_still ,_,_,/still_CONN_still ,_,_,/g' *.tags

sed -i -e 's/,_,_, briefly_RB_briefly ,_,_,/,_,_, briefly_CONN_briefly ,_,_,/g' *.tags
sed -i -e 's/Briefly_RB_briefly ,_,_,/briefly_CONN_briefly ,_,_,/g' *.tags

sed -i -e 's/Broadly_RB_broadly speaking_VBG_speak ,_,_,/broadlyspeaking_CONN_broadlyspeaking ,_,_,/g' *.tags

#sed -i -e 's/_CC_but yet_RB_yet/yet_CONN_yet/g' *.tags #seems to have temporal meaning, with contrast conveyed by but
sed -i -e 's/_IN_by and_CC_and large_JJ_large/andlarge_CONN_byandlarge/g' *.tags

sed -i -e 's/,_,_, by_IN_by contrast_NN_contrast ,_,_,/,_,_, incontrast_CONN_incontrast ,_,_,/g' *.tags
sed -i -e 's/By_IN_by contrast_NN_contrast ,_,_,/incontrast_CONN_incontrast ,_,_,/g' *.tags

sed -i -e 's/_IN_by the_DT_the same_JJ_same token_NN_token/thesametoken_CONN_bythesametoken/g' *.tags

sed -i -e 's/_IN_by the_DT_the way_NN_way ,_,_,/theway_CONN_bytheway ,_,_,/g' *.tags

sed -i -e 's/by_IN_by the_DT_the way_NN_way )_)_)/bytheway_CONN_bytheway )_)_)/g' *.tags
sed -i -e 's/by_IN_by the_DT_the way_NN_way ._SENT_./bytheway_CONN_bytheway ._SENT_./g' *.tags

sed -i -e 's/_RB_consequently/_CONN_consequently/g' *.tags

sed -i -e 's/Correspondingly_RB_correspondingly/correspondingly_CONN_correspondingly/g' *.tags

sed -i -e 's/_IN_despite that_DT_that ,_,_,/this_CONN_despiteP ,_,_,/g' *.tags

sed -i -e 's/_IN_despite this_DT_this ,_,_,/this_CONN_despiteP ,_,_,/g' *.tags

sed -i -e 's/,_,_, equally_RB_equally ,_,_,/,_,_, equally_CONN_equally ,_,_,/g' *.tags
sed -i -e 's/;_:_; equally_RB_equally ,_,_,/;_:_; equally_CONN_equally ,_,_,/g' *.tags
sed -i -e 's/Equally_RB_equally ,_,_,/equally_CONN_equally ,_,_,/g' *.tags

sed -i -e 's/,_,_, even_RB_even so_RB_so ,_,_,/,_,_, evenso_CONN_evenso ,_,_,/g' *.tags
sed -i -e 's/Even_RB_even so_RB_so ,_,_,/evenso_CONN_evenso ,_,_,/g' *.tags

sed -i -e 's/_RB_eventually/_CONN_eventually/g' *.tags
# надо исключить except for: not_RB_not able_JJ_able to_TO_to move_VB_move at_IN_at all_DT_all except_IN_except for_IN_for my_PP$_my hand_NN_hand . Все остальные употребления mark discourse relations between propositions, but sed does not support lookarounds!
sed -i -e 's/_IN_except for_IN_for/_notCONN_exceptfor for_IN_for/g' *.tags # удаляем строки с except for, не меняя word count,  а потом аннотируем все употребления except как CONN; надо также исключить: which is why the program remains popular, except in coal-producing regions., services covered under Russia's national insurance system, except in medically necessary situtations., the buck has nowhere stop except with you, For "90 per cent" of the Christian refugees, as more than one of them told me, there is no solution except emigration from the Middle East.: вводим зпт и тире как критерий, исключаем сочетания с предлогом
sed -i -e 's/_IN_except in_IN_in/_notCONN_exceptin in_IN_in/g' *.tags
sed -i -e 's/_IN_except with_IN_with/_notCONN_exceptwith with_IN_with/g' *.tags

sed -i -e 's/,_,_, except _IN_except/,_,_, except_CONN_except/g' *.tags

sed -i -e 's/–_NN_– except _IN_except/–_NN_– except_CONN_except/g' *.tags

sed -i -e 's/Except_IN_except/Except_CONN_except/g' *.tags # for occurences like Except_IN_except Faria_NP_Faria said_VBD_say that_IN_that

sed -i -e 's/_JJ_first of_IN_of all_DT_all/ofall_CONN_firstofall/g' *.tags

sed -i -e 's/_RB_firstly/_CONN_firstly/g' *.tags

sed -i -e 's/_RB_first and_CC_and foremost_RB_foremost/andforemost_CONN_firstandforemost/g' *.tags

sed -i -e 's/,_,_, first_RB_first ,_,_,/,_,_, first_CONN_firstly ,_,_,/g' *.tags
sed -i -e 's/First_RB_first ,_,_,/first_CONN_firstly ,_,_,/g' *.tags
sed -i -e 's/and_CC_and first_RB_first ,_,_,/first_CONN_firstly ,_,_,/g' *.tags
sed -i -e 's/And_CC_and first_RB_first ,_,_,/first_CONN_firstly ,_,_,/g' *.tags

sed -i -e 's/,_,_, for_IN_for all_DT_all that_WDT_that/,_,_, forallthat_CONN_forallP/g' *.tags #варианта c this нет?
sed -i -e 's/For_IN_for all_DT_all that_WDT_that/forallthat_CONN_forallP/g' *.tags
sed -i -e 's/For_IN_for all_PDT_all that_DT_that/forallthat_CONN_forallP/g' *.tags
sed -i -e 's/,_,_, for_IN_for all_PDT_all that_WDT_that/,_,_, forallthat_CONN_forallP/g' *.tags
sed -i -e 's/,_,_, for_IN_for all_DT_all this_WDT_this/,_,_, forallthis_CONN_forallP/g' *.tags #добавила
sed -i -e 's/For_IN_for all_DT_all this_WDT_this/forallthis_CONN_forallP/g' *.tags
sed -i -e 's/For_IN_for all_PDT_all this_DT_this/forallthis_CONN_forallP/g' *.tags
sed -i -e 's/,_,_, for_IN_for all_PDT_all this_WDT_this/,_,_, forallthis_CONN_forallP/g' *.tags

sed -i -e 's/_IN_for one_CD_one thing_NN_thing/onething_CONN_foronething/g' *.tags
sed -i -e 's/_IN_for another_DT_another thing_NN_thing/anotherthing_CONN_foranotherthing/g' *.tags

sed -i -e 's/_IN_for example_NN_example/example_CONN_forexample/g' *.tags

sed -i -e 's/_IN_for instance_NN_instance/instance_CONN_forinstance/g' *.tags

sed -i -e 's/_IN_for that_DT_that reason_NN_reason/thatreason_CONN_forPreason/g' *.tags

sed -i -e 's/_IN_for this_DT_this reason_NN_reason/thisreason_CONN_forPreason/g' *.tags

sed -i -e 's/_RB_furthermore/_CONN_furthermore/g' *.tags

sed -i -e 's/Further_RBR_further ,_,_,/further_CONN_further ,_,_,/g' *.tags

sed -i -e 's/_RB_hence/_CONN_hence/g' *.tags

sed -i -e 's/_RB_however ,_,_,/_CONN_however ,_,_,/g' *.tags # зпт исключает however_RB_however good_JJ_good you_PP_you can_MD_can be_VB_be

sed -i -e 's/,_,_, incidentally_RB_incidentally/,_,_, incidentally_CONN_incidentally/g' *.tags
sed -i -e 's/Incidentally_RB_incidentally/incidentally_CONN_incidentally/g' *.tags

sed -i -e 's/_IN_in actual_JJ_actual fact_NN_fact/fact_CONN_infact/g' *.tags

sed -i -e 's/_IN_in addition_NN_addition ,_,_,/addition_CONN_inaddition ,_,_,/g' *.tags

sed -i -e 's/_IN_in any_DT_any case_NN_case/anycase_CONN_inanycase/g' *.tags

sed -i -e 's/_IN_in any_DT_any event_NN_event/anyevent_CONN_inanyevent/g' *.tags

sed -i -e 's/_IN_in comparison_NN_comparison ,_,_,/comparison_CONN_incomparison ,_,_,/g' *.tags
sed -i -e 's/_IN_by comparison_NN_comparison ,_,_,/comparison_CONN_incomparison ,_,_,/g' *.tags
sed -i -e 's/_IN_by way_NN_way of_IN_of comparison_NN_comparison ,_,_,/wayofcomparison_CONN_incomparison ,_,_,/g' *.tags
sed -i -e 's/_IN_by way_NN_way of_IN_of contrast_NN_contrast ,_,_,/wayofcontrast_CONN_incontrast ,_,_,/g' *.tags

sed -i -e 's/_IN_in conclusion_NN_conclusion ,_,_,/conclusion_CONN_inconclusion ,_,_,/g' *.tags

sed -i -e 's/_IN_in consequence_NN_consequence ,_,_,/consequence_CONN_inconsequence ,_,_,/g' *.tags

sed -i -e 's/,_,_, in_IN_in contrast_NN_contrast ,_,_,/,_,_, incontrast_CONN_incontrast ,_,_,/g' *.tags #учтен вариант by contrast
sed -i -e 's/In_IN_in contrast_NN_contrast ,_,_,/incontrast_CONN_incontrast ,_,_,/g' *.tags

sed -i -e 's/_IN_in fact_NN_fact/fact_CONN_infact/g' *.tags # вариант in actual fact  и as a matter of fact
sed -i -e 's/_IN_as a_DT_a matter_NN_matter of_IN_of fact_NN_fact/amatteroffact_CONN_asamatteroffact/g' *.tags

sed -i -e 's/_IN_in general_JJ_general ,_,_,/general_CONN_ingeneral ,_,_,/g' *.tags
sed -i -e 's/_IN_in general_NN_general ,_,_,/general_CONN_ingeneral ,_,_,/g' *.tags
sed -i -e 's/in_IN_in general_NN_general ._SENT_./ingeneral_CONN_ingeneral ._SENT_./g' *.tags

sed -i -e 's/_IN_in other_JJ_other words_NNS_word ,_,_,/otherwords_CONN_inotherwords ,_,_,/g' *.tags

sed -i -e 's/,_,_, in_IN_in particular_JJ_particular/,_,_, inparticular_CONN_inparticular/g' *.tags
sed -i -e 's/In_IN_in particular_JJ_particular ,_,_,/inparticular_CONN_inparticular ,_,_,/g' *.tags

sed -i -e 's/_IN_in short_JJ_short ,_,_,/short_CONN_inshort ,_,_,/g' *.tags

sed -i -e 's/_IN_in spite_NN_spite of_IN_of that_DT_that ,_,_,/spiteofthat_CONN_inspiteofP ,_,_,/g' *.tags

sed -i -e 's/_IN_in such_JJ_such cases_NNS_case/suchacase_CONN_insuchacase/g' *.tags # 'это не коннектор, а какой-то другой способ выражения связности, нет? Это обстоятельство в предложении, обозначающее условие. Неправильно! Это причина/условие следствие, в русском словаре это наречный оборот. В английских не нашла. Включаю в список
sed -i -e 's/_IN_in such_PDT_such a_DT_a case_NN_case/suchacase_CONN_insuchacase/g' *.tags
sed -i -e 's/in_IN_in that_DT_that case_NN_case/insuchacase_CONN_insuchacase/g' *.tags
sed -i -e 's/In_IN_in that_DT_that case_NN_case/insuchacase_CONN_insuchacase/g' *.tags

sed -i -e 's/_IN_in summary_NN_summary ,_,_,/summary_CONN_insummary ,_,_,/g' *.tags

sed -i -e 's/In_IN_in sum_NN_sum ,_,_,/insum_CONN_insum ,_,_,/g' *.tags

sed -i -e 's/_IN_in that_DT_that regard_NN_regard/thatregard_CONN_inPregard/g' *.tags
sed -i -e 's/_IN_in this_DT_this regard_NN_regard/thisregard_CONN_inPregard/g' *.tags

#sed -i -e 's/_IN_in the_DT_the first_JJ_first place_NN_place ,_,_,/thefirstplace_CONN_inthefirstplace !_SENT_!/g' *.tags # Merriam-Webster insists that in sent-final position it means to begin with (there is always should or negation in the sent!). The second use underlines the importance and there can be in the second place, then. Это скорее эмоциональность, а не связность. Чем переводится? demand begins to fall, undercutting the purpose of the increase in the first place. = в первую очередь; which the Europeans had taken from the natives in the first place = которые до этого были захвачены европейцами у местного населения; Yes, but that only raises a further question of why the conflict happened along religious lines in the first place. = Да, но в таком случае возникает другой вопрос: почему вообще возник конфликт на религиозной основе?
#sed -i -e 's/in_IN_in the_DT_the first_JJ_first place_NN_place ._SENT_./inthefirstplace_CONN_inthefirstplace ._SENT_./g' *.tags

sed -i -e 's/_IN_in the_DT_the meantime_NN_meantime/themeantime_CONN_inthemeantime/g' *.tags

sed -i -e 's/,_,_, in_IN_in the_DT_the same_JJ_same way_NN_way ,_,_,/,_,_, inthesameway_CONN_inthesameway ,_,_,/g' *.tags
sed -i -e 's/;_:_; in_IN_in the_DT_the same_JJ_same way_NN_way ,_,_,/;_:_; inthesameway_CONN_inthesameway ,_,_,/g' *.tags
sed -i -e 's/In_IN_in the_DT_the same_JJ_same way_NN_way ,_,_,/inthesameway_CONN_inthesameway ,_,_,/g' *.tags
sed -i -e 's/In_IN_in the_DT_the second_JJ_second place_NN_place ,_,_,/inthesecondplace_CONN_inthesecondplace ,_,_,/g' *.tags

sed -i -e 's/I_PP_I mean_VBP_mean ,_,_,/imean_CONN_imean ,_,_,/g' *.tags
sed -i -e 's/,_,_, I_PP_I mean_VBP_mean ._SENT_./imean_CONN_imean ,_,_,/g' *.tags

sed -i -e 's/_PP_it can_MD_can be_VB_be concluded_VBN_conclude/canbeconcluded_CONN_canbeconcluded/g' *.tags

sed -i -e 's/_PP_it follows_VBZ_follow that_IN_that/followsthat_CONN_itfollowsthat/g' *.tags # считаем это грамматикалихованными предложениями в функции коннекторов

sed -i -e 's/;_:_; lastly_RB_lastly ,_,_,/;_:_; lastly_CONN_lastly ,_,_,/g' *.tags
sed -i -e 's/,_,_, lastly_RB_lastly ,_,_,/,_,_, lastly_CONN_lastly ,_,_,/g' *.tags
sed -i -e 's/Lastly_RB_lastly/lastly_CONN_lastly/g' *.tags

sed -i -e 's/,_,_, likewise_RB_likewise/,_,_, likewise_CONN_likewise/g' *.tags
sed -i -e 's/;_:_; likewise_RB_likewise/;_:_; likewise_CONN_likewise/g' *.tags
sed -i -e 's/Likewise_RB_likewise/likewise_CONN_likewise/g' *.tags

sed -i -e 's/Meantime_NN_meantime/Meantime_CONN_inthemeantime/g' *.tags

sed -i -e 's/meanwhile_RB_meanwhile ,_,_,/meanwhile_CONN_meanwhile ,_,_,/g' *.tags
sed -i -e 's/Meanwhile_RB_meanwhile/meanwhile_CONN_meanwhile/g' *.tags

#sed -i -e 's/_VB_mind you_PP_you ,_,_,/you_CONN_mindyou ,_,_,/g' *.tags # interactive rather than connective element

sed -i -e 's/_RB_moreover/_CONN_moreover/g' *.tags

sed -i -e 's/,_,_, more_RBR_more accurately_RB_accurately ,_,_,/,_,_, moreaccurately_CONN_moreaccurately ,_,_,/g' *.tags
sed -i -e 's/More_RBR_more accurately_RB_accurately ,_,_,/moreaccurately_CONN_moreaccurately ,_,_,/g' *.tags

sed -i -e 's/_RBR_more importantly_RB_importantly/importantly_CONN_moreimportantly/g' *.tags

sed -i -e 's/,_,_, more_RBR_more precisely_RB_precisely ,_,_,/,_,_, moreprecisely_CONN_moreprecisely ,_,_,/g' *.tags
sed -i -e 's/More_RBR_more precisely_RB_precisely ,_,_,/moreprecisely_CONN_moreprecisely ,_,_,/g' *.tags

sed -i -e 's/_RBR_more to_TO_to the_DT_the point_NN_point/tothepoint_CONN_moretothepoint/g' *.tags

sed -i -e 's/_RB_namely/_CONN_namely/g' *.tags

#sed -i -e 's/Naturally_RB_naturally/naturally_CONN_naturally/g' *.tags # this is rather attitude and evaluation. Oxford: sentence adverb As may be expected; of course. naturally, I hoped for the best

sed -i -e 's/_RB_nevertheless/nevertheless_CONN_nevertheless/g' *.tags

sed -i -e 's/_RB_nonetheless/_CONN_nonetheless/g' *.tags

sed -i -e 's/Notwithstanding_RB_notwithstanding ,_,_,/notwithstanding_CONN_notwithstanding ,_,_,/g' *.tags
sed -i -e 's/notwithstanding_RB_notwithstanding ._SENT_./notwithstanding_CONN_notwithstanding ._SENT_./g' *.tags

sed -i -e 's/,_,_, now_RB_now ,_,_,/,_,_, now_CONN_now ,_,_,/g' *.tags
sed -i -e 's/;_:_; now_RB_now ,_,_,/;_:_; now_CONN_now ,_,_,/g' *.tags
sed -i -e 's/:_:_: now_RB_now ,_,_,/:_:_: now_CONN_now ,_,_,/g' *.tags
sed -i -e 's/Now_RB_now ,_,_,/now_CONN_now ,_,_,/g' *.tags

sed -i -e 's/,_,_, once_RB_once again_RB_again ,_,_,/,_,_, onceagain_CONN_onceagain ,_,_,/g' *.tags
sed -i -e 's/Once_RB_once again_RB_again ,_,_,/onceagain_CONN_onceagain ,_,_,/g' *.tags
sed -i -e 's/ONCE_RB_once again_RB_again ,_,_,/onceagain_CONN_onceagain ,_,_,/g' *.tags

sed -i -e 's/_IN_on a_DT_a different_JJ_different note_NN_note/adifferentnote_CONN_onadifferentnote/g' *.tags

sed -i -e 's/_IN_on the_DT_the contrary_NN_contrary/thecontrary_CONN_onthecontrary/g' *.tags

sed -i -e 's/_IN_on the_DT_the one_CD_one hand_NN_hand/theonehand_CONN_ontheonehand/g' *.tags

sed -i -e 's/_IN_on the_DT_the other_JJ_other hand_NN_hand/theotherhand_CONN_ontheotherhand/g' *.tags

sed -i -e 's/_IN_on the_DT_the whole_NN_whole ,_,_,/thewhole_CONN_onthewhole ,_,_,/g' *.tags

sed -i -e 's/_IN_on top_NN_top of_IN_of that_DT_that ,_,_,/topofthat_CONN_ontopofP ,_,_,/g' *.tags
sed -i -e 's/_IN_on top_NN_top of_IN_of this_DT_this ,_,_,/topofthis_CONN_ontopofP ,_,_,/g' *.tags

sed -i -e 's/_CC_or at_IN_at least_JJS_least/atleast_CONN_atleast/g' *.tags

sed -i -e 's/or_CC_or more_RBR_more accurately_RB_accurately/moreaccurately_CONN_moreaccurately/g' *.tags

sed -i -e 's/_VBP_put it_PP_it another_DT_another way_NN_way/itanotherway_CONN_putitanotherway/g' *.tags
sed -i -e 's/_VBP_put it_PP_it bluntly_RB_bluntly/itanotherway_CONN_putitanotherway/g' *.tags
sed -i -e 's/_VBP_put it_PP_it mildly_RB_mildly/itanotherway_CONN_putitanotherway/g' *.tags

sed -i -e 's/_RB_rather ,_,_,/_CONN_rather ,_,_,/g' *.tags

sed -i -e 's/_RB_secondly ,_,_,/_CONN_secondly ,_,_,/g' *.tags
sed -i -e 's/,_,_, second_RB_second ,_,_,/,_,_, second_CONN_secondly ,_,_,/g' *.tags
sed -i -e 's/Second_RB_second ,_,_,/second_CONN_secondly ,_,_,/g' *.tags

sed -i -e 's/_RB_similarly ,_,_,/_CONN_similarly ,_,_,/g' *.tags

sed -i -e 's/Subsequently_RB_subsequently ,_,_,/subsequently_CONN_subsequently ,_,_,/g' *.tags

sed -i -e 's/That_DT_that said_VBD_say ,_,_,/thatsaid_CONN_thatsaid ,_,_,/g' *.tags

sed -i -e 's/that_WDT_that is_VBZ_be to_TO_to say_VB_say/thatistosay_CONN_thatistosay/g' *.tags

sed -i -e 's/then_RB_then ._SENT_./then_CONN_then ._SENT_./g' *.tags
sed -i -e 's/,_,_, then_RB_then ,_,_,/then_CONN_then ,_,_,/g' *.tags
sed -i -e 's/Then_RB_then ,_,_,/then_CONN_then ,_,_,/g' *.tags

sed -i -e 's/_RB_therefore/_CONN_therefore/g' *.tags

sed -i -e 's/_RB_thirdly ,_,_,/_CONN_thirdly ,_,_,/g' *.tags

sed -i -e 's/,_,_, third_RB_third ,_,_,/,_,_, third_CONN_third ,_,_,/g' *.tags
sed -i -e 's/Third_RB_third ,_,_,/third_CONN_third ,_,_,/g' *.tags

sed -i -e 's/,_,_, though_RB_though ._SENT_./though_CONN_though ._SENT_./g' *.tags

#sed -i -e 's/Thus_RB_thus/thus_CONN_thus/g' *.tags # it makes sense to relax the constraints here and go for thus (no comma, lower)
sed -i -e 's/_RB_thus/_CONN_thus/g' *.tags
#sed -i -e 's/,_,_, thus_RB_thus/,_,_, thus_CONN_thus/g' *.tags
#sed -i -e 's/;_:_; thus_RB_thus/;_:_; thus_CONN_thus/g' *.tags
#sed -i -e 's/_CC_and thus_RB_thus/thus_CONN_thus/g' *.tags

sed -i -e 's/too_RB_too !_SENT_!/too_CONN_too !_SENT_!/g' *.tags
sed -i -e 's/too_RB_too ?_SENT_?/too_CONN_too ?_SENT_?/g' *.tags
sed -i -e 's/too_RB_too ._SENT_./too_CONN_too ._SENT_./g' *.tags

sed -i -e 's/To_TO_To begin_VB_begin with_IN_with ,_,_,/Tostartwith_CONN_tostartwith ,_,_,/g' *.tags

sed -i -e 's/To_TO_to cap_VB_cap it_PP_it all_DT_all/Tocapitall_CONN_tocapitall/g' *.tags

sed -i -e 's/To_TO_To cap_VB_cap it_PP_it all_RB_all/Tocapitall_CONN_tocapitall/g' *.tags

sed -i -e 's/To_TO_To start_VB_start with_IN_with ,_,_,/Tostartwith_CONN_tostartwith ,_,_,/g' *.tags

sed -i -e 's/_RB_ultimately/ultimately_CONN_ultimately/g' *.tags

sed -i -e 's/To_TO_To summarise_VB_summarise ,_,_,/Tosummarise_CONN_sumup ,_,_,/g' *.tags
sed -i -e 's/To_TO_To summarize_VB_summarize ,_,_,/Tosummarize_CONN_sumup ,_,_,/g' *.tags
sed -i -e 's/To_TO_To sum_VB_sum up_RB_up ,_,_,/Tosumup_CONN_sumup ,_,_,/g' *.tags
sed -i -e 's/To_TO_To sum_VB_sum up_RB_up :_:_:/Tosumup_CONN_sumup :_:_:/g' *.tags

sed -i -e 's/_WP_what is_VBZ_be more_JJR_more/ismore_CONN_whatismore/g' *.tags

sed -i -e 's/which_WDT_which is_VBZ_be to_TO_to say_VB_say/whichistosay_CONN_thatistosay/g' *.tags
sed -i -e 's/Yet_RB_yet ,_,_,/yet_CONN_yet ,_,_,/g' *.tags

# new arrivals upon inspecting pop-sci ted and written
#to get rid of  "so runs_VBZ_run postwar_JJ_postwar history_NN_history ,_,_," and so that , ORDER MATTERS!
sed -i -re 's/So_RB_so \S+_VB[^G]_\S+\s/SoVERB_simCONN_SO verb_VB_verb /g' *.tags
sed -i -re 's/_RB_so that_IN_that/that_notCONN_SO that_IN_that/g' *.tags
sed -i -re 's/\S+_VB[^G]_\S+ so_RB_so/verbVBverb VerbSo_notCONN_SO/g' *.tags
#sed -i -re 's/not_RB_not so_RB_so/notSo_notCONN_notSO/g' *.tags # does not make sense because I don't target in-sentence lowercase so
sed -i -e 's/So_RB_so/SO_CONN_SO/g' *.tags #убрала зпт

sed -i -e 's/Otherwise_RB_otherwise/Otherwise_CONN_otherwise/g' *.tags
sed -i -e 's/,_,_, otherwise_RB_otherwise/,_,_, otherwise_CONN_otherwise/g' *.tags
sed -i -e 's/:_:_: otherwise_RB_otherwise/:_:_: otherwise_CONN_otherwise/g' *.tags
sed -i -e 's/;_:_; otherwise_RB_otherwise/;_:_; otherwise_CONN_otherwise/g' *.tags

sed -i -e 's/,_,_, but_CC_but otherwise_RB_otherwise/,_,_, butotherwise_CONN_otherwise/g' *.tags
sed -i -e 's/-_:_- otherwise_RB_otherwise/-_:_- otherwise_CONN_otherwise/g' *.tags

sed -i -e 's/To_TO_To recapitulate_VB_recapitulate ,_,_,/Torecapitulate_CONN_tocapitall ,_,_,/g' *.tags

sed -i -e 's/As_IN_as already_RB_already noted_VBN_note ,_,_,/ihavealreadynoted_CONN_ihavealreadynoted ,_,_,/g' *.tags

sed -i -e 's/Indeed_RB_indeed/indeed_CONN_indeed/g' *.tags #убрала зпт

#применять к размеченным TreeTagger корпусам


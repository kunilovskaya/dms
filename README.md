the repository contains scripts and support files for processing/extracting statistics/visualising learners tmx and professional tmx (and reference (txt) corpora with regard to discourse markers analysis

for some scripts there are duplicates in python and ipython notebook

ATTENTION! a lot of arguments are hard-coded!


preprocessing (tag_tmx folder and mult_customize_tmx/uniq_customize_tmx as well as throwout_shorttexts_fromtmx.ipynb)
	a) filtering
	b) tagging and annotating dms of types CONN and *EM
	
stats: extracting statistics (searchlists provided in search folder) 
	a) descriptive stats 
		separately for documents and for items
		separately for monoligual reference corpora (txt) and for parallel test corpora (tmx, separately for learners and prof)
	b) inferencial: wilkoxon ranksum for translationally distinctive dms

plots: has suppot files and scripts that produce visual representations of (comparisons for) distributions, ST-TT correlation
	histograms
	boxplots
	barplots
	regression
	


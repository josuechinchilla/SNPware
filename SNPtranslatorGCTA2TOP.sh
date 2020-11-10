#!/bin/bash

########################################
#Name: SNPtranslator.sh
#Version 3.1
#Author: Josue Chinchilla-Vargas
#Date: May 5, 2020
#Iowa State University
#
#Notes:
#To compile: chmod u+x SNPdictionarypipeline.sh
#
#Use: ./SNPtranslator $1 $2 $3 
# $1: final report file
# $2: genotype file in long format
# $3: name of the output files
#example: ./SNPtranslator.sh final_reports_merged.txt geno.txt output_name
#Known Bugs: NA
#
########################################

#kill script if errors occur.  When not testing code- remove '-o xtrace' to not see all code while running
set -o errexit -o nounset -o pipefail  #-o xtrace

echo "CREATING GENOTYPE DICCTIONARY..."
awk -F ' ' '{print $1" "$3" "$4" "$5" "$6}' $1 > step1.jo #input file is output of the final report merger, considered the reference population for SNP coding.
awk -F ' ' '{print $1}' step1.jo > ids.jo
cut -d ' ' -f2- step1.jo  | sed 's/ //g' | sed 's/.\{2\}/& /g' | tr ' ' '\t' >noids.jo

echo "CREATING OUTPUT FILES...."
echo "SNP_ID	GCTA_Genotype	TOP_Genotype"> header_long.jo
paste ids.jo noids.jo > almost_long.jo
cat header_long.jo almost_long.jo > $3_dictionary_long.txt

awk '
!(a[$1]) {a[$1]=$0; next}
a[$1] {w=$1; $1=""; a[w]=a[w] $0}
END {for (i in a) print a[i]}
' FS="\t" OFS="\t" $3_dictionary_long.txt > step4.jo
echo "SNP_ID	GCTA_Genotype	TOP_Genotype		GCTA_Genotype	TOP_Genotype		GCTA_Genotype	TOP_Genotype		GCTA_Genotype	TOP_Genotype">header_wide.jo
sort -k1,1 step4.jo > $3_dictionary_wide.jo
cat header_wide.jo $3_dictionary_wide.jo> $3_dictionary_wide.txt

head -1 $2 >geno_header.jo
tail -n +2 $2 >geno_noheader.jo
sort -k2 geno_noheader.jo >sorted.jo
awk -F ' ' '{print $1" "$2"*"$3" "$3}' sorted.jo| sort -k2 > star_geno.jo

awk -F ' ' '{print $1"*"$2" "$3}' $3_dictionary_long.txt | tr '\t' ' ' | sort > template.jo
join -1 2 -2 1  star_geno.jo template.jo > matched.jo
tr '*' ' '< matched.jo > nostar.jo
awk -F ' ' '{print $3" "$1" "$4" "$5}' nostar.jo | tr ' ' '\t' >done_noheader.jo
echo "ID SNP_ID GCTA_Genotype TOP_Genotype" >final_header.jo
cat final_header.jo done_noheader.jo | tr ' ' '\t'> $3_equivalence.txt
awk -F ' ' '{print $1" "$2" "$4}' $3_equivalence.txt | sort -k1 > $3_TOP_genotypes_long.txt



echo "REMOVING INTERMEDIATE FILES..."
rm *.jo

echo "DONE"

#!/bin/bash
#==============================================================================#
# Header
#==============================================================================#
# ISU - Animal Breeding and Genetics Group
# Author: Josue Chinchilla-Vargas et al.
# Created (date): June 7, 2020
# Version (of the script): 1.0
#==============================================================================#
# Description
#==============================================================================#

# SNPlibrarian.Top2AB uses as many illumina final report files to create a genotype library that shows all genotypes available at each locus in coded as Illumia Top strand and their equivalence in AB code.
# The library is produced in wide and long format

#==============================================================================#
# Setup
#==============================================================================#
#Input files:

#	As many Illumina FinalReport files as wanted

# Output files:

#	Top2AB_genotype_dictionary_wide.txt: Wide format dictionary of genotypes at each loci coded as Top and their equivalence in AB.
# Format: 
#	SNP_ID	Top_Genotype	AB_Genotype		Top_Genotype	AB_Genotype		Top_Genotype	AB_Genotype		Top_Genotype	AB_Genotype
	#SNP1	--				--				AA				AA				AG				AB				GG				BB	

#	Top2AB_genotype_dictionary_long.txt: Long format dictionary of genotypes at each loci coded as Top and their equivalence in AB.
# Format:
#	SNP_ID	Top_Genotype	AB_Genotype
#	SNP1	AG				AB

#==============================================================================#
set -o errexit -o nounset -o pipefail


echo "PROCESSING FINAL REPORTS"

for i in $@; do
  tail -n +11 $i > final_report$i.fr
  echo "" >>  final_report$i.fr
  
done

cat *.fr > final_reports_merged.jo


echo "CREATING GENOTYPE DICTIONARY..."
awk -F ' ' '{print $1" "$5" "$6" "$7" "$8}' final_reports_merged.jo > step1.jo
sort -k1,1 step1.jo| uniq > step2.jo
awk -F ' ' '{print $1}' step2.jo > ids.jo
cut -d ' ' -f2- step2.jo  | sed 's/ //g' | sed 's/.\{2\}/& /g' | tr ' ' '\t' >noids.jo

echo "CREATING OUTPUT FILES...."
echo "SNP_ID	Top_Genotype	AB_Genotype"> header_long.jo
paste ids.jo noids.jo > almost_long.jo
cat header_long.jo almost_long.jo > Top2AB_genotype_dictionary_long.txt

awk '
!(a[$1]) {a[$1]=$0; next}
a[$1] {w=$1; $1=""; a[w]=a[w] $0}
END {for (i in a) print a[i]}
' FS="\t" OFS="\t" Top2AB_genotype_dictionary_long.txt > step4.jo
echo "SNP_ID	Top_Genotype	AB_Genotype		Top_Genotype	AB_Genotype		Top_Genotype	AB_Genotype		Top_Genotype	AB_Genotype">header_wide.jo
sort -k1,1 step4.jo > Top2AB_genotype_dictionary_wide.jo
cat header_wide.jo Top2AB_genotype_dictionary_wide.jo> Top2AB_genotype_dictionary_wide.txt


rm *.jo
rm *.fr

echo "DONE"
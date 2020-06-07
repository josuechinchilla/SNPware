#!/bin/bash
#==============================================================================#
# Header
#==============================================================================#
# ISU - Animal Breeding and Genetics Group
# Author: Josue Chinchilla-Vargas et al.
# Created (date): June 7, 2020
# Version (of the script): 1.0
# Program (if applicable):
# Program Version (if applicable):
#==============================================================================#
# Description
#==============================================================================#

# SNPtranslator works with a genotype library produced by SNPlibrarian to translate genotype files in long format from GCTA or Top to AB format.

#==============================================================================#
# Setup
#==============================================================================#
#Input files:

#	$1: genotype in long fromat
# Format:  
#  ID	SNP_ID	Genotype
#  UD1	SNP1	GG

#	$2: genotype library in long format
# Format:
#	SNP_ID	GCTA_Genotype	AB_Genotype
#	SNP1	TA				AB

# Output files:

#	$1_genotype_equivalence.txt: Equivalence table between genotype in original format and genotype in new format at each loci for each individual.
# Format: 
#	ID	SNP_ID	GCTA_Genotype	AB_Genotype
#	ID1	SNP1	CC				BB

#	$1_AB_genotypes_long.txt: AB genotypes in long format.
# Format:
#	ID	SNP_ID	AB_Genotype
#	ID1	SNP1	BB

#==============================================================================#
set -o errexit -o nounset -o pipefail

echo "CREATING OUTPUT FILES...."
head -1 $1 >geno_header.jo
tail -n +2 $1 >geno_noheader.jo
sort -k2 geno_noheader.jo >sorted.jo
awk -F ' ' '{print $1" "$2"*"$3" "$3}' sorted.jo| sort -k2 > star_geno.jo

awk -F ' ' '{print $1"*"$2" "$3}' $2 | tr '\t' ' ' | sort > template.jo
join -1 2 -2 1  star_geno.jo template.jo > matched.jo
tr '*' ' '< matched.jo > nostar.jo
awk -F ' ' '{print $3" "$1" "$4" "$5}' nostar.jo | tr ' ' '\t' | sort -k1 >done_noheader.jo
echo "ID SNP_ID GCTA_Genotype AB_Genotype" >final_header.jo
cat final_header.jo done_noheader.jo | tr ' ' '\t'> $1_genotype_equivalence.txt
awk -F ' ' '{print $1" "$2" "$4}' $1_genotype_equivalence.txt | sort -k1 > $1_AB_genotypes_long.txt



echo "REMOVING INTERMEDIATE FILES..."
rm *.jo

echo "DONE"

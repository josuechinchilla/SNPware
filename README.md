# SNPWare
SNPware is a family of short bash scripts that allows to translate genotypes coded as GCTA or Illuimina Top Strand to AB coding. The scripts work using standard Illumina FinalReport files to create a library of genotypes at each locus through the different SNPlibrarians. The genotype library is then used as an input for SNPtranslator to translate genotypes to the desire coding.

The methods in these scripts require a set of reference data (Illumina FinalReport files) and the genotypes to be transalted in LONG format.

## Contents
SNPWare includes 7 scripts:
```
- SNPlibrarian.GC2AB -> creates GCTA to AB library.
- SNPlibrarian.Top2AB -> creates Top strand to AB library.
- SNPlibrarian.AB2GC -> creates AB to GCTA library.
- SNPlibrarian.AB2Top -> creates AB to Top strand library.
- SNPlibrarian.GC2Top -> creates GCTA to Top strand library.
- SNPlibrarian.Top2GC -> creates Top strand to GCTA library.
- SNPtranslator -> Uses output from the SNPlibrarians to translate genotypes to the desired coding format.
```
## SNPlibrarians
All the SNPlibrarian codes work in the same manner:

### Usage
./SNPlibrarian.X2Y.sh FinalReport1 FinalReport2 ... FinalReportZ

### Input files:
As many Illumina FinalReport files as wanted.

### Output files:
### X2Y_genotype_dictionary_wide.txt: 
WIDE format dictionary of genotypes at each loci coded as X and their equivalence in Y.
#### Format: 
SNP_ID	X_Genotype1	Y_Genotype1		X_Genotype2	Y_Genotype2		X_Genotype3	Y_Genotype3		X_Genotype4	Y_Genotype4

### X2Y_genotype_dictionary_long.txt: 
Long format dictionary of genotypes at each loci coded as X and their equivalence in Y.
#### Format:
SNP_ID   X_Genotype	 Y_Genotype


## SNPtranslator
SNPtranslator works with a genotype library produced by one fo the SNPlibrarians to translate genotype files in LONG format from X to Y coding.
### Usage
./SNPtranslator genotype_file X2Y_genotype_dictionary_long.txt

### Input files:

 ### genotype_file
 genotype of individuals to be translated in LONG format with header. Genotype at each locus should be in capital letters with NO space between them (AA) and missing should be coded as --.
#### Format:  
ID	SNP_ID	Genotype

### X2Y_genotype_dictionary_long.txt: 
Long format dictionary of genotypes at each loci coded as X and their equivalence in Y.
#### Format:
SNP_ID   X_Genotype	 Y_Genotype

### Output files:

###	genotype_equivalence.txt: 
Equivalence table between genotype in original format and genotype in new format at each loci for each individual.
#### Format: 
ID	SNP_ID	GCTA_Genotype	AB_Genotype

###	Y_genotypes_long.txt: AB genotypes in long format.
#### Format:
ID	SNP_ID	Y_Genotype

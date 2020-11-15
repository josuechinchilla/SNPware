# SNPWare
SNPware is a family of short bash scripts that allows to translate genotypes coded as GCTA or Illuimina Top Strand to AB coding. The scripts work using standard Illumina FinalReport files to create a "dictionary" of genotypes at each locus. The genotype "dictionary" is then used  to translate genotypes to the desired coding format.

The methods in these scripts require a set of reference data (Illumina FinalReport files) and the genotypes to be translated in LONG format.

## Contents
SNPWare includes 7 scripts:
```
- FinaReprot_merger.sh
- SNPtranslator_GCTA2TOP.sh
- SNPtranslator_AB2TOP.sh 
- SNPtranslator_TOP2AB.sh
- SNPtranslator_TOP2GCTA.sh
- SNPtranslator_AB2GCTA.sh
- SNPtranslator_GCTA2AB.sh

```
## FinaReprot_merger
### Usage
./FinaReprot_merger FinalReport1 FinalReport2 ... FinalReportZ

### Input files:
As many Illumina FinalReport files as wanted.

### Output file:
### Final_reports_merged.txt: 
catted final reports with no header.



## SNPtranslator
SNPtranslator works with a genotype library produced by one fo the SNPlibrarians to translate genotype files in LONG format from X to Y coding.
### Usage
./SNPtranslator ./SNPtranslator final_reports_merged.txt genotype_file output_files

### Input files:

 ### final_reports_merged.txt
 catted final reports with no header to be used as reference population to translate the genotypes.
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

#!/bin/bash

########################################
#Name: FinalReport_merger.sh
#Version 1.0
#Author: Josue Chinchilla-Vargas
#Date: May 5, 2020
#Iowa State University
#
#Notes:
#To compile: chmod u+x SNPdictionarypipeline.sh
#
#Use: FinalReport_merger.sh FinalReport1 FinalReport2 ... FinalReportZ
#Known Bugs: NA
#
########################################

#kill script if errors occur.  When not testing code- remove '-o xtrace' to not see all code while running
set -o errexit -o nounset -o pipefail  #-o xtrace


echo "PROCESSING FINAL REPORTS"


for i in $@; do
  tail -n +11 $i > final_report$i.fr
  echo "" >>  final_report$i.fr
  
done

cat *.fr > final_reports_merged.txt
rm *.fr
echo "DONE"
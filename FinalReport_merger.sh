#!/bin/bash

#set -o errexit -o nounset -o pipefail


echo "PROCESSING FINAL REPORTS"


for i in $@; do
  tail -n +11 $i > final_report$i.fr
  echo "" >>  final_report$i.fr
  
done

cat *.fr > final_reports_merged.txt
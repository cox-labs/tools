# tools
## MedianVar.R
This script is for calculating the median of normalized variance from a Perseus matrix table.

How to run:<br/>
args[1] - Perseus matrix table of proteinGroup table<br/>
args[2] - Row number of the annotation for sample groups<br/>
args[3] - Row number of the annotation of Type which shows E, N, C and T<br/>
args[4] - Row number of the first row of intensity values<br/>
EX: Rscript MedianVar.R proteinGroup_Perseus.txt 4 1 5<br/>

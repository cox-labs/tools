#devtools::install_github("cox-labs/PerseusR")
library(PerseusR)
args = commandArgs(trailingOnly=TRUE)
if (length(args) != 2) {stop(paste("This script is for calculating the median of normalized variance from a Perseus matrix table.
How to run:
args[1] - Perseus matrix table of proteinGroup table
args[2] - Row number of the annotation for sample groups
args[3] - Row number of the annotation of Type which shows E, N, C and T
args[4] - Row number of the first row of intensity values
EX: Rscript MedianVar.R proteinGroup_Perseus.txt 4 1 5\n" ,sep="\n"), call.=FALSE)}
cat("Running now...\n")
inFile <- args[1]
outFile <- args[2]
#inFile<-"C:/Users/animeshs/GD/tools/MedianVar/proteinGroup_Perseus.txt"
mdata <- read.perseus(inFile)
Samples<-mdata@annotRows$Samples
celltypes <- as.character(unique(Samples))
Type<-mdata@annotRows$Experiments
Channel<-mdata@annotRows$Channels
Uniprot<-paste(mdata@annotCols$Protein.IDs)
counts<- main(mdata)
counts<-counts[complete.cases(counts), ]
#countz<-counts
colnames(counts)<-Samples
vars<-c()
a<-1
for (cell in celltypes){
  counts2 <- counts[,grepl(cell, names(counts))]
  nor_vars_c <- c()
  l<-1
  for(j in seq(1, nrow(counts2))) {
    nor_vars_c[l] <- var(unlist(counts2[j,]), na.rm=TRUE)/var(unlist(counts[j,]), na.rm=TRUE)
    l<-l+1
  }
  vars[a]<-median(nor_vars_c,na.rm = T)
  a<-a+1
}
#countz2<-counts2
df <- data.frame(matrix(unlist(vars), nrow=length(vars), byrow=T))
colnames(df)<-c("median of normalized variances")
#print(df)
outMdata <- matrixData(main=df,annotCols=as.data.frame(matrix(unlist(celltypes), nrow=length(vars), byrow=T)))
#outFile<-"C:/Users/animeshs/GD/tools/MedianVar/proteinGroup_Perseus.txt.out.txt"
write.perseus(outMdata,annotCols=celltypes, outFile)
cat("Done...\n")

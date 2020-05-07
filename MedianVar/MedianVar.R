cat(paste("This script is for calculating the median of normalized variance from a Perseus matrix table.
How to run:
args[1] - Perseus matrix table of proteinGroup table
args[2] - Row number of the annotation for sample groups
args[3] - Row number of the annotation of Type which shows E, N, C and T
args[4] - Row number of the first row of intensity values
EX: Rscript MedianVar.R proteinGroup_Perseus.txt 4 1 5\n" ,sep="\n"))

args = commandArgs(trailingOnly=TRUE)
counts<- read.table(args[1], header=TRUE, comment.char = '&', sep='\t', stringsAsFactors = F)
cat("Running now...\n")
celltypes <- c()
newColNames <- c()
d<-1
c<-1
for (gname in counts[args[2],]){
  if (nchar(gname) != 0){
    if (grepl('#', gname)){
      ind<-which(strsplit(gname, "")[[1]]=="}")
      gname<-substr(gname, ind+1, nchar(gname))
    }
    newColNames[d]<-gname
    if (isTRUE(gname %in% celltypes)){
    } else {
      celltypes[c] <- gname
      c<-c+1
    }
    d<-d+1
  }
}
tnames<-paste(rev(counts[args[3],]), sep ='')
ind<-match('E', tnames)
colInd<-ncol(counts)-ind+1
df<-counts[args[4]:nrow(counts),1:colInd]
counts<-data.frame()
for(j in seq(1, nrow(df))) {
  detect <- FALSE
  for(k in seq(1, ncol(df))) {
    if ((grepl("NaN", df[j,k]))){
      detect <- TRUE
    }
  }
  if (isTRUE(detect)){
  }
  else{
    counts <- rbind(counts, df[j,])
  }
}
colnames(counts)<-newColNames
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
  vars[a]<-median(nor_vars_c)
  a<-a+1
}
df <- data.frame(matrix(unlist(vars), nrow=length(vars), byrow=T))
rownames(df)<-celltypes
colnames(df)<-c("median of normalized variances")
print(df)

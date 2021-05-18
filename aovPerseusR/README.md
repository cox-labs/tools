## proteinGroupsANOVA.r
R script callable via https://github.com/cox-labs/PerseusR that can reproduce the ANOVA p&q-values(using Benjamini/Hochberg) from [Multiple-sample tests in Perseus](http://coxdocs.org/doku.php?id=perseus:user:activities:MatrixProcessing:Tests:MultipleSampleTestProcessing): It also provides the mean-difference with posthoc/TukeyHSD corrected p-values for each group comparison as shown in the attached Perseus session. Need to be mindful that NAs are being imputed as 0 so better to take care of NAs in Perseus beforehand! 

## pre-requisites
[R](https://cloud.r-project.org/), [devtools](https://www.r-project.org/nosvn/pandoc/devtools.html) and [PerseusR](https://github.com/cox-labs/PerseusR) , note on windows if 
`"Error in utils::download.file(url, path, method = method, quiet = quiet,  :cannot open URL 'https://api.github.com/repos/cox-labs/PerseusR/tarball/HEAD'"
`use
`options(download.file.method = "wininet")`
followed by install
`devtools::install_github("cox-labs/PerseusR")` within R session

## usage
Download [Perseus](https://maxquant.net/download_asset/perseus/latest) and invoke [External:Matrix=>R](https://github.com/cox-labs/PluginInterop) with following parameters:
script: <full path to>\proteinGroupsANOVA.r
R: <full path to>\Rscript.exe

## test
```
aovt<-anova(lm(c(-0.267558, -1.34843, -0.736034, -0.950788, -0.631172, -1.35648, -0.338978, 0.179467, -1.38368, -0.374963, -0.0118891, 0.583722, 0.646115, 2.28853, -0.117149)~c(rep("g1",5),rep("g2",5),rep("g3",5))))
summary.lm(aovt)
aovt<-aov(c(-0.267558, -1.34843, -0.736034, -0.950788, -0.631172, -1.35648, -0.338978, 0.179467, -1.38368, -0.374963, -0.0118891, 0.583722, 0.646115, 2.28853, -0.117149)~c(rep("g1",5),rep("g2",5),rep("g3",5))) #0.0134
summary(aovt)[[1]][["Pr(>F)"]][[1]]
postHoc<-TukeyHSD(aovt,ordered = TRUE)
names(postHoc)<-"compare"
postHoc<-data.frame(postHoc$compare)
diff<-t(postHoc["diff"])
plot(TukeyHSD(aovt))
padj<-sapply(postHoc["p.adj"],as.numeric)
-log10(padj) 
        p.adj
[1,] 0.019911
[2,] 1.720245
[3,] 1.495404
```

comparison to Perseus session session.sps file:
```
Group1	Group2	Group3	C: ANOVA Significant	N: ANOVA p value	N: ANOVA q-value	T: Name	T: Significant pairs
-1.72025	-1.49541	1.72025		0.0134469	0.644	Row 12	Group3_Group1;Group3_Group2
```
but note that first values/-1.72025 in Perseus is -(thirdvalue)/1.72025 though Group3 could very well be -Group2 i.e. log10(g3-g2) =>  -1.4954 which is log10(0.0319592) from R. Probably it was decided to base G3 from g3-g1 and not g3-g3 because of the fact that 0.0190439 < 0.0319592 ? Unfortunately, the [Source code: not public](http://coxdocs.org/doku.php?id=perseus:user:activities:MatrixProcessing:Tests:MultipleSampleTestProcessing), hope it soon is https://github.com/cox-labs @JurgenCox 

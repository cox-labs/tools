# tools

## MedianVar.R
This script is for calculating the median of normalized variance from a Perseus matrix table.

How to run:<br/>
args[1] - Perseus matrix table of proteinGroup table<br/>
args[2] - Row number of the annotation for sample groups<br/>
args[3] - Row number of the annotation of Type which shows E, N, C and T<br/>
args[4] - Row number of the first row of intensity values<br/>
EX: Rscript MedianVar.R proteinGroup_Perseus.txt 4 1 5<br/>

## MedianVarPerseus.R
This script is for calculating same the above using [External:Matrix=>R](https://github.com/cox-labs/PluginInterop) [PerseusR](https://github.com/cox-labs/PerseusR) to call directly from [Perseus](https://maxquant.net/download_asset/perseus/1.6.15.0) after installing R: 
```
devtools::install_github("cox-labs/PerseusR")
```

Test:

```
File Generic-matrix-upload proteinGroup_Perseus.txt into Perseus 
Invoke External:Matrix=>R and provide script&R location like following respectively:
script: <full-path-to>MedianVarPerseus.R
R: <full-path-to>Rscript.exe
```
As shown in session1.sps.

PS: on windows if "Error in utils::download.file(url, path, method = method, quiet = quiet,  :cannot open URL 'https://api.github.com/repos/cox-labs/PerseusR/tarball/HEAD'" run "options(download.file.method = "wininet")" before installing:


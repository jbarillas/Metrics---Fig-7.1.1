# Metrics---Replicate Fig-7.1.1

To replicate Figure 7.1.1 you will need to download all the files in the repository to a single folder.

Open Figure7.do in Stata and change the working directory to the folder with all the downloaded files. You will then run the .do file and await for the results to be finished. Your working folder should now include new datasets such as 'census80i.dta' and 'censusgimp.dta', as well as text documents such as 'histogram.txt' and 'density_weights.txt'.

You can now open the figure1.R file in R or RStudio and run the whole code (note running 'setwd(file.choose())' will cause a pop-up window to appear, at which you should choose the folder with your previous datasets and .do files.)

To change the main title in the graphs, you must revise the 'mtext' command to reflect the new title. 


###Changes Made
* Created Figure7.do which runs the necessary .do files in proper order instead of having to open each one separately.
* Deleted redundant 'cd' commands within original .do files and moved it to the Figure7.do master file.
* Fixed obselete portion of code within .do files so that they may run on Stata 13+
* Added different colors to figure1.R code and a main title for the replicated figures.

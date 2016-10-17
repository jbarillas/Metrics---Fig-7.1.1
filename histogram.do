#delimit ;
set more 1;
capture log close;
log using histogram.log, replace;

***************************************************************************************;
* Empirical Example for Quantile Regression under Mis-specification, by J. Angrist,   *;
* V. Chernozhukov, and I. Fernandez-Val                                               *;
***************************************************************************************;

***************************************************************************************;
* Program:  Data for histogram of education                                           *;
***************************************************************************************;


use census80.dta, clear;

keep educ;

saveold census80i.dta, replace;
clear;

log close;
exit;

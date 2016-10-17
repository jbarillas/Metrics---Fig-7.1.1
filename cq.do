#delimit ;
set more 1;
 
capture log close;
log using cq.log, replace;

***************************************************************************************;
* Empirical Example for Quantile Regression under Mis-specification, by J. Angrist,   *;
* V. Chernozhukov, and I. Fernandez-Val                                               *;
***************************************************************************************;

***************************************************************************************;
* Program: 	Conditional Quantiles calculation                                         *;
***************************************************************************************;

*****************************************************************************************;
*                      CONTROLS: EDUCATION                                               ;
*****************************************************************************************;

use census80.dta, clear;

gen cqlogwk_q10 = logwk;
gen cqlogwk_q25 = logwk;
gen cqlogwk_q50 = logwk;
gen cqlogwk_q75 = logwk;
gen cqlogwk_q90 = logwk;


sort educ;

collapse (p10) cqlogwk_q10 (p25) cqlogwk_q25 (p50) cqlogwk_q50 (p75) cqlogwk_q75 (p90) cqlogwk_q90 [iweight=perwt], by(educ);

sort educ;

list;

save census80cq.dta, replace;

clear;

log close;
exit;


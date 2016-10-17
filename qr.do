#delimit ;
set more 1;
 
capture log close;
log using qr.log, replace;

***************************************************************************************;
* Empirical Example for Quantile Regression under Mis-specification, by J. Angrist,   *;
* V. Chernozhukov, and I. Fernandez-Val                                               *;
***************************************************************************************;

***************************************************************************************;
* Program:  Quantile regressions and weights calculations                             *;
***************************************************************************************;

*****************************************************************************************;
*                      CONTROLS: EDUCATION                                               ;
*****************************************************************************************;

use census80.dta, clear;

sort educ;

merge educ using census80cq.dta;
tab _merge;
drop _merge;


* QUANTILE REGRESSION;

foreach tau of numlist 10 25 50 75 90 {;
	version 12: qreg logwk educ [aweight = perwt], q(`tau');
	predict qrlogwk_q`tau';
	};

* OLS;

regress logwk educ [aweight = perwt];
predict qrlogwk_ols;

gen cqlogwk_ols = logwk;

* QR RESIDUAL AND APPROXIMATION ERRORS;

foreach tau of numlist 10 25 50 75 90 {;
	gen delta_q`tau' = qrlogwk_q`tau' - cqlogwk_q`tau';
	gen epsilon_q`tau' = logwk - cqlogwk_q`tau';
	};

save census80qr.dta, replace;

* AVERAGING IN EDUCATION CELLS;

collapse (mean) delta* qrlogwk* cqlogwk*  (count) perwt [iweight=perwt], by(educ);


egen sperwt = sum(perwt);
gen preduc =  perwt/sperwt;


* CHAMBERLAIN'S ESTIMATOR;

foreach tau of numlist 10 25 50 75 90 {;
	regress cqlogwk_q`tau' educ [aweight=preduc];
	predict cqrlogwk_q`tau';
	};

keep delta* preduc educ* cqlogwk* qrlogwk* cqrlogwk*;

sort educ;

saveold census80g.dta, replace;

clear;

log close;
exit;


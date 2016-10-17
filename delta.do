#delimit ;
set more 1;
 
capture log close;
log using delta.log, replace;

***************************************************************************************;
* Empirical Example for Quantile Regression under Mis-specification, by J. Angrist,   *;
* V. Chernozhukov, and I. Fernandez-Val                                               *;
***************************************************************************************;

***************************************************************************************;
* Program:  Importance weights calculations (using kernel method)                     *;
*		Auxiliar program: generating file with delta					  *;
***************************************************************************************;

set matsize 200;

use census80qr.dta, clear;

keep educ perwt delta*;

sort educ;

collapse (mean) delta* [iweight=perwt], by(educ);

foreach tau of numlist 10 25 50 75 90 {;
	foreach index of numlist 5/20 {;
		gen delta`index'_q`tau' = delta_q`tau' if (educ == `index');
		};
	};

drop delta_q* educ;

collapse (mean) delta*;

expand 101;

gen u = _n;

sort u;

saveold census80delta.dta, replace;

clear;

log close;
exit;

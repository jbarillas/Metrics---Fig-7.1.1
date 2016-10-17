#delimit ;
set more 1;
 
capture log close;
log using importance_weights.log, replace;

***************************************************************************************;
* Empirical Example for Quantile Regression under Mis-specification, by J. Angrist,   *;
* V. Chernozhukov, and I. Fernandez-Val                                               *;
***************************************************************************************;

***************************************************************************************;
* Program:  Importance weights calculations (using kernel method)                     *;
*		                                                 				  *;
***************************************************************************************;

set matsize 200;

use census80qr.dta, clear;

gen u = _n in 1/101;
sort u;
merge u using census80delta.dta;
tab _merge;
drop _merge;

foreach tau of numlist 10 25 50 75 90 {;
	foreach index of numlist 5/20 {;
		gen epsilon`index'_q`tau' = delta`index'_q`tau' * (u - 1)/100;
		kdensity epsilon_q`tau' [aweight = perwt] if (educ==`index'), nograph gauss generate(ep`index'_q`tau' density`index'_q`tau') at(epsilon`index'_q`tau');
		display $S_3;
		gen wdensity`index'_q`tau' = (1 - (u-1)/100) * density`index'_q`tau'; 
		};
	};


keep in 1/101;
keep wdensity*;

collapse (mean) wdensity*;

expand 16;
gen educ = _n + 4;

foreach tau of numlist 10 25 50 75 90 {;
	gen wdensity_q`tau' = wdensity5_q`tau';
	foreach index of numlist 6/20 {;
		replace wdensity_q`tau' = wdensity`index'_q`tau' if (_n+4 == `index');
		};
	};

keep educ wdensity_q*;

* NORMALIZING IMPORTANCE WEIGHTS;

foreach tau of numlist 10 25 50 75 90 {;
	egen swdensity_q`tau' = sum(wdensity_q`tau');
	gen wqr5_q`tau' = wdensity_q`tau'/swdensity_q`tau';
	gen impweight_q`tau' = wdensity_q`tau';
	};


keep educ wqr5_q* impweight*;
sort educ;
list educ wqr5_q*;

sort educ;

saveold census80gimp.dta, replace;

clear;

* ADDING IMPORTANCE WEIGHTS TO FILE FOR GRAPHS;

use census80g.dta, clear;
sort educ;
merge educ using census80gimp.dta;
tab _merge;
drop _merge;

foreach tau of numlist 10 25 50 75 90 {;
	gen nnawqr5_q`tau' = wqr5_q`tau' * preduc;
	egen snnawqr5_q`tau' = sum(nnawqr5_q`tau');
	gen awqr5_q`tau' = nnawqr5_q`tau'/snnawqr5_q`tau';
	};

drop nnawqr5* snnawqr5*;

saveold census80g.dta, replace;

clear;

log close;

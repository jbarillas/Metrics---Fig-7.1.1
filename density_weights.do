#delimit ;
set more 1;
 
capture log close;
log using density_weights.log, replace;
***************************************************************************************;
* Empirical Example for Quantile Regression under Mis-specification, by J. Angrist,   *;
* V. Chernozhukov, and I. Fernandez-Val                                               *;
***************************************************************************************;

***************************************************************************************;
* Program:  Density weights calculations                                              *;
***************************************************************************************;

set matsize 200;

use census80qr.dta, clear;

gen epsilonp = 0 in 1/1;

foreach tau of numlist 10 25 50 75 90 {;
	foreach index of numlist 5/20 {;
		kdensity epsilon_q`tau' [aweight = perwt] if (educ==`index'), nograph gauss generate(ep`index'_q`tau' density`index'_q`tau') at(epsilonp);
		display $S_3;
		};
	};

foreach tau of numlist 10 25 50 75 90 {;
	foreach index of numlist 5/20 {;
		gen adensity`index'_q`tau' = density`index'_q`tau' / 2;
		};
	};

keep in 1;
keep adensity*;

expand 16;
gen educ = _n + 4;

foreach tau of numlist 10 25 50 75 90 {;
	gen adensity_q`tau' = adensity5_q`tau';
	foreach index of numlist 6/20 {;
		replace adensity_q`tau' = adensity`index'_q`tau' if (_n+4 == `index');
		};
	};

keep educ adensity_q*;

* NORMALIZING DENSITY WEIGHTS;

foreach tau of numlist 10 25 50 75 90 {;
	egen sadensity_q`tau' = sum(adensity_q`tau');
	gen dwqr2_q`tau' = adensity_q`tau'/sadensity_q`tau';
	gen dweight_q`tau' = adensity_q`tau';
	};


keep educ dwqr2_q* dweight*;
sort educ;
list educ dwqr2_q*;

sort educ;

saveold census80gd.dta, replace;

clear;

* ADDING DENSITY WEIGHTS TO FILE FOR GRAPHS;

use census80g.dta, clear;
sort educ;
merge educ using census80gd.dta;
tab _merge;
drop _merge;

saveold census80g.dta, replace;

clear;

log close;
exit;

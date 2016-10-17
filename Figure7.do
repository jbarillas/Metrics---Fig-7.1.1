// Set Working Directory
clear
set more off
log close _all
cd "C:\Users\jbarillas\Documents\Programs"

// Run necessary do files
run cq
run qr
run delta
run importance_weights
run density_weights
run histogram

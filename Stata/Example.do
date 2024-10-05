* Load the .dta file directly from GitHub
	use "https://raw.githubusercontent.com/Ahlfeldt/ABRSQOL-toolkit/main/DATA/ABRSQOL-testdata.dta", clear

* Install the ABRSQOL-toolkit (once available on SSC)
	capture ssc install ABRSQOL
	
* In the meantime, copy from GitHub
	* Download the ado and help files from GitHub
	copy "https://raw.githubusercontent.com/Ahlfeldt/ABRSQOL-toolkit/main/Stata/abrsqol.ado" "abrsqol.ado", replace
	copy "https://raw.githubusercontent.com/Ahlfeldt/ABRSQOL-toolkit/main/Stata/abrsqol.sthlp" "abrsqol.sthlp", replace
	* Copy the files to your personal ado directory with the replace option
	copy "abrsqol.ado" "`c(sysdir_personal)'\abrsqol.ado", replace
	copy "abrsqol.sthlp" "`c(sysdir_personal)'\abrsqol.sthlp", replace

	
* Run the solver under the baseline parameterization
	ABRSQOL MyQoLmeasure1 w p_H P_t p_n L L_b
* The solver also works with different variable names
	ren w wage
	ABRSQOL MyQoLmeasure2 wage p_H P_t p_n L L_b
* Assume expenditure on non-housing consumption is greater
	ABRSQOL MyQoLmeasure3 wage p_H P_t p_n L L_b "alpha=0.8"
* Same, plus increasing speed of convergence
	ABRSQOL MyQoLmeasure4 wage p_H P_t p_n L L_b "alpha=0.8" "conv=1"
	
* Simple comparison to Rosen-Roback amenity
	gen RRQOL = p_H^(0.3)/wage
	gen RRQOL_hat = RRQOL / RRQOL[1]
	twoway 	(scatter MyQoLmeasure1 RRQOL_hat [w=L] , mcolor(black%20) mlcolor(black%0)) 	///
			(scatter MyQoLmeasure1 RRQOL_hat, mcolor(none) mlabel(Name) mlabsize(1) mlabcol(black))	///
			,  ytitle("ABRS QoL measure") xtitle("Rosen-Roback QoL measure") legend(off)
			
* End of do file
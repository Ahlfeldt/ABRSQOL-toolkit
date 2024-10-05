* Load the .dta file directly from GitHub
	use "https://raw.githubusercontent.com/Ahlfeldt/ABRSQOL-toolkit/main/DATA/ABRSQOL-testdata.dta", clear
* Install the ABRSQOL-toolkit
	capture ssc install ABRSQOL
	
* Run the solver under the baseline parameterization
	ABRSQOL MyQoLmeasure1 w p_H P_t p_n L L_b
* The solver also works with different variable names
	ren w wage
	ABRSQOL MyQoLmeasure2 wage p_H P_t p_n L L_b
* Assume expenditure on non-housing consumption is greater
	ABRSQOL MyQoLmeasure3 wage p_H P_t p_n L L_b "alpha=0.8"
* Same, plus increasing speed of convergence
	ABRSQOL MyQoLmeasure4 wage p_H P_t p_n L L_b "alpha=0.8" "conv=0.5"
	
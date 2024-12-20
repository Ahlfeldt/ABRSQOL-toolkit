********************************************************************************
*** Quality of life solver for                                               ***
*** Ahlfeldt, Bald, Roth, Seidel:                                            ***
*** Measuring quality of life under spatial frictions                        ***	
*** Version 1.0.0                                                            ***											
*** (c) Gabriel M Ahlfeldt, Fabian Bald, Duncan Roth, Tobias Seidel          ***
*** 10/2024                                                                  ***
********************************************************************************


* Define programme
	capture program drop ABRSQOL 
	program define ABRSQOL
		// Syntax consists of the following compulsory arguments
			// 1: QOL variable to be generated
			// 2: Wage index
			// 3: Floor space price index
			// 4: Tradable goods price index
			// 5: Local services price index
			// 6: Residence population
			// 7: Hometown population
		// In addition you can add optional arguments of the form 
			// "parameter = value"
			// where parameter is the parameter you want to manipulate 
			// value is the the value you want the parameter to take
		// You can do this with the following parameters
			// alpha
			// beta
			// gamma
			// xi
			// conv
			// tolerance
			// maxiter
	
* Version statement
	version 17.0

* Check if the variable in argument 1 (QoL variable) already exists
	capture confirm variable `1'
	if _rc == 0 {  // If _rc is 0, the variable exists
		display as error "Error: The variable `1' already exists in the dataset. Please choose a different name."
		exit 198
	}
	// If variable doesn't exist, continue with the program			
	
* Check if the subfolder ABRSQOLTEMP exists
	capture quietly cd ABRSQOLTEMP

	// If the folder exists, Stata sets a return code of 0 (meaning no error)
	if !_rc {
		// Display an error message and stop the code
		display as error "Error: The folder 'ABRSQOLTEMP' already exists. Please remove or rename this folder before running the code."
		qui cd ..
		exit 198
	}
	// If the folder does not exist we create it
	qui mkdir ABRSQOLTEMP

* Check if the variable ABRSQOLID exists in the dataset
	capture confirm variable ABRSQOLID
	if _rc == 0 { // _rc == 0 means the variable exists
		di as error "Error: The variable 'ABRSQOLID' already exists in the dataset. Please remove it before proceeding."
		exit 198 // Exits the program with a custom error code
	}
	// If not, creeate an ID Variable for later merging
	qui gen ABRSQOLID = _n

* Preserve data
	preserve

* Drop variables that will be generated by the programme
/*
	foreach name in A_hat A_hat_up mathcal_P_hat mathcal_L mathcal_L_hat Psi {
		capture drop `var'
	}
 */
	
* Define parameter values
	scalar alpha = 0.7                    // income share on non-housing
	scalar beta = 0.5	                  // share of alpha spent on tradable goods
	scalar gamma = 3                      // gamma parameter
	scalar xi = 5                         // xi parameter
	scalar conv = 0.5			      	  // convergence parameter
	scalar tolerance = 1*10^(-5)		  // tolerance parameter
	scalar maxiter	= 10000				  // max iterations	
	
* Override parameter values with user entry
	capture scalar `8'
	capture scalar `9'
	capture scalar `10'
	capture scalar `11'
	capture scalar `12'
	capture scalar `13'
	capture scalar `14'
	
* Define tolerance level for solver
	global tolerance_total = tolerance
	global maxiter = maxiter

* Generate key variables
	capture gen temp_w = `2'
	capture gen temp_p_H = `3'
	capture gen temp_P_t = `4'
	capture gen temp_p_n = `5'
	capture gen temp_L = `6'
	capture gen temp_L_b = `7'
	
* Define key variables
	global keyvars temp_w temp_p_H temp_P_t temp_p_n temp_L temp_L_b

* Schrink the data set to observations without missings
	qui foreach var of varlist $keyvars {
		drop if `var' == .
	}
* Save total size
	global J = _N	
	
* Adjust L_b to have same sum as 
	qui sum temp_L
	local L_sum = r(sum)
	qui sum temp_L_b
	local L_b_sum = r(sum)
	qui replace temp_L_b = temp_L_b * `L_sum' / `L_b_sum'
	
* Express all variables in relative differences
	qui foreach var of varlist $keyvars {
		gen `var'_hat = `var'/`var'[1]
	}
	
* Guess QoL and create placeholders for loop
	qui gen double temp_A_hat=1
	qui gen double temp_A_hat_up=1
	qui gen double temp_mathcal_P_hat = 1
	qui gen double temp_mathcal_L = 1
	qui gen double temp_mathcal_L_hat = 1
	qui gen double temp_Psi = 1
	
* Begin loop to solve for QoL **************************************************
	local Ototal = 100000
	local count = 1
	display "------------------------------------------------------------------"
	while `Ototal' > $tolerance_total & `count' <= $maxiter {
	display "...iteration `count', value of objective function: `Ototal'"
* Compute predicted psi
	qui replace temp_mathcal_P_hat = (temp_P_t_hat^(alpha*beta)) * (temp_p_n_hat^(alpha*(1-beta))) * (temp_p_H_hat^(1-alpha))
	local denominator = 0
	qui forval num = 1/$J { 
		local denominator = `denominator' + (temp_A_hat[`num']*temp_w_hat[`num']/temp_mathcal_P_hat[`num'])^gamma
	}
	qui forval num = 1/$J { 
		local numerator = (exp(xi)-1)*(temp_A_hat[`num']*temp_w_hat[`num']/temp_mathcal_P_hat[`num'])^gamma
		scalar temp_psi_`num' = (1+`numerator'/`denominator')^(-1)
		qui replace temp_Psi = temp_psi_`num' if _n == `num'
	}

* Compute predicted mathcal L_b
	qui replace temp_mathcal_L = 0
	qui forval num = 1/$J { 
		replace temp_mathcal_L = temp_mathcal_L + temp_psi_`num'*L_b[`num'] 
	}
	qui replace temp_mathcal_L = temp_mathcal_L + (exp(xi)-1)*temp_Psi*temp_L_b
	qui replace temp_mathcal_L_hat = temp_mathcal_L/temp_mathcal_L[1]
	
* Compute predicted QoL
	qui replace temp_A_hat_up = temp_mathcal_P_hat / temp_w_hat * (temp_L_hat/temp_mathcal_L_hat)^(1/gamma)
* Evaluate objective	
	qui gen tempObjective = abs(temp_A_hat_up-temp_A_hat)
	qui sum tempObjective
	local Ototal = r(sum)/r(N)
	qui drop tempObjective
* Update guess
	qui replace temp_A_hat = conv*temp_A_hat_up + (1-conv)*temp_A_hat
	local count = `count'+1
} // Loop ends ***************************************************************** 
* End
	display "------------------------------------------------------------------"
	display "...finalizing..."
	qui gen `1' = temp_A_hat
	qui foreach name in $keyvars {
		drop `name'_hat
	}

* Save outcome and merge to initial data set
	qui keep  ABRSQOLID  `1' 
	qui save "ABRSQOLTEMP/ABRSQOLTEMP.dta", replace
	restore 
	qui merge 1:1 ABRSQOLID using "ABRSQOLTEMP/ABRSQOLTEMP.dta"
	qui drop _m ABRSQOLID
	capture shell rd /s /q ABRSQOLTEMP
	capture shell rm -rf ABRSQOLTEMP
* Display success
	display "------------------------------------------------------------------"
	display "...QoL variable generated: `1'..."
	display "------------------------------------------------------------------"
	end
	
* END

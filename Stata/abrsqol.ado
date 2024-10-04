**********************************************************************
*** Quality of life solver for 									   ***
*** Ahlfeldt, Bald, Roth, Seidel:								   ***
*** Measuring quality of life under spatial frictionshe			   ***	
*** Version 0.9  												   ***											
*** (c) Gabriel M Ahlfeldt,Fabian Bald, Duncan Roth, Tobias Seidel ***
*** 10/2024							 	   						   ***
**********************************************************************


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
		
* Define parameter values
	scalar alpha = 0.7                    // income share on non-housing
	scalar beta = 0.5	                  // share of alpha spent on tradable goods
	scalar gamma = 3                      // gamma parameter
	scalar xi = 5                         // xi parameter
	scalar conv = 0.2			      	  // convergence parameter
	scalar tolerance = 1*10^(-10)		  // tolerance parameter
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
	capture gen w = `2'
	capture gen p_H = `3'
	capture gen P_t = `4'
	capture gen p_n = `5'
	capture gen L = `6'
	capture gen L_b = `7'
	
* Define key variables
	global keyvars w p_H P_t p_n L L_b

* Schrink the data set to observations without missings
	qui foreach var of varlist $keyvars {
		drop if `var' == .
	}
* Save total size
	global J = _N	
	
* Adjust L_b to have same sum as 
	qui sum L
	local L_sum = r(sum)
	qui sum L_b
	local L_b_sum = r(sum)
	qui replace L_b = L_b * `L_sum' / `L_b_sum'
	
* Express all variables in relative differences
	qui foreach var of varlist $keyvars {
		gen `var'_hat = `var'/`var'[1]
	}
	
* Guess QoL and create placeholders for loop
	qui gen double A_hat=1
	qui gen double A_hat_up=1
	qui gen double mathcal_P_hat = 1
	qui gen double mathcal_L = 1
	qui gen double mathcal_L_hat = 1
	qui gen double Psi = 1
	
* Begin loop to solve for QoL **************************************************
	local Ototal = 100000
	local count = 1
	while `Ototal' > $tolerance_total & `count' <= $maxiter {
	display "...iteration `count', value in objective function: `Ototal'"
* Compute predicted psi
	qui replace mathcal_P_hat = (P_t_hat^(alpha*beta)) * (p_n_hat^(alpha*(1-beta))) * (p_H_hat^(1-alpha))
	local denominator = 0
	qui foreach num of numlist 1 / $J {
		local denominator = `denominator' + (A_hat[`num']*w_hat[`num']/mathcal_P_hat[`num'])^gamma
	}
	foreach num of numlist 1 / $J {
		local numerator = (exp(xi)-1)*(A_hat[`num']*w_hat[`num']/mathcal_P_hat[`num'])^gamma
		scalar psi_`num' = (1+`numerator'/`denominator')^(-1)
		qui replace Psi = psi_`num' if _n == `num'
	}

* Compute predicted mathcal L_b
	qui replace mathcal_L = 0
	qui foreach num of numlist 1 / $J {
		replace mathcal_L = mathcal_L + psi_`num'*L_b[`num'] 
	}
	qui replace mathcal_L = mathcal_L + (exp(xi)-1)*Psi*L_b
	qui replace mathcal_L_hat = mathcal_L/mathcal_L[1]
	
* Compute predicted QoL
	qui replace A_hat_up = mathcal_P / w_hat * (L_hat/mathcal_L_hat)^(1/gamma)
* Evaluate objective	
	qui gen tempObjective = abs(A_hat_up-A_hat)
	qui sum tempObjective
	local Ototal = r(sum)
	qui drop tempObjective
* Update guess
	qui replace A_hat = conv*A_hat_up + (1-conv)*A_hat
	local count = `count'+1
} // Loop ends ***************************************************************** 
* End
	display "------------------------------------------------------------------"
	display "...finalizing..."
	qui gen `1' = A_hat
	qui foreach name in $keyvars {
		drop `name'_hat
	}
	qui drop A_hat A_hat_up mathcal_P_hat mathcal_L mathcal_L_hat Psi
    * Drop key variables if they were not already in data set
		if "`2'" != "w" {
			drop w
		}
		if "`3'" != "p_H" {
			drop p_H
		}
		if "`4'" != "P_t" {
			drop P_t
		}
		if "`5'" != "p_n" {
			drop P_t
		}
		if "`6'" != "L" {
			drop P_t
		}
		if "`7'" != "L_b" {
			drop P_t
		}
	display "------------------------------------------------------------------"
	display "QoL generated" 
	display "------------------------------------------------------------------"
	display "Notice that observations with missing values in key variables have been dropped"
	display "Notice that if any of these key variables were in the data set, they have been interpreted in the spirit of ABRS: w p_H P_t p_n L L_b"
	end
	
* END
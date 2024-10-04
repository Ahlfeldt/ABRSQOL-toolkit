********************************************************************************
*** This programm executes simple counterfactuals using the 				 ***
*** Ahlfeldt-Bald-Seide-Roth frameworks									   	 ***
*** By Gabriel M. Ahlfeldt, Fabian Bald, Duncan Roth, Tobias Seidel			 ***
*** Version 0.9, 03-2024													 ***
********************************************************************************


* Programme definition

capture capture program drop ABRS
program define ABRS 
	version 17.0 	// The program has not been tested with earlier version, but is likely to run on them
	capture set scheme s1color
	capture set scheme stcolor

* Clear space
qui clear

// Set scalars based on parameter values to default
	scalar alpha = 0.66
	scalar gamma = 3
	scalar delta = 0.3
	scalar sigma = 4
	scalar zeta = 0.04				

	scalar A_hat_1 = 0.2
	scalar eta_hat_1 = 0
	scalar k_hat_1 = eta_hat_1^(-1)
	scalar phibar_hat_1 = 0

	scalar A_hat_2 = 0
	scalar eta_hat_2 = 0
	scalar k_hat_2 = eta_hat_2^(-1)
	scalar phibar_hat_2 = 0
	
	* For visualization
	scalar min_w_hat = 0
	scalar step_w_hat = 1
	scalar max_w_hat = 2
	scalar min_L_hat = 0
	scalar step_L_hat = 1
	scalar max_L_hat = 2
	scalar min_p_hat = 0
	scalar step_p_hat = 1
	scalar max_p_hat = 2

// Override with user entry
	capture scalar `1'
	capture scalar `2'
	capture scalar `3'
	capture scalar `4'
	capture scalar `5'
	capture scalar `6'
	capture scalar `7'
	capture scalar `8'
	capture scalar `9'
	capture scalar `10'
	capture scalar `11'
	capture scalar `12'
	capture scalar `13'
	capture scalar `14'
	capture scalar `15'
	capture scalar `16'
	capture scalar `17'
	capture scalar `18'
	capture scalar `19'
	capture scalar `20'

// Use the updaed values to generate scalars for panel sizes	
	local 12 = min_w_hat
	local 13 = step_w_hat
	local 14 = max_w_hat
	local 15 = min_L_hat
	local 16 = step_L_hat
	local 17 = max_L_hat
	local 18 = min_p_hat
	local 19 = step_p_hat
	local 20 = max_p_hat	
	
// Un-log user entry
	scalar A_hat_1 = exp(A_hat_1)
	scalar eta_hat_1 =exp(eta_hat_1)
	scalar k_hat_1 = eta_hat_1^(-1)
	scalar phibar_hat_1 = exp(phibar_hat_1)

	scalar A_hat_2 = exp(A_hat_2)
	scalar eta_hat_2 = exp(eta_hat_2)
	scalar k_hat_2 = eta_hat_2^(-1)
	scalar phibar_hat_2 = exp(phibar_hat_2)
	
* Generate equilibrium relationships
	qui set obs 100000	
	* Region 1
	    qui gen w_hat_1 = _n*0.0001
		qui gen L_hat_1 = 	k_hat_1^(-(1-alpha)/((1/gamma)+(1-alpha)*delta)) * ///
						A_hat_1^(1/((1/gamma)+delta*(1-alpha))) * ///
						w_hat_1^((1-delta*(1-alpha))/(1/gamma+delta*(1-alpha)))
		qui gen p_hat_1_FMC = 	k_hat_1^(1/(1-(1-alpha)*delta)) * ///
						A_hat_1^(-delta/(1-delta*(1-alpha))) * ///
						L_hat_1^(delta*(1/gamma+1)/(1-(1-alpha)*delta))
		qui gen p_hat_1_GMC = k_hat_1*phibar_hat_1^(delta*(1-sigma)/(zeta*(sigma-1)-1))*w_hat_1^(delta*(sigma-1)*(zeta+1)/(zeta*(sigma-1)-1))
		qui gen w_hat_1_GMC = (p_hat_1_FMC/k_hat_1)^((zeta*(sigma-1)-1)/(delta*(sigma-1)*(zeta+1)))*phibar_hat_1^(1/(zeta+1))
	* Region 2
		qui gen w_hat_2 = _n*0.001
		qui gen L_hat_2 = 	k_hat_2^(-(1-alpha)/(1/gamma+(1-alpha)*delta)) * ///
						A_hat_2^(gamma/(1+gamma*delta*(1-alpha))) * ///
						w_hat_2^((1-delta*(1-alpha))/(1/gamma+delta*(1-alpha)))
		qui gen p_hat_2_FMC = k_hat_2^(1/(1-(1-alpha)*delta)) * ///
						A_hat_2^(-delta/(1-delta*(1-alpha))) * ///
						L_hat_2^(delta*(1/gamma+1)/(1-(1-alpha)*delta))
		qui gen p_hat_2_GMC = k_hat_2*phibar_hat_2^(delta*(1-sigma)/(zeta*(sigma-1)-1))*w_hat_2^(delta*(sigma-1)*(zeta+1)/(zeta*(sigma-1)-1))
		qui gen w_hat_2_GMC = (p_hat_2_FMC/k_hat_2)^((zeta*(sigma-1)-1)/(delta*(sigma-1)*(zeta+1))) *phibar_hat_2^(1/(zeta+1))
	
* Generate equilibrium outcomes	
	* Gen aux variables
		qui gen Z = 1 - zeta*(sigma-1)
		qui gen D = Z*(1-(1-alpha)*delta) + sigma*[(1/gamma)+(1-alpha)*delta]
		* Region 1
			qui gen L_hat_star_1 = k_hat_1^(((alpha-1)*sigma)/D) *A_hat_1^(sigma/D)*phibar_hat_1^(((sigma-1)*(1-(1-alpha)*delta))/D)
			qui gen w_hat_star_1 = 	k_hat_1^((1-alpha)*Z/D) * A_hat_1^(-Z/D) * phibar_hat_1^((sigma-1)*((1/gamma)+(1-alpha)*delta)/D)							
			qui gen p_hat_star_1 = 	k_hat_1^((Z+sigma/gamma)/D) * A_hat_1^(delta*(sigma-Z)/D) * phibar_hat_1^(((sigma-1)*(1+1/gamma)*delta)/D)	
		* Region 2
			qui gen L_hat_star_2 = k_hat_2^(((alpha-1)*sigma)/D) *A_hat_2^(sigma/D)*phibar_hat_2^(((sigma-1)*(1-(1-alpha)*delta))/D)
			qui gen w_hat_star_2 = 	k_hat_2^((1-alpha)*Z/D) * A_hat_2^(-Z/D) * phibar_hat_2^((sigma-1)*((1/gamma)+(1-alpha)*delta)/D)								
			qui gen p_hat_star_2 = 	k_hat_2^((Z+sigma/gamma)/D) * A_hat_2^(delta*(sigma-Z)/D) * phibar_hat_2^(((sigma-1)*(1+1/gamma)*delta)/D)	
	
display "<<< general equilibrium effects >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
	local lL_hat_star_1 = round(ln(L_hat_star_1), 0.01)
	local lw_hat_star_1 = round(ln(w_hat_star_1), 0.01)
	local lp_hat_star_1 = round(ln( p_hat_star_1), 0.01)
	local lrw_hat_star_1 =  round(ln(w_hat_star_1)-(1-alpha)*ln(p_hat_star_1), 0.01)
	local lL_hat_star_2 = round(ln(L_hat_star_2), 0.01)
	local lw_hat_star_2 = round(ln(w_hat_star_2), 0.01)
	local lp_hat_star_2 = round(ln( p_hat_star_2), 0.01)
	local lrw_hat_star_2 =  round(ln(w_hat_star_2)-(1-alpha)*ln(p_hat_star_2), 0.01)
	display "----------------------"
	display "All results are responses to changes in fundamentals in log units"
	display "----------------------"
	display "Region 1 (red solid)"
	display "----------------------"
	display "Total employment: `lL_hat_star_1'"
	display "Wage:             `lw_hat_star_1'"
	display "Rent:             `lp_hat_star_1'"
	display "Real wage:        `lrw_hat_star_1'"
	display "----------------------"
	display "Region 2 (blue dashed)"
	display "----------------------"
	display "Total employment: `lL_hat_star_2'"
	display "Wage:             `lw_hat_star_2'"
	display "Rent:             `lp_hat_star_2'"
	display "Real wage:        `lrw_hat_star_2'"
	display "----------------------"
display "<<< preparing graph >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"	
* Plot G1
	* region graph condition
		local region1space  "w_hat_1 >= `12' & w_hat_1 <= `14' & L_hat_1 <= `17'"
		local region2space  "w_hat_2 >= `12' & w_hat_2 <= `14' & L_hat_2 <= `17'"
	qui twoway 	/// region 1 
			(line L_hat_1 w_hat_1  if `region1space', sort(w_hat_1) color(red)) ///
	 		(line L_hat_1 w_hat_star_1 if L_hat_1 <= L_hat_star_1, lcolor(red) lpattern(shortdash))			///
			(line L_hat_star_1 w_hat_1 if w_hat_1 <= w_hat_star_1 & `region1space', lcolor(red) lpattern(shortdash))			///
				/// region 2
			(line L_hat_2 w_hat_2 if `region2space', sort(w_hat_2) color(blue) lpattern(longdash)) ///
	 		(line L_hat_2 w_hat_star_2 if L_hat_2 <= L_hat_star_2, lcolor(blue) lpattern(shortdash))			///
			(line L_hat_star_2 w_hat_2 if w_hat_2 <= w_hat_star_2 & `region2space', lcolor(blue) lpattern(shortdash))			///
	, xtitle("Relative wage (w_hat)") ytitle("Relative employment (L_hat)")  yscale(alt) xscale(alt) legend(off) graphregion(color(white) margin(zero)) name(Q1, replace) xlabel(`12'[`13']`14') ylabel(`15'[`16']`17') xline(1, lpattern(dot)) yline(1, lpattern(dot)) plotregion(margin(zero)) xline(0, lpattern(solid) lcolor(black)) yline(0, lpattern(solid) lcolor(black)) nodraw
* Plot G2
	* region graph condition
		local region1space  "p_hat_1_FMC >= `18' & p_hat_1_FMC <= `20' & L_hat_1 <= `17'"
		local region2space  "p_hat_2_FMC >= `18' & p_hat_2_FMC <= `20' & L_hat_2 <= `17'"
	qui twoway 	/// region 1
			(line L_hat_1 p_hat_1_FMC if `region1space', sort(w_hat_1) color(red)) ///
		 	(line L_hat_1 p_hat_star_1 if L_hat_1 <= L_hat_star_1, lcolor(red) lpattern(shortdash))			///
			(line L_hat_star_1 p_hat_1_FMC if p_hat_1_FMC <= p_hat_star_1 & p_hat_1_FMC >= `18', lcolor(red) lpattern(shortdash))			///
				/// region 2
			(line L_hat_2 p_hat_2_FMC if `region2space', sort(w_hat_1) color(blue) lpattern(longdash)) ///	
		 	(line L_hat_2 p_hat_star_2 if L_hat_2 <= L_hat_star_2, lcolor(blue) lpattern(shortdash))			///
			(line L_hat_star_2 p_hat_2_FMC if p_hat_2_FMC <= p_hat_star_2 & p_hat_2_FMC >= `18', lcolor(blue) lpattern(shortdash))			///
, xtitle("Relative rent (p_hat)") ytitle("Relative employment (L_hat)")   xscale(alt) legend(off) graphregion(color(white) margin(zero)) name(Q2, replace)	xscale(reverse) ylabel(`15'[`16']`17')    xlabel(`18'[`19']`20') xline(1, lpattern(dot)) yline(1, lpattern(dot)) plotregion(margin(zero))  xline(0, lpattern(solid) lcolor(black)) yline(0, lpattern(solid) lcolor(black)) nodraw
* Plot G3	
	* region graph condition
		local region1space  "p_hat_1_FMC >= `18' & p_hat_1_FMC <= `20' & w_hat_1_GMC >= `12' & w_hat_1_GMC <= `14' "
		local region2space  "p_hat_2_FMC >= `18' & p_hat_2_FMC <= `20' & w_hat_2_GMC >= `12' & w_hat_2_GMC <= `14'"
	qui twoway 	/// region 1
			(line w_hat_1_GMC p_hat_1_FMC if `region1space', sort(w_hat_1) color(red)) ///
			(line w_hat_1_GMC p_hat_star_1 if w_hat_1_GMC <= w_hat_star_1 & w_hat_1_GMC >= `12', lcolor(red) lpattern(shortdash))			///
			(line w_hat_star_1 p_hat_1_FMC if p_hat_1_FMC <= p_hat_star_1 & p_hat_1_FMC >= `18' , lcolor(red) lpattern(shortdash))			///
				/// region 2
			(line w_hat_2_GMC p_hat_2_FMC if `region2space', sort(w_hat_2) color(blue) lpattern(longdash)) ///
			(line w_hat_2_GMC p_hat_star_2 if w_hat_2_GMC <= w_hat_star_2 & w_hat_2_GMC >= `12', lcolor(blue) lpattern(shortdash))			///
			(line w_hat_star_2 p_hat_2_FMC if p_hat_2_FMC <= p_hat_star_2 & p_hat_2_FMC >= `18' , lcolor(blue) lpattern(shortdash))			///
	, xtitle("Relative rent (p_hat)") ytitle("Relative wage (w_hat)")   legend(off) graphregion(color(white) margin(zero)) name(Q3, replace)	yscale(reverse) xscale(reverse)  xlabel(`18'[`19']`20') ylabel(`12'[`13']`14') xline(1, lpattern(dot)) yline(1, lpattern(dot)) plotregion(margin(zero))  xline(0, lpattern(solid) lcolor(black)) yline(0, lpattern(solid) lcolor(black)) nodraw
* Plot G4
	* region graph condition
		local region1space  "w_hat_1 >= `12' & w_hat_1 <= `14' "
		local region2space  "w_hat_2 >= `12' & w_hat_2 <= `14' "
	qui twoway (line w_hat_1 w_hat_1 if `region1space', sort(w_hat_1) color(black)) ///
			/// region 1
			(line w_hat_1 w_hat_star_1 if w_hat_1 <= w_hat_star_1  & w_hat_1 >= `12', lcolor(red) lpattern(shortdash))			///
			(line w_hat_star_1 w_hat_1 if w_hat_1 <= w_hat_star_1 & w_hat_1 >= `12', lcolor(red) lpattern(shortdash))			///
			/// region 2
			(line w_hat_2 w_hat_star_2 if w_hat_2 <= w_hat_star_2  & w_hat_2 >= `12', lcolor(blue) lpattern(shortdash))			///
			(line w_hat_star_2 w_hat_2 if w_hat_2 <= w_hat_star_2 & w_hat_2 >= `12', lcolor(blue) lpattern(shortdash))			///
			, xtitle("Relative wage (w_hat)") ytitle("Relative wage (w_hat)")   legend(off) graphregion(color(white) margin(zero)) name(Q4, replace) yscale(reverse)		yscale(alt) xlabel(`12'[`13']`14') ylabel(`12'[`13']`14') xline(1, lpattern(dot)) yline(1, lpattern(dot)) plotregion(margin(zero))  xline(0, lpattern(solid) lcolor(black)) yline(0, lpattern(solid) lcolor(black)) nodraw
* Combine
	graph combine Q2 Q1 Q3 Q4, cols(2)  xsize(10) ysize(10)
	display "<<< all done >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
end
	
* Program completed *************************************************************


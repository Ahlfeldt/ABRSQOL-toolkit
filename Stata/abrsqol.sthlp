{smcl}
{hline}
help for {hi:ABRSQOL}
{hline}

{title:Quality-of-life solver for "Measuring quality of life under spatial frictions"}

{title:Description}

ABRSQOL is part of the ABRSQOL-toolkit that provides numerical solvers for quality-of-life (QoL) measures that are consistent with the mode developed in Ahlfeldt, Bald, Roth, Seidel: Measuring quality of life under spatial frictions, henceforth ABRS. Notice that quality of life is identified up to a constant. Therefore, the inverted QoL measures measure has a relative interpretation only. We normalize the QoL relative to the first observation in the data set. It is straightforward to rescale the QoL measure to any other location or any other value (such as the mean or median in the distribution of QoL across locations). 

{title:Syntax}

ABRSQOL outcome wage floor_space_price tradable_goods_price local_services_price residence_population hometown_population ["parameter=value"]

The following arguments are compulsory
outcome                 QOL variable to be generated, name can be freely chosen
wage                    Wage index, must exist in data set
floor_space_price       Floor space price index, must exist in data set
local_services_price    Tradable goods price index, must exist in data set
residence_population    Local services price index, must exist in data set
residence_population    Residence population, must exist in data set
hometown_population     Hometown population, must exist in data set

The following parameters can be adjusted by adding "parameter=value" 
as an argument. Below is a brief description and canonical parameter 
values

alpha       Income share on non-housing consumtpion     0.7
beta        Share of tradable goods in non-housing      0.5
            consumption  								
gamma       Idiosyncratic taste dispersion              3
            (inverse labour supplyelasticity)	
xi          Valuation of local ties                     5
conv        Convergence parameter                       0.5
            Hgher value increases spead of 
            convergence and risk of bouncing                           
tolerance   Value used in stopping rule                 1*10^(-5)
            The mean absolute error (MAE)
            Smaller values imply greater precision and
            longer convergence
maxiter     Maximum iteration                           10000                     
            Maximum number of iteratios after which 
            the algorithm is forced to stop

The program will use these parameter values if you do not add an argument. 
You can change any of the parameter values by adding "parameter=value" as an argument. 
You can add as many arguments as there are parameters.


{title:Example 1:} 
Baseline parameterization

ABRSQOL MyQOLmeasure w p_H P_t p_n L L_b

{title:Example 2}: 
Increases income share on non-housing consumption to 0.8

ABRSQOL MyQOLmeasure w p_H P_t p_n L L_b "alpha=0.8"

{title:Example 3:} 
Increases income share on non-housing consumption to 0.8 and increases convergence parameter to 0.75
    
ABRSQOL MyQOLmeasure w p_H P_t p_n L L_b "alpha=0.8" "conv=0.75"

You can add as many arguments as there are parameters.

{title:Verion}
0.9, 10/2024

{title:Authors}

Gabriel M Ahlfeldt, Humboldt University of Berlin
Fabian Bald, European University Viadrina
Duncan Roth, Institute for Employment Research
Tobias Seidel, University of Duisburg-Essen


{title:References}

The complete ABRSQOL-toolkit is available as a GitHub repository. {browse "https://github.com/Ahlfeldt/ABRSQOL-toolkit":[link]}

The toolkit builds on: 

Ahlfeldt, Bald, Roth, Seidel: Measuring quality of life under spatial frictions

When using this programme or the toolkit in your work, please cite the paper.

{title:End of help file}

\name{ABRSQOL}
\alias{ABRSQOL}
\title{Hello, World!}
\usage{
ABRSQOL()
}
\description{
ABRSQOL is part of the ABRSQOL-toolkit that provides numerical solvers for quality-of-life (QoL) measures that are consistent with the mode developed in Ahlfeldt, Bald, Roth, Seidel: Measuring quality of life under spatial frictions, henceforth ABRS.
    Notice that quality of life is identified up to a constant. Therefore, the inverted QoL measures measure has a relative interpretation only. We normalize the QoL relative to the first observation in the data set. It is straightforward to rescale the QoL measure to any other location or any other value (such as the mean or median in the distribution of QoL across locations).


BRSQOL {it:outcome wage floor_space_price tradable_goods_price local_services_price residence_population hometown_population} ["parameter=value"]

The following arguments are compulsory:

outcome                 QOL variable to be generated, name can be freely chosen; must be included in syntax
wage                    Wage index, can have any name, but must exist in data set; must be included in syntax
floor_space_price       Floor space price index, can have any name, but must exist in data set; must be included in syntax
local_services_price    Tradable goods price index, can have any name, but must exist in data set; must be included in syntax
local_services_price    Local services price index, can have any name, but must exist in data set; must be included in syntax
residence_population    Residence population, must can have any name, but must exist in data set; must be included in syntax
hometown_population     Hometown population, can have any name, but must exist in data set; must be included in syntax

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

}
\examples{

# run with ABRSQOL_testdata
ABRSQOL()

ABRSQOL(
  # supply your dataset as a dataframe
  df=my_dataframe,

  # specify the name for the output variable
  QoL_varname='qol_indicator',

  # and specify the corresponding variable name for your dataset
  w = 'wage',
  p_H = 'floor_space_price',
  P_t = 'tradable_goods_price',
  p_n = 'local_services_price',
  L = 'residence_pop',
  L_b = 'L_b',
  alpha = 0.7,
  beta = 0.5,
  gamma = 3,
  xi = 5.5,
  upfactor = 0.5,
  tolerance = 0.000000000001),
  maxiter = 50000
}

# you can also reference the variables in your dataset by using the column index
ABRSQOL(
  df=my_dataframe,
  QoL_varname='A',
  w = 1,
  p_H = 3,
  P_t = 4,
  p_n = 2,
  L = 6,
  L_b = 5,
}

# or in case the variables in your data are named similor to the testdata, you can ommit variable names and use default
ABRSQOL(
  df=my_dataframe,
  alpha = 0.7,
  beta = 0.5,
  gamma = 3,
  xi = 5.5,
  upfactor = 0.5,
}

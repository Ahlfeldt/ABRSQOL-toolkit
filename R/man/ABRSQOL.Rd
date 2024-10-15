\name{ABRSQOL}
\alias{ABRSQOL}
\title{ABRSQOL-toolkit that provides numerical solvers for quality-of-life measures}
\usage{
# see examples and description
ABRSQOL(
  df=my_dataframe,
  w = 'w', p_H = 'p_H', P_t = 'P_t', p_n = 'p_n', L = 'L', L_b = 'L_b',
  alpha = 0.7, beta = 0.5, gamma = 3, xi = 5.5,
  conv = 0.5, tolerance = 1e-10, maxiter = 1e4
  )
}
\description{
ABRSQOL is part of the ABRSQOL-toolkit that provides numerical solvers for quality-of-life (QoL) measures that are consistent with the mode developed in Ahlfeldt, Bald, Roth, Seidel: Measuring quality of life under spatial frictions, henceforth ABRS.
Notice that quality of life is identified up to a constant. Therefore, the inverted QoL measures measure has a relative interpretation only. We normalize the QoL relative to the first observation in the data set. It is straightforward to rescale the QoL measure to any other location or any other value (such as the mean or median in the distribution of QoL across locations).


The following arguments are compulsory:

QoL_varname   outcome                 QOL variable to be generated, name can be freely chosen;
w             wage                    Wage index, can have any name, but must exist in data set;
p_H           floor_space_price       Floor space price index, can have any name, but must exist in data set;
P_t           tradable_goods_price    Tradable goods price index, can have any name, but must exist in data set;
p_n           local_services_price    Local services price index, can have any name, but must exist in data set;
L             residence_population    Residence population, must can have any name, but must exist in data set;
L_b           hometown_population     Hometown population, can have any name, but must exist in data set;

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
tolerance   Value used in stopping rule                 1e-10
            The mean absolute error (MAE)
            Smaller values imply greater precision and
            longer convergence
maxiter     Maximum iteration                           10000
            Maximum number of iteratios after which
            the algorithm is forced to stop

The program will use these parameter values if you do not add an argument.
You can change any of the parameter values by adding "parameter=value" as an argument.
You can add as many arguments as there are parameters.


}
\examples{

# Example 1: load testdata, run QoL inversion with default parameters, store result as 'QoL' variable, view result 
testdata = get("ABRSQOL_testdata")
testdata$QoL = ABRSQOL(df=testdata)
View(testdata)

# Example 2: load your data from csv, run inversion, save result as csv
my_dataframe = a = read.csv("path/to/your/csv_filename.csv")
my_dataframe$quality_of_life = ABRSQOL(
  # supply your dataset as a dataframe
  df=my_dataframe,
  # and specify the corresponding variable name for your dataset
  w = 'wage',
  p_H = 'floor_space_price',
  P_t = 'tradable_goods_price',
  p_n = 'local_services_price',
  L = 'residence_pop',
  L_b = 'hometown_population',
  # freely adjust remaining parameters
  alpha = 0.7,
  beta = 0.5,
  gamma = 3,
  xi = 5.5,
  conv = 0.3,
  tolerance = 1e-11,
  maxiter = 50000
)
write.csv(my_dataframe, 'qol_of_my_data.csv')

# Example 3: Reference variables in your dataset by using the column index
ABRSQOL(
  df=my_dataframe,
  w = 1,
  p_H = 3,
  P_t = 4,
  p_n = 2,
  L = 6,
  L_b = 5
)


# Example 4: Having named the variables in your data according to the default parameters, you can ommit specifying variable names
ABRSQOL(
  df=my_dataframe,
  alpha = 0.7,
  beta = 0.5,
  gamma = 3,
  xi = 5.5,
  conv = 0.5
)
}

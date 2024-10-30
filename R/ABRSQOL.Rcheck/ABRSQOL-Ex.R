pkgname <- "ABRSQOL"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('ABRSQOL')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("ABRSQOL")
### * ABRSQOL

flush(stderr()); flush(stdout())

### Name: ABRSQOL
### Title: ABRSQOL numerical solution algorithm to invert a quality of life
###   measure
### Aliases: ABRSQOL

### ** Examples

# Example 1: load testdata, run QoL inversion with default parameters, append and view result
data(ABRSQOL_testdata)
my_dataframe = ABRSQOL_testdata
my_dataframe$QoL = ABRSQOL(df=ABRSQOL_testdata)
View(my_dataframe)

# Example 2: load your data from csv, run inversion, save result as csv
# my_dataframe = read.csv("path/to/your/csv_filename.csv")
my_dataframe$quality_of_life = ABRSQOL(
  # supply your dataset as a dataframe
  df=my_dataframe,
  # and specify the corresponding variable name for your dataset
  w = 'wage',
  p_H = 'floor_space_price',
  P_t = 'tradable_goods_price',
  p_n = 'local_services_price',
  L = 'residence_pop',
  L_b = 'L_b',
  # freely adjust remaining parameters
  alpha = 0.7,
  beta = 0.5,
  gamma = 3,
  xi = 5.5,
  conv = 0.3,
  tolerance = 1e-11,
  maxiter = 50000
)
write.csv(my_dataframe, 'qol_of_my_data.csv'

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




cleanEx()
nameEx("ABRSQOL_testdata")
### * ABRSQOL_testdata

flush(stderr()); flush(stdout())

### Name: ABRSQOL_testdata
### Title: Test data for ABRSQOL quality of life inversion
### Aliases: ABRSQOL_testdata
### Keywords: datasets

### ** Examples

library('ABRSQOL')
data(ABRSQOL_testdata)
ABRSQOL_testdata$QoL = ABRSQOL(df=ABRSQOL_testdata)
View(ABRSQOL_testdata)



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')

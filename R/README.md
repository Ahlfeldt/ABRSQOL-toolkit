
# ABRSQOL


## Installation
To install the R package of the ABRSQOL-toolkit from github, you must first install the devtools package. 
If you are new to R, note that you need to install [R-tools](https://cran.r-project.org/bin/windows/Rtools/) beforehand to be able to install the devtools package. 

``` r
install.packages('devtools')
```
You may then install and load it by running:
``` r
devtools::install_github('Ahlfeldt/ABRSQOL-toolkit', subdir='R')
library(ABRSQOL)
```

## Examples
### Example 1: load testdata, run QoL inversion with default parameters, store result as 'QoL' variable, view result
``` r
testdata = get("ABRSQOL_testdata")
testdata$QoL = ABRSQOL(df=testdata)
View(testdata)
```

### Example 2: load your data from csv, run inversion, save result as csv
``` r
my_dataframe = read.csv("path/to/your/csv_filename.csv")
my_dataframe$quality_of_life = ABRSQOL(
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
```

#### Example 3: Reference variables in your dataset by using the column index
``` r
ABRSQOL(
  df=my_dataframe,
  w = 1,
  p_H = 3,
  P_t = 4,
  p_n = 2,
  L = 6,
  L_b = 5
)
```

### Example 4: Having named the variables in your data according to the default parameters, you can ommit specifying variable names
``` r
ABRSQOL(
  df=my_dataframe,
  alpha = 0.7,
  beta = 0.5,
  gamma = 3,
  xi = 5.5,
  conv = 0.5
)
```

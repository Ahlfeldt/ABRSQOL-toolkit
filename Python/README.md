
# ABRSQOL


## Installation
To install the R package of the ABRSQOL-toolkit from github, you must first install the devtools package. 
If you are new to R, note it might be necessary to install [R-tools](https://cran.r-project.org/bin/windows/Rtools/) beforehand to be able to install the devtools package. 

```console

pip install -e "vcs+protocol://https://github.com/Ahlfeldt/ABRSQOL-toolkit/#egg=pkg&subdirectory=pkg_dir"

pip install -e "git+https://git.repo/some_repo.git#egg=$NAME_OF_PACKAGE&subdirectory=$SUBDIR_IN_REPO" # install a python package from a repo subdirectory


```
You may then install and load it by running:
```python
from abrsqol import ABRSQOL
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
  # specify the corresponding variable name for your dataset
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
# Write output to target folder (just replace the path)
write.csv(my_dataframe, 'C:/FOLDER/qol_of_my_data.csv')
```

### Example 3: Reference variables in your dataset by using the column index
``` r
my_dataframe$QoL = ABRSQOL(
  df=my_dataframe,
  w = 1,
  p_H = 3,
  P_t = 4,
  p_n = 2,
  L = 6,
  L_b = 5
)
```

### Example 4: Having named the variables in your data according to the default parameters, you can omit specifying variable names
``` r
my_dataframe$QoL = ABRSQOL(
  df=my_dataframe,
  alpha = 0.7,
  beta = 0.5,
  gamma = 3,
  xi = 5.5,
  conv = 0.5
)
```

## Ready-to-use script

If you are new to R, you may find it useful to execute the Example.R script saved in this folder. It will install the package, load the testing data set, generate a quality-of-life index, and save it to your working directory.  It should be straightforward to adapt the script to your data and preferred parameter values.

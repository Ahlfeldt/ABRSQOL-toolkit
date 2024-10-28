################################################################################
### Illustrative application of the ABRSQOL-toolkit based on                 
### Ahlfeldt, Bald, Roth, Seidel:                                            
### Measuring quality of life under spatial frictions                        	                                                            											
### 10/2024                                                                  
################################################################################

# This is an example code that you can execute as an Python script

# Install and run ABRSQOL-toolkit
# install package into your environment through your console via
# pip install "git+https://git@github.com/Ahlfeldt/ABRSQOL-toolkit.git#subdirectory=Python&egg=ABRSQOL"


import ABRSQOL
from pandas import read_csv
import os
import pandas as pd

# Load your data. You can replace the URL in "" with a local path on your machine, e.g. "c:\temp\ABRSQOL-testdata.csv"
my_dataframe = pd.read_csv("https://raw.githubusercontent.com/Ahlfeldt/ABRSQOL-toolkit/main/DATA/ABRSQOL-testdata.csv")
# or load testdata to inspect format requierement of input data
# my_dataframe = ABRSQOL.testdata

# Use ABRSQOL to solve for quality of life 
my_dataframe['QoL1'] = ABRSQOL.invert_quality_of_life(
  # supply your dataset as a dataframe
  df=my_dataframe,
  # specify the corresponding variable name for your data set. 
  # E.g., if your variable is named wage, use 'wage' instead of 'w'
  w = 'w',
  p_H = 'p_H',
  P_t = 'P_t',
  p_n = 'p_n',
  L = 'L',
  L_b = 'L_b',
  # freely adjust remaining parameters
  alpha = 0.7,
  beta = 0.5,
  gamma = 3,
  xi = 5,
  conv = 0.3,
  tolerance = 1e-11,
  maxiter = 50000
)
# To check current working directory
print(os.getcwd())
# Write output to target folder (just replace the path)
my_dataframe.to_csv('my_data_with_qol.csv', index=False)  
my_dataframe.describe()


# only df argument is required.
# Whenever you don't specify another argument its defaul value will be used.
# In this case assume all variables in my_dataframe are named as default,
# except for L (residence population) and L_b (hometown population)
my_dataframe['residence_pop'] = my_dataframe['L']
# Generate new variables with different names for illustration
my_dataframe['home_pop'] = my_dataframe['L_b']
# Rerun the package with simplified syntax
my_dataframe['QoL2'] = ABRSQOL.invert_quality_of_life(
  df=my_dataframe,
  L = 'residence_pop',
  L_b = 'home_pop',
  alpha = 0.7,
  beta = 0.5,
  gamma = 3,
  xi = 5.5,
  conv = 0.5
)
my_dataframe.describe()

# DONE
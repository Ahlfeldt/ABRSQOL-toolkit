################################################################################
### Illustrative application of the ABRSQOL-toolkit based on                 
### Ahlfeldt, Bald, Roth, Seidel:                                            
### Measuring quality of life under spatial frictions                        	                                                            											
### 10/2024                                                                  
################################################################################

# This is an example code that you can execute as an R script

# Start from an empty workspace
rm(list = ls())

# Install devtools
install.packages('devtools')

# Install and run ABRSQOL-toolkit
devtools::install_github('Ahlfeldt/ABRSQOL-toolkit', subdir='R/ABRSQOL')
library(ABRSQOL)

# Load the testing data. You can replace the URL in "" with a local path on your machine, e.g. "c:\temp\ABRSQOL-testdata.csv"
my_dataframe <- read.csv("https://raw.githubusercontent.com/Ahlfeldt/ABRSQOL-toolkit/main/DATA/ABRSQOL-testdata.csv")

# Use ABRSQOL to solve for quality of life 
my_dataframe$QoL1 <- ABRSQOL(
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
# Check current working directory where output will be saved
getwd()
# Write output to target folder (just replace the path)
write.csv(my_dataframe, 'my_data_with_qol.csv')


# only df argument is required.
# Whenever you don't specify another argument its defaul value will be used.
# In this case assume all variables in my_dataframe are named as default,
# except for L (residence population) and L_b (hometown population)
my_dataframe$QoL2 <- ABRSQOL(
  df=my_dataframe,
  L = 'residence_pop',
  L_b = 'home_pop',
  alpha = 0.7,
  beta = 0.5,
  gamma = 3,
  xi = 5.5,
  conv = 0.5
)

# DONE
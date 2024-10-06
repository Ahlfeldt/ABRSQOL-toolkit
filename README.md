# This site is under construction. The content is not ready to use.<br>Please be patient... 
# Toolking for measuring quality of life under spatial frictions
(c) Gabriel M. Ahlfeldt, Fabian Bald, Duncan Roth, Tobias Seidel

Version 0.9, 2024-09

**General instructions:**

This toolkit provides implementations of a numerical solution algorithm to invert unobserved quality of life from observed datain various programming languages. 

When using this toolkit in your work, please cite Gabriel M. Ahlfeldt, Fabian Bald, Duncan Roth, Tobias Seidel (forthcoming): Measuring quality of life under spatial frictions.

**Folders**

Name | Description |
|:---------------------------------------------|:-------------------------------------------------------------------------|
| DATA | Folder containing data set on which ABRSQOL can be tested.   |
| MATLAB | Folder containing a MATLAB function along with instructions. It does not contain the variables used in the paper.  |
| Python | Folder containing a Python package along with instructions. |
| R | Folder containing an R package along with instructions. |
| Stata | Folder containing a Stata ado file along with instructions. |

**Files**

Folder | Name  | Description |
|:-------------------|:-------------------------------------|:-------------------------------------------------------------------------|
| DATA | ABQOS-testdata.csv | Test data set in comma separated format. Please note that this is a test data set, and it is **not identical** to the data used in the paper. |
| DATA | ABQOS-testdata.dta | Test data set in commaStata format. Please note that this is a test data set, and it is **not identical** to the data used in the paper. |
| Stata | Example.do | Illustrative script that reads the test data set and calls the ABRSQOL programme with an exemplary syntax. Just open the do file in Stata after you have installed the ABRSQOL-toolkit and take it from there. |
| Stata | abrs.ado | Stata ado file. It needs to be copied to your personal ado file folder. This is done by the Examlple.do file. You can also copy it manually. To locate the path, type `adopath` in Stata. Alternatively, you can type `ssc install ABRSQOL` in Stata. |
| Stata | abrs.sthlp | Stata help file. It needs to be copied to your personal ado file folder. This is done by the Examlple.do file. You can also copy it manually. Once copied, you can call it by typing `help ABRSQOL` in Stata.


**Other files**:

| Name | Description |
|:---------------------------------------------|:-------------------------------------------------------------------------|
| XXX| YYY |

**Notes on Stata ado programme**: To install the ado file in Stata, just type 'ssc install ABRS'. In case Stata cannot connect to the internet, you may also manually copy both files to your ado folder. The programme will be ready to use. For information on the syntax, type 'help ABRS'.

**Further resources**: 

Gabriel M. Ahlfeldt, Fabian Bald, Duncan Roth, Tobias Seidel (forthcoming): Measuring quality of life under spatial frictions.

**Acknowledgements**

We thank [Max von Mylius](https://github.com/maximylius) for implementing the algorithm in Python and R.

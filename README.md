# Toolking for measuring quality of life under spatial frictions
# This is site is under construction. Content is not ready to use. Please be patient
(c) Gabriel M. Ahlfeldt, Fabian Bald, Duncan Roth, Tobias Seidel

Version 0.9, 2024-09

**General instructions:**

This toolkit provides implementations of a numerical solution algorithm to invert unobserved quality of life from observed datain various programming languages. 

When using this toolkit in your work, please cite Gabriel M. Ahlfeldt, Fabian Bald, Duncan Roth, Tobias Seidel (forthcoming): Measuring quality of life under spatial frictions.

**Folders**

Name | Description |
|:---------------------------------------------|:-------------------------------------------------------------------------|
| DATA | Folder containing data set on which ABRSQOL can be tested |
| MATLAB | Folder containing a MATLAB function along with instructions |
| Python | Folder containing a Python package along with instructions |
| R | Folder containing an R package along with instructions |
| Stata | Folder containing a Stata ado file along with instructions |

**Files**

Folder | Name  | Description |
|:---------------------------------------------|:-------------------------------------------------------------------------|
| DATA | ABQOS-testdata.csv | Test data set in comma separated format |
| DATA | ABQOS-testdata.dta | Test data set in commaStata format |
| Stata | Example.do | Illustrative script that reads the test data set and calls the ABRSQOL programme with an exemplary syntax |
| Stata | abrs.ado | Stata ado file. It needs to be copied to your personal ado file folder. To locate the path, type adopath in Stata |


**Other files**:

| Name | Description |
|:---------------------------------------------|:-------------------------------------------------------------------------|
| XXX| YYY |

**Notes on Stata ado programme**: To install the ado file in Stata, just type 'ssc install ABRS'. In case Stata cannot connect to the internet, you may also manually copy both files to your ado folder. The programme will be ready to use. For information on the syntax, type 'help ABRS'.

**Further resources**: 

Gabriel M. Ahlfeldt, Fabian Bald, Duncan Roth, Tobias Seidel (forthcoming): Measuring quality of life under spatial frictions.

**Acknowledgements**

We thank [Max von Mylius](https://github.com/maximylius) for implementing the algorithm in Python and R.

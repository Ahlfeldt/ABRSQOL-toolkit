# Toolking for measuring quality of life under spatial frictions
(c) Gabriel M. Ahlfeldt, Fabian Bald, Duncan Roth, Tobias Seidel

Version 0.9, 2024-09

**General instructions:**

This toolkit implements a numerical solution algorithm to invert a quality of life (QoL) from observed data in various programming languages. The QoL measure is based on Ahlfeldt, Bald, Roth, Seidel (2024): Measuring quality of life under spatial frictions. Unlike the traditional Rosen-Roback measure, this measure accounts for mobility frictions—generated by idiosyncratic tastes and local ties—and trade frictions—generated by trade costs and non-tradable services, thereby reducing non-classical measurement error. 

Notice that quality of life is identified up to a constant. Therefore, the inverted QoL measures measure has a relative interpretation only. We normalize the QoL relative to the first observation in the data set. It is straightforward to rescale the QoL measure to any other location or any other value (such as the mean or median in the distribution of QoL across locations). 

When using this toolkit in your work, please cite Gabriel M. Ahlfeldt, Fabian Bald, Duncan Roth, Tobias Seidel (forthcoming): Measuring quality of life under spatial frictions.

**Folders**

Name | Description |
|:---------------------------------------------|:-------------------------------------------------------------------------|
| DATA | Folder containing data a set on which ABRSQOL can be tested.   |
| MATLAB | Folder containing a MATLAB function along with instructions. It does not contain the variables used in the paper.  |
| Python | Folder containing a Python package along with instructions. *Under construction*. |
| R | Folder containing an R package along with instructions. *Under construction*.  |
| Stata | Folder containing a Stata ado file along with instructions. |

**Files**

Folder | Name  | Description |
|:-------------------|:-------------------------------------|:-------------------------------------------------------------------------|
| DATA | ABQOS-testdata.csv | Test data set in comma separated format. Please note that this is a test data set, and it is **not identical** to the data used in the paper. The data set includes average disposable household income as a measure of wage, the local labour market house price index from [Ahlfeldt, Heblich, Seidel (2023)](https://doi.org/10.1016/j.regsciurbeco.2022.103836), the 2015 census population as a measure of residence population and hte 1985 census population as measure of hometown population. Tradable goods price and local services price indices are uniformly set to one. |
| DATA | ABQOS-testdata.dta | Stata version of the test data set. Please note that this is a test data set, and it is **not identical** to the data used in the paper. |
| MATLAB | Example.m | Illustrative script that reads the test data set and calls the ABRSQOL funcation with an exemplary syntax. **Your journey starts here**. Just open the script file in MATLAB after you have copied it from the MATLAB folder and take it from there. You may also just copy the code to your MATLAB script editor and run it as a script (**do not just copy the code to the command window**). |
| MATLAB | abrsqol.m | MATLAB function. It needs to be copied to yourworking directory file folder. This is done by the Examlple.m file. |
| R | Example.do | Illustrative script that reads the test data set and calls the ABRSQOL programme with an exemplary syntax. **Your journey starts here**. Just open the do file in R and take it from there. You may also just copy the code to your R script editor editor and run it as a script (**do not just copy the code to the command window**). |
| Stata | Example.do | Illustrative script that reads the test data set and calls the ABRSQOL programme with an exemplary syntax. **Your journey starts here**. Just open the do file in Stata after you have installed the ABRSQOL-toolkit and take it from there. You may also just copy the code to your Stata do file editor and run it as a script (**do not just copy the code to the command window**). |
| Stata | abrsqol.ado | Stata ado file. It needs to be copied to your personal ado file folder. This is done by the Examlple.do file. You can also copy it manually. To locate the path, type `adopath` in Stata. Alternatively, you can type `ssc install ABRSQOL` in Stata. |
| Stata | abrsqol.sthlp | Stata help file. It needs to be copied to your personal ado file folder. This is done by the Examlple.do file. You can also copy it manually. Once copied, you can call it by typing `help ABRSQOL` in Stata.

**Notes on Stata ado programme**: To install the ado file in Stata, just type 'ssc install ABRS'. In case Stata cannot connect to the internet, you may also manually copy both files to your ado folder. The programme will be ready to use. For information on the syntax, type 'help ABRS'.

**Other files**:

| Name | Description |
|:---------------------------------------------|:-------------------------------------------------------------------------|
| ABRSQOL-Codebook.pdf | Codebook introducing variables and laying out the structure of the solver in pseduo code |

**Further resources**: 

Gabriel M. Ahlfeldt, Fabian Bald, Duncan Roth, Tobias Seidel (forthcoming): Measuring quality of life under spatial frictions.

**Acknowledgements**

We thank [Max von Mylius](https://github.com/maximylius) for implementing the algorithm in Python and R.

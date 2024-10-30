#' Test data for ABRSQOL quality of life inversion
#'
#' This is a test data set, and it is not identical to the data used in the
#' paper. The data set includes average disposable household income as a
#' measure of wage, the local labour market house price index from Ahlfeldt,
#' Heblich, Seidel (2023), the 2015 census population as a measure of
#' residence population and hte 1985 census population as measure of hometown
#' population. Tradable goods price and local services price indices
#' are uniformly set to one.
#'
#' @docType data
#'
#' @usage data(ABRSQOL_testdata)
#'
#' @format data.frame with colnames=c('llm_id','w','p_H','P_t','p_n','L','L_b',
#' 'Name','coord_x','coord_y') and 141 observations
#'
#' @keywords datasets
#'
#' @references Gabriel M. Ahlfeldt, Fabian Bald, Duncan Roth, Tobias Seidel
#' (forthcoming): Measuring quality of life under spatial frictions.
#'
#' @source 
#' \href{https://github.com/Ahlfeldt/ABRSQOL-toolkit}{ABRSQOL-toolkit}
#'
#' @examples
#' library('ABRSQOL')
#' data(ABRSQOL_testdata)
#' ABRSQOL_testdata$QoL = ABRSQOL(df=ABRSQOL_testdata)
#' ABRSQOL_testdata
"ABRSQOL_testdata"

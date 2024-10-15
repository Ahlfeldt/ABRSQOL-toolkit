#' ABRSQOL numerical solvers for quality-of-life measures
#'
#' ABRSQOL is part of the ABRSQOL-toolkit that provides numerical solvers for quality-of-life (QoL) measures that are consistent with the mode developed in Ahlfeldt, Bald, Roth, Seidel: Measuring quality of life under spatial frictions, henceforth ABRS. 
#' Notice that quality of life is identified up to a constant. Therefore, the inverted QoL measures measure has a relative interpretation only. We normalize the QoL relative to the first observation in the data set. 
#' It is straightforward to rescale the QoL measure to any other location or any other value (such as the mean or median in the distribution of QoL across locations).
#'
#' @param df data.frame or matrix
#' @param QoL_varname str
#' @param w str
#' @param p_H str
#' @param P_t str
#' @param p_n str
#' @param L str
#' @param L_b str
#' @param alpha float
#' @param beta float
#' @param gamma float
#' @param xi float
#' @param conv float
#' @param tolerance float
#' @param maxiter int
#'
#' @return Numeric vector of QoL measure (identified up to a constant)
#'
#' @examples
#' ABRSQOL(
#'  df=my_dataframe,
#'  QoL_varname='A',
#'  w = 'w', p_H = 'p_H', P_t = 'P_t', p_n = 'p_n', L = 'L', L_b = 'L_b',
#'  alpha = 0.7, beta = 0.5, gamma = 3, xi = 5.5,
#'  conv = 0.5, tolerance = 1e-10, maxiter = 1e4
#' )
#' # Example 1: run with ABRSQOL_testdata
#' ABRSQOL()
#' 
# Example 2: run with own data and specified varnames
#' ABRSQOL(
#'   # supply your dataset as a dataframe
#'   df=my_dataframe,
#'   # specify the name for the output variable
#'   QoL_varname='qol_indicator',
#'   # and specify the corresponding variable name for your dataset
#'   w = 'wage',
#'   p_H = 'floor_space_price',
#'   P_t = 'tradable_goods_price',
#'   p_n = 'local_services_price',
#'   L = 'residence_pop',
#'   L_b = 'L_b',
#'   # freely adjust remaining parameters
#'   alpha = 0.7,
#'   beta = 0.5,
#'   gamma = 3,
#'   xi = 5.5,
#'   conv = 0.3,
#'   tolerance = 1e-11,
#'   maxiter = 50000
#' )
#' 
#' 
#' # Example 3: Reference variables in your dataset by using the column index
#' ABRSQOL(
#'   df=my_dataframe,
#'   QoL_varname='A',
#'   w = 1,
#'   p_H = 3,
#'   P_t = 4,
#'   p_n = 2,
#'   L = 6,
#'   L_b = 5
#' )
#' 
#' 
#' # Example 4: Having named the variables in your data according to the default parameters, you can ommit specifying variable names
#' ABRSQOL(
#'   df=my_dataframe,
#'   alpha = 0.7,
#'   beta = 0.5,
#'   gamma = 3,
#'   xi = 5.5,
#'   conv = 0.5
#' )
#'
#' @export
ABRSQOL <- function(
  df, # data.frame or matrix containing dataset
  # specify variable names or column index
  w = 'w', # 2: Wage index
  p_H = 'p_H', # 3: Floor space price index
  P_t = 'P_t', # 4: Tradable goods price index
  p_n = 'p_n', # 5: Local services price index
  L = 'L', # 6: Residence population
  L_b = 'L_b', # 7: Hometown population
  # DEFINE PARAMETER VALUES
  alpha = 0.7, #income share on non-housing; 1-alpha expenditure on housing (Source: Statistisches Bundesamt, 2020)
  beta = 0.5, # share of alpha that is spent on tradable good
  gamma = 3, # Own calculations
  xi = 5.5, # Own calculations
  # CONVERGENCE AND STOPPING PARAMETERS
  conv = 0.5, # convergence parameter
  tolerance = 1e-10, # Tolerance level for loop
  maxiter = 10000
  ) {
  
  if(is.na(df)){
    cat("Load test data set and apply QoL inversion.")
    df = get("ABRSQOL_testdata")
  }

  if(QoL_varname %in% names(df)){
    cat("\nQoL variable '",QoL_varname,"' already exists and will be overwritten.")
  }

  # Generate key variables
  L_b = matrix(data = as.vector(unlist(df[L_b])), ncol=length(L_b), byrow=FALSE)
  L = matrix(data = as.vector(unlist(df[L])), ncol=length(L), byrow=FALSE)
  w = matrix(data = as.vector(unlist(df[w])), ncol=length(w), byrow=FALSE)
  P_t = df[[P_t]]
  p_H = df[[p_H]]
  p_n = df[[p_n]]


  # if there are different number of rows = unit of observation per variable throw an error
  if(length( unique(c(length(L_b),length(L),length(w),length(P_t),length(p_H),length(p_n)))) != 1){
    stop("\nVariables do not have the same length:","\nL_b: ",length(L_b), "\nL: ",length(L),"\nw: ",length(w),"\nP_t: ",length(P_t),"\np_H: ",length(p_H),"\np_n: ",length(p_n))
  }
  # else save units of observation
  J = length(L_b)

  # if there are unequal number of dimensions throw an error
  if(length(unique(c(dim(L_b)[2],dim(L)[2],dim(w)[2]))) != 1){
    stop("\nVariables do not have the same dimension:","\nL_b: ",dim(L_b)[2], "\nL: ",dim(L)[2],"\nw:", dim(w)[2])
  }
  # else assign theta number of dimensions
  Theta = dim(L_b)[2]


  ## Inversion
  
  # Adjust L_b to have same sum as L
  L_bar = sum(L) # total number of workers in dataset
  L_b_adjust <- L_bar / apply(L_b, 2, function(x) sum(x));
  L_b <- t(t(L_b) * L_b_adjust);
  
  # Express all variables in relative differences
  # Calculate relative employment, L_hat
  L_hat <- sweep(L, 2, L[1,], `/`)
  # Calculate relative wages, w_hat
  w_hat <- sweep(w, 2, w[1,], `/`);
  # Calculate relative price levels
  P_t_hat <- P_t / P_t[1];
  p_H_hat <- p_H / p_H[1];
  p_n_hat <- p_n / p_n[1];

  # Calculate aggregate price level
  P_hat <- (P_t_hat ^(alpha *beta)) * (p_n_hat ^(alpha *(1-beta)))  * (p_H_hat ^(1-alpha));
  P <- (P_t ^(alpha *beta))  * (p_n ^(alpha *(1-beta)))  * (p_H ^(1-alpha));

  # Relative Quality of life (A_hat)
  # Guess values relative QoL
  A_hat <- matrix(1, J, Theta); # First guess: all locations have the same QoL
  A <- A_hat;

  # list to store output
  O_vector_total <- list();
  O_total = max(100000, 2*tolerance) # Starting value for loop  
  count <- 1; # Counts the number of iterations

  cat("\nBegin loop to solve for QoL...\n")
  while (O_total > tolerance && count <= maxiter){
    cat("\r...itertion",count,", value of objective function:",O_total)
    # (1) Calculate model-consistent aggregation shares, Psi_b

    nom <- (as.vector(A) * w  * as.vector(1/P)) ^(gamma);

    lambda_nb <- sweep(nom, 2, apply(nom, 2, function(x) sum(x)), `/` );

    Psi_b <- ((sweep((exp(xi) - 1) * nom, 2, apply(nom, 2, function(x) sum(x)), `/`)) + 1) ^(-1);

    # (2) Calculate mathcal_L

    mathcal_L <- apply(L_b *Psi_b, 2, function(x) sum(x)) + L_b *Psi_b *(exp(xi) - 1);

    # (3) Calculate relative mathcal_L

    mathcal_L_hat <- sweep(mathcal_L, 2, mathcal_L[1,], `/`);

    # (4) Calculate relative QoL, A_hat, according to equation (17)

    A_hat_up <- as.vector(P_hat) * (1/ w_hat) * (L_hat / mathcal_L_hat) ^(1 /gamma);

    # (5) Calculate deviations from inital guesses for QoL levels

    O_total <- sum(abs(A_hat_up-A_hat))/J;

    O_vector_total[count] <- O_total;

    # Update QoL levels for next iteration of loop

    A_hat <- conv * A_hat_up + (1-conv) * A_hat;
    A <- A_hat;

    # Next iteration
    count <- count+1;

  }
  # cat("\n------------------------------------------------------------------");
  # cat("\n...finalizing...");

  # L_i = lambda_nb * (apply(L_b *Psi_b, 2, function(x) sum(x)) + L_b *Psi_b *(exp(xi) - 1));
  # test_agg = sum(L_i)-L_bar; # should be zero!!
  # test_i = L_i-L; # should be zero for all i !!#

  cat("\n------------------------------------------------------------------\n");
  cat("\n...QoL variable generated:\n")
  cat(str(A,vec.len=20))
  cat("\n------------------------------------------------------------------");

  return(A)
}

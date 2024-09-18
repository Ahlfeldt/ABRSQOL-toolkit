# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   https://r-pkgs.org
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'



qol_pseudo_data <- function(
    Theta = 1, # Number of worker groups. The codes are flexible enough to allow for an arbitrary number of heterogeneous worker groups
    JJ = 10, # Total number of regions
    L_bar = 5.5*10^6, # Assume 55 million workers in the dataset
    lL_b_theta = matrix(rnorm(JJ*Theta,11,0.92), nrow = JJ, byrow = FALSE),
    lL_theta = matrix(rnorm(JJ*Theta,11,0.92), nrow = JJ, byrow = FALSE),
    lw_theta = matrix(rnorm(JJ*Theta,0,1/3), nrow = JJ, byrow = FALSE),
    ln_P_t = matrix(rnorm(JJ*1,0,1/3), nrow = JJ, byrow = FALSE),
    ln_p_H = matrix(rnorm(JJ*1,0,1/3), nrow = JJ, byrow = FALSE),
    ln_p_n = matrix(rnorm(JJ*1,0,1/3), nrow = JJ, byrow = FALSE)
) {
  ## For now use "pseudo data" instead

  # (1) Model birth-place locations

  # lL_b_theta <- matrix(rnorm(JJ*Theta,11,0.92), nrow = JJ, byrow = FALSE);
  L_b_theta <- exp(lL_b_theta);
  L_b <- L_b_theta;

  # Normalise to get to L_bar

  L_b_adjust <- L_bar / apply(L_b, 2, function(x) sum(x));

  L_b <- t(t(L_b) * L_b_adjust);

  # (2) Model employment

  # lL_theta <- matrix(rnorm(JJ*Theta,11,0.92), nrow = JJ, byrow = FALSE);
  L_theta <- exp(lL_theta);
  L <- L_theta;

  # Normalise to get to L_bar

  L_adjust <- L_bar / apply(L, 2, function(x) sum(x));
  L <- t(t(L) * L_adjust);


  # (3) Model wages

  # lw_theta <- matrix(rnorm(JJ*Theta,0,1/3), nrow = JJ, byrow = FALSE);    #wages, group-specific
  w_theta <- exp(lw_theta);
  w <- w_theta;

  # (4) Model tradable price levels

  # ln_P_t <- matrix(rnorm(JJ*1,0,1/3), nrow = JJ, byrow = FALSE);

  P_t <- exp(ln_P_t);

  # (5) Model floor space prices

  # ln_p_H <- matrix(rnorm(JJ*1,0,1/3), nrow = JJ, byrow = FALSE);

  p_H <- exp(ln_p_H);

  # (6) Model prices of non-tradables

  # ln_p_n <- matrix(rnorm(JJ*1,0,1/3), nrow = JJ, byrow = FALSE);

  p_n <- exp(ln_p_n);
  return(list(
    'L_b' = L_b,
    'L' = L,
    'w' = w,
    'P_t' = P_t,
    'p_H' = p_H,
    'P_t' = P_t
  ))
}

qol_pseudo_data()




qol_inversion <- function(
    L_b = exp(matrix(rnorm(JJ*Theta,11,0.92), nrow = JJ, byrow = FALSE)),
    L = exp(matrix(rnorm(JJ*Theta,11,0.92), nrow = JJ, byrow = FALSE)),
    w = exp(matrix(rnorm(JJ*Theta,0,1/3), nrow = JJ, byrow = FALSE)),
    P_t = exp(matrix(rnorm(JJ*1,0,1/3), nrow = JJ, byrow = FALSE)),
    p_H = exp(matrix(rnorm(JJ*1,0,1/3), nrow = JJ, byrow = FALSE)),
    p_n = exp(matrix(rnorm(JJ*1,0,1/3), nrow = JJ, byrow = FALSE)),

    L_bar = 5.5*10^6,# Assume 55 million workers in the dataset,

    # SET PARAMETER VALUES
    alpha = 0.7, #income share on non-housing; 1-alpha expenditure on housing (Source: Statistisches Bundesamt, 2020)
    beta = 0.5, # share of alpha that is spent on tradable good
    gamma = 3, # Own calculations
    xi = 5.5, # Own calculations

    #
    upfactor = 0.2, # Updating factor in loop
    O_total = 100000,# Starting value for loop
    tolerance_total = 1*10^(-10) # Tolerance level for loop

    ) {



  ## Note: Loading in all variables needed for inversion //
  # Data originates from IEB datatset
  # Note: should include the original dataset // Load your own dataset there


  # (1) Model birth-place locations

  # Normalise to get to L_bar

  L_b_adjust <- L_bar / apply(L_b, 2, function(x) sum(x));
  L_b <- t(t(L_b) * L_b_adjust);

  # (2) Model employment

  # Normalise to get to L_bar

  L_adjust <- L_bar / apply(L, 2, function(x) sum(x));
  L <- t(t(L) * L_adjust);

  # (3) Model wages
  # (4) Model tradable price levels
  # (5) Model floor space prices
  # (6) Model prices of non-tradables


  ## Inversion

  # Relative Quality of life (A_hat)

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


  # list to store output
  O_vector_total <- list();

  # Guess values relative QoL
  A_hat <- matrix(1, JJ, Theta); # First guess: all locations have the same QoL
  A <- A_hat;

  count <- 0; # Counts the number of iterations
  while (O_total > tolerance_total){

    # (1) Calculate model-consistent aggregation shares, Psi_b

    nom <- (as.vector(A) * w  * as.vector(1/P)) ^(gamma);
    print(nom);

    print(dim(nom));
    lambda_nb <- sweep(nom, 2, apply(nom, 2, function(x) sum(x)), `/` );

    Psi_b <- ((sweep((exp(xi) - 1) * nom, 2, apply(nom, 2, function(x) sum(x)), `/`)) + 1) ^(-1);

    # (2) Calculate mathcal_L

    mathcal_L <- apply(L_b *Psi_b, 2, function(x) sum(x)) + L_b *Psi_b *(exp(xi) - 1);

    # (3) Calculate relative mathcal_L

    mathcal_L_hat <- sweep(mathcal_L, 2, mathcal_L[1,], `/`);

    # (4) Calculate relative QoL, A_hat, according to equation (17)

    A_hat_up <- as.vector(P_hat) * (1/ w_hat) * (L_hat / mathcal_L_hat) ^(1 /gamma);

    # (5) Calculate deviations from inital guesses for QoL levels

    O_total <- sum(abs(A_hat_up-A_hat));
    O_vector_total[count] <- sum(abs(A_hat_up-A_hat));

    # Update QoL levels for next iteration of loop

    A_hat <- upfactor * A_hat_up + (1-upfactor) * A_hat;
    A <- A_hat;

    # Next iteration
    count <- count+1;

  }

  L_i = lambda_nb * (apply(L_b *Psi_b, 2, function(x) sum(x)) + L_b *Psi_b *(exp(xi) - 1));
  test_agg = sum(L_i)-L_bar; # should be zero!!
  test_i = L_i-L; # should be zero for all i !!#

  return (list(
    'A' = A,
    'P' = P,
    'P_hat' = P_hat,
    'L' = L,
    'L_b' = L_b,
    'L_hat' = L_hat,
    'w_hat' = w_hat,
    'P_t_hat' = P_t_hat,
    'p_H_hat' = p_H_hat,
    'p_n_hat' = p_n_hat,
    'L_i' = L_i,
    'test_agg' = test_agg,
    'test_i' = test_i,
    'count' = count
  ))


}

qol_inversion();
pseudo_data = qol_pseudo_data();
qol_inversion(
  L_b = pseudo_data[['L_b']],
  L = pseudo_data[['L']],
  w = pseudo_data[['w']],
  P_t = pseudo_data[['P_t']],
  p_H = pseudo_data[['p_H']],
  p_n = pseudo_data[['p_n']],
)



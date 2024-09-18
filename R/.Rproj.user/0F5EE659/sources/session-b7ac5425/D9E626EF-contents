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
  JJ = 144, # Total number of regions
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

}
qol_pseudo_data()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Illustrative application of the ABRSQOL-toolkit based on                 
%%% Ahlfeldt, Bald, Roth, Seidel:                                            
%%% Measuring quality of life under spatial frictions                        	                                                            											
%%% (c) Gabriel M. Ahlfeldt, Fabian Bald, Duncan Roth, Tobias Seidel          
%%% 10/2024                                                                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [A, O_total, test_agg] = ABRSQOL(alpha, beta, gamma, xi, w, p_H, P_t, p_n, L, L_b)
% Syntax %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % The function returns the following outputs
        % A          The quality of life measure; you can use other names
        % O_total    The value of the objective function; you can use other names
        % test_agg   A test that evaluates if for the inverted QoL the
        %            population is correctly predicted; should be zero; you can use
        %            other names
    % The funciton uses the following arguments
        % alpha     The share of expenditure on non-housing goods
        % beta      The share of tradables in consumption of non-housing goods
        % gamma     Preference heterogeneity (inverse labour supply elasticity)
        % xi        Valuation of local ties
        %
        % alpha, beta, gamma, xi must be scalars held in memory. They can
        % take different names or values 
        %
        % w         Wage index
        % p_H       Floor space price index
        % P_t       Tradable goods price index
        % p_n       Non-tradable goods price index
        % L         Resident population
        % L_b       Hometown population
        % w P_H p_t p_n L L_n must be N x 1 vectors of the same length

%% Inversion

% Relative Quality of life (A_hat)

% Retreive the number of observations
[JJ, ~] = size(w);

% Adjust hometown population to have the same total als resident population
L_bar = sum(L);
L_b_adjust = L_bar ./ sum(L_b,1);  % Normalise to get to L_bar
L_b = L_b .* L_b_adjust;

% Calculate relative employment, L_hat
L_hat = L ./ L(1,:);

w_hat = w ./ w(1,:);    % Calculate relative wages, w_hat


% Calculate relative price levels
P_t_hat = P_t./ P_t(1);
p_H_hat = p_H./ p_H(1);
p_n_hat = p_n./ p_n(1);

% Calculate aggregate price level

P_hat = (P_t_hat.^(alpha.*beta)) .* (p_n_hat.^(alpha.*(1-beta))) .* (p_H_hat.^(1-alpha));

P = (P_t.^(alpha.*beta)) .* (p_n.^(alpha.*(1-beta))) .* (p_H.^(1-alpha));

count = 1; % Counts the number of iterations
upfactor = 0.2; % Updating factor in loop

O_total = 100000; % Starting value for loop
tolerance_total = 1*10^(-10); % Tolerance level for loop

% Guess values relative QoL

A_hat = ones(JJ,1); % First guess: all locations have the same QoL
A = A_hat;

while O_total > tolerance_total 

% (1) Calculate model-consistent aggregation shares, Psi_b

nom = (A .* w ./ P).^(gamma) ;
lambda_nb = nom ./ sum(nom,1);

Psi_b = (((exp(xi) - 1) .* nom ./ sum(nom,1)) + 1).^(-1);

% (2) Calculate mathcal_L

mathcal_L = sum(L_b.*Psi_b,1) + L_b.*Psi_b.*(exp(xi) - 1);

% (3) Calculate relative mathcal_L

mathcal_L_hat = mathcal_L ./ mathcal_L(1,:);

% (4) Calculate relative QoL, A_hat, according to equation (17)

A_hat_up = P_hat ./ w_hat .* (L_hat ./ mathcal_L_hat).^(1./gamma);

% (5) Calculate deviations from inital guesses for QoL levels

O_total = sum(abs(A_hat_up-A_hat),'all');
O_vector_total(count) = sum(abs(A_hat_up-A_hat),'all');

% Update QoL levels for next iteration of loop

A_hat = upfactor .* A_hat_up + (1-upfactor) .* A_hat;
A = A_hat;

% Next iteration
count = count+1;

end

L_i = lambda_nb .* ((sum(L_b.*Psi_b,1) + L_b.*Psi_b.*(exp(xi) - 1)));
test_agg = sum(L_i)-L_bar; % should be zero!!
test_i = L_i-L; % should be zero for all i !!



end 
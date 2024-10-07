%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Illustrative application of the ABRSQOL-toolkit based on                 
%%% Ahlfeldt, Bald, Roth, Seidel:                                            
%%% Measuring quality of life under spatial frictions                        	                                                            											
%%% (c) Gabriel M. Ahlfeldt, Fabian Bald, Duncan Roth, Tobias Seidel          
%%% 10/2024                                                                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc


% This files load the testing data set and uses the ABRSQOL function
% See ABRSQOL.m for a detailed description of the syntax

% Set the working directory
cd('D:\Dropbox\GA_FB_DR_TS_MIGRATION\ABRSQOL-toolkit/MATLAB');

% Copy relevant files to working directory

    % Test data
        % Define the URL of the raw .mat file on GitHub
        url = 'https://raw.githubusercontent.com/Ahlfeldt/ABRSQOL-toolkit/main/DATA/ABRSQOL-testdata.mat';
        % Define the destination file name, including the path
        outputFile = 'ABRSQOL-testdata.mat';
        % Download the file and save it to the specified directory
        websave(outputFile, url);
    % ABQRSQOL function
        % Define the URL of the raw .m file on GitHub
        url = 'https://raw.githubusercontent.com/Ahlfeldt/ABRSQOL-toolkit/main/MATLAB/ABRSQOL.m';
        % Define the destination file name, including the path
        outputFile = 'ABRSQOL.m';
        % Download the file and save it to the specified directory
        websave(outputFile, url);

% Load the .mat file into the workspace
load('ABRSQOL-testdata.mat');

% Solve for region-specific QoL
[A, O_total, test_agg] = ABRSQOL(alpha, beta, gamma, xi, w, p_H, P_t, p_n, L, L_b);

% Done
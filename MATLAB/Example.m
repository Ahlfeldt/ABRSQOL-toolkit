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

% Set the working directory to the path to which Example.m has been copied

    % Detect the path of the currently running script (Example.m)
    scriptPath = fileparts(mfilename('fullpath'));
    % Change the working directory to the path of Example.m
    cd(scriptPath);
    % Now, scriptPath is set as the working directory
    disp(['Working directory set to: ', scriptPath]);


% Copy relevant files to working directory

    % Test data
        % Define the URL of the raw .mat file on GitHub
        url = 'https://raw.githubusercontent.com/Ahlfeldt/ABRSQOL-toolkit/main/DATA/ABRSQOL-testdata.csv';
        % Define the destination file name, including the path
        outputFile = 'ABRSQOL-testdata.csv';
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
% load('ABRSQOL-testdata.mat');

%% SET PARAMETER VALUES
%%%%%%%%%%%%%%%%%%%%%%
    alpha = 0.7;                    % income share on non-housing
    beta = 0.3419;                  % share of alpha that is spent on tradable good                        
    gamma = 3;                      % canonical value
    xi = 5.5;                       % canonical value

%% Note: Loading in all variables needed for inversion // 
    % Data in Application originates from IEB datatset
    % Note: should include the original dataset // Load your own dataset there

%% For exemplary purposes use "testdata" instead
    testdata = readmatrix("ABRSQOL-testdata.csv"); 
    % Required inputs
    llm_id = (1:141)';     % Local labour market identifier
    w = testdata(:,2);     % Wages
    p_H = testdata(:,3);   % Floor space price levels
    P_t = testdata(:,4);   % Price levels of tradable goods
    p_n = testdata(:,5);   % Price levels of nontradable services
    L = testdata(:,6);     % Residence population
    L_b = testdata(:,7);   % Hometown population    

% Solve for region-specific QoL
    [A, O_total, test_agg] = ABRSQOL(alpha, beta, gamma, xi, w, p_H, P_t, p_n, L, L_b);

% Save key outputs
    % A and llm_id are both Jx1 vectors of the same size
    J = length(A); % Replace with the actual size of A and llm_id if known
    
    % Create a table with the vectors A and llm_id
    T = table(llm_id,A);
    
    % Write the table to a CSV file with headers
    writetable(T, 'QoLoutput.csv');

% Done
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

% Notice that the first time you need to run this code as an entire script
% (by pressing the Run button), else the current working directory will not
% be recognized

% Set the working directory to the path to which Example.m has been copied

    % Detect the path of the currently running script (Example.m)
    scriptPath = fileparts(mfilename('fullpath'));
    % Change the working directory to the path of Example.m
    cd(scriptPath);
    % Inform the user about the working directory
    disp(['Working directory set to: ', scriptPath]);
    
    % Note: If the automatic detection does not work, you can manually set the working directory.
    % To do this, use the following command:
    % cd('path_to_your_directory');
    % Replace 'path_to_your_directory' with the path where Example.m is located.
    % For example:
    % cd('/Users/yourname/Documents/Example'); % On macOS or Linux
    % cd('C:\Users\yourname\Documents\Example'); % On Windows

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

    % Read the data using readtable to handle both numeric and text data
    testdata = readtable("ABRSQOL-testdata.csv");
    
    % Extract the required inputs
    llm_id = (1:141)';         % Local labour market identifier
    w = testdata{:, 2};        % Wages (assuming 'wages' is in the second column)
    p_H = testdata{:, 3};      % Floor space price levels
    P_t = testdata{:, 4};      % Price levels of tradable goods
    p_n = testdata{:, 5};      % Price levels of nontradable services
    L = testdata{:, 6};        % Residence population
    L_b = testdata{:, 7};      % Hometown population
    
    % Extract the Name variable as a cell array of strings (assuming 'Name' is a column in the CSV)
    Name = testdata.Name;     % If the column header is 'Name'

% Solve for region-specific QoL
    [A, O_total, test_agg] = ABRSQOL(alpha, beta, gamma, xi, w, p_H, P_t, p_n, L, L_b);

% Save key outputs
    % A and llm_id are both Jx1 vectors of the same size
    J = length(A); % Replace with the actual size of A and llm_id if known
    
    % Create a table with the vectors A and llm_id
    T = table(llm_id,A);
    
    % Write the table to a CSV file with headers
    writetable(T, 'QoLoutput.csv');

% Generate comparison to canonical Rosen-Roback measure

    % Assume p_H, wage, A, L, and Name are vectors of the same length
    RRQOL = p_H.^0.3 ./ w;
    RRQOL_hat = RRQOL / RRQOL(1); % Normalize by the first value

    % Create the scatter plot
    figure;
    
    % Normalize L for scaling (optional: helps keep sizes reasonable)
    L_normalized = 300 * (L - min(L)) / (max(L) - min(L)) + 20; % Scale to a larger range with a minimum size of 20
    
    % Create the scatter plot with light grey dots and sizes based on L
    scatter(RRQOL_hat, A, L_normalized, [0.7 0.7 0.7], 'filled', 'MarkerEdgeAlpha', 0.2); % Lighter grey color with transparency
    
    hold on;
    
    % Add labels for the points with smaller font size
    for i = 1:length(A)
        text(RRQOL_hat(i), A(i), Name{i}, 'FontSize', 6, 'Color', 'k', 'HorizontalAlignment', 'center');
    end
    
    % Customize the plot appearance
    xlabel('Rosen-Roback QoL measure');
    ylabel('ABRS QoL measure');
    set(gca, 'Color', 'white'); % Set background color to white
    legend('off'); % Turn off the legend
    
    % Adjust axes limits if needed for better visualization
    xlim([min(RRQOL_hat)*0.9, max(RRQOL_hat)*1.1]);
    ylim([min(A)*0.9, max(A)*1.1]);

hold off;


hold off;

% Done
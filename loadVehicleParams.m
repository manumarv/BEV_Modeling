T = readtable('Vehicles_Params_Summary.xlsx');
params = table2struct(T(strcmp(T.Make,'Toyota_Proace'), :));








SOC_init = 0.5; 
% eta_ess = 0.8; % energy storage subsystem round-trip efficiency
% E_batt = 2.0;
% E_ess_max = E_batt * 1000 * 3600; % energy storage capacity, J


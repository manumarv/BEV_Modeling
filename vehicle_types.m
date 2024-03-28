% Specify the path to the Excel sheet containing vehicle types
%excelFilePath = 'Vehicles_Params_Summary.xlsx';

% Read the vehicle types from the Excel sheet
vehicleTypesTable = readtable('Vehicles_Params_Summary.xlsx');
vehicleTypes = table2cell(vehicleTypesTable(:, 'Make'));

% Save the vehicle types to the MATLAB workspace
assignin('base', 'vehicleTypes', vehicleTypes);

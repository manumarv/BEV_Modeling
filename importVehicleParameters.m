function vehicleParams = importVehicleParameters(filename, targetMake)
    % Input:
    % - filename: Excel file containing vehicle parameters
    % - targetMake: Make of the car for which you want to import parameters
    
    % Read data from Excel file
    [data, headers] = xlsread(filename);

    % Find the column index for 'Make'
    makeColumnIndex = find(strcmp(headers, 'Make'));

    % Find rows where the 'Make' column matches the target make
    targetMakeRows = find(strcmp(data(:, makeColumnIndex), targetMake));

    % If no matching rows are found, display a message and return an empty struct
    if isempty(targetMakeRows)
        disp(['No data found for ', targetMake]);
        vehicleParams = struct();
        return;
    end

    % Extract parameters for the specified make
    makeData = data(targetMakeRows, :);

    % Create a struct to store vehicle parameters
    vehicleParams = struct();

    % Assign values to the struct fields
    for i = 1:length(headers)
        paramName = headers{i};
        paramValue = makeData(1, i);  % Assuming all rows have the same values for a given parameter

        % Assign parameter to the struct
        vehicleParams.(paramName) = paramValue;
    end
end

function params = getVehicleParams(vehicleName)
    T = readtable('Vehicles_Params_Summary.xlsx');
    params = table2struct(T(strcmp(T.Make, vehicleName), :));
end
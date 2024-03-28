%disp(selectedParamsStruct);

function [params,drivecycleData] = loadParams(targetMake, vehicleParamsFile, drivecycleFile)
    
     % Load Vehicle Parameters
    T = readtable(vehicleParamsFile);
    params = table2struct(T(strcmp(T.Make, targetMake), :));

    % Load Drive Cycle Data
    drivecycleData = readtable(drivecycleFile);

    end

%[targetMake, vehicleParamsFile, drivecycleFile] =  ...; % Define your file paths and targetMake

%Usage?

%targetMake=
%vehicleParamsFile=
% drivecycleFile = 'C:\Users\cob_e\OneDrive - purdue.edu\Mywork\PhD Thesis\Thesis Defense Proposal\AED\Autonomous Eco Driving for  Battery Electric Delivery Vehicle\Energy Consumption Modeling for Delivery Electric Vehicles\Drive Cycles\all_processed_drive_cycles\2006-03-21.csv'



%[params, drivecycleData] = loadParams(targetMake, vehicleParamsFile, drivecycleFile);


%F_tractive = vehicleDynamics(drivecycleData.speed_mph, drivecycleData.accel_meters_ps, 0, params);




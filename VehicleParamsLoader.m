classdef VehicleParamsLoader < matlab.System

    properties
        ExcelFilePath = 'C:\Users\cob_e\OneDrive - purdue.edu\Mywork\PhD Thesis\Thesis Defense Proposal\AED\Autonomous Eco Driving for  Battery Electric Delivery Vehicle\Energy Consumption Modeling for Delivery Electric Vehicles\Vehicles_Params_Summary.xlsx';
    end

    methods (Access = protected)
        function setupImpl(obj)
            % Initialization code
        end

        function params = stepImpl(obj, vehicleType)
            % Load parameters based on the selected vehicle type
            params = loadVehicleParams(vehicleType, obj.ExcelFilePath);
        end

        function resetImpl(obj)
            % Reset or finalize code
        end
    end
end

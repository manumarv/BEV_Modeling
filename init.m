clear,clc;
%DRIVE CYCLE SELECTION 

%folderPath = 'C:\Users\cob_e\OneDrive - purdue.edu\Mywork\PhD Thesis\Thesis Defense Proposal\AED\Autonomous Eco Driving for  Battery Electric Delivery Vehicle\Energy Modeling\Drive Cycles\all_processed_drive_cycles'; % Specify the folder path
%fileName = '2006-03-21.csv'; % Specify the drive cycle name
%filePath = fullfile(folderPath, fileName); % Construct the full file path

drivecycleData = readtable('2006-03-21.csv');
drivecycleData = table2array(drivecycleData(:,2:5));

%VEHICLE SELECTION
%Available Vehicles
%Renault Kangoo -E
%Toyota_Proace
%Peugeot E- Boxer
%Blue Arc EV
%Ford
%Mercedes-Benz

T = readtable('Vehicles_Params_Summary.xlsx');
params = table2struct(T(strcmp(T.Make,'Renault Kangoo -E'), :));

%PARAMS INIT

M_glider    = params.VehicleMass_lbs_/2.205;  % glider mass, kg
M_driver    = 70; % driver mass kg
C_D         = params.Cd;    % drag coefficient
C_0         = params.Cr;   % rolling resistance coefficient
A_F         = params.FrontalArea_m2_;    % frontal area, m^2
eta_ess     = 0.8; % energy storage subsystem round-trip efficiency
r_wheel     = params.WheelRadius_meters_; % wheel radius, m
P_eng_min   = 10000.0; % min engine power, W
P_eng_max   = 85000.0; % max engine power, W
G_diff      = 0.268;     % differential gear ratio
G_cvt_min   = 0.5;  % minimum tansmission gear ratio
w_eng_min   = 1000; % minimum engine speed, rpm
E_batt      = 2.0;   % battery capacity, kW
SOC_init    = 0.5; % initial SOC
m_batt      = 21.74; % battery mass, kg/kw-hr
G_elec      = 1; % gear ratio for motor
rho         = params.AirDensity; % density of air, kg/m^3
g           = 9.8; % acceleration due to gravity,  m/s^s

%out=sim('powertrain_model',3556);
%run Plot.m
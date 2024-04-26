clear,clc;
%% DRIVE CYCLE AND VEHICLE SELECTION

%folderPath = 'C:\Users\cob_e\OneDrive - purdue.edu\Mywork\PhD Thesis\Thesis Defense Proposal\AED\Autonomous Eco Driving for  Battery Electric Delivery Vehicle\Energy Modeling\Drive Cycles\all_processed_drive_cycles'; % Specify the folder path
%fileName = '2006-03-21.csv'; % Specify the drive cycle name
%filePath = fullfile(folderPath, fileName); % Construct the full file path

drivecycleData = readtable('2006-03-21.csv');
drivecycleData = table2array(drivecycleData(:,2:5));

%Available Vehicles: 
    %Renault Kangoo -E
    %Toyota_Proace
    %Peugeot E- Boxer
    %Blue Arc EV
    %Ford
    %Mercedes-Benz

T = readtable('Vehicles_Params_Summary.xlsx');
params = table2struct(T(strcmp(T.Make,'Renault Kangoo -E'), :));

speed_vector = (drivecycleData(:,3:3)).';
acceleration_vector = (drivecycleData(:,4:4)).';



%% PARAMS INIT

% Vehicle Parameters
m    = params.VehicleMass_lbs_/2.205;  % glider mass, kg
M_driver    = 80;           % driver mass kg
cd          = params.Cd;    % drag coefficient
cr          = params.Cr;                    % rolling resistance coefficient
A_F         = params.FrontalArea_m2_;    % frontal area, m^2
eta_ess     = 0.8; % energy storage subsystem round-trip efficiency
wr          = params.WheelRadius_meters_; % wheel radius, m
P_eng_min   = 10000.0; % min engine power, W
P_eng_max   = 85000.0; % max engine power,  W
G_diff      = 0.268;     % differential gear ratio
G_cvt_min   = 0.5;  % minimum tansmission gear ratio
w_eng_min   = 1000; % minimum engine speed, rpm
rho_a       = params.AirDensity; % density of air, kg/m^3
g           = 9.8; % acceleration due to gravity,  m/s^s

%Battery Parameters
E_batt      = 2.0;   % battery capacity, kW
SOC_init    = 0.5; % initial SOC
m_batt      = 21.74; % battery mass, kg/kw-hr
G_elec      = 1; % gear ratio for motor


%Motor Curve - Characteristics 
RPM     = [0 1200 2400 3600 4800 6000 7200]; 
N_m     = [235.1 235 234.8 234.6 204.5 161.8 120.6];
Eff     = [90 87.4 92.8 94.8 94.3 92.9 91.9]; 
Pm_kW   = [0 29.5 59 88.4 102.8 101.6 90.9];
V_rms   = [8.5 26.5 50.8 75.1 80.6 80.6 80.6]; 

Tmmax       = [245, 245, 245, 180, 130, 100, 80, 70, 59, 50, 40, 32, 28]; 

%Conversion Multipliers
meter_to_miles  = 0.000621371;
mph_to_m_s      = 0.44704;
lbs_to_kg       = 0.45351;
joules_to_kWh   = 0.0000002778;

% GearBox Tranmission Data Mode


gear_logic_selection = 'optimal'; % Initialize the mode (can be 'optimal' or 'suboptimal')

if strcmp(gear_logic_selection, 'optimal')
    gear_ratios = [3.0, 1.5]; % Gear ratios for optimal mode
elseif strcmp(gear_logic_selection, 'suboptimal')
    gear_ratios = [3.0]; % Gear ratio for suboptimal mode
else
    gear_ratios = [2.5]; % Default gear ratio if neither optimal nor suboptimal
end

%gear_ratios = [3,1.5];

% fixed_gear_ratio = 1 ;
% dt = 0.1;


%% OPTIMIZATION OPTIONS 


% Import Optimal Gear Sequence

[optimal_gear_sequence, min_energy] = minimize_energy_consumption(speed_vector, acceleration_vector, m, wr, cr, cd, g, rho_a, gear_ratios, dt, Tmmax);

optimal_gear_indices = optimal_gear_sequence;

optimal_gear_ratios = (gear_ratios(optimal_gear_indices)).';
index_columns=(1:length(optimal_gear_ratios)).';

optimal_gear_ratios = [index_columns,optimal_gear_ratios];

% Define your simulation time step
%dt = 0.1;  % Adjust dt to your Simulink model's time step
%simulation_time = 0:dt:(length(optimal_gear_ratios)-1)*dt;

%N= length(drivecycleData);



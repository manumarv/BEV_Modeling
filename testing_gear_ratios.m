% Define gear ratios to evaluate
gear_ratios = [1.5, 4,7.8]; % Example gear ratios
n_t = 0.98; % Transmission efficiency
dt = 1; % Time step in seconds

% Vehicle and motor parameters
cleparams.WheelRadius_meters_ = params.WheelRadius_meters_; % define this value
%drivecycleData = drivecycleData(:,1:1); % load your drive cycle data
motor_efficiency = 0.9; % assume a constant motor efficiency for simplicity

% Initialize array to store energy consumption for each gear ratio
Energy_kWh_per_gear = zeros(length(gear_ratios), 1);


RPM = [0 1200 2400 3600 4800 6000 7200]; 
N_m = [235.1 235 234.8 234.6 204.5 161.8 120.6];
Eff = [0 87.4 92.8 94.8 94.3 92.9 91.9]; 
Pm_kW = [0 29.5 59 88.4 102.8 101.6 90.9];
V_rms = [8.5 26.5 50.8 75.1 80.6 80.6 80.6]; 




% Interpolation function for efficiency
efficiency_interp = @(torque) interp1(N_m, Eff, torque, 'linear', 'extrap');

% The rest of your code...
for i = 1:length(gear_ratios)
    GR = gear_ratios(i);

    % Torque at the wheels in N.m
    T_w = out.Traction_Force.Data * params.WheelRadius_meters_;

    % Torque in Motor in N.m
    T_m = T_w / (GR * n_t);

    % Interpolate the efficiency based on the motor torque
    motor_efficiency = efficiency_interp(T_m) / 100; % Divide by 100 to convert percentage to a fraction

    % The rest of your calculations using motor_efficiency...
    % Wheel Speed in RPM (assuming drivecycleData(:,3) is wheel speed in m/s)
    w_wheel_rpm = (drivecycleData(:,3) / params.WheelRadius_meters_) * (60 / (2 * pi));

    % Motor Speed in RPM
    w_motor_rpm = w_wheel_rpm * GR;

    % Convert motor speed to rad/s
    w_motor_rad_s = w_motor_rpm * (2 * pi / 60);

    % Motor Power in W (considering interpolated motor efficiency)
    P = T_m .* w_motor_rad_s(1:3556).' * motor_efficiency;

    % Calculate energy consumed (integrating power over each time step)
    Energy = cumsum(P) * dt; % Energy in Joules

    % Convert energy to kWh and store it for this gear ratio
    Energy_kWh_per_gear(i) = Energy(end) / (3.6e6); % Divide by 3.6e6 to convert Joules to kWh
end

% Output the energy consumption for each gear ratio
disp('Energy consumption for each gear ratio (in kWh):');
disp(Energy_kWh_per_gear);
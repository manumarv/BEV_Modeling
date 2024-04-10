
% GR  = 7.8;
% n_t = 0.98;
% 
% %Torque at the wheels in N.m
% T_w = out.Traction_Force*params.WheelRadius_meters_;
% 
% %Torque in Motor in N.m
% T_m = T_w/(GR*n_t);  
% 
% %Wheel Speed in RPM
% w_wheel = drivecycleData(:,3:3)/params.WheelRadius_meters_;       
% 
% %Motor Speed rad/s
% w_motor = w_wheel *GR*(2*pi/60); 
% 
% %Motor Power 
% P = T_m.Data(:,1).*w_motor(1:3556,1);
% 
% 
% % Calculate energy consumed (assuming constant power over each time step dt)
% dt = 1; % Time step in seconds
% Energy = cumsum(P) * dt; % Energy in Joules
% 
% Energy_kWh = Energy(end) / (3.6e6) % Divide by 3.6e6 to convert Joules to kWh\


% Define gear ratios to evaluate
gear_ratios = [7.8, 10, 12]; % Example gear ratios
n_t = 0.98; % Transmission efficiency
dt = 1; % Time step in seconds

% Vehicle and motor parameters
params.WheelRadius_meters_ = params.WheelRadius_meters_; % define this value
drivecycleData = drivecycleData(:,1:1); % load your drive cycle data
motor_efficiency = 0.9; % assume a constant motor efficiency for simplicity

% Initialize array to store energy consumption for each gear ratio
Energy_kWh_per_gear = zeros(length(gear_ratios), 1);

for i = 1:length(gear_ratios)
    GR = gear_ratios(i);

    % Torque at the wheels in N.m
    T_w = out.Traction_Force.Data * params.WheelRadius_meters_;

    % Torque in Motor in N.m
    T_m = T_w / (GR * n_t);

    % Wheel Speed in RPM (assuming drivecycleData(:,3) is wheel speed in m/s)
    w_wheel_rpm = (drivecycleData / params.WheelRadius_meters_) * (60 / (2 * pi));

    % Motor Speed in RPM
    w_motor_rpm = w_wheel_rpm * GR;

    % Convert motor speed to rad/s
    w_motor_rad_s = w_motor_rpm * (2 * pi / 60);

    % Motor Power in W (considering motor efficiency)
    P = T_m .* w_motor_rad_s(1:3556) * motor_efficiency;

    % Calculate energy consumed (integrating power over each time step)
    Energy = cumsum(P) * dt; % Energy in Joules

    % Convert energy to kWh and store it for this gear ratio
    Energy_kWh_per_gear(i) = Energy(end) / (3.6e6); % Divide by 3.6e6 to convert Joules to kWh
end

% Output the energy consumption for each gear ratio
disp('Energy consumption for each gear ratio (in kWh):');
disp(Energy_kWh_per_gear);

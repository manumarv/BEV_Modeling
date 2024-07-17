clc;
clear;

% Load the data
drivecycleData = readtable('extracted_data_filtered - Copy.csv');

% Assuming 'cycle_sec' is the first column and 'Speed (mph)' is the third column
cycle_sec = table2array(drivecycleData(:,2)); % Time in seconds
speed_mph = table2array(drivecycleData(:,4)); % Speed in miles per hour (mph)

% Convert speed from mph to km/h for better readability
speed_kph = speed_mph * 1.60934;

% Initialize variables
numStops = 0;
idleTime = 0;
numTurns = 0;
speedLimits = [];
routeLength = 0;

% Parameters
idleSpeedThreshold = 5; % Speed threshold to consider as idle (in km/h)
timeStep = mean(diff(cycle_sec)); % Assuming nearly constant time step

% Calculate number of stops and idle time
for i = 2:length(speed_kph)
    if speed_kph(i) < idleSpeedThreshold && speed_kph(i-1) >= idleSpeedThreshold
        numStops = numStops + 1;
    end
    if speed_kph(i) < idleSpeedThreshold
        idleTime = idleTime + timeStep;
    end
end

% Calculate number of turns (assuming GPS data or directional changes are available)
% Placeholder calculation as we only have speed data
% numTurns = ... (this would require directional data, which we don't have here)

% Calculate speed limits
speedLimits = [min(speed_kph), max(speed_kph)];

% Calculate route length
routeLength = sum(speed_kph * 1000 / 3600 .* timeStep); % Convert speed to m/s and multiply by time to get distance

% Create a summary table
summaryTable = table(numStops, idleTime, numTurns, speedLimits(1), speedLimits(2), routeLength, ...
                     'VariableNames', {'Number_of_Stops', 'Idle_Time_sec', 'Number_of_Turns', ...
                                       'Min_Speed_kph', 'Max_Speed_kph', 'Route_Length_m'});

% Display the summary table
disp(summaryTable);

% Plot the drive cycle
figure;
plot(cycle_sec, speed_kph);
xlabel('Time (s)');
ylabel('Speed (km/h)');
title('Drive Cycle');
grid on;

% Plot Drive Cycle 

for i = 1:length(vehicleList)
    figure;
    subplot(3, 1, 1);
    plot(time_vector, speed_vector);
    title(['Drive Cycle Speed - ' vehicleList{i}]);
    xlabel('Time (s)');
    ylabel('Speed (m/s)');
    grid on;

    subplot(3, 1, 2);
    plot(time_vector, torque_data_optimal{i});
    title(['Torque (Optimal) - ' vehicleList{i}]);
    xlabel('Time (s)');
    ylabel('Torque (N.m)');
    grid on;

    subplot(3, 1, 3);
    plot(time_vector, torque_data_suboptimal{i});
    title(['Torque (Suboptimal) - ' vehicleList{i}]);
    xlabel('Time (s)');
    ylabel('Torque (N.m)');
    grid on;
end

figure(1)
x1 = linspace(0, 1, length(out.F_aero.Data(:,1)));
plot(x1, out.F_aero.Data(:,1))
hold on
plot(x1, out.F_acc.Data(:,1))
hold off
grid
legend('F-aero', 'F-acc')
xlabel('x')
ylabel('Forces (Newtons)')

figure(2)
x1 = linspace(0, 1, length(out.F_aero.Data(:,1)));
plot(x1, out.Power_Needed.Data(:,1))
hold on
plot(x1, out.motor_power.Data(:,1))
plot(x1,out.Battery_Power.Data(:,1))
hold off
grid
legend('Power Needed', 'Motor Power','Battery Power')
xlabel('x')
ylabel('Power (kW)')


% Permanent Magnet Motor Analysis 


figure(3);
plot(out.Motor_Speed.Data(:,1), out.Motor_Torque.Data(:,1))
grid
legend('Motor Speed')
xlabel('x')
ylabel('Torque (N.m)')




plot(x1,out.Motor_Torque.Data);
title('Motor Torque')
ylabel('Nm');
% 

figure(4);
plot(out.Motor_Speed.Data);
title('Motor Speed')
ylabel('RPM');


% 
figure(5);
plot(out.Battery_Current.Data);
title('Battery Current')
ylabel('A');

figure(6);
plot(out.SOC.Data);
title('State of Charge')
ylabel('SOC');

Summary = categorical(["Tractive Energy (kWh)"; "Aerodynamic Lost (kWh)"; "Rolling Resistance Loss(kWh)"; "Miles Traveled"]);
Results = [round(out.Tractive_Energy.Data(3556),2);
            round(out.Aero_Force_Loss.Data(3556),2);
            round(out.Rolling_resistance_loss.Data(3556),2); 
            round(out.Miles_Traveled.Data(3556),2)];

T = table(Summary,Results)



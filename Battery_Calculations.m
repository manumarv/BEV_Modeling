%Battery Calculations

C_eff = 0.99; % Coulumnb Efficiency
B_eff = 0.97; % Battery Efficiency

D=300; % km 
Range =300;
voltage = 48;
Batt_Power = P_m./(C_eff*B_eff);%Watts

Power_km= (trapz(Batt_Power)/(D*3.6*10^6))*1000 ;%kWatts



Battery_Capacity = Power_km*Range; %w/h


Ah=Battery_Capacity/voltage;


 
% C = I/Ah;
% 
% SOC = 100 * integral(i/(3600*Ah));


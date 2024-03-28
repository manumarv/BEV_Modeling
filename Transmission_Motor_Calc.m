%Transmission Calculations
function [T_w,N_w,N_m,T_m,P_m] = Transmission_Motor_Calc(tractive_force,params,v_mph);

    v = v_mph * 0.44704;
    %Torque Required at the wheels
    T_w = tractive_force.*params.WheelRadius_meters_;
    
    %Wheel speed in rpm
    N_w = (v.*60)/(2*pi*params.WheelRadius_meters_);
    
    %Motor Torque
    T_m = T_w./(params.TransmissionGearRatio);
    
    %Motor Speed
    N_m = N_w.*params.TransmissionGearRatio; 
    
    %Traction Motor
    P_m = (2*pi.*N_m.*T_m)/(60*0.95); 

end 


% [T_w,N_w,N_m,T_m,P_m] = Transmission_Motor_Calc(F_tractive,params, drivecycleData.speed_mph);



 
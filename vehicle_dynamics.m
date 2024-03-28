function [F_tractive,F_aero]= vehicleDynamics(v_mph, a_mps2, alpha, params)
    v = v_mph * 0.44704; % Convert mph to m/s
    a = a_mps2;

    GVM = params.VehicleMass_lbs_ / 2.205;
    GVW = GVM * 9.8;

    F_rolling = (params.Cr * GVW) / params.WheelRadius_meters_;

    F_aero = (0.5 * params.AirDensity * params.Cd * params.FrontalArea_m2__1) .* v.^2;

    F_grade = 0; % GVW * sin(alpha);

    F_acc = GVM .* a;

    F_tractive = F_rolling + F_grade + F_aero + F_acc;
end

% Usage:
%F_tractive = vehicle_dynamics(drivecycleData.speed_mph, drivecycleData.accel_meters_ps, 0, params);



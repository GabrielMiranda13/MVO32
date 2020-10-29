function [f,X,U,Y]=trim_function(x,trim_par,flag_cond)

theta_deg_eq= x(1) + trim_par(flag_cond).gamma_deg;
X=[trim_par(flag_cond).V; x(1:2); theta_deg_eq; trim_par(flag_cond).h; 0];
U=[x(3:4); 0];

[Xdot,Y]=long_dynamics(0,X,U,flag_cond);

f=[
    Xdot(1:3)
    Xdot(4)-trim_par(flag_cond).thetadot_deg_s;
    ];

end

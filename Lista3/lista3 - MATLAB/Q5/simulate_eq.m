function [Xdot,Y] = simulate_eq(t,X,U_eq,flag_cond)

U = U_eq;

[Xdot,Y] = dynamics(t,X,U,flag_cond);

Y = [
    Y
    U
    ];

end
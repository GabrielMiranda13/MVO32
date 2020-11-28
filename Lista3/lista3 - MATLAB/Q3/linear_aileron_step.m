function [Xdot,Y] = linear_aileron_step(t,X,U_eq,flag_cond)

U=U_eq;

if(t>=0)
    U(5)=U(5)+5;
end

[Xdot,Y]=linear_dynamics(t,X,U,flag_cond);

Y = [
    Y
    U
    ];

end
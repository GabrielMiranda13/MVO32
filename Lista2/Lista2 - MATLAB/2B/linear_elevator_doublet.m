function [Xdot,Y] = linear_elevator_doublet(t,X,U_eq,flag_cond)

U=U_eq;

if(t>=1 && t<3)
    U(3)=U(3)+5;
elseif(t>=3 && t<5)
    U(3)=U(3)-5;
end

[Xdot,Y]=linear_dynamics(t,X,U,flag_cond);

Y = [
    Y
    U
    ];

end
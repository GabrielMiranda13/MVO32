function [Xdot,Y] = throttle_doublet(t,X,U_eq,flag_cond)

U=U_eq;

if(t>1 && t<3.5)
    U(1)=U(1)-0.1;
    U(2)=U(2)+0.1;
elseif(t>=3.5 && t<6)
    U(1)=U(1)+0.1;
    U(2)=U(2)-0.1;
end

[Xdot,Y]=dynamics(t,X,U,flag_cond);

Y = [
    Y
    U
    ];

end
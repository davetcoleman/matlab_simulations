function notebook_function4 = pendulum_equation4(t,x1,x2,x3,x4,x5,u)
%PENDULUM_EQUATION4
%    NOTEBOOK_FUNCTION4 = PENDULUM_EQUATION4(T,X1,X2,X3,X4,X5,U)

%    This function was generated by the Symbolic Math Toolbox version 5.11.
%    13-Nov-2013 17:45:07

t2 = sin(x3);
t3 = cos(x3);
t4 = t2.^2;
t5 = t4.*7.8529e1;
t6 = t5+5.9e1;
t7 = 1.0./t6;
notebook_function4 = t7.*(t2.*4.56876e3-t2.*t3.*7.8529e1+t3.*x2.*2.8e1)-t3.*t7.*u;

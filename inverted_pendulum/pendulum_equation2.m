function notebook_function2 = pendulum_equation2(t,x1,x2,x3,x4,x5,u)
%PENDULUM_EQUATION2
%    NOTEBOOK_FUNCTION2 = PENDULUM_EQUATION2(T,X1,X2,X3,X4,X5,U)

%    This function was generated by the Symbolic Math Toolbox version 5.11.
%    13-Nov-2013 17:45:07

t2 = sin(x3);
t3 = t2.^2;
t4 = t3.*2.662e2;
t5 = t4+2.0e2;
t6 = 1.0./t5;
notebook_function2 = t6.*u-t6.*(x2.*2.8e1-t2.*x4.^2.*7.8529e1+t2.*cos(x3).*2.60876e3);

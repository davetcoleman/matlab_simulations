function notebook_function2 = pendulum_equation2(t,x1,x2,x3,x4)
%PENDULUM_EQUATION2
%    NOTEBOOK_FUNCTION2 = PENDULUM_EQUATION2(T,X1,X2,X3,X4)

%    This function was generated by the Symbolic Math Toolbox version 5.11.
%    13-Nov-2013 12:58:27

t2 = sin(x3);
notebook_function2 = -(x2.*2.8e1-t2.*x4.^2.*7.8529e1+t2.*cos(x3).*2.60876e3)./(t2.^2.*2.662e2+2.0e2);
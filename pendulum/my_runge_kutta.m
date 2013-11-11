function y_new = my_runge_kutta(t,y,h,f)
%Runge-Kutta
%
% t - current time
% y - current state
% h - time step
% f - a function of the system

k1 = f(t,y);
k2 = f(t+.5*h,y+h/2*k1);
k3 = f(t+.5*h,y+h/2*k2);
k4 = f(t+h,y+h*k3);

y_new = y + 1/6*h*(k1 + 2*k2 + 2*k3 + k4);
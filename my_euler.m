function x_new = my_euler(t,x,h,f)
% euler method - simplest form of Runge-Kutta
%
% t - current time
% x - current state - position, velocity
% h - time step
% f - a function of the system

x_new = x + h*f(t,x);


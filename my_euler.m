function y_new = my_euler(t,y,h,f)
% euler method - simplest form of Runge-Kutta
%
% t - current time
% y - current state - position, velocity
% h - time step
% f - a function of the system

y_new = y(2) + h*f(t,y);


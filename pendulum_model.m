x_new = function pendulum_model(t,x)
% model of system

x_new = @(t,x) -g/l*sin(x(1))-k/m*velocity;
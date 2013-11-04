function x_new = pendulum_model(t,x)

% change in theta position = theta velocity
x1_dot = x(2);

% change in theta velocity = theta acceleration
x2_dot = pendulum_equation(t,x(1),x(2)); 

x_new = [x1_dot, x2_dot];
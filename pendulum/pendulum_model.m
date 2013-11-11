function x_new = pendulum_model(t,x)

% change in theta position = theta velocity
x1_dot = x(2);

% change in theta velocity = theta acceleration
x2_dot = pendulum_equation2(t,x(1),x(2),x(3)); 

% integral of position
x3_dot = pendulum_equation3(t,x(1));

x_new = [x1_dot, x2_dot, x3_dot];
function x_dot = pendulum_model(t,x)
% my implementation of an inverted pendulum with a cart

x_dot = zeros(4,1); % a column vector

% change in theta position = theta velocity
x_dot(1) = x(2);

% change in theta velocity = theta acceleration
x_dot(2) = pendulum_equation2(t,x(1),x(2),x(3),x(4)); 

%
x_dot(3) = x(4);

% 
x_dot(3) = pendulum_equation4(t,x(1),x(2),x(3),x(4));
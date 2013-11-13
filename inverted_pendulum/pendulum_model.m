function y_dot = pendulum_model(t,y)
% my implementation of an inverted pendulum with a cart

y_dot = zeros(4,1); % a column vector

% change in theta position = theta velocity
y_dot(1) = y(2);

% change in theta velocity = theta acceleration
y_dot(2) = pendulum_equation2(t,y(1),y(2),y(3),y(4)); 

%
y_dot(3) = y(4);

% 
y_dot(4) = pendulum_equation4(t,y(1),y(2),y(3),y(4));
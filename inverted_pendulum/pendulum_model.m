function y_dot = pendulum_model(t,y)
% my implementation of an inverted pendulum with a cart

y_dot = zeros(4,1); % a column vector

% cart velocity
y_dot(1) = y(2);

% cart acceleration
y_dot(2) = pendulum_equation2(t,y(1),y(2),y(3),y(4),y(5),0);

% change in theta position = theta velocity
y_dot(3) = y(4);

% change in theta velocity = theta acceleration
y_dot(4) = pendulum_equation4(t,y(1),y(2),y(3),y(4),y(5),0);

% cart control input
y_dot(5) = pendulum_equation5(t,y(1),y(2),y(3),y(4),y(5),0);
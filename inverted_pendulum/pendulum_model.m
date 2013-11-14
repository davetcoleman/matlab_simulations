function y_dot = pendulum_model(t,y)
% my implementation of an inverted pendulum with a cart

y_dot = zeros(4,1); % a column vector

% cart velocity
y_dot(1) = y(2);

%G = 1.0e+03 * [   -0.0000   -0.0567  -9.0427   -1.0415];
global G;

% control
u = min(500,-G(1)*y(1)-G(2)*y(2)-G(3)*y(3)-G(4)*y(4));

% cart acceleration
y_dot(2) = pendulum_equation2(t,y(1),y(2),y(3),y(4),y(5),u);

% change in theta position = theta velocity
y_dot(3) = y(4);

% change in theta velocity = theta acceleration
y_dot(4) = pendulum_equation4(t,y(1),y(2),y(3),y(4),y(5),u);

% cart control input
y_dot(5) = pendulum_equation5(t,y(1),y(2),y(3),y(4),y(5),u);
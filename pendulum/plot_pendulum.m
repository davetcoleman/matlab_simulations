function plot_pendulum(theta, length)

% start pendulum horizontal

x = [0, sin(theta) * length];
y = [0, cos(theta) * length];
bob_x = x(2);
bob_y = y(2);

% visualize
plot(x,y,'-',bob_x,bob_y,'o')
window_size = length*1.25;
axis([-window_size,window_size,-window_size,window_size])
axis('square')
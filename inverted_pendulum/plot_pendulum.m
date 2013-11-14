function plot_pendulum(theta, cart_x, length, time)

% cart properties
width = 0.1;
height = 0.05;

% start pendulum horizontal
x = [cart_x, cart_x+sin(theta) * length];
y = [0, cos(theta) * length];
bob_x = x(2);
bob_y = y(2);

% visualize
plot(x,y,'-',bob_x,bob_y,'o')
rectangle('Position',[cart_x-width/2,-height/2,width,height])

% format window
window_size = length*2;
axis([-window_size,window_size,-window_size,window_size])
axis('square')

% time stamp
text(window_size*0.7, -window_size*0.9, strcat('Sec: ',num2str(time)), 'Color', 'k');
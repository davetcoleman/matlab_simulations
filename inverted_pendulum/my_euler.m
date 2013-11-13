function varargout = my_euler(ode,tspan,y0,options,varargin)
% my custom euler method - simplest form of Runge-Kutta

time_step = 0.001;
t_start = tspan(1);
t_end = tspan(2);

t = [t_start:time_step:t_end]';
[rows, columns]=size(t);
y = zeros(rows,4); % a column vector

y(1,:) = y0';

for time_id = 2:1:rows
    y(time_id,:) = y(time_id-1,:) + time_step*ode(t(time_id),y(time_id-1,:))';
end

varargout{1} = t;
varargout{2} = y;

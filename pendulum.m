clc
clear
clf

figure(1)
figure(2)

% load equations from mupad and save to file
notebook_handle = mupad('my_pendulum_notebook.mn');
notebook_function = getVar(notebook_handle,'x2_dot');
matlabFunction(notebook_function,'file','pendulum_equation.m',...
    'vars',{'t','x1','x2'});
% wrap the mupad function to provide vector
pendulum_model = @(t,x) pendulum_equation(t,x(1),x(2)); 

% kinematic properties
g = 9.8; % gravity
m = 1; % mass, grams
l = 0.5; % radius, meters
k = 1.0; % coefficient of friction

% time
RUN_TIME = 5; % sec
RUN_SPEED = 1.5; % percent realtime, 1=100%

for method = 1:1:2
    
    % choose method type
    if method == 1
        integration_method = @my_euler;
        integration_name = 'euler';
    else
        integration_method = @my_runge_kutta;
        integration_name = 'runge-kutta4';
    end
    
    time_step = 1; % sec

    for i = 1:1:3 % number of tests to perform
        time_step = time_step / 10;
        fprintf('\nSimulation #%d, timestep =%f \n',i,time_step);

        %trajectory_result = [];
        trajectory_result = zeros(RUN_TIME/time_step,2);

        % state variables
        t = 0; % time in sec
        % x1 = position = theta  - radians
        % x2 = velocity = theta_dot   - radians/s
        x = [pi/2, 0]; 

        tic
        for time_id = 1:1:RUN_TIME/time_step

            % calculate new time
            t = t + time_step;

            % approximate the new velocity
            x(2) = integration_method(t,x,time_step,pendulum_model);

            % calculate new position
            x(1) = x(1) + time_step*x(2);

            % record the trajectory for later analysis
            trajectory_result(time_id,:) = [t, x(1)];

            %figure(1)
            %plot_pendulum(x(1)+pi,l);    
            %pause(time_step/RUN_SPEED);
        end
        toc
        figure(2)
        plot(trajectory_result(:,1),trajectory_result(:,2),...
            'DisplayName',sprintf('%s, %f, %f',integration_name, time_step,...
            trajectory_result(end,2)))

        if i==1
            legend('-DynamicLegend')
            hold all;
        end
    end
end

xlabel('Time')
ylabel('Theta')
title('Integration Step Size')
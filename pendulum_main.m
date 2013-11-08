clc
clear
clf

figure(1)
figure(2)
figure(3)

%% load model of system and experimental data

% load equations from mupad and save to file
notebook_handle = mupad('my_pendulum_notebook.mn');
notebook_function = getVar(notebook_handle,'x2_dot');
matlabFunction(notebook_function,'file','pendulum_equation.m',...
    'vars',{'t','x1','x2'});

% read our pendulum's actual data
experimental = analyze_experimental();
%pause(1)

%% plot the vector field diagram of the pendulum

% start state based on experiment
start_position = experimental(1,2) % pi/2
start_time = 0.21;
time_step = 0.1;

% state variables
% x1 = position = theta  - radians
% x2 = velocity = theta_dot   - radians/s
t=0;

figure(3)

x1_min = -10;
x1_max = 10;
x2_min = -10;
x2_max = 10;
axis([x1_min, x1_max, x2_min, x2_max])

for x1 = x1_min:1:x1_max
    for x2 = x2_min:1:x2_max
        x = [x1, x2];
        % approximate the new state variables
        x_new = 1.*my_euler(t,x,time_step,@pendulum_model);

        arrow(x,x_new,'Length',8)
        hold all
    end
end

xlabel('x_1')
ylabel('x_2')
title('Vector Field Representation')

return 

%% integrate the model with different timesteps and methods

% time
RUN_TIME = 60; % sec
RUN_SPEED = 1.5; % percent realtime, 1=100%

for method = 3:1:3
    
    % choose method type
    if method == 1
        integration_method = @my_euler;
        integration_name = 'euler';
    elseif method == 2
        integration_method = @my_runge_kutta;
        integration_name = 'runge-kutta4';
    elseif method == 3
        integration_method = @(t,y,h,f) ode45(f, [t, t+h], y);
        integration_name = 'ode45';
    elseif method == 4
        integration_method = @(t,y,h,f) ode113(f, [t, t+h], y);
        integration_name = 'ode113';
    elseif method == 5
        integration_method = @(t,y,h,f) ode15s(f, [t, t+h], y);
        integration_name = 'ode15s';
    end
    
    time_step = 0.01; % sec

    for i = 1:1:1 % number of tests to perform
        time_step = time_step / 10;
        fprintf('\nSimulation: %d, Method: %s, Timestep: %f \n',i,...
            integration_name, time_step);

        %trajectory_result = [];
        trajectory_result = zeros(RUN_TIME/time_step,2);

        % start state based on experiment
        start_position = experimental(1,2); % pi/2
        start_time = 0.21;
        
        % state variables
        t = start_time; % time in sec
        % x1 = position = theta  - radians
        % x2 = velocity = theta_dot   - radians/s
        x = [start_position, 0]; 

        tic
        for time_id = 1:1:RUN_TIME/time_step

            % calculate new time
            t = t + time_step;

            % approximate the new state variables
            x = my_euler(t,x,time_step,@pendulum_model);

            % record the trajectory for later analysis
            trajectory_result(time_id,:) = [t, x(1)];

            %figure(1)
            %plot_pendulum(x(1)+pi,l);    
            %pause(time_step/RUN_SPEED);
        end
        elapsed_time = toc
        
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

% plot the experimental data for RUN_TIME amount of time
cutoff = experimental(:,1) < RUN_TIME;
plot(experimental(cutoff,1),experimental(cutoff,2),...
    'DisplayName',sprintf('Experimental'))

xlabel('Time')
ylabel('Theta')
title('Simulating Pendulum With Various Integraters')
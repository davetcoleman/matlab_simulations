clc
clear
clf

%% pendulum properties
length = .295;

%% format figures
figure(1)


figure(2)
%figure(3)
hold off

%% load model of system and experimental data

% load equations from mupad and save to file
notebook_handle = mupad('my_pendulum_notebook.mn');
% x2_dot
notebook_function2 = getVar(notebook_handle,'x2_dot');
matlabFunction(notebook_function2,'file','pendulum_equation2.m',...
    'vars',{'t','x1','x2','x3','x4'});
% x3_dot
notebook_function4 = getVar(notebook_handle,'x4_dot');
matlabFunction(notebook_function4,'file','pendulum_equation4.m',...
    'vars',{'t','x1','x2','x3','x4'});

% read our pendulum's actual data
%experimental = analyze_experimental();

%% plot the vector field diagram of the pendulum

if 0
    % start state based on experiment
    start_position = experimental(1,2) % pi/2
    start_time = 0.21;
    time_step = 0.025;

    % state variables
    % x1 = position = theta  - radians
    % x2 = velocity = theta_dot   - radians/s
    t=0;

    figure(3)

    x1_min = -5;
    x1_max = 5;
    x2_min = -5;
    x2_max = 5;
    axis([x1_min, x1_max, x2_min, x2_max])


    for x1 = x1_min:0.5:x1_max
        for x2 = x2_min:0.5:x2_max
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
end

%% integrate the model with different timesteps and methods

% time
RUN_TIME = 5; % sec
RUN_SPEED = 1; % percent realtime, 1=100%

for method = 3:1:3
    
    % choose method type
    if method == 1
        integration_method = @my_euler;
        integration_name = 'euler';
    elseif method == 2
        integration_method = @my_runge_kutta;
        integration_name = 'runge-kutta4';
    elseif method == 3
        integration_method = @ode45;
        integration_name = 'ode45';
    elseif method == 4
        integration_method = @ode113;
        integration_name = 'ode113';
    elseif method == 5
        integration_method = @ode15s;
        integration_name = 'ode15s';
    end
    
    fprintf('\nSimulation: %d, Method: %s, Timestep: %s \n',i,...
        integration_name, '?');

    % start states
    start_position_cart = 0;
    start_position_pendulum = 0.01;
    start_time = 0; 

    % state variables
    % x1 = position of cart
    % x2 = velocity of cart
    % x3 = position of pendulum joint
    % x4 = velocity of pendulum joint
    y0 = [start_position_cart; 0; start_position_pendulum; 0]; 

    tic % start recording time

    % approximate the new state variables
    %x = integration_method(t,x,time_step,@pendulum_model);
    [t,y] = integration_method(@pendulum_model, [start_time, RUN_TIME], y0);
 
    %% animate pendulum
    if 1
        figure(1)
        [rows, columns]=size(t);
        for step_id=1:1:rows
            plot_pendulum(y(step_id,3),y(step_id,1),length);    
            pause(0.01);
        end
    end

    elapsed_time = toc

    figure(2)
    plot(t,y);
         %t(:,1),y(:,1),'DisplayName',sprintf('x'))

    if 1
        legend('-DynamicLegend')
        hold all;
    end
end

xlabel('Time')
ylabel('Theta')
legend('x','x\_dot','theta','theta\_dot');
title('Simulating Pendulum With Various Integraters')

%% plot the experimental data for RUN_TIME amount of time

if 0
    cutoff = experimental(:,1) < RUN_TIME;
    plot(experimental(cutoff,1),experimental(cutoff,2),...
        'DisplayName',sprintf('Experimental'))
end

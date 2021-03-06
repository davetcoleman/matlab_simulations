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
    'vars',{'t','x1','x2','x3','x4','x5','u'});
% x4_dot
notebook_function4 = getVar(notebook_handle,'x4_dot');
matlabFunction(notebook_function4,'file','pendulum_equation4.m',...
    'vars',{'t','x1','x2','x3','x4','x5','u'});
% x5_dot
notebook_function5 = getVar(notebook_handle,'x5_dot');
matlabFunction(notebook_function5,'file','pendulum_equation5.m',...
    'vars',{'t','x1','x2','x3','x4','x5','u'});
% 
notebook_functionA = getVar(notebook_handle,'Asolved');
matlabFunction(notebook_functionA,'file','pendulum_equation_A.m');
%
notebook_functionB = getVar(notebook_handle,'Bsolved');
matlabFunction(notebook_functionB,'file','pendulum_equation_B.m');

A = pendulum_equation_A;
B = pendulum_equation_B;

y1_weight = 100000;
y2_weight = 1;
y3_weight = 10;
y4_weight = 1;
Q = diag([y1_weight, y2_weight, y3_weight, y4_weight]);

global G
[X,L,G] = care(A,B,Q)
G = G*10;

pendulum_model2 = @(t,y) pendulum_model(t,y);
 
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
            x_new = 1.*my_euler(t,x,time_step,pendulum_model2);

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
RUN_TIME = 50; % sec
RUN_SPEED = 20; % percent realtime, 1=100%

method = 3;

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
start_position_pendulum = 0.1;
start_time = 0; 

% state variables
% x1 = position of cart
% x2 = velocity of cart
% x3 = position of pendulum joint
% x4 = velocity of pendulum joint
% x5 = pendulum joint integrator
y0 = [start_position_cart; 0; start_position_pendulum; 0; 0]; 

tic % start recording time

% approximate the new state variables
%x = integration_method(t,x,time_step,@pendulum_model);
[t,y] = integration_method(@pendulum_model, [start_time, RUN_TIME], y0);

elapsed_time = toc % stop recording

%% plot state vars
figure(2)

%u = min(10000*y(:,3)+100*y(:,4)+10*y(:,5),500)
K_P = 8000;
K_Px = 20;
u1 = -K_P*y(:,3);
u2 = -K_Px*y(:,2);
u = 0.01*min(u1+u2,500);

plot(t,y) %(:,[2,3]),t,0.01*[0.01*u1,u2])
legend('-DynamicLegend')
xlabel('Time')
ylabel('Theta')
legend('x','x\_dot','theta','theta\_dot','x\_integrator');
%legend('x\_dot','theta','u1','u2');
title('Simulating Pendulum With Various Integraters')

%% animate pendulum
if 1
    figure(1)
    [rows, columns]=size(t);
    for step_id=1:20:rows
        % todo make time steps even
        % http://www.mathworks.com/matlabcentral/newsreader/view_thread/312019
        plot_pendulum(y(step_id,3),y(step_id,1),length,t(step_id));    
        pause(t(step_id)/RUN_SPEED);
    end
end

%% plot the experimental data for RUN_TIME amount of time

if 0
    cutoff = experimental(:,1) < RUN_TIME;
    plot(experimental(cutoff,1),experimental(cutoff,2),...
        'DisplayName',sprintf('Experimental'))
end

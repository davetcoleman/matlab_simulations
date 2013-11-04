function result=analyze_experimental()
% read our pendulum's actual data
experimental = csvread('data/swing2.csv');

% the camera was tilted during recording
degree_adjust = -4.5;
tilt_offset_rad = degree_adjust / 180 * pi;
experimental(:,2) = experimental(:,2) - tilt_offset_rad;

% invert the angle's origin
experimental(:,2) = pi - experimental(:,2);

% cause left side of pendulum to be negative
experimental(:,2) = experimental(:,2) - (experimental(:,2)>(pi/2))*pi;

% add a third colum for degrees
experimental(:,3) = experimental(:,2) / pi * 180;

% remove bad data
cutoff_line = 58;
if 1
    for i=1:1:size(experimental,1)
        % only do for second half
        if experimental(i,1) > 26
            % check if over the bounds
            if experimental(i,3) > cutoff_line-experimental(i,1) || ...
                experimental(i,3) < -cutoff_line+experimental(i,1)
                experimental(i,2) = NaN;
            end
        end
    end
end

% re-add a third colum for degrees
experimental(:,3) = experimental(:,2) / pi * 180;


t=[1:1000];
plot(experimental(t,1),experimental(t,3), ...
     experimental(t,1), cutoff_line-experimental(t,1).*1, ...
     experimental(t,1), -cutoff_line+experimental(t,1).*1 )
%experimental(t,1), 100 + t.^2 )
     
result = experimental;

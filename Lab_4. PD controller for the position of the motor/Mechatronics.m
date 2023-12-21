Kw = 60/(317*2*pi); % V/(rad/s)
R = 0.299; % ohm
L = 0.0823/1000; % H
Kt = 30.2/1000; % Nm/A
J = 142/(1000*100*100); % Kg m ^2
B = 30.2*0.137*60/(1000*7580*2*pi);% Nm/rad/s
Kp = 1 % too high of a Kp can cause the system to become unstable or lead to overshoot.
Kd = 0.0006 % should not be higher
[data] = xlsread('Project_Temperature_data.xls');
time = data(:,1);
temp = data(:,2);
figure
plot(time,temp);

N     = 3;     % Order
Fpass = 0.05;  % Passband Frequency
Apass = 1;     % Passband Ripple (dB)
Fs    = 0.5;   % Sampling Frequency
h = fdesign.lowpass('n,fp,ap', N, Fpass, Apass, Fs);% design a lowpass filter with all these coefficients
Hd = design(h, 'cheby1', ...
    'SOSScaleNorm', 'Linf');
% Hd  coefficients of the filter and the gain values
% Hd = 
%         FilterStructure: [1x37 char]            
%             Arithmetic: 'double'               
%               sosMatrix: [2x6 double]           
%             ScaleValues: [0.145707496327704;1;1]
%     OptimizeScaleVal ues: true                   
%        PersistentMemory: false
sosMatrix = Hd.sosMatrix; % sub part of the matrix
gain = Hd.ScaleValues; % scale values

temp1 = temp; % temperature data
offset = temp1(1); % offset id the first value of temperature data 25.26 degree
%offset = mean(temp1)
temp1 = temp1-offset; % subtract the offset everywhere and that is the data I filtered out
y = prod(gain)*sosfilt(sosMatrix, temp1); % y is the output
figure;
plot(time,temp,time,y+offset,'r--')% add the offset back in to make it better
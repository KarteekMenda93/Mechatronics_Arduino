[data] = xlsread('Temp_data.xlsx');
time = data(:,1);
temp = data(:,2);
figure
plot(time,temp);

N     = 3;     % Order
Fpass = 0.05;  % Passband Frequency
Apass = 1;     % Passband Ripple (dB)
Fs    = 0.5;   % Sampling Frequency
h = fdesign.lowpass('n,fp,ap', N, Fpass, Apass, Fs);
Hd = design(h, 'cheby1', ...
    'SOSScaleNorm', 'Linf');
% Hd
% Hd = 
%         FilterStructure: [1x37 char]            
%             Arithmetic: 'double'               
%               sosMatrix: [2x6 double]           
%             ScaleValues: [0.145707496327704;1;1]
%     OptimizeScaleValues: true                   
%        PersistentMemory: false
sosMatrix = Hd.sosMatrix;
gain = Hd.ScaleValues;

temp1 = temp;
offset = temp1(1);
temp1 = temp1-offset;
y = prod(gain)*sosfilt(sosMatrix, temp1);
figure;
plot(time,temp,time,y+offset,'r--')
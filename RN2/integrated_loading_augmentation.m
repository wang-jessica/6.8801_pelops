
%% section 1: load all csv files in the selected folder
clear all; % Clear workspace
clc;       % Clear command window 

%folder = uigetdir; %Get to the directory of the folder containing the file
[originalfileName, folder] = uigetfile("*.csv",'Select CSV Files', 'MultiSelect','on');
if folder == 0
    error('Error no folder selected');
end 

fileList = dir(fullfile(folder,'*.csv')); %Access all the files in the folder
csvList = cell(1,length(fileList)); % list of strings to load each csv for augmentation


for n = 1:length(fileList)
    %Construct the full file path 
    fileName = fullfile(fileList(n).folder, fileList(n).name);
    csvList{n} = fileList(n).name;
    %Read the csv file 
    T = readtable(fileName);
    %Extract first and seventh column 
    I  = T(3:end,1);
    %VI = T(3:end,7);
    %Convert tables to two columns 
    %I_VI = [I VI];
    I = [I];
    %Construct the new filename for the MAT file
    newFileName = fullfile(fileList(n).folder, [fileList(n).name(1:end-4), '_ECG.mat']);
    % Save the variables to a MAT file
    % save(newFileName, 'I_VI');
    save(newFileName, 'I');
end
disp(['Sucess!' , num2str(length(fileList)),'files have been converted to .mat']);

%% Section 2: for each csv file, perform 3 different augmentations
% store the results in a new 4-column csv file 
% column 1: original signal
% column 2: augmentation combo 1
% column 3: augmentation combo 2
% column 4: augmentation combo 3

for n = 1:length(csvList)
    disp(int2str(n))
    ECG = readmatrix(csvList{n});
    ECG(1:2,:) = [];
    lead_1 = ECG(:,1);
    output(:,1) = lead_1;
    for k=1:3
        aug = randi(6);
        augmented = lead_1;
        if aug==1
            augmented = gaussian_augmentation(augmented);
            augmented = baseline_wander_augmentation(augmented);
        elseif aug==2
            augmented = gaussian_augmentation(augmented);
            augmented = butterworth_filter_augmentation(augmented);
        elseif aug==3
            augmented = gaussian_augmentation(augmented);
            augmented = dropout_augmentation(augmented);
        elseif aug==4
            augmented = gaussian_augmentation(augmented);
            augmented = line_noise_augmentation(augmented);
        elseif aug==5
            augmented = baseline_wander_augmentation(augmented);
            augmented = butterworth_filter_augmentation(augmented);
        elseif aug==6
            augmented = baseline_wander_augmentation(augmented);
            augmented = dropout_augmentation(augmented);
        elseif aug==7
            augmented = baseline_wander_augmentation(augmented);
            augmented = line_noise_augmentation(augmented);
        elseif aug==8
            augmented = butterworth_filter_augmentation(augmented);
            augmented = dropout_augmentation(augmented);
        elseif aug==9
            augmented = butterworth_filter_augmentation(augmented);
            augmented = line_noise_augmentation(augmented);
        elseif aug==10
            augmented = dropout_augmentation(augmented);
            augmented = line_noise_augmentation(augmented);
        end
       output(:,k+1) = augmented;
    end
    
    % Save "output" array as a MAT file
    newFileName = fullfile(fileList(n).folder, [fileList(n).name(1:end-4), '_augmented.mat']);
    save(newFileName, 'output');
    % save "output" array as a csv file
    writematrix(output,[newFileName,'.csv']);
end


%%
%Fs=500;
%t=0:1/Fs:10;
%t=t(1:end-1);
%t = t(1:length(lead_1));

figure
subplot(4,1,1)
plot(normal)
title('Raw WPW ECG - Lead I')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4,1,2)
plot(aug1)
title('Augmentation #1')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4,1,3)
plot(aug2)
title('Augmentation #2')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4,1,4)
plot(aug3)
title('Augmentation #3')
xlabel('Time (s)')
ylabel('Amplitude')

%%

function [noisy_sig] = gaussian_augmentation(input_lead)
%Gaussian Data Augmentation sub-function
%Adds white gaussian noise of random dB (from 15-30) to input lead
noise_dB=randi([15,30]);
noisy_sig = awgn(input_lead,noise_dB,'measured');
end


function [dropout_sig] = dropout_augmentation(input_sig)
%dropout augmentation sub-function
%randomly chooses 5% (from literature) of data points to drop-out
%disp('numel(input_sig)')

idx = randperm(numel(input_sig),round(numel(input_sig)*5/100)) ; 
dropout_sig = input_sig;
dropout_sig(idx)=0;
end


function [wander_sig] = baseline_wander_augmentation(input_sig)
%Baseline wander augmentation sub-function
%Adds three sine function (with random phase, frequency, and amplitude) to
%signal to generate simulated baseline wander
maxi = max(abs(input_sig));
for k=1:3
    rand_sin_freq(k) = 0.05 + (0.5-0.05).*rand(1);
    rand_phase(k) = 0 + 2*pi.*rand(1);
    rand_sin_scale(k) = 0.05 + (0.20-0.05) .* rand(1);
end
Fs=500;
t=0:1/Fs:10;
%t=t(1:end-1);
t = t(1:length(input_sig));
rand_sin = (maxi*rand_sin_scale(1)*sin(2*pi*rand_sin_freq(1)*t + rand_phase(1)) + ...
    maxi*rand_sin_scale(2)*sin(2*pi*rand_sin_freq(2)*t + rand_phase(2)) + ...
    maxi*rand_sin_scale(3)*sin(2*pi*rand_sin_freq(3)*t + rand_phase(3)))';
%disp(size(input_sig))
%disp(size(rand_sin))
wander_sig =  + input_sig + rand_sin;
end


function [butterworth_sig] = butterworth_filter_augmentation(input_sig)
%Butterworth filter augmentation sub-function
%applies 5th order butterworth filter with LP = 0.5 Hz and HP = 50 Hz
%(standard in literature) 
Fs = 500; 
f_low = 0.5;
f_high = 50;
[b,a] = butter(5,[f_low,f_high]/(Fs/2),'bandpass');
butterworth_sig = filtfilt(b,a,input_sig);
end


function [linenoise_sig] = line_noise_augmentation(input_sig)
%line noise augmentation sub-function
%adds a 60 Hz (in literature) sine wave with random phase and amplitude to
%input signal
freq_ln = 60;
rand_amp = 0.05+(0.1-0.05)*rand(1);
rand_phase = 0 + 2*pi*rand(1);
amp_sin = max(input_sig)*rand_amp;
Fs=500;
t=0:1/Fs:10;
%t=t(1:end-1);
t = t(1:length(input_sig));
linenoise_sig = input_sig + (amp_sin*sin(2*pi*freq_ln*t + rand_phase))';
end







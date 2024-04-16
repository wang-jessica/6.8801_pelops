ECG = readmatrix('5b091d749f7c63201.xlsx.csv');
ECG(1:2,:) = [];
lead_1 = ECG(:,1);

for n=1:3
if n==1
    noisy_sig = gaussian_augmentation(lead_1);
    output(:,1) = baseline_wander_augmentation(noisy_sig);
elseif n==2
    butterworth_sig = butterworth_filter_augmentation(lead_1);
    output(:,2) = line_noise_augmentation(butterworth_sig);
elseif n==3
    dropout_sig = dropout_augmentation(lead_1);
    output(:,3) = baseline_wander_augmentation(dropout_sig);
end
end

Fs=500;
t=0:1/Fs:10;
t=t(1:end-1);

subplot(4,1,1)
plot(t,lead_1)
title('Raw WPW ECG - Lead I')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4,1,2)
plot(t,output(:,1))
title('Augmentation #1 - Gaussian Noise + Baseline Wander')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4,1,3)
plot(t,output(:,2))
title('Augmentation #2 - Butterworth Filtering + Line Noise')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(4,1,4)
plot(t,output(:,3))
title('Augmentation #3 - Dropout + Baseline Wander')
xlabel('Time (s)')
ylabel('Amplitude')





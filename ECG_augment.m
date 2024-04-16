ECG = readmatrix('5b091d749f7c63201.xlsx.csv');
Fs = 500; 
f_low = 0.5;
f_high = 40;
[b,a] = butter(5,[f_low,f_high]/(Fs/2),'bandpass');
ECG(1:2,:)=[];


for i=1:12
    lead(:,i) = ECG(:,i);
    lead_filtered(:,i) = filtfilt(b,a,lead(:,i));
end

for n=1:12
    lead_filtered(:,i) = filtfilt(b,a,lead(:,i));
    

end
noise_dB=randi([0,40]);
noisy_sig = awgn(lead(:,2),noise_dB,'measured');

plot(lead(:,2))

hold on
plot(noisy_sig)
legend('Normal','Gaussian Noise')
ECG = readmatrix('5b091d749f7c63201.xlsx.csv');
Fs = 500; 
f_low = 0.5;
f_high = 40;
[b,a] = butter(5,[f_low,f_high]/(Fs/2),'bandpass');
ECG(1:2,:)=[];
I = ECG(:,1);
II = ECG(:,2);
III = ECG(:,3);
aVR = ECG(:,4);
aVL = ECG(:,5);
aVF = ECG(:,6);
V1 = ECG(:,7);
V2 = ECG(:,8);
V3 = ECG(:,9);
V4 = ECG(:,10);
V5 = ECG(:,11);
V6 = ECG(:,12);
for i=1:12
    lead(:,i) = ECG(:,i);
    lead_filtered(:,i) = filtfilt(b,a,lead(:,i));
end

t= 0:1/Fs:10;
t=t(1:end-1);
subplot(3,4,1)
plot(t,lead(:,1))
hold on
plot(t,lead_filtered(:,1))
title('Lead I WPW ECG')
legend('Filtered', 'Unfiltered')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,4,2)
plot(t,lead(:,2))
hold on
plot(t,lead_filtered(:,2))
title('Lead II WPW ECG')
legend('Unfiltered','Filtered')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,4,3)
plot(t,lead(:,3))
hold on
plot(t,lead_filtered(:,3))
title('Lead III WPW ECG')
legend('Unfiltered','Filtered')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,4,4)
plot(t,lead_filtered(:,4))
hold on
plot(t,lead(:,4))
title('Lead aVR WPW ECG')
legend('Unfiltered','Filtered')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,4,5)
plot(t,lead(:,5))
hold on
plot(t,lead_filtered(:,5))
title('Lead aVL WPW ECG')
legend('Unfiltered','Filtered')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,4,6)
plot(t,lead(:,1))
hold on
plot(t,lead_filtered(:,6))
title('Lead aVF WPW ECG')
legend('Unfiltered','Filtered')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,4,7)
plot(t,lead(:,7))
hold on
plot(t,lead_filtered(:,7))
title('Lead V1 WPW ECG')
legend('Unfiltered','Filtered')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,4,8)
plot(t,lead(:,8))
hold on
plot(t,lead_filtered(:,8))
title('Lead V2 WPW ECG')
legend('Unfiltered','Filtered')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,4,9)
plot(t,lead(:,9))
hold on
plot(t,lead_filtered(:,9))
title('Lead V3 WPW ECG')
legend('Unfiltered','Filtered')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,4,10)
plot(t,lead(:,10))
hold on
plot(t,lead_filtered(:,10))
title('Lead V4 WPW ECG')
legend('Unfiltered','Filtered')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,4,11)
plot(t,lead(:,11))
hold on
plot(t,lead_filtered(:,11))
title('Lead V5 WPW ECG')
legend('Unfiltered','Filtered')
xlabel('Time (s)')
ylabel('Amplitude')

subplot(3,4,12)
plot(t,lead(:,12))
hold on
plot(t,lead_filtered(:,12))
title('Lead V6 WPW ECG')
legend('Unfiltered','Filtered')
xlabel('Time (s)')
ylabel('Amplitude')

 


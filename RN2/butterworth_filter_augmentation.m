%Butterworth filter augmentation sub-function
%applies 5th order butterworth filter with LP = 0.5 Hz and HP = 50 Hz
%(standard in literature) 

function [butterworth_sig] = butterworth_filter_augmentation(input_sig)
Fs = 500; 
f_low = 0.5;
f_high = 50;
[b,a] = butter(5,[f_low,f_high]/(Fs/2),'bandpass');
butterworth_sig = filtfilt(b,a,input_sig);
end
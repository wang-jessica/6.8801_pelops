%line noise augmentation sub-function
%adds a 60 Hz (in literature) sine wave with random phase and amplitude to
%input signal

function [linenoise_sig] = line_noise_augmentation(input_sig)
freq_ln = 60;
rand_amp = 0.05+(0.1-0.05)*rand(1);
rand_phase = 0 + 2*pi*rand(1);
amp_sin = max(input_sig)*rand_amp;
Fs=500;
t=0:1/Fs:10;
t=t(1:end-1);
linenoise_sig = input_sig + (amp_sin*sin(2*pi*freq_ln*t + rand_phase))';
end

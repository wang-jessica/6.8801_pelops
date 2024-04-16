%Baseline wander augmentation sub-function
%Adds three sine function (with random phase, frequency, and amplitude) to
%signal to generate simulated baseline wander

function [wander_sig] = baseline_wander_augmentation(input_sig)
maxi = max(abs(input_sig));
for k=1:3
rand_sin_freq(k) = 0.05 + (0.5-0.05).*rand(1);
rand_phase(k) = 0 + 2*pi.*rand(1);
rand_sin_scale(k) = 0.05 + (0.20-0.05) .* rand(1);
end
Fs=500;
t=0:1/Fs:10;
t=t(1:end-1);
rand_sin = (maxi*rand_sin_scale(1)*sin(2*pi*rand_sin_freq(1)*t + rand_phase(1)) + ...
    maxi*rand_sin_scale(2)*sin(2*pi*rand_sin_freq(2)*t + rand_phase(2)) + ...
    maxi*rand_sin_scale(3)*sin(2*pi*rand_sin_freq(3)*t + rand_phase(3)))';
wander_sig =  + input_sig + rand_sin;
end
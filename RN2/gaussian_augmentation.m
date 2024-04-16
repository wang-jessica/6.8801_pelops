%Gaussian Data Augmentation sub-function
%Adds white gaussian noise of random dB (from 15-30) to input lead


function [noisy_sig] = gaussian_augmentation(input_lead)
noise_dB=randi([15,30]);
noisy_sig = awgn(input_lead,noise_dB,'measured');
end
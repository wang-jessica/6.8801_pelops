%dropout augmentation sub-function
%randomly chooses 5% (from literature) of data points to drop-out

function [dropout_sig] = dropout_augmentation(input_sig)
idx = randperm(numel(input_sig),round(numel(input_sig))*5/100) ; 
dropout_sig = input_sig;
dropout_sig(idx)=0;
end

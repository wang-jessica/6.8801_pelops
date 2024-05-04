wpwdir = 'C:\Users\FreqMux\Documents\MATLAB\Shreyas\PhD\Homework\6.8800\Augmented_WPW_PTB-XL';
normaldir = 'C:\Users\FreqMux\Documents\MATLAB\Shreyas\PhD\Homework\6.8800\Augmented_Normal_PTB-XL';

wpwfiles = dir(wpwdir);
normalfiles = dir(normaldir);
imgsize = [224 224];

masterdir = 'C:\Users\FreqMux\Documents\MATLAB\Shreyas\PhD\Homework\6.8800\Training Data';
wdir = 'WPW';
ndir = 'Normal';

for i = 1:numel(wpwfiles)
    if ~strcmp(wpwfiles(i).name, '.') && ~strcmp(wpwfiles(i).name, '..')
        if wpwfiles(i).isdir
            disp(['Directory: ' wpwfiles(i).name]);
        else
            disp(['File: ' wpwfiles(i).name])
            ecgs = csvread(wpwfiles(i).name);
            for ii = 1:size(ecgs,2)
                ecg = ecgs(:,ii);
                wt = imresize(abs(cwt(ecg, 500)), imgsize);
                im = ind2rgb(round(rescale(wt,0,255)),jet(128));
                imfilename = "WPW"+ "_" + num2str(i) + "_" + num2str(ii) + ".jpg";
                imwrite(im, fullfile(masterdir, wdir, imfilename));
            end
        end
    end
end

for i = 1:numel(normalfiles)
    if ~strcmp(normalfiles(i).name, '.') && ~strcmp(normalfiles(i).name, '..')
        if normalfiles(i).isdir
            disp(['Directory: ' normalfiles(i).name]);
        else
            disp(['File: ' normalfiles(i).name])
            ecgs = csvread(normalfiles(i).name);
            for ii = 1:size(ecgs,2)
                ecg = ecgs(:,ii);
                wt = imresize(abs(cwt(ecg, 500)), imgsize);
                im = ind2rgb(round(rescale(wt,0,255)),jet(128));
                imfilename = "Normal"+ "_" + num2str(i) + "_" + num2str(ii) + ".jpg";
                imwrite(im, fullfile(masterdir, ndir, imfilename));
            end
        end
    end
end
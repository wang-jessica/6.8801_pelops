%Script to process all .csv files in a folder

clear all; % Clear workspace
clc;       % Clear command window 

%folder = uigetdir; %Get to the directory of the folder containing the file

[originalfileName, folder] = uigetfile("*.csv",'Select CSV Files', 'MultiSelect','on');

if folder == 0
    error('Error no folder selected');
end 

fileList = dir(fullfile(folder,'*.csv')); %Access all the files in the folder 


for n = 1:length(fileList)
    %Construct the full file path 
    fileName = fullfile(fileList(n).folder, fileList(n).name);

    %Read the csv file 
    T = readtable(fileName);

    %Extract first and seventh column 
    I  = T(3:end,1);
    VI = T(3:end,7);

    %Convert tables to two columns 
    I_VI = [I VI];

    % Construct the new filename for the MAT file
    newFileName = fullfile(fileList(n).folder, [fileList(n).name(1:end-4), '_ECG.mat']);
    
    % Save the variables to a MAT file
    save(newFileName, 'I_VI');
end

disp(['Sucess!' , num2str(length(fileList)),'files have been converted to .mat']);

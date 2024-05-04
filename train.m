parentDir = 'C:\Users\FreqMux\Documents\MATLAB\Shreyas\PhD\Homework\6.8800';
dataDir = 'Training Data';

allImages = imageDatastore(fullfile(parentDir,dataDir), ...
    "IncludeSubfolders",true, ...
    "LabelSource","foldernames");
[imgsTrain,imgsValidation] = splitEachLabel(allImages,0.8,"randomized");
disp("Number of training images: "+num2str(numel(imgsTrain.Files)))
disp("Number of validation images: "+num2str(numel(imgsValidation.Files)))

net = dag2dlnetwork(googlenet);

net.Layers(1)
net.Layers(end-3:end)
% newDropoutLayer = dropoutLayer(0.6,"Name","new_Dropout");
% net = replaceLayer(net,"pool5-drop_7x7_s1",newDropoutLayer);
numClasses = numel(categories(imgsTrain.Labels));
newConnectedLayer = fullyConnectedLayer(numClasses,"Name","new_fc", ...
    "WeightLearnRateFactor",5,"BiasLearnRateFactor",5);
% net = replaceLayer(net,'loss3-classifier',newConnectedLayer);

net.Layers(end-3:end)
options = trainingOptions("sgdm", ...
    MiniBatchSize=8, ...
    MaxEpochs=20, ...
    InitialLearnRate=1e-4, ...
    ValidationData=imgsValidation, ...
    ValidationFrequency=10, ...
    Verbose=true, ...
    Plots="training-progress", ...
    Metrics="accuracy");

trainedGN = trainnet(imgsTrain,net,"crossentropy",options);
classNames = categories(imgsTrain.Labels);
scores = minibatchpredict(trainedGN,imgsValidation);
YPred = scores2label(scores,classNames);
accuracy = mean(YPred==imgsValidation.Labels);
disp("GoogLeNet Accuracy: "+num2str(100*accuracy)+"%")
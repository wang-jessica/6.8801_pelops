trainDir = 'C:\Users\FreqMux\Documents\MATLAB\Shreyas\PhD\Homework\6.8800\NewExperiments\Task1_WPWvsNormal\Training';
valDir = 'C:\Users\FreqMux\Documents\MATLAB\Shreyas\PhD\Homework\6.8800\NewExperiments\Task1_WPWvsNormal\Validation';
testDir = 'C:\Users\FreqMux\Documents\MATLAB\Shreyas\PhD\Homework\6.8800\NewExperiments\Task1_WPWvsNormal\Testing';

trainImages = imageDatastore(trainDir, "IncludeSubfolders",true, ...
    "LabelSource","foldernames");
valImages = imageDatastore(valDir, "IncludeSubfolders",true, ...
    "LabelSource","foldernames");
testImages = imageDatastore(testDir, "IncludeSubfolders",true, ...
    "LabelSource","foldernames");

disp("Number of training images: "+num2str(numel(trainImages.Files)))
disp("Number of validation images: "+num2str(numel(valImages.Files)))
disp("Number of test images: "+num2str(numel(testImages.Files)))

net = dag2dlnetwork(resnet18);
net.Layers(end-3:end)

% replace global average pooling with dropout to help regularization 
% change fully connected layer to have 2 output classes

newDropoutLayer = dropoutLayer(0.6,"Name","new_Dropout");
net = replaceLayer(net,"pool5",newDropoutLayer);

numClasses = numel(categories(trainImages.Labels));
newConnectedLayer = fullyConnectedLayer(numClasses,"Name","new_fc", ...
    "WeightLearnRateFactor",5,"BiasLearnRateFactor",5);
net = replaceLayer(net,'fc1000',newConnectedLayer);

net.Layers(end-3:end)

% use custom loss function -- weighted cross entropy
table = countEachLabel(trainImages);

classWeights = dlarray([table{2,2} table{1,2}]);
weightedCrossEntropy = @(Y, T) WCE(Y,T, classWeights);

% training parameters
options = trainingOptions("adam", ...
    MiniBatchSize=32, ...
    MaxEpochs=5, ...
    InitialLearnRate=1e-4, ...
    Shuffle='every-epoch', ...
    ValidationData=valImages, ...
    ValidationFrequency=10, ...
    Verbose=true, ...
    Plots="training-progress", ...
    Metrics="accuracy");

trainedGN = trainnet(trainImages,net,weightedCrossEntropy,options);
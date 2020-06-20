format compact
% creating input and output variable
input0 = [0 1 1 1 1 0 1 0 0 0 0 1 1 0 0 0 0 1 1 0 0 0 0 1 0 1 1 1 1 0]';
input1 = [0 0 0 0 0 0 1 0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0]';
input2 = [1 0 0 0 0 0 1 0 0 1 1 1 1 0 0 1 0 1 0 1 1 0 0 1 0 0 0 0 0 1]';
target0 = [1 0 0]';
target1 = [0 1 0]';
target2 = [0 0 1]';
% set up input and output
input = [input0 input1 input2];
target = [target0 target1 target2];
NEURON = 20;
learningRate = 0.45;
% create randome hidden layer weight and bias
[hiddenWe, hiddenBi, outputWe, outputBi, learningR] = initialize(input, target, NEURON, learningRate);
% initialize the variable
hiddenWeight = hiddenWe;
hiddenBias = hiddenBi;
outputWeight = outputWe;
outputBias = outputBi;
learningRate = learningR;

% ===========Start========================   
dispGraph = 1;

[outputW, outputB, hiddenW, hiddenB] = training(input, target, hiddenWeight, hiddenBias, outputWeight, outputBias, learningRate, dispGraph);
myHiddenW = hiddenW;
myHiddenB = hiddenB;
myOutputW = outputW;
myOutputB = outputB;
predictedValue = predict(input, hiddenW, hiddenB, outputW, outputB);
% display the weight using the fig
figure()
imagesc(myOutputW);
colormap(hsv);
colorbar;

figure()
imagesc(myHiddenW);
colormap(hsv);
colorbar;
% end of display weight

% =======Calling function for Changing pixel ===============
graph = [0 0 0];

for j = 1:3
    graph(j) = doCalculateWithWeight(input, ((j-1)*4), myHiddenW, myHiddenB, myOutputW, myOutputB, target);
end

figure()
xAxis = [0,4,8];
pixels0 = plot(xAxis, graph());
title('Part1: Percentage of Correctness due to Chaning Pixel')
xlabel('Number of pixels'), ylabel('Percent Correct(%)'), M1 = "3 Digits";
hold on
legend([pixels0;], [M1]);
grid on, axis([0 8 0 100]);

% ============End=========================
function count = doCalculateWithWeight(inputPx, numberOfPixelChange, myHiddenW, myHiddenB, myOutputW, myOutputB, target)
    [row, col] = size(inputPx);
    tempPxho = [];
    totalCorrect = 0;
    for i = 1:10
       for k = 1:col
           eachDigit = inputPx(:,k,:);
           length(eachDigit);
           % fprintf("Changing Now\n")
           tempPxho(:,k,:) = addNoise(eachDigit, numberOfPixelChange);
       end 
        % axion1, p0 == a0
        axion1 = tempPxho;
        % axion2 
        hiddenN2 = myHiddenW * axion1 + myHiddenB;
        hiddenAxion2 = logsig(hiddenN2);
        % axion3
        outputN3 = myOutputW * hiddenAxion2 + myOutputB;
        outputAxion3 = logsig(outputN3);
        %  ================ Error guy ===================
        tempError = 0;
        [aM,aI] = max(outputAxion3);
        [tM,tI] = max(target);
        if tI == aI
           totalCorrect = totalCorrect + 1; 
        end
        tempPxho = inputPx;
    % End of Error uy
    end
    totalCorrect = totalCorrect / 10;
   
    count = totalCorrect*100;
    
end
% =============Function Call==============
% ==============Adding Noise to input ==========================
% ===========Add Noise Function==============
function pvec = addNoise(pvec, num)
    % ADDNOISE Add noise to "binary" vector
    %   pvec pattern vector (-1 and 1)
    %   num  number of elements to flip randomly
    % Handle special case where there's no noise
    if num == 0    
        return;
    end
    % first, generate a random permutation of all indices into pvec
    inds = randperm(length(pvec));
    % then, use the first n elements to flip 
    pvec(inds(1:num)) = -pvec(inds(1:num));
end
% ==============End of Noise to input=========

% ================= End of Testing Chagning =====================
function [hiddenWeight, hiddenBias, outputWeight, outputBias, learningRate] = initialize(input, target, neuron, learningR)
    inputSize = length(input);
    targetSize = length(target);
    % initalize hidden layer Weight and Bias
    hiddenWeight = randn(neuron, inputSize);
    hiddenBias = rand(neuron, 1);
    % initialize output layer Weight and Bias
    outputWeight = randn(targetSize, neuron);
    outputBias = rand(targetSize, 1);
    learningRate = learningR;
end

function [axion1, axion2, axion3, totalError] = feedforward(input, target, hiddenW, hiddenB, outputW, outputB)
    % to prevent log go to infinte
    % input p0 == a0
    % I just decided to n1 == p0
    n1 = input;
    axion1 = input;
    % hidden layer
    n2 = (hiddenW * axion1) + hiddenB;
    axion2 = logsig(n2);
    % output layer
    n3 = (outputW * axion2) + outputB;
    axion3 = logsig(n3);
    totalError = target - axion3;
end

function [outputW, outputB, hiddenW, hiddenB] = training(input, target, hiddenW, hiddenB, outputW, outputB, learningRate, dispGraph)
    myInput = input;
    
    % my testing for normalize the input and output
    target1 = [0.99 0.01 0.01]';
    target2 = [0.01 0.99 0.01]';
    target3 = [0.01 0.01 0.99]';
    myTarget = [target1, target2, target3];
    
    % end of my testing
    
    myLearningRate = learningRate;
    % putting errors to Error Vector
    epoch = 900;
    disp("ErrorSize")
    ErrorVector = zeros(1,epoch);
    if dispGraph == 1
        figure()
    end
    [row, col] = size(target)
    % ===========EPOCH ===============
    for j = 1:epoch
        tempError = 0;
        for i = 1:col
            % normalize the input data
            myTestInput = ((input(:,i) / 1.0) * 0.99) + 0.01;
            [axion1, axion2, axion3, totalError] = feedforward(input(:,i), myTarget(:,i), hiddenW, hiddenB, outputW, outputB);
            
            loss3 = (axion3 - myTarget(:,i)) .* axion3 .* (1 - axion3);
            outputW = outputW - learningRate * (loss3 * axion2');
            outputB = outputB - learningRate * loss3;
            loss2 = (outputW' * loss3) .* axion2 .* (1 - axion2);
            hiddenW = hiddenW - learningRate * (axion1' .* loss2);
            hiddenB = hiddenB - learningRate * loss2;
         
            tempError = tempError + totalError' * totalError;    
        end
        tempError = tempError / (col*col);
        ErrorVector(j) = tempError;
        if dispGraph == 1 
                plot(ErrorVector(1:j));
                ylim([0,1]);
                drawnow();
                title('Part1: Training Accuracy')
                xlabel(["\bf Epoch"])
                ylabel(["\bf Percent Error (Mean Value) %"])
         end
    end
end

% ========== predict function ========================
% ========== use w and b that is corrected by training
function predicted_num = predict(inputData, hiddenW, hiddenB, outputW, outputB)
    predictN2 = hiddenW * inputData + hiddenB;
    predictAxion2 = logsig(predictN2);
    predictN3 = outputW * predictAxion2 + outputB;
    disp("predict")
    predictAxion3 = logsig(predictN3);
    predictedValue = [];
    [row, col] = size(predictAxion3);
    predicted_num = predictAxion3
end

% ==========Accuracy=======================
function count = accuracy(axion3 ,targetOuput)
     [aM,aI] = max(axion3);
     [tM,tI] = max(targetOuput);
      count = tI == aI;
end

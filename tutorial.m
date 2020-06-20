format compact

%myInput = 3.0;
%fprintf("My Output: %d\n", a(myInput))

% NND transfer function, hardlim(n)
%function n = a(input_)
%    weight = 1;
%    bias = -3;
%    n_value = (weight * input_) + bias;
%    fprintf("My Input: %d\n", input_)
%    n = func(n_value);   
%end

myInput = [1 2 3];
myWeight = [-2 0 5];
myBias = 14;
neuron(myInput, myWeight, myBias);
neuronTranspose(myInput, myWeight, myBias);
% test data
sprintf("OR   AND")
inputV1 = [0 0]
weightM = [1 1; 1 1];
biasV = [-1 -2];
% end of test data
%layer(inputV1, weightM, biasV)
%layerMathlabOperation(inputV1, weightM, biasV);
% testing data for banana and pineapple
bananaP1 = [-1 1 -1]
pineappleP2 = [-1 -1 1]
decisionWeight = [0 0 1]
bias = 0
layerMathlabOperation(pineappleP2, decisionWeight, bias)
%layerMathlabOperation(bananaP1, decisionWeight, bias)
% end of testing 
function transferFunc = func(n_value)
        transferFunc = hardlim(n_value);
end 

% modifiy the function
% i am going to transpose input_ 
% inner product using loop
function result_a = neuron(input_, weight_, bias_)
    % if the lenght of input and weight is different
    % in vector inner product, it is not possible to get scalar
    if (length(input_) ~= length(weight_))
        disp("Number of Element should be same to conduct" + ... 
            " inner product" + ...
            " exiting the Function")
        return
    end
    productResult = 0;
    for i = 1:length(input_)
        productResult = productResult + (input_(i) * weight_(i));
    end
    % Add bias to productResult to get summation
    summation = productResult + bias_;
    result_a = func(summation);
end

function result_a2 = neuronTranspose(input_, weight_, bias_)
    % if the length of input and weight is differnt
    % in vector inner product, it is not possible to get scalar
    if (length(input_) ~= length(weight_))
        disp("Number of Element should be same to conduct" + ...
            " inner product" + ...
            " exiting the Function")
        return
    end
    summation = (weight_ * input_') + bias_;
    result_a2 = func(summation);
end

% single layer
% input vector, weight matrix, bias vector
% return single value (a vector of a neuron output)
function summation = layer(inputV_, weightM_, biasV_ )
    [weightRows, weightCols] = size(weightM_);
    [inputRows, inputCols] = size(inputV_);
    transposeBias = biasV_';
    % create a variable that hold summation value
    % size will be weightRows, inputRows
    result = zeros(weightRows, inputRows);
    for i = 1:weightRows
        for j = 1:weightCols
            result(i) = (result(i) + (weightM_(i,j) * inputV_(j)));
        end
        result(i) = result(i) + transposeBias(i);
    end
    % convert column vector into row vector
    summation = func(result');
end

function summation = layerMathlabOperation(inputV_, weightM_, biasV_)
    n = weightM_ * inputV_' + biasV_';
    % use ' to convert to vector looks better
    summation = changedFunc(n);
end



% this function is modified version of hardlims
% instead hardlims return 1 if x >= 0, display pineapple
% instead hardlims return -1 if x < 0, display banana
function transferFunction = changedFunc(n_value)
    if n_value >= 0
        transferFunction = "Pineapple";
    else 
        transferFunction = "Banana";
    end
end

        



    

    
    
        
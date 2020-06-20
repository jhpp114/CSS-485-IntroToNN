format compact

p1 = [1; 4];
p2 = [1; 5];
p3 = [2; 4];
p4 = [2 ; 5];
p5 = [3; 1];
p6 = [3; 2];
p7 = [4; 1];
p8 = [4; 2];
inputs = [p1 p2 p3 p4 p5 p6 p7 p8];
targets = [0 0 0 0 1 1 1 1];

% Before Trained
weight = [0 0];
bias = 0;
% Trained ouptut for weight and bias
[weight, bias] = perceptronTraining(inputs, targets, weight, bias)

% 4.11.ii
for i = 1:length(inputs)
    target = hardlim(weight * inputs(:, i)+ bias)
end
% end of 4.11.ii

% function perceptronTraining returns two values (trained weights and bias)
function [weight, bias] = perceptronTraining(inputs_, targets_, weight_, bias_)
    % if target and axion is not equal
    % train the weight and bias until target and axion is equal
    % weight and bias can be updated by following formula
    % w(new) = w(old) + ep
    % b(new) = b(old) + e
    while 1
        allCorrect = 1;
        for i = 1:length(inputs_)
           a = hardlim(weight_ * inputs_(:, i)+ bias_);
           if targets_(i) ~= a
               error = targets_(i) - a;
               weight_ = weight_ +  error * inputs_(:, i)';
               bias_ = bias_ + error;
               allCorrect = 0;
           end
        end
        if allCorrect
           break;
        end
    end
    weight = weight_;
    bias = bias_;
end



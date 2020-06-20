format compact

input0 = [0 1 1 1 1 0 1 0 0 0 0 1 1 0 0 0 0 1 1 0 0 0 0 1 0 1 1 1 1 0]';
input1 = [0 0 0 0 0 0 1 0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0]';
input2 = [1 0 0 0 0 0 1 0 0 1 1 1 1 0 0 1 0 1 0 1 1 0 0 1 0 0 0 0 0 1]';
target0 = [1 0 0]';
target1 = [0 1 0]';
target2 = [0 0 1]';
% set up input and output
input = [input0 input1 input2];

for i = 1:3
    input(:,i)
end

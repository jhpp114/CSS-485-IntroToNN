format compact
tempVec1 = [1 2 3 4];
tempVec2 = [1 2 3 4];
[row, col] = size(tempVec1);
tempVec3 = zeros(col,row);

for i = 1:length(tempVec2)
    tempVec3(i) = tempVec2(i);    
end
result = 0;
for i = 1:length(tempVec2)
    result = result + (tempVec1(i) * tempVec2(i));
end
result;
% 1 x 6

inputV1 = [1 2 3 4 5 6];
% 2 x 6
weightM = [1 2 3 4 5 6; 1 2 3 4 5 6; 1 2 3 4 5 6];
bias = [1 1 1 1 1 1];
[rows, cols] = size(weightM);

[input_rows, input_cols] = size(inputV1);
test = zeros(rows, input_rows);
for i = 1:rows
    for j = 1:cols
        test(i) = test(i) + (weightM(i,j) * inputV1(j) + bias(j)');
    end
end
hardlim(test);

value1 = [1 2 3 4 5 6];
value2 = [1 2 3 4 5 6; 1 2 3 4 5 6; 1 2 3 4 5 6];
value3Bias = [1 1 1];
tempResult = value2 * value1' + value3Bias';


% tempResult = weightM * inputV1'

weightT = [1 1; 1 1];
inputT = [1 1];
bias = [-1 -2];
hardlim(weightT * inputT' + bias');
% banana == -1
% pineapple == 1
banana = [-1 1 -1]
pineapple = [-1 -1 1]
weight = [0 0 1]
bias = 0
% with 1 1 1
summation = weight * banana' + bias'
%hardlims(summation)








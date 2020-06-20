format compact
p0 = [-1 1 1 1 1 -1 1 -1 -1 -1 -1 1 1 -1 -1 -1 -1 1 1 -1 -1 -1 -1 1 -1 1 1 1 1 -1]';
%length(p0)
p1 = [-1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 -1 1 1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1]';
%length(p1)
p2 = [1 -1 -1 -1 -1 -1 1 -1 -1 1 1 1 1 -1 -1 1 -1 1 -1 1 1 -1 -1 1 -1 -1 -1 -1 -1 1]';
%length(p2)
% create my 3
p3 = [-1 -1 -1 -1 -1 -1 1 -1 1 1 -1 1 1 -1 1 1 -1 1 1 1 1 1 1 1 -1 -1 -1 -1 -1 -1]';
%length(p3)
p4 = [-1 -1 -1 -1 -1 -1 1 1 1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 -1 1 -1 -1 -1 1 1 1 1 1 1]';
%length(p4)
p5 = [1 1 1 -1 -1 1 1 -1 1 -1 -1 1 1 -1 1 -1 -1 1 1 -1 1 -1 -1 1 1 -1 1 1 1 1]';
%length(p5)
p6 = [1 1 1 1 1 1 1 -1 1 -1 -1 1 1 -1 1 -1 -1 1 1 -1 1 1 1 1 -1 -1 -1 -1 -1 -1]';
%length(p6)

% Weight calculation
%target = [p0 p1 p2 p3];
    %p2 p3 p4 p5 p6];
%pTrans = target';
%myWeight = target * pTrans;
% test with the weight
testingWeight = p0*p0' + p1*p1' + p2*p2'+ p3*p3'+ p4* p4' + p5 * p5' + p6 * p6'
% end of test

% test with the doCalculateWithInputV
inputDigit2 = [p0 p1];
inputDigit3 = [p0 p1 p2];
inputDigit4 = [p0 p1 p2 p3];
inputDigit5 = [p0 p1 p2 p3 p4];
inputDigit6 = [p0 p1 p2 p3 p4 p5];
inputDigit7 = [p0 p1 p2 p3 p4 p5 p6];

% all pixels Y value for graph and X value
xValue = [2 3 4 5 6 7]
% ============ 2 pixcel ==============
digit2Y2Pixel = doCalculateWithWeight(inputDigit2, 2)
digit3Y2Pixel = doCalculateWithWeight(inputDigit3, 2)
digit4Y2Pixel = doCalculateWithWeight(inputDigit4, 2)
digit5Y2Pixel = doCalculateWithWeight(inputDigit5, 2)
digit6Y2Pixel = doCalculateWithWeight(inputDigit6 ,2)
digit7Y2Pixel = doCalculateWithWeight(inputDigit7, 2)
yValuePix2 = [digit2Y2Pixel digit3Y2Pixel digit4Y2Pixel digit5Y2Pixel digit6Y2Pixel digit7Y2Pixel]
% ============= 4 pixel ==============
digit2Y4Pixel = doCalculateWithWeight(inputDigit2, 4)
digit3Y4Pixel = doCalculateWithWeight(inputDigit3, 4)
digit4Y4Pixel = doCalculateWithWeight(inputDigit4, 4)
digit5Y4Pixel = doCalculateWithWeight(inputDigit5, 4)
digit6Y4Pixel = doCalculateWithWeight(inputDigit6, 4)
digit7Y4Pixel = doCalculateWithWeight(inputDigit7, 4)
yValuePix4 = [digit2Y4Pixel, digit3Y4Pixel, digit4Y4Pixel, digit5Y4Pixel, digit6Y4Pixel, digit7Y4Pixel]
% ============= 6 pixel =============
digit2Y6Pixel = doCalculateWithWeight(inputDigit2, 6)
digit3Y6Pixel = doCalculateWithWeight(inputDigit3, 6)
digit4Y6Pixel = doCalculateWithWeight(inputDigit4, 6)
digit5Y6Pixel = doCalculateWithWeight(inputDigit5, 6)
digit6Y6Pixel = doCalculateWithWeight(inputDigit6, 6)
digit7Y6Pixel = doCalculateWithWeight(inputDigit7, 6)
yValuePix6 = [digit2Y6Pixel, digit3Y6Pixel, digit4Y6Pixel, digit5Y6Pixel, digit6Y6Pixel, digit7Y6Pixel]
% ============= Graph ==================
plot(xValue, yValuePix2, '-o', 'DisplayName', 'with pixel 2')
hold on
plot(xValue, yValuePix4, '-o', 'DisplayName', 'with pixel 4')
hold on
plot(xValue, yValuePix6, '-o', 'DisplayName', 'with pixel 6')
legend('Location','northwest')
title('Percent Error of Change of Noise Pixels')
xlabel(["\bf Number of Digits"])
ylabel(["\bf Error Percent %"])

%fprintf("P0 Wrong Count: %d\n", doCalculate(p0, myWeight, 2))
%fprintf("P1 Wrong Count: %d\n", doCalculate(p1, myWeight, 2))
%fprintf("p2 Wrong Count: %d\n", doCalculate(p2, myWeight, 2))
%fprintf("p3 Wrong Count: %d\n", doCalculate(p3, myWeight, 2))
%fprintf("p4 Matched Count: %d\n", doCalculate(p4, myWeight, 6))
%fprintf("p5 Matched Count: %d\n", doCalculate(p5, myWeight, 2))
%fprintf("p6 Matched Count: %d\n", doCalculate(p6, myWeight, 2))

%calculateError(testingValue)
theLast = doCalculateWithWeight(inputDigit7, 2)

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

%function count = doCalculate(inputPx, weight, numberOfPixelChange)
    % inputPx is already transposed
    %pxSummation = weight * inputPx;
    %pxAxion = hardlims(pxSummation);
    % set up for iteration and change pixel
    %counter = 0;
    %wrongCounter = 0;
    %tempPx = inputPx;
    %for i = 1:10
        % fprintf("Change Start %d\n", i);
        %tempPx = addNoise(tempPx, numberOfPixelChange);
        %tempSummation = weight * tempPx;
        %tempAxion = hardlims(tempSummation)
        %if pxAxion == tempAxion
        %    counter = counter + 1;
        %else
        %    wrongCounter = wrongCounter + 1;
        %end
        % reset the tempPx to original
        %tempPx = inputPx;
    %end
    %count = wrongCounter;
%end

% so now the weight calculation is dynamic
function count = doCalculateWithWeight(inputPx, numberOfPixelChange)
    targetNew = inputPx;
    pTranspose = targetNew';
    weight = targetNew * pTranspose
    % find a way to 
    % inputPx is already transposed
    [row col] = size(inputPx);
    % numerator = col * 10;
    totalCounter = 0;
    for k = 1:col
        actualPx = inputPx(:,k,:);
        tempPx = actualPx;
        counter = 0;
        wrongCounter = 0;
        pxAxion = actualPx;
        for i = 1:10
            % fprintf("Change Start %d\n", i);
            tempPx = addNoise(tempPx, numberOfPixelChange);
            tempSummation = weight * tempPx;
            tempAxion = hardlims(tempSummation);
            if pxAxion == tempAxion
                counter = counter + 1;
            else
                wrongCounter = wrongCounter + 1
            end
            % reset the tempPx to original
            tempPx = actualPx;
        end
        % wrongCounter = wrongCounter / numerator;
        totalCounter =  wrongCounter + totalCounter;
    end
    count = totalCounter * 100;
end
% end of test



format compact
% all of the inputs are ready to go
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
% test if the value is same

% end of test
inputDigit2 = [p0 p1];
inputDigit3 = [p0 p1 p2];
inputDigit4 = [p0 p1 p2 p3];
inputDigit5 = [p0 p1 p2 p3 p4];
inputDigit6 = [p0 p1 p2 p3 p4 p5];
inputDigit7 = [p0 p1 p2 p3 p4 p5 p6];

xValue = [2 3 4 5 6 7]
% ============ 2 pixel ==============
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
title('PseudoInverse: Percent Error of Change of Noise Pixels')
xlabel(["\bf Number of Digits"])
ylabel(["\bf Error Percent %"])
ylim([-1 100])

% text for 2 px
for dis = 1:6
    text(dis+1, yValuePix2(dis), ['(' num2str(dis+1) ',' num2str(yValuePix2(dis)) ')'])
end
% end for 2 px
% text for 4 px
for dis = 1:6
    text(dis+1, yValuePix4(dis), ['(' num2str(dis+1) ',' num2str(yValuePix4(dis)) ')'])
end
% end for 4px
% text for 6px
for dis = 1:6
    text(dis+1, yValuePix6(dis), ['(' num2str(dis+1) ',' num2str(yValuePix6(dis)) ')'])
end
% end of 6px

hold off

% test if the value is same
target = [p0 p1 p2 p3 p4 p5 p6];
pPlus = pinv(target);
weight = target * pPlus;
figure()
imagesc(weight);
colormap(hsv);
colorbar;

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

% change the weight calculation to pseudoInverse
function count = doCalculateWithWeight(inputPx, numberOfPixelChange)
    targetNew = inputPx;
    pInverse = pinv(targetNew);
    weight = targetNew * pInverse;
    summation = weight * inputPx;
    pxAxion = hardlims(summation);
    counter = 0;
    wrongCounter = 0;
    totalCounter = 0;
    [row, col] = size(targetNew);
    %fprintf("Between\n");
        for i = 1:10
            for k = 1:col
                eachDigit = targetNew(:,k,:);
                length(eachDigit);
                % fprintf("Changing Now\n")
                tempPxho(:,k,:) = addNoise(eachDigit, numberOfPixelChange);
            end
            % fprintf("After Change\n")
            tempPxho;
            tempSummation = weight * tempPxho;
            tempAxion = hardlims(tempSummation);
            if pxAxion == tempAxion
                counter = counter + 1;
            else
                wrongCounter = wrongCounter + 1;
            end
            % reset the tempPx to original
            % somehow i have to reset the values
            % fprintf("After Reset\n")
            tempPxho = inputPx;
        end
        fprintf("Calcuation Start\n");
        wrongCounter = wrongCounter / 10;
        totalCounter =  wrongCounter + totalCounter;
        count = totalCounter * 100;
end



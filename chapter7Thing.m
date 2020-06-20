format compact
p1Input = [-1;1]
p2Input = [0; 0]
p3Input = [1;-1]
p4Input = [1;0]
p5Input = [0;1]

myWeight = [-1 -1]
bias = 0.5

summation = n(p1Input, myWeight, bias)
a = hardlimFunc(summation)

function axion = n(input_, weight_, bias)
    axion = weight_ * input_ + bias
end

function myFunc = hardlimFunc(input_)
   myFunc = hardlim(input_)
end

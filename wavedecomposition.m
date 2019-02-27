function [sol ,l] = wavedecomposition(x,dl) % initiallising the function with input signal and teh elvel of decomposition
[w1 ,w2 ,lr, hr] =wfilters('haar');%getting the haar wavelet coefficients
s1=[length(x)]; % preserving the sequence length
c=[]; % initialising an empty array
cd=[]; % initialising an empty array to store approximation coefficients
cv=[]; % initialising an empty array to store decomposition coefficients


for L=1:dl % number of times the decomposition happens
    
    %if the sequence length is just 1 then the convolved sequence is summed to get the cd and cv
    
   if(length(cd) == 1)
       cd =sum( conv(x,w1)); % convolving the input signal with lowpass filter coefficients
       cv = sum(conv(x,w2)); % convolving the input signal with highpass filter coefficients
       
       
   %else it is convolved with low pass filter and the further downsampled to get cd
   %convolved with high pass filter and the further downsampled to get cv
   else
    cd = downsample(conv(x,w1),2,1);
    cv = downsample(conv(x,w2),2,1);
   end
   
   
   
   %length of approximation and decomposition coefficients are preserved

    l = [length(cd) length(cv) s1];
    s1 = l(2:end);
    %the high passcomponent cv is not decomposed further so it is preserved
    c=[cv c];
    sol = [cd c];
    x=cd; % only the low pass coefficients are sent to further decomposition
end 

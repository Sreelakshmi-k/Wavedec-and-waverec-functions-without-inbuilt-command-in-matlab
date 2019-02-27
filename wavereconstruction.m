function dec = wavereconstruction(solution,l)% initiallising the function with low passnand high pass decomposition coeffients
%the decomposition and reconstruction filters for haar wavelet

[ld ,hd ,lr, hr] =wfilters('haar'); % getting the filter coefficients
dec=solution;
len = l(1:length(l)-1); %removing the length of input signal

for i = 1: length(l)-2
    %cd low pass coefficients cv high pass decomposition coefficients
    cd = dec(1:len(1)); % takes only the Low frequency of decomposed signal
    cv = dec(len(1)+1 : (len(1)+1)+len(2)-1);% takes only the high frequency of decomposed signal
   
    a = conv(upsample(cd,2),lr);  %upsampling thelow frequency decomposition coefficients and then convolveing with the respective low pass reconstruction filters
    b = conv(upsample(cv ,2) ,hr);%upsampling thelow frequency decomposition coefficients and then convolveing with the respective low pass reconstruction filters
   
    cd = a+b;  %adding the  coefficients to get the previous level approximation(low frequency) coefficients
   
    cd  =  cd(1:find(cd,1,'last'));  % removing the extra zeros at the end
    %if the coefficients are equal (this will occur when the further decomposition is done by single value sequence
    if(cd(1) == cd(2))
        cd = cd(1);
    end
   
    cv = dec((len(1)+1)+len(2) :end);  % retaining the decomposition coefficients as they are preserved by decomposition process
   
    dec = [cd cv]; %  appending to get the previous level cd and cv
    
    len = [length(cd) len(3:end)]; %previous level lengths
end
    
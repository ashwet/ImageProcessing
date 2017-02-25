origin = imread('cameraman.png');
crpt1 = imread('corrupt1.png');
crpt3 = imread('corrupt3.png');
crpt4 = imread('corrupt4.png');
fx = origin
%For Corrupt Image 1: 
gx = 255 - crpt1;
result = (fx - gx) .^ 2;
min(min(result));
max(max(result));
%for Corrupt Image 2
gx = crpt2;
fx = origin;
brightness = uint8(mean2(crpt2) - mean2(origin));
%For Corrupt Image 3
fx = origin;
gx = crpt3;
gmin = min(min(fx));
gmax = max(max(fx));
temp = round(255/(gmax - gmin) * (fx - gmin))
temp = temp - 1;
sum(sum(temp-gx) .^ 2);
%For Corrupt Image 4
fx = origin;
gx = crpt4;
c = log(256);
temp = uint8(255/c*log(double(fx+1)));
sum(sum(double(temp)-double(gx)).^2);
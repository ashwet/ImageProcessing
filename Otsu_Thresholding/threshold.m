%Part 1

clear;
i1 = imread('input1.png');
for T = 0:255
    b = i1>=T;
    w2 = sum(b(:));
    w1 = numel(i1)-w2;
    m2 = mean(i1(b));
    m1 = mean(i1(~b));
    bcv(T+1)=w1*w2*(m1-m2)^2;
end
[mv, mindex] = max(bcv);
totsu = mindex -1;
figure; plot(bcv);
s=sprintf('Totsu=%d\n',totsu);
title(s);
figure;imshow(i1>=totsu);
title('Otsu Thresholded Output Image');

%Part 2

clear;
i2=imread('input2.png');
N=11;
Nh=floor(N/2);
[R,C]=size( i2 );
for T = 0:255
    b = i2>=T;
    w2 = sum(b(:));
    w1 = numel(i2)-w2;
    m2 = mean(i2(b));
    m1 = mean(i2(~b));
    bcv(T+1)=w1*w2*(m1-m2)^2;
end
[mv,mindex]=max(bcv);
Totsu=mindex-1;
figure;imshow(i2>=Totsu);
title('Otsu Threshold Image For Input2');
meanIm=zeros(R,C,'uint8');
for r= Nh+1: (R-Nh-1)
    for c= Nh+1 :(C-Nh-1)
        meanIm(r,c)= mean(mean(i2(r-Nh:r+Nh,c-Nh:c+Nh)));
    end
end


figure;imshow(meanIm);
title('Mean Image');

k=1;
g=i2>= k*meanIm;
figure;imshow(g);
title('K = 1');

k=0.9;
g=i2>= k*meanIm;
figure;imshow(g);
title('K = 0.9');

k=1.1;
g=i2>= k*meanIm;
figure;imshow(g);
title('K = 1.1');
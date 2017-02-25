i = imread('peppers.jpg');
i_hsv = rgb2hsv(i);
imshow(i);
N = 10;
red = ginput(N);
red = uint8(red);
green = ginput(N);
green = uint8(green);
yellow = ginput(N);
yellow = uint8(yellow);
orange = ginput(N);
orange = uint8(orange);
hue = i_hsv(:,:,1);
redhue = [];
for k=1:N;
redhue(k) = hue(red(k,1),red(k,2));
end
greenhue = []
for k=1:N;
greenhue(k) = hue(green(k,1),green(k,2));
end
yellowhue = [];
for k=1:N;
yellowhue(k) = hue(yellow(k,1),yellow(k,2));
end
orangehue = [];
for k=1:N;
orangehue(k) = hue(orange(k,1),orange(k,2));
end
redhuemean = mean(redhue);
greenhuemean = mean(greenhue);
yellowhuemean = mean(yellowhue);
orangehuemean = mean(orangehue);
huearray = [redhuemean,greenhuemean,yellowhuemean,orangehuemean];
huearray = huearray';
huearray = sortrows(huearray);
huerange = [0,(huearray(1)+huearray(2))/2,(huearray(2)+huearray(3))/2,(huearray(3)+huearray(4))/2,1];
[row, col]= find(hue>=huerange(1)&hue<=huerange(2));
[row1, col1]= find(hue>huerange(2)&hue<=huerange(3));
[row2, col2]= find(hue>huerange(3)&hue<=huerange(4));
[row3, col3]= find(hue>huerange(4)&hue<=huerange(5));
pepperclass = [];
meanR=0;
meanG=0;
meanB=0;
meanR1=0;
meanG1=0;
meanB1=0;
meanR2=0;
meanG2=0;
meanB2=0;
meanR3=0;
meanG3=0;
meanB3=0;
count=0;count1=0;count2=0;count3=0;
seg_i=double(i);
[r,c]= size(hue);
for k = 1:r
    for j = 1:c
        if hue(k,j)>=huerange(1) & hue(k,j)<=huerange(2)
            pepperclass(k,j)=0;
            meanR=meanR+seg_i(k,j,1);
            meanG=meanG+seg_i(k,j,2);
            meanB=meanB+seg_i(k,j,3);
            count=count+1;
        elseif hue(k,j)>huerange(2) & hue(k,j)<=huerange(3)
            pepperclass(k,j)=1;
            meanR1=meanR1+seg_i(k,j,1);
            meanG1=meanG1+seg_i(k,j,2);
            meanB1=meanB1+seg_i(k,j,3);
            count1=count1+1;
        elseif hue(k,j)>huerange(3) & hue(k,j)<=huerange(4)
            pepperclass(k,j)=2;
            meanR2=meanR2+seg_i(k,j,1);
            meanG2=meanG2+seg_i(k,j,2);
            meanB2=meanB2+seg_i(k,j,3);
            count2=count2+1;
        elseif hue(k,j)>huerange(4) & hue(k,j)<=huerange(5)
            pepperclass(k,j)=3;  
            meanR3=meanR3+seg_i(k,j,1);
            meanG3=meanG3+seg_i(k,j,2);
            meanB3=meanB3+seg_i(k,j,3);
            count3=count3+1;
        end
    end
end
meanR=meanR/count;
meanG=meanG/count;
meanB=meanB/count;
meanR1=meanR1/count1;
meanG1=meanG1/count1;
meanB1=meanB1/count1;
meanR2=meanR2/count2;
meanG2=meanG2/count2;
meanB2=meanB2/count2;
meanR3=meanR3/count3;
meanG3=meanG3/count3;
meanB3=meanB3/count3;
for k = 1:r
    for j = 1:c
        if hue(k,j)>=huerange(1) & hue(k,j)<=huerange(2)
            seg_i(k,j,1)=meanR;
            seg_i(k,j,2)=meanG;
            seg_i(k,j,3)=meanB;
        elseif hue(k,j)>huerange(2) & hue(k,j)<=huerange(3)
            seg_i(k,j,1)=meanR1;
            seg_i(k,j,2)=meanG1;
            seg_i(k,j,3)=meanB1;
        elseif hue(k,j)>huerange(3) & hue(k,j)<=huerange(4)
            seg_i(k,j,1)=meanR2;
            seg_i(k,j,2)=meanG2;
            seg_i(k,j,3)=meanB2;
        elseif hue(k,j)>huerange(4) & hue(k,j)<=huerange(5)
            seg_i(k,j,1)=meanR3;
            seg_i(k,j,2)=meanG3;
            seg_i(k,j,3)=meanB3;
        end
    end
end
seg_i = uint8(seg_i);
imshow(seg_i);
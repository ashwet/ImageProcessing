clear; clc;
I = imread('salt-pep.png');
win = 3; %change this variable to change window size
Rep = zeropadding(I, win);
array = zeros(1,win*win);
[r,c] = size(I);
B = zeros(r, c);
for x = 1 : r
    for y = 1 : c
        for i = 1 : win
            for j = 1 : win
                %q = x - 1;     w = y -1;
                array((i - 1) * win + j) = Rep(i+x-1, j+y-1);
            end
        end
        B(x, y) = findmedian(array);
    end
end
figure; imshow(I);
figure; imshow(uint8(B));

d=[];
w=[];
for W=3:21:101
    sum=0;array=zeros(1,W*W);
    Rep = zeropadding(I, W);
    for x = 1 : r
        for y = 1 : c
            for i = 1 : W
                for j = 1 : W
                    array((i - 1) * W + j) = Rep(i+x-1, j+y-1);
                end
            end
            [med,duration] = findmedian(array);
            B(x,y)=med;
            sum=sum+duration;
        end
    end
    d=[d sum];
    w=[w W];
end
figure; plot( w, d, '-ro' );
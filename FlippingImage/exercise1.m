%Item-1
I=imread('mountain.png');
meanMountainColumn = mean(I);
plot(meanMountainColumn);
meanMountainColumn=meanMountainColumn';
%Item-2
darkestCol = find(meanMountainColumn == min(meanMountainColumn));
darkestCol = int16(darkestCol);
%Item-3
flipImage = I(480:-1:1,1:640);
imshow(flipImage);
whos;
%Item-4
halfImage = I(1:2:end,1:2:end);
imshow(halfImage);
%Item-5
myHist=1:256
[a,b] = size(I);
counter = 0;
counter = int16(counter);
for k=1:256
    for i=1:a
        for j=1:b
            if I(i,j)==k-1;
                counter = counter +1;
            end
        end
    end
    myHist(k)=counter;
    counter=0;
end
myHist=int16(myHist);
myHist = myHist';
myHist;
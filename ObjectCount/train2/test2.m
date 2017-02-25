clear;
folder_name = 'video1/';

inputImageN0 = 1;
inputImageN1 = 100;
for i = inputImageN0:inputImageN1
    input_im_name = sprintf ( '%sFRM_%05d.png%', folder_name, i );
    f = imread ( input_im_name );
    f = rgb2gray(f);
    
end
bgImg = uint8(sumImg / 200);
fgImg = max(f-bgImg,0);

fgImg = imdilate(fgImg, strel('square',3));
fgImg = imerode(fgImg, strel('square',3));
fgImg = imfill(fgImg,8,'holes');
L = bwlabel(fgImg,4);
L = uint16(L);
stats = regionprops(L,'Area');
x = [stats.Area];
y = x;
for i=1:numel(x)
    if x(i) < 100
        y(i) = 0;
        L(L==i) = 0;
    end
end
numO = max(find(find(y)));
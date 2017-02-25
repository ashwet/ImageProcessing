f = imread('rice.png');
f1 = im2bw(f,graythresh(f));
figure, imshow(f1); title('Otsu thresholding image');
f2 = bwlabel(f1,4);
f2 = uint16(f2);
figure, imshow(f2,[]); title('Labled Image');
stats = regionprops(f2,'Area');
x = [stats.Area];
for i=1:numel(x)
if x(i) < 50;
   f2(f2==i) = 0;
end
end
f2(f2>0)=1;
figure, imshow(f2,[]); title('Binary image after small region removal');
B = strel('square',3);
E = imerode(f2,B);
figure, imshow(E,[]); title('Erosion image');
figure,imshow(f2-E,[]);title('Final boundary image'); 
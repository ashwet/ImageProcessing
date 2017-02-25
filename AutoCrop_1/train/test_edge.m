clear;
folder_name = 'data/';

inputImageN0 = 1;
inputImageN1 = 25;
tic;
for i = inputImageN0:inputImageN1
    
    %load input image
    input_im_name = sprintf ( '%sinput_%d.jpg', ...
        folder_name, i );
    f = imread ( input_im_name );
    BW = rgb2gray(f);
    %fe = medfilt2(fe);
    fe = histeq(BW);
    figure, plot(imhist(BW));
     [~,threshold] = edge(BW,'Canny');
    ff = 0.8;
    BWe1 = edge(BW,'Canny', [], 3);
    BWe2 = edge(fe,'Canny', 0, 3);
    se90 = strel('line', 3, 90);
    se0 = strel('line', 3, 0);
    BWe1dill = imdilate(BWe1, [se90 se0]);
    BWe1fill = imfill(BWe1dill, 'holes');
    figure, imshowpair(BWe1,BWe2,'montage');
end
toc;
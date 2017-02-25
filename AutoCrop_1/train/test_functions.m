
folder_name = 'data/';

inputImageN0 = 1;
inputImageN1 = 1;
%tic;
for i = inputImageN0:inputImageN1
    %load input image
    input_im_name = sprintf ( '%sinput_%d.jpg', ...
        folder_name, i );
    f = imread ( input_im_name );
    fg = rgb2gray(f);
    tic; BW1 = im2bw(fg,graythresh(fg)); toc;
    tic; BW2 = imquantize(fg,multithresh(fg)); toc;
%     green = f(:,:,2);
%     blue = f(:,:,3);
%     fg = rgb2gray(f);
%     fg1 = imgaussfilt(fg);
%     fg2 = medfilt2(fg);
%     BW1 = imbinarize(fg1,'adaptive','Sensitivity',0.6);
%     BW2 = imbinarize(fg2,'adaptive','Sensitivity',0.6);
%     %figure, imshow(BW);
%     figure, imshowpair(fg1,fg2,'montage');
end
%toc;
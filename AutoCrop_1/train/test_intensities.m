folder_name = 'data/';

inputImageN0 = 1;
inputImageN1 = 25;
for i = inputImageN0:inputImageN1
    %load input image
    input_im_name = sprintf ( '%sinput_%d.jpg', ...
        folder_name, i );
    f = imread ( input_im_name );
    f = rgb2gray(f);
    [R C] = size(f);
    temp = f((R/2)-25:(R/2)+25,(C/2)-25:(C/2)+25);
    int = double(mean(mean(double(temp)))/255);
    BW = im2bw(f,int);
    figure, imshow(BW);
end
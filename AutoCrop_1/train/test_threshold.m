clear;
folder_name = 'data/';

inputImageN0 = 8;
inputImageN1 = 8;
tic;
for i = inputImageN0:inputImageN1
    %load input image
    input_im_name = sprintf ( '%sinput_%d.jpg', ...
        folder_name, i );
    f = imread ( input_im_name );
    green = f(:,:,2);
    blue = f(:,:,3);
    green = medfilt2(green);
    blue = medfilt2(blue);
    BW1 = im2bw(green,graythresh(green));
    BW2 = im2bw(blue,graythresh(blue));
    se90 = strel('line', 3, 90);
    se0 = strel('line', 3, 0);
    BW1 = imdilate(BW1, [se90 se0]);
    BW2 = imdilate(BW2, [se90 se0]);
    final = BW1&BW2;
    figure, imshow(final);
    [h,v] = size(final);
    sh = sum(final);
    sv = sum(transpose(final));
    
    sdh_tl = abs(sh(1:end/2-1)-sh(2:(end/2)));
    temp = find(sdh_tl > 40,1,'first');
    if isempty(temp)
        sx(i) = v/6;
    else 
        sx(i) = temp;
    end
    sdv_tl = abs(sv(1:end/2-1)-sv(2:(end/2)));
    temp = find(sdv_tl > 40,1,'first');
    if isempty(temp)
        sy(i) = h/6;
    else 
        sy(i) = temp;
    end
    
    sdh_br = abs(sh(end/2:end-1)-sh((end/2+1:end)));
    temp = find(sdh_br > 35,1,'first');
    if isempty(temp)
        sx_br(i) = h-v/6;
    else 
        sx_br(i) = temp;
    end
    sdv_br = abs(sv(end/2:end-1)-sv((end/2+1:end)));
    temp = find(sdv_br > 50,1,'first');
    if isempty(temp)
        sy_br(i) = c-h/6;
    else 
        sy_br(i) = temp;
    end
    
    sHeight(i) = (h/2+sy_br(i)) - sy(i);
    sWidth(i) = (v/2+sx_br(i)) - sx(i);
end
toc;
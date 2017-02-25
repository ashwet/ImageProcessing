function [sx, sy, sWidth, sHeight] = auto_crop ( f )

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
    BW1 = imfill(BW1, 'holes');
    BW2 = imfill(BW2, 'holes');
    final = BW1&BW2;
    [h,v] = size(final);
    sh = sum(final);
    sv = sum(transpose(final));
    
    sdh_tl = abs(sh(1:end/2-1)-sh(2:(end/2)));
temp = find(sdh_tl > 40,1,'first');
    if isempty(temp)
        sx = v/6;
    else 
        sx = v-temp;
    end
    sdv_tl = abs(sv(1:end/2-1)-sv(2:(end/2)));
    temp = find(sdv_tl > 40,1,'first');
    if isempty(temp)
        sy = h/6;
    else 
        sy = h-temp;
    end
    
    sdh_br = abs(sh(end:-1:(end/2)+1)-sh((end-1:-1:end/2)));
    temp = find(sdh_br > 45,1,'first');
    if isempty(temp)
        sx_br = h-v/6;
    else 
        sx_br = temp;
    end
    sdv_br = abs(sv(end:-1:(end/2)+1)-sv((end-1:-1:end/2)));
    temp = find(sdv_br > 50,1,'first');
    if isempty(temp)
        sy_br = v-h/6;
    else 
        sy_br = temp;
    end
    
    sHeight = (h/2+sy_br) - sy;
    sWidth = (v/2+sx_br) - sx;
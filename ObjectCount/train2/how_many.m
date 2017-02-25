function [ct] = how_many ( prefix, ct_f, num_f )
%prefix - name of video folder
%ct_f - vector of frames used for grading
%num_f - number of frames

%i is an array of integers from 1 to the number of frames
for i = 1:num_f;
    fn = sprintf ( '%sFRM_%05d.png%', prefix, i);
    f = imread ( fn );
    f = rgb2gray(f);
    f = f(30:end-30,30:end-30);
    if i==1
        sumImg = zeros(size(f));
    end
    sumImg = sumImg + double(f);
end
ct = double(zeros(1,numel(ct_f)));
bgImg = uint8(sumImg / (num_f));
bgImg = medfilt2(bgImg,[3 3]);
for j=1:numel(ct_f)
    fn = sprintf ( '%sFRM_%05d.png%', prefix, ct_f(j));
    f = imread ( fn );
    f = rgb2gray(f);
    f = f(30:end-30,30:end-30);
    fgImg = imabsdiff(f,bgImg);
    fgImg = medfilt2(fgImg,[2 2]);
    fgImg = im2bw(fgImg,graythresh(fgImg));
    fgImg = imclose(fgImg,strel('square',3));
    fgImg = imfill(fgImg,8,'holes');
    [L,count] = bwlabel(fgImg,4);
    L = uint16(L);
    stats = regionprops(L,'Area');
    x = [stats.Area];
    y = x;
    if count>200;
        th=85;
    elseif count<200;
        th=60;
    end
    for i=1:numel(x)
        if x(i) <= th
            y(i) = 0;
        end
    end
    ct(j) = max(find(find(y)));
end
function [ct] = how_many2 ( prefix, ct_f, ~ )
%prefix - name of video folder
%ct_f - vector of frames used for grading
%num_f - number of frames

%i is an array of integers from 1 to the number of frames
% for i = 1:num_f;
%     fn = sprintf ( '%sFRM_%05d.png%', prefix, i);
%     f = imread ( fn );
%     f = rgb2gray(f);
%     if i==1
%         sumImg = zeros(size(f));
%     end
%     sumImg = sumImg + double(f);
% end
ct = double(zeros(1,numel(ct_f)));
% bgImg = uint8(sumImg / (num_f+60));
for j=1:numel(ct_f)
    fn = sprintf ( '%sFRM_%05d.png%', prefix, ct_f(j));
    f = imread ( fn );
    f = rgb2gray(f);
    f = 2*f - imdilate(f, strel('square',5));
    f(f<0) = 0;
    f(f>1) = 1;
    f = imdilate(f, strel('square',5)) - f;
    f = ~(f <= multithresh(f)*0.8);
    f = imclose(f,strel('square',3));
    f = imfill(f,8,'holes');
    figure;imshow(f,[]);
%     fgImg = ~fgImg;
    L = bwlabel(f,4);
    L = uint16(L);
%     [~, C]=find(L(1,1:end));
%     for c=1:size(C,2)
%         f(L==L(1,C(c)))=0;
%     end
%     L = bwlabel(f,4);
%     L = uint16(L);
    stats = regionprops(L,'Area');
    x = [stats.Area];
    y = x;
    for i=1:numel(x)
        if x(i) < 100
            y(i) = 0;
        end
    end
    ct(j) = max(find(find(y)));
 end
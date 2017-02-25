%Part-1
f = imread('input.jpg');
r = imread('ref.jpg');
h = imhist(f);
figure, plot(h), title('Input Image Histogram');
hn = h / numel(f);
figure, plot(hn), title('Input Image Normalised Histogram');
cdfi = cumsum(hn);
figure, plot(cdfi), title('Input Image Cumulative Distribution Function');
%Part-2
g = cdfi(f+1);
imshow(g), title('Equalised Image');
gh = imhist(g);
figure, plot(gh), title('Equalised Image Histogram');
ghn = gh / numel(g);
ch = cumsum(ghn);
figure, plot(ch), title('Equalised Image CDF');
%Part-3
hr = imhist(r);
hrn = hr / numel(r);
cdfo = cumsum(hrn);
figure; plot(cdfi, '-r');
hold on;
plot(cdfo, '-b'), title('Input Image CDF(Red) vs Reference Image CDF(Blue)');

for i=1:256
    for j=1:256
        if cdfi(i) <= cdfo (j)
            t(i) = j-1;
            break;
        end
        t(i) = 255;
    end
end     
m = uint8(t(f+1));
ht = imhist(m);
imshow(m), title('Histogram Matched Output Image');
hm = ht/ numel(m);
cdfm = cumsum(hm);
figure; plot(cdfi, '-r');
hold on;
plot(cdfo, '-b');
hold on;
plot(cdfm, '-g');
title('CDF Input(red) vs CDF Reference(Blue) vs CDF Histogram matched(Green)');
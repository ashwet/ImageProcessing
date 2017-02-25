f = imread('rice.png');
f = im2bw(f);
L = 1;
i = 1;
eqTab = [];
[R,C] = size(f);
h = zeros(R,C,'uint16');
for r=1:R
    for c=1:C
        if(f(r,c)==true)
            if(r==1)
                topL = 0;
            else
                topL = h(r-1,c);
            end
            if(c==1)
                leftL = 0;
            else
                leftL = h(r,c-1);
            end
            if(leftL == 0 && topL == 0)
                h(r,c)=L;
                L = L+1;
            elseif(leftL == 0 && topL ~= 0)
                h(r,c) = topL;
            elseif(leftL ~= 0 && topL == 0)
                h(r,c) = leftL;
            elseif(leftL ~= 0 && topL ~= 0)
                h(r,c) = min(leftL,topL);
                if(leftL ~= topL)
                    eqTab(i,1) = h(r,c);
                    eqTab(i,2) = max(leftL,topL);
                    i = i+1;
                end
            end
        end
    end
end
figure;imshow(h,[]);title('Labled Image');
eqTab = unique(eqTab,'rows');
labelCount=max(max(h));
eqTable(1:labelCount)=1:labelCount;

for i=1:size(eqTab,1)
    eqTable(eqTab(i,2))=eqTable(eqTab(i,1));
end

g=h;
for r=1:R
    for c=1:C
        if(h(r,c)~=0)
            g(r,c) = eqTable(h(r,c));
        end
    end
end
counter = 0;
cmap = rand(unique(labelCount),3);
for z=1:labelCount
    for row=1:R
        for col=1:C
            if g(row,col)==z;
                counter=counter+1;
            end
        end
    end
    hist(z)=counter;
    counter=0;
end
figure; imshow(g,[]); title('Output');
colormap (cmap);
noise=hist<mean(hist);
Thresh=mean(hist)
for i=1:size(noise,2)
    if(noise(i)~=0)
        g(g==i)=0;
    else
        counter=counter+1;
    end
end
nObj=counter

figure,imshow(g,[]);title('CCL output with threshold');
colormap (cmap);
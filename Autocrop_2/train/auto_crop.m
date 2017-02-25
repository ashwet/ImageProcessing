function [x0, y0, x1, y1, x2, y2, x3, y3] = auto_crop ( f )

    f = imadjust(f,stretchlim(f),[]);
    green = f(:,:,2);
    blue = f(:,:,3);
    green = medfilt2(green);
    blue = medfilt2(blue);
    BW1 = im2bw(green,graythresh(green));
    BW2 = im2bw(blue,graythresh(blue));
    BW = BW1&BW2;
    [Ri,Ci] = size(BW);
    BW = imopen(BW,ones(7,7));
    [L,~] = bwlabel(BW,4);
    L = uint16(L);
    stats = regionprops(L,'Area');
    x = [stats.Area];
    y = x;
    for j=1:numel(x)
        if x(j) ~= max(x)
            L(L==j) = 0;
        end
    end
    L(L>0) = 1;
    L = imfill(L, 'holes');
    e = edge(L,'Canny',[]);
    se45 = strel('line',10,45);
    se135 = strel('line',10,135);
    e = imdilate(e,[se135 se45]);
    [H,T,R] = hough(e);
    peaks = houghpeaks(H,4);
    lines = houghlines(e,T,R,peaks,'FillGap',150);    
    rho_s = abs([lines.rho]);
    
    %TopLeft Point Of Document
    index=find(rho_s==min(rho_s));
    x0 = lines(min(index)).point1(1);
    y0 = lines(min(index)).point1(2);
    
    %BottomRight Point Of Document
    index=find(rho_s==max(rho_s));
    x2 = lines(min(index)).point2(1);
    y2 = lines(min(index)).point2(2);
    
%    TopLeftP_f = [1,1];
    TopRightP_f = [1,Ci];
    BottomLeftP_f = [Ri,1];
%    BottomRightP_f = [Ri,Ci];

    for k = 1:length(lines)
        vertice1(k,:) = [lines(k).point1];
        vertice2(k,:) = [lines(k).point2];
    end
    vertice = cat(1,vertice1,vertice2);
    
    if(length(vertice)==8)
            for l = 1:length(vertice)
                d_BL(l) = pdist2(BottomLeftP_f,vertice(l,:));
                d_TR(l) = pdist2(TopRightP_f,vertice(l,:));
            end

            index_BL=find(d_BL==min(d_BL));
            index_TR=find(d_TR==min(d_TR));

            if(min(index_BL)<5)
                x3 = vertice1(min(index_BL),1);
                y3 = vertice1(min(index_BL),2);
            elseif(min(index_BL)>=5)
                x3 = vertice2(min(index_BL)-4,1);
                y3 = vertice2(min(index_BL)-4,2);
            end

            if(min(index_TR)<5)
                x1 = vertice1(min(index_TR),1);
                y1 = vertice1(min(index_TR),2);
            elseif(min(index_TR)>=5)
                x1 = vertice2(min(index_TR)-4,1);
                y1 = vertice2(min(index_TR)-4,2);
            end
    %Fault Tolerance
    else
            x1 = double(Ci*.75);
            y1 = double(Ri*.25);
            x3 = double(Ci*.25);
            y3 = double(Ri*.75);
    end
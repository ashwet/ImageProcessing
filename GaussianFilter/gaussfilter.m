clear;
for sig = 3:2:7
        f = imread('input.png');
        wh = floor(2.5*sig - 0.5);
        w = zeros(2*wh+1, 2*wh+1);
        %w = rand(2*wh+1, 2*wh+1);
        imagesc(w); colormap jet;
        for y = -wh:wh
            for x = -wh:wh
                w(x+wh+1,y+wh+1) = exp(-1*(x^2+y^2)/(2*sig^2));
            end
        end
        w = w/sum(w(:));
        imagesc(w);colormap jet;

        [R,C] = size(f);
        g = zeros (R,C, 'uint8');
        total = 0;
        for a = wh+1:(size(f,1)-wh-1)
            for b = wh+1 : (size(f,2)-wh-1)
            total = 0;
                for c = -wh:wh
                    for d = -wh:wh
                        total = total + w(wh+c+1,wh+d+1)*f(a-c,b-d);
                    end
                end
                g(a,b) = total;
            end
        end
        figure; imshow(g);
end
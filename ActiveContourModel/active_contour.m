function active_contour()
close all;

f = imread('circle.png');
f = imfilter(f, ones(13, 13)/13^2);
[R, C] = size(f);

a = 1; b = 1; stepSize = 5;

nb = 40;
pts = zeros(nb,2);
pts(1:10,1) = 1; pts(1:10,2) = floor(1:C/10:C);
pts(11:20,1) = floor(1:R/10:R); pts(11:20,2) = C;
pts(21:30,1) = R; pts(21:30,2) = floor(C:-C/10:1);
pts(31:40,1) = floor(R:-R/10:1); pts(31:40,2) = 1;


gx = imfilter(single(f), [-1 1]);
gy = imfilter(single(f), [-1 1]');


stepSize = 5;
n = 100002;
for j = 1 : n %number of iter
    
    
    curRandPt = ceil(rand()*nb);
    
  
    Eex = - (abs(gx(pts(curRandPt, 1), pts(curRandPt, 2)))^2 + abs(gy(pts(curRandPt, 1), pts(curRandPt, 2)))^2);
    
    P = pts(max(mod(curRandPt+1, nb + 1), 1), :) - pts(curRandPt, :);
    Einf = sqrt(P(1)^2 + P(2)^2);
    
    z = curRandPt-1;
    if(z==0)
        z = nb;
    end;
    Q = pts(max(mod(curRandPt+1, nb + 1), 1), :) - (2 .* pts(curRandPt, :)) + pts(z, :);
    Eins = sqrt(Q(1)^2 + Q(2)^2);
    
    Ein = (a * (Einf ^ 2)) + (b * (Eins ^ 2));
    E = Ein + Eex;
    

  
    randomPoint = pts(curRandPt, :);

    randX = min(max(1, randomPoint(1, 1) + ceil(rand()*-stepSize-2) + ceil(rand()*(stepSize+2))), R);
    randY = min(max(1, randomPoint(1, 2) + ceil(rand()*-stepSize-2) + ceil(rand()*(stepSize+2))), C);
    randomPoint = [randX, randY];
    
   
    Eex = - (abs(gx(randX, randY))^2 + abs(gy(randX, randY))^2);
    
    P = pts(max(mod(curRandPt+1, nb + 1), 1), :) - randomPoint;
    Einf = sqrt(P(1)^2 + P(2)^2);
    
    Q = pts(max(mod(curRandPt+1, nb + 1), 1), :) - (2 .* randomPoint) + pts(z, :);
    Eins = sqrt(Q(1)^2 + Q(2)^2);
    Ein = (a * (Einf ^ 2)) + (b * (Eins ^ 2));
    
    Enew = Ein + Eex;
    
    if(Enew < E)
        pts(curRandPt, :) = randomPoint;
    end;
    if(j== 1001 ||j==30001 || j== 100001 )
         figure; imshow(vis_acm(f, pts), []);
          xlabel(sprintf('Iteration %d:\n E_{old} = %d. \n E_{new} = %d = E_{in} + E_{ex}.  E_{in} = %d. E_{ex} = %d.\n E_{in} = E_{in(%s_{1})}^{2} + E_{in(%s_{2})}^{2} = %d^{2} + %d^{2}.\n', j-1, ceil(E), ceil(Enew), ceil(Ein), ceil(Eex), '\Delta', '\Delta', ceil(Einf), ceil(Eins)));
    end;
end;
 imshow(vis_acm(f, pts), []);
end

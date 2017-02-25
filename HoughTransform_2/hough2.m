f=imread('doc.jpg');
figure;imshow(f);title('Input');
g=rgb2gray(f);
g=g(1:4:end,1:4:end);
e=edge(g, 'canny' );
figure;imshow(e);title('Canny Edge Image');

[R C]=size(e);
d=ceil(sqrt(R^2+C^2));
a=zeros(2*d+1,180,'uint16');
for r=1:R
    for c=1:C
        if(e(r,c)==1)
            for angle=1:180
                p=floor(c*cosd(angle-1)+r*sind(angle-1));
                p=p+d+1;
                a(p,angle)=a(p,angle)+1;
            end
        end
    end
end

figure,imshow(a,[]);colormap jet
title('Visualisation of Accumulator Array Without Non-Max Suppression');
%non max suppression
[R C]=size(a);
tempAcc=a;

for r = 6: R-5
    for c =6:C-5
       
            maxValue=max(max(a(r-5:r+5,c-5:c+5)));
            if(a(r,c)==maxValue)
            a(r-5:r+5,c-5:c+5)=0;
            a(r,c)=maxValue;
            else
            a(r,c) = 0;
            end
            

    end
end
figure,imshow(a,[]);colormap jet
title('Visualisation of Accumulator Array after Non-Max Suppression');
b=a;
for j=1:4 
    [m,n] = find(b==max(max(b)));
    M(j) = m;
    N(j) = n;
    b(m,n) = 0;
 
end;  

L = M;
O = N;
L = (L - d-1)
O = (O - 1)
figure;imshow(e);
hold on ;

x = 1:500;
for i=1:4
   y = -cotd(O(i))*x + L(i)*cscd(O(i));
        plot(x,y,'y');
    
end 
hold off ;

figure;
imshow(g);
hold on ;
x = 1:500;
for i=1:4
     y = -cotd(O(i))*x + L(i)*cscd(O(i));
        plot(x,y,'y');
end 

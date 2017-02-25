f = false(100,100);
f(25, 25:75) = true;
f(75, 25:75) = true;
f(25:75, 25) = true;
f(25:75, 75) = true;
imshow(f);title('Synthetic Image');
d = ceil(sqrt(100^2 + 100^2));
a = zeros(2*d + 1,180,'uint16');
for r = 1:100
    for c = 1:100
        if f(r,c) == true;
            for theta = 1:180
                p = round(r*cosd(theta-1) + c*sind(theta-1));
                p = p + d + 1;
                a(p,theta) = a(p,theta) + 1;
            end
                if r==25 && c==25
                    figure, imshow(a,[]); title('Visualization of accumulator array after populating the first edge pixel');
                end
        end
    end
end
figure, imshow(a,[]); title('Visualization of accumulator array after populating all edge pixel');
[rho,theta] = find(a==max(max(a)));
indice = [rho, theta]
indice(:,2) = indice(:,2) - 1;
indice(:,1) = indice(:,1) - d - 1;
indice
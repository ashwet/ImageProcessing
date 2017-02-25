f = imread('rice.png');
f = im2bw(f);
[R,C] = size(f);

%erotion

f1 = false(size(f));
B = ones(3);
for r=2:(R-1)
    for c=2:(C-1)
    A = f(r-1:r+1,c-1:c+1);
    if all((A & B==B)==true);
        f1(r,c) = true;
    else
        f1(r,c) = false;
    end
    end
end
figure; imshow(f1); title('Erosion Output with 3x3 matrix with all 1s');

f1 = false(size(f));
B = [0 1 0; 0 1 0; 0 1 0];
for r=2:(R-1)
    for c=2:(C-1)
    A = f(r-1:r+1,c-1:c+1);
    if all((A & B==B)==true);
        f1(r,c) = true;
    else
        f1(r,c) = false;
    end
    end
end
figure; imshow(f1); title('Erosion Output with 3x3 matrix with 1s along center column');

f1 = false(size(f));
B = ones(7);
for r=4:(R-3)
    for c=4:(C-3)
    A = f(r-3:r+3,c-3:c+3);
    if all(((A & B)==B)==true);
        f1(r,c) = true;
    else
        f1(r,c) = false;
    end
    end
end
figure; imshow(f1); title('Erosion Output with 7x7 matrix with all 1s');

%dilation

f1 = false(size(f));
B = ones(3);
for r=2:(R-1)
    for c=2:(C-1)
    A = f(r-1:r+1,c-1:c+1);
    if (sum(sum(A & B))>=1);
        f1(r,c) = true;
    else
        f1(r,c) = false;
    end
    end
end
figure; imshow(f1); title('Dilation Output with 3x3 matrix with all 1s');

f1 = false(size(f));
B = [0 1 0; 0 1 0; 0 1 0];
for r=2:(R-1)
    for c=2:(C-1)
    A = f(r-1:r+1,c-1:c+1);
    if (sum(sum(A & B))>=1);
        f1(r,c) = true;
    else
        f1(r,c) = false;
    end
    end
end
figure; imshow(f1); title('Dilation Output with 3x3 matrix with 1s along center column');

f1 = false(size(f));
B = ones(7);
for r=4:(R-3)
    for c=4:(C-3)
    A = f(r-3:r+3,c-3:c+3);
    if (sum(sum(A & B))>=1);
        f1(r,c) = true;
    else
        f1(r,c) = false;
    end
    end
end
figure; imshow(f1); title('Dilation Output with 7x7 matrix with all 1s');
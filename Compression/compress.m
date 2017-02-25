f = 100 .* ones(8,8);
U = dctmtx(8);
figure; imagesc(U*f*U'); title('Visualization of DCT of 8x8 matrix of 100s');
f = rand(8,8)*255;
figure; imagesc(U*f*U'); title('Visualization of DCT of 8x8 matrix of random values between 0 and 255');
f = imread('input.png');
[R,C] = size(f);
g = zeros(R,C);
w = 8;
for i=1:w:C
    for j=1:w:R
        if((j+w-1)<=R && (i+w-1)<=C)
            g(j:j+w-1,i:i+w-1) = U * double(f(j:j+w-1,i:i+w-1)) * U';
        end
    end
end
figure; imagesc(g); title('Visualization of DCT of input.png');
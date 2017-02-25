function A = zeropadding(f,wi)
[r, c] = size(f);
A = zeros(r + floor(wi/2)*2, c + floor(wi/2)*2);
for x = floor(wi/2)+1 : r + 1
    for y = floor(wi/2)+1 : c + 1
        A(x,y) = f(x - 1, y - 1);
    end
end
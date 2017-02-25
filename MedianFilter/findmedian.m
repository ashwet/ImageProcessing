function [m, duration]=findmedian(A)
tic;
A=sort(A,2);
[r,c]=size(A);

if(mod(c,2)==0)
    m = (A(1,c/2)+A(1,c/2+1))/2;
else
    m = A(1,(c+1)/2);
end
duration = toc;
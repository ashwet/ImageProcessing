I = imread('input.png');
region = ones(size(I));
proclist = [1];
threshold=20;
region_num=1;
while numel(proclist)~=0
   r = proclist(1);
    proclist = [proclist(2:end)];
    [R, C] = find(region==r);
    h =  std2(double(I(R(1):R(end),C(1):C(end))));
    if(h>threshold)
        [R, C] = find(region==r);
        X = uint16(R(1));
        Y = uint16(C(1));
        X_e = uint16(R(end));
        Y_e = uint16(C(end));
        if (isempty(region(X:(X+X_e)/2,Y:(Y+Y_e)/2)) ~=1 && sum( size(region(X:(X+X_e)/2,Y:(Y+Y_e)/2)) ~= size(region(X:X_e,Y:Y_e)) )~=0)
            region_num = region_num + 1;
            region(X:(X+X_e)/2,Y:(Y+Y_e)/2) = region_num;
            proclist = [proclist region_num];
        end
        if (isempty(region(X:(X+X_e)/2,(Y+Y_e)/2+1:Y_e)) ~=1 && sum( size(region(X:(X+X_e)/2,(Y+Y_e)/2+1:Y_e)) ~= size(region(X:X_e,Y:Y_e)) )~=0)
            region_num = region_num+1;
            region(X:(X+X_e)/2,(Y+Y_e)/2+1:Y_e) = region_num;
            proclist = [proclist region_num];
        end
        if (isempty(region((X+X_e)/2+1:X_e,Y:(Y+Y_e)/2)) ~=1 && sum( size(region((X+X_e)/2+1:X_e,Y:(Y+Y_e)/2)) ~= size(region(X:X_e,Y:Y_e)) )~=0)
            region_num = region_num+1;
            region((X+X_e)/2+1:X_e,Y:(Y+Y_e)/2) = region_num;
            proclist = [proclist region_num];
        end
        if (isempty(region((X+X_e)/2+1:X_e,(Y+Y_e)/2+1:Y_e)) ~=1 && sum( size(region((X+X_e)/2+1:X_e,(Y+Y_e)/2+1:Y_e)) ~= size(region(X:X_e,Y:Y_e)) )~=0)
            region_num = region_num+1;
            region((X+X_e)/2+1:X_e,(Y+Y_e)/2+1:Y_e) = region_num;
            proclist = [proclist region_num];
        end
    end
end
visualize_sp(I,region);

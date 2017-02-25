function [r,c] = i_spy ( object_im, big_im, x )

% note that this implementation does not use variable "x"

Ro = size(object_im, 1);
Co = size(object_im, 2);

Rb = size(big_im, 1);
Cb = size(big_im, 2);

size_im = size(big_im, 1);

o_im = int16(rgb2gray(object_im));
b_im = int16(rgb2gray(big_im));

if size_im <= 481
    step = 23;
    for r = 1 : Rb - (Ro-1)
        for c = 1 : Cb - (Co-1)
            diff_val = b_im(r:step:r+(Ro-1), c:step:c+(Co-1)) - o_im(1:step:end,1:step:end); 
            if ( sum ( abs ( diff_val(:)) ) == 0 )
                return;
            end
        end
    end
elseif (size_im >= 482) && (size_im <= 760)  
    step = 47;
    for r = 1 : Rb - (Ro-1)
        for c = 1 : Cb - (Co-1)
            diff_val = b_im(r:step:r+(Ro-1), c:step:c+(Co-1)) - o_im(1:step:end,1:step:end); 
            if ( sum ( abs ( diff_val(:)) ) == 0 )
                return;
            end
        end
    end
else
    step = 56;
    for r = 110 : ((Rb-50) - (Ro-1))
        for c = 70 : ((Cb-70) - (Co-1))
        diff_val = b_im(r:step:r+(Ro-1), c:step:c+(Co-1)) - o_im(1:step:end,1:step:end); 
            if ( sum ( abs ( diff_val(:)) ) == 0 )
                return;
            end
        end
    end
end
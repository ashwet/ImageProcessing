function [ct] = test_how_many ( prefix, ct_f, num_f )
%prefix - name of video folder
%ct_f - vector of frames used for grading
%num_f - number of frames

%i is an array of integers from 1 to the number of frames
i = [1:num_f];

%load an image
fn = sprintf ( '%sFRM_%05d.png%', prefix, i);
img = imread ( fn );

%Some random numbers get returned
for x=1:numel(ct_f)
    ct(x) = randi(99)+1;
end
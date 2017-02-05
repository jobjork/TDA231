function [arr] = var_array(data,im,dig)
data_scale=data(:,im,dig)/255; % Scaling the pixels to range [0,1]

arr=zeros(32,1);
for i=1:32
    arr(i,1)=var(data_scale(i:(i+15))); % Variance of each row and column of an image
end

end
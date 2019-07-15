function [ output_args ] = untitled3( input_args )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

ImOr=double(rgb2gray(imread('rm_rodilla.jpg')))/255;
% ImOr=double(imread('cameraman.tif'))/255;

Tempx=[-1,0,1;-2,0,2;-1,0,1]/4;
Tempy=[-1,-2,-1;0,0,0;1,2,1]/4;
Gx=imfilter(ImOr,Tempx);
Gy=imfilter(ImOr,Tempy);
G=sqrt((Gx.^2)+(Gy.^2));
imshow((G));

B=edge(ImOr,'sobel');
figure (2), imshow(B);

end


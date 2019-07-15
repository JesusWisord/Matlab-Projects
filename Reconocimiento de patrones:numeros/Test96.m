Im1=double(imread('test96.bmp'));
Im1=imbinarize(Im1);
h=[0,1,0;1,1,1;0,1,0];
Im1=imerode(Im1,h);
Im1=imopen(Im1,h);



[whiteMatrix, n]=bwlabel(Im1);
Im2=not(Im1);
[blackMatrix, n2]=bwlabel(Im2);
figure(1), imshow(whiteMatrix)
whiteProperties=regionprops(whiteMatrix,'all');
whiteProperties(1)=[];
blackProperties=regionprops(blackMatrix,'all');
resultsNine=(whiteMatrix*0)+1;
resultsSix=(whiteMatrix*0)+1;

for n=1:size(blackProperties,1)
    rectangle('Position',blackProperties(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end

for n=1:size(whiteProperties,1)
    rectangle('Position',whiteProperties(n).BoundingBox,'EdgeColor','b','LineWidth',2)
end

s=find([blackProperties.Area]<1200);
bw=Im1;
for n=1:size(s,2)
    d=round(blackProperties(s(n)).BoundingBox);
    bw(d(2):d(2)+d(4),d(1):d(1)+d(3))=1;
end

imshow(bw);
Im1=bw;
[whiteMatrix, n]=bwlabel(Im1);
Im2=not(Im1);
[blackMatrix, n2]=bwlabel(Im2);
figure(1), imshow(whiteMatrix)
whiteProperties=regionprops(whiteMatrix,'all');
whiteProperties(1)=[];
blackProperties=regionprops(blackMatrix,'all');
resultsNine=(whiteMatrix*0)+1;
resultsSix=(whiteMatrix*0)+1;

for n=1:size(blackProperties,1)
    rectangle('Position',blackProperties(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end

for n=1:size(whiteProperties,1)
    rectangle('Position',whiteProperties(n).BoundingBox,'EdgeColor','b','LineWidth',2)
end

for aux=1:size(blackProperties,1)
CentroidBlack(aux,1)=blackProperties(aux).Centroid(1);
CentroidBlack(aux,2)=blackProperties(aux).Centroid(2);
CentroidBlack(aux,3)=blackProperties(aux).BoundingBox(1);
CentroidBlack(aux,4)=blackProperties(aux).BoundingBox(2);
CentroidBlack(aux,5)=blackProperties(aux).BoundingBox(3);
CentroidBlack(aux,6)=blackProperties(aux).BoundingBox(4);
end

for aux=1:size(whiteProperties,1)
CentroidWhite(aux,1)=whiteProperties(aux).Centroid(1);
CentroidWhite(aux,2)=whiteProperties(aux).Centroid(2);
CentroidWhite(aux,3)=whiteProperties(aux).BoundingBox(1);
CentroidWhite(aux,4)=whiteProperties(aux).BoundingBox(2);
CentroidWhite(aux,5)=whiteProperties(aux).BoundingBox(3);
CentroidWhite(aux,6)=whiteProperties(aux).BoundingBox(4);
CentroidWhite(aux,7)=whiteProperties(aux).Area;
end

[Black,k] = sort(CentroidBlack(:,1));
Black = [Black CentroidBlack(k,2)  CentroidBlack(k,3) CentroidBlack(k,4) CentroidBlack(k,5) CentroidBlack(k,6)];

[White,k] = sort(CentroidWhite(:,1));
White = [White CentroidWhite(k,2) CentroidWhite(k,3) CentroidWhite(k,4) CentroidWhite(k,5) CentroidWhite(k,6)];

for n=1:size(CentroidWhite,1)
%     rectangle('Position',blackProperties(n).BoundingBox,'EdgeColor','g','LineWidth',2)
%     rectangle('Position',whiteProperties(n).BoundingBox,'EdgeColor','b','LineWidth',2)
    hold on
    blackX=Black(n,1);
    blackY=Black(n,2);
    plot(blackX,blackY,'*');
    whiteX=White(n,1);
    whiteY=White(n,2);
    plot(whiteX,whiteY,'o');
    d=round(Black(n,:));
    auxS=2;
    if (blackY > whiteY) 
        resultsNine(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3))=Im1(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3));
    else if (blackY < whiteY) 
        resultsSix(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3))=Im1(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3));
        else 
        resultsElse(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3))=Im1(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3));  
        end
    end

end
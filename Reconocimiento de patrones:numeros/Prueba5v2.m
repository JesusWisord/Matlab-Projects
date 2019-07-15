clear all, close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Prueba de Patrones por Extrema %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Im1=double(imread('test96.bmp'));

Im1=imbinarize(Im1);
h=[0,1,0;1,1,1;0,1,0];
Im1=imerode(Im1,h);
Im1=imopen(Im1,h);
upper=zeros(1,80);
down=zeros(1,80);
left=upper;
right=upper;
results=(Im1*0)+1;
results2=results;
results3=results;

[whiteMatrix, n]=bwlabel(Im1);
Im2=not(Im1);
[blackMatrix, n2]=bwlabel(Im2);
h=figure(1), imshow(whiteMatrix)
whiteProperties=regionprops(whiteMatrix,'all');
whiteProperties(1)=[];
blackProperties=regionprops(blackMatrix,'all');
results=(whiteMatrix*0)+1;
hold on
phi = linspace(0,2*pi,50);
cosphi = cos(phi);
sinphi = sin(phi);

for k = 1:length(blackProperties)
    x=blackProperties(k).Extrema(:,1);
    y=blackProperties(k).Extrema(:,2);
    plot(x,y,'*');
    rectangle('Position', blackProperties(k).BoundingBox,'EdgeColor','g','LineWidth',2)
    centerX=blackProperties(k).Centroid(1);
    centerY=blackProperties(k).Centroid(2);
    plot(centerX,centerY,'o');
    lengthX=blackProperties(k).BoundingBox(3);
    lengthY=blackProperties(k).BoundingBox(4);
    line ([centerX-round(lengthX/2) centerX+round(lengthX/2)],[centerY centerY], 'color', 'magenta', 'marker', 'p', 'LineStyle', '-.')
    line ([centerX centerX],[centerY-round(lengthY/2) centerY+round(lengthY/2)], 'color', 'magenta', 'marker', 'p', 'LineStyle', '-.')
    for c=1:8
        if x(c) >= centerX
            upper(k)=upper(k)+1;
        else
            down(k)=down(k)+1;
        end
        if y(c) >= centerY
            right(k)=right(k)+1;
        else
            left(k)=left(k)+1;
        end
    end
end


saveas(h,'Recuadros con Ejes.jpg','jpg')

for c=1:length(blackProperties)
    d=round(blackProperties(c).BoundingBox);
    auxS=0;
    if down(c) > upper (c)
        results(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3))=Im1(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3));
    else if down(c) < upper (c)
        results2(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3))=Im1(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3));
        else if right(c) > left(c)
                results2(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3))=Im1(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3));
            else if right(c) < left(c)
                    results(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3))=Im1(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3));
                else
                    results3(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3))=Im1(d(auxS+2):d(auxS+2)+d(auxS+4),d(auxS+1):d(auxS+1)+d(auxS+3));
                end
            end 
        end
    end
end

figure(1), imshow(results)
figure(2), imshow(results2)
figure(3), imshow(results3)



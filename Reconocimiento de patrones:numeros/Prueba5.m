clear all, close all
Im1=double(imread('testTY1.jpg'));
Im1=imbinarize(Im1);
h=[1,1,1;1,1,1;0,1,0];
Im1=imerode(Im1,h);
Im1=imopen(Im1,h);
Im1=imerode(Im1,h);
Im1=imopen(Im1,h);
Im2=not(Im1);
[blackMatrix, n2]=bwlabel(Im2);
figure(1), imshow(Im1)
blackProperties=regionprops(blackMatrix,'all');
resultsT=(blackMatrix*0)+1;
resultsY=(blackMatrix*0)+1;
resultselse=(blackMatrix*0)+1;
upper=zeros(1,size(blackProperties,1));
down=upper
left=upper;
right=upper;

hold on
for k=1:size(blackProperties,1)
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

for k=1:size(blackProperties)
    z(k)=blackProperties(k).EquivDiameter;
    y(k)=blackProperties(k).MinorAxisLength;
    x(k)=blackProperties(k).Eccentricity;
end

figure
plot(x,y,'o')
pause

for k=1:size(blackProperties)
    d=round(blackProperties(k).BoundingBox);
    if (d(1)+d(3)>713)
        d(3)=d(3)-1;
    end
    if upper(k)==down(k) && left(k)==right(k)
        resultselse(d(2):d(2)+d(4),d(1):d(1)+d(3))=Im1(d(2):d(2)+d(4),d(1):d(1)+d(3));
    else if x(k) > .80
            resultsT(d(2):d(2)+d(4),d(1):d(1)+d(3))=Im1(d(2):d(2)+d(4),d(1):d(1)+d(3));
        else 
            resultsY(d(2):d(2)+d(4),d(1):d(1)+d(3))=Im1(d(2):d(2)+d(4),d(1):d(1)+d(3));
        end
    end
end


% for k=1:size(blackProperties)
%     d=round(blackProperties(k).BoundingBox);
%     if (d(1)+d(3)>713)
%         d(3)=d(3)-1;
%     end
%     if x(k) < .77 && x(k) > .66
%         resultsY(d(2):d(2)+d(4),d(1):d(1)+d(3))=Im1(d(2):d(2)+d(4),d(1):d(1)+d(3));
%     else if x(k) > .77 && x(k) < .86
%             resultsT(d(2):d(2)+d(4),d(1):d(1)+d(3))=Im1(d(2):d(2)+d(4),d(1):d(1)+d(3));
%         else 
%             resulstelse(d(2):d(2)+d(4),d(1):d(1)+d(3))=Im1(d(2):d(2)+d(4),d(1):d(1)+d(3));
%         end
%     end
% end

figure
imshow(resultsY)
figure
imshow(resultsT)
figure
imshow(resultselse)

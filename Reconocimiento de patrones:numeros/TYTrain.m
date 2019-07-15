clear all, close all
Im1=double(imread('testTY1.jpg'));
Im1=imbinarize(Im1);
h=[1,1,1;1,1,1;1,1,1];
Im1=imerode(Im1,h);
Im1=imerode(Im1,h);
Im1=imopen(Im1,h);
Im2=not(Im1);
[blackMatrix, n2]=bwlabel(Im2);
h= figure(1), imshow(Im1)
blackProperties=regionprops(blackMatrix,'all');
resultsT=(blackMatrix*0)+1;
resultsY=(blackMatrix*0)+1;
resultselse=(blackMatrix*0)+1;
upper=zeros(1,size(blackProperties,1));
down=upper;
left=upper;
right=upper;
p1=upper;
p2=p1;
p3=p1;
p4=p1;
hold on

phi = linspace(0,2*pi,50);
cosphi = cos(phi);
sinphi = sin(phi);

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
        xbar = blackProperties(k).Centroid(1);
    ybar = blackProperties(k).Centroid(2);

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

    a = blackProperties(k).MajorAxisLength/2;
    b = blackProperties(k).MinorAxisLength/2;

    theta = pi*blackProperties(k).Orientation/180;
    R = [ cos(theta)   sin(theta)
         -sin(theta)   cos(theta)];

    xy = [a*cosphi; b*sinphi];
    xy = R*xy;

    xx = xy(1,:) + xbar;
    yx = xy(2,:) + ybar;

    plot(xx,yx,'r','LineWidth',2);

end

saveas(h,'Matriz de Prueba.jpg','jpg');

x=0; y=0; z=0;
for k=1:size(blackProperties,1)
    x(k)=blackProperties(k).MajorAxisLength;
    y(k)=blackProperties(k).MinorAxisLength;
    z(k)=blackProperties(k).Eccentricity;
end


figure
plot (x,y,'o')

pause


for n=1:size(blackProperties,1)
%     rectangle('Position',blackProperties(n).BoundingBox,'EdgeColor','g','LineWidth',2)
    majorX=blackProperties(n).MajorAxisLength
    minorX=blackProperties(n).MinorAxisLength
    Exx=blackProperties(n).Eccentricity

    d=round(blackProperties(n).BoundingBox);
    if (d(1)+d(3)>713)
        d(3)=d(3)-1;
    end
    extent=blackProperties(n).Extent;
    eccent=blackProperties(n).Eccentricity
    if extent > .46
        resultselse(d(2):d(2)+d(4),d(1):d(1)+d(3))=Im1(d(2):d(2)+d(4),d(1):d(1)+d(3));
    else
        if eccent < .79 && eccent > .65 %|| extent < .36
        resultsY(d(2):d(2)+d(4),d(1):d(1)+d(3))=Im1(d(2):d(2)+d(4),d(1):d(1)+d(3));
        else if eccent >= .80 && eccent < .90 %|| extent > .36 && extent < .46
            resultsT(d(2):d(2)+d(4),d(1):d(1)+d(3))=Im1(d(2):d(2)+d(4),d(1):d(1)+d(3));
        else
            resultselse(d(2):d(2)+d(4),d(1):d(1)+d(3))=Im1(d(2):d(2)+d(4),d(1):d(1)+d(3));
        end
    end
    end
end
% hold on

figure(1), imshow(resultsY)
figure(2), imshow(resultsT)
figure(3), imshow(resultselse)

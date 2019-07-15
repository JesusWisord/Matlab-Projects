function [ Lrgb ] = untitled2( I )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    %Lo primero que hay que hacer con este metodo es detectar bordes en la
    %imagen con un filtro sobel
    hy = fspecial('sobel');
    hx = hy';
    Iy = imfilter(double(I), hy, 'replicate');
    Ix = imfilter(double(I), hx, 'replicate');
    gradmag = sqrt(Ix.^2 + Iy.^2);
    figure
    imshow(gradmag,[]), title('Gradient magnitude (gradmag)')
    imwrite(gradmag,'Filtro sobel.jpg', 'jpg');
    pause;
    L = watershed(gradmag);
    Lrgb = label2rgb(L);
    figure, imshow(Lrgb), title('Watershed transform of gradient magnitude (Lrgb)')
    imwrite(Lrgb,'Sobresegementeo.jpg', 'jpg');
    %Despues necesitamos encontrar los marcadores del primer plano. Para
    %esto necesitamos aplicar una apertura y cerradura por reconstrucci?n
    %ya que las funciones de apertura y cerradura simples no son
    %suficientes.    
    se = strel('disk', 20); %Creamos el elemento estructural
    %Aqui mostramos la apertura normal
    Io = imopen(I, se);
    figure
    imshow(Io), title('Opening (Io)')
    imwrite(Io,'Apertura normal.jpg', 'jpg');
    pause;
    %Aqui aplicamos la apertura por reconstruccion
    Ie = imerode(I, se); %Primero erosionamos
    Iobr = imreconstruct(Ie, I); %Aplicamos la reconstruccion
    figure
    imshow(Iobr), title('Opening-by-reconstruction (Iobr)')
    imwrite(Iobr,'Apertura por reconstruccion.jpg', 'jpg');
    pause;
    %Hacer una cerradura despu?s de la apertura nos puede permitir eliminar
    %puntos negros y otras cosas que no permiten una correcta segmentacion
    Ioc = imclose(Io, se); %Primero comprobamos una cerradura normal
    figure
    imshow(Ioc), title('Opening-closing (Ioc)')
    imwrite(Ioc,'Apertura-cerradura normal.jpg', 'jpg');
    pause;
    %Ahora aplicamos la cerradura por reconstruccion para crear una
    %apertura-cerradura por reconstruccion
    Iobrd = imdilate(Iobr, se);%Primero dilatamos
    %Aplicamos reconstruccion con los complementos de de la dilatacion de
    %la apertura por reconstrucci?n junto con la simple apertura por
    %reconstrucci?n
    Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
    %Se busca el complemento y se muestra
    Iobrcbr = imcomplement(Iobrcbr);
    figure
    imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)')
    imwrite(Iobrcbr,'Apertura-cerradura por reconstruccion.jpg', 'jpg');
    pause;
    %Finalizamos buscando el maximo regional en nuestra imagen, esto nos
    %permitira encontrar los marcadores para el primer plano de la imagen
    fgm = imregionalmax(Iobrcbr);
    figure
    imshow(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)')
    imwrite(fgm,'Regional Maxima de la apertura-cerradura por reconstruccion.jpg', 'jpg');
    pause;
    %Para apreciar mejor el resultado superpondremos el marcador de primer
    %plano con la imagen original
    I2 = I;
    I2(fgm) = 255;
    figure
    imshow(I2), title('Regional maxima superimposed on original image (I2)')
    imwrite(I2,'Regional maximo superpuesto a imagen original.jpg', 'jpg');
    pause;
    %Los marcadores se suavizan y delimitan un poco mas con una cerradura y
    %erosion simple
    se2 = strel(ones(5,5));
    fgm2 = imclose(fgm, se2);
    fgm3 = imerode(fgm2, se2);
    %Este proceso suele dejar pixeles solitarios dispersos en ciertas areas
    %de la imagen que puede corregirse con el comando bwareaopen. El
    %comando elimina burbujas de pixeles que esten por debajo de cierto
    %numero de pixeles por grupo. Volvemos a mostrar la imagen ya corregida
    fgm4 = bwareaopen(fgm3, 20);
    I3 = I;
    I3(fgm4) = 255;
    figure
    imshow(I3)
    title('Modified regional maxima superimposed on original image (fgm4)')
    imwrite(I3,'Maxima Regional modificada y superpuesta.jpg', 'jpg');
    pause;
    %Gracias a nuestra imagen anterior podemos saber que todo pixel oscuro
    %pertence al fondo por lo que utilizaremos esa imagen para binarizar
    bw = im2bw(Iobrcbr);
    figure
    imshow(bw), title('Thresholded opening-closing by reconstruction (bw)')
    imwrite(bw,'Binarizacion.jpg', 'jpg');
    pause;
    %Los pixeles negros representan el fondo pero no queremos que estos
    %pixeles esten tan cerca de los bordes de nuestros objetos que tratamos
    %de segmentar. Trataremos de "adelgazar" el fondo mediante el siguiente
    %metodo
    D = bwdist(bw); %Conseguimos una distancia euclidiana de nuestra imagen
    %binarizada
    DL = watershed(D); %Aplicamos watershed
    bgm = DL == 0; %Buscamos las lineas cresta con esta condici?n
    figure %Mostramos el resultado
    imshow(bgm), title('Watershed ridge lines (bgm)') 
    imwrite(bgm,'Lineas Cresta Watershed.jpg', 'jpg');
    pause;
    %Con este comando se busca el que el minimo y maximo de region ocurran
    %en ciertas areas de la imagen, en este caso queremos el minimo en el
    %fondo y el m?ximo en los marcadores de primer plano
    gradmag2 = imimposemin(gradmag, bgm | fgm4);
    %Podemos aplicar ahora la segmentaci?n de Watershed
    L = watershed(gradmag2);
    %Aqui se aplica una dilatacion para lograr que nuestros marcadores se
    %expandan hasta llegar a las lineas encontradas
    I4 = I;
    I4(imdilate(L == 0, ones(3, 3)) | bgm | fgm4) = 255;
    figure
    imshow(I4)
    title('Markers and object boundaries superimposed on original image (I4)')
    imwrite(I4,'Marcadores y objetos superpuestos en original.jpg', 'jpg');
    pause;
    %Asignamos un falso color a cada segmento mediante una etiqueta.
    Lrgb = label2rgb(L, 'jet', 'w', 'shuffle');
    figure
    imshow(Lrgb)
    title('Colored watershed label matrix (Lrgb)')
    imwrite(Lrgb,'Matriz etiquetada.jpg', 'jpg');
    pause;
    %Por ultimo mostramos la imagen etiquetada superpuesta con la original
    f=figure
    imshow(I)
    hold on
    himage = imshow(Lrgb);
    himage.AlphaData = 0.3;
    title('Lrgb superimposed transparently on original image')
    saveas(f,'Imagen etiquetada superpuescloseta con original.jpg','jpg');

end


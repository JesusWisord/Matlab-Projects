    
%     %Leemos nuestra imagen DICOM
%     img=dicomread('brain_014.dcm');
%     %Le damos un formato doble a nuestra imagen con im2double y luego le
%     %damos un ajuste
%     imgp1=im2double(img);
%     imgp1=imadjust(imgp1);
%     %Multiplicamos pixel por pixel nuestra matriz
%     imgp1=imgp1.*255;
%     imgp1=uint8(imgp1);
%     imwrite(imgp1,'brain_014.jpg','jpg');
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Para el segundo semilleo tomamos las coordenadas que nos mencionan en
    %la practica y creamos una segunda funcion que nos procese la tecnica
    %de semilla por vecino de la region
    %Nuestras coordenadas en imagen son 492,473 por lo que en matriz las
    %invertiremos para lograr hallar el pixel de partida
    xActual=473;
    yActual=492;
    %Nuestros incrementos iniciaran en 0
    xInc=0;
    yInc=0;
    %Creamos una condicion logica para poder repetir el semilleo hasta que
    %ya no se encuentre ningun pixel en nuestro rango
    condicion=true;
    
    %Leemos nuestra imagen y creamos las imagenes necesarias para que
    %nuestro ciclo pueda trabajar
    img_b1=imread('mdb063.pgm');
    img_b2=img_b1;
    img_b3=img_b2*0;
    imwrite(img_b2,'semilleo 2.jpg','jpg');
    imwrite(img_b3,'Imagen Final Semilleo 2.jpg','jpg');
    
    
    
    while condicion
        %Se llama a la funcion de semilleo mientras nuestra condicion sea
        %verdadera
        [condicion,xActual,yActual,xInc,yInc, img3]=semilleo2(xActual,yActual,xInc,yInc);
    end
    
    
    
    
    
    
    
    
    
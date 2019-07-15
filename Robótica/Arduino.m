function [] = Arduino(output)


        %borrar previos
        delete(instrfind({'Port'},{'/dev/cu.usbmodem14201'}));
        %crear objeto serie
        s = serial('/dev/cu.usbmodem14201','Baudrate', 9600);
        warning('off','MATLAB:serial:fscanf:unsuccessfulRead');
        %abrir puerto
        fopen(s)
        fprintf(s,'%s',mat2str(output))
        
        out=fscanf(s)
        
        fclose(s)
        delete(s)
        clear s


end
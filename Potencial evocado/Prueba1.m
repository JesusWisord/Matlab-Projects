load('vep.mat');

for z=1:10
    
    Canal=EEG(z,:);
    Fs=512;
    back=round(200*(512/1000));
    front=round(250*(512/1000));
    ventana=zeros(size(stim_times,2),231);


    for n=1:size(stim_times,2)
        begin=stim_times(n)-back;
        for x=1:231
            ventana(n,x)=Canal(begin+x-1);
        end
    end

    h = figure(1)
    plot(Canal)
    title(sprintf('Canal %d',z));
    xlabel('Tiempo (ms)');
    ylabel('Voltaje (mV)');
    saveas(h,sprintf('Canal %d.png',z))
    
    
    

    prom=mean(ventana);

    h=figure(2)
    plot(ventana(1,:))
    title(sprintf('Ventana 1'));
    xlabel('Tiempo (ms)');
    ylabel('Voltaje (mV)');
    saveas(h,sprintf('Ventana 1.png'))
    

    figure(3)
    t=-back:front;
    t=t/(512*100);
    plot(t,prom,'blue')
    hold on
    x=[0, 0]
    y=[-20,50]
    plot(x,y,'red')
    title(sprintf('Promedio de Ventanas de Canal %d',z));
    xlabel('Tiempo (ms)');
    ylabel('Voltaje (mV)');
    %saveas(h,sprintf('Promediado de Ventana %d.png',z))
    %axis([-200,250,-10,25]);
    hold off

    prom2=prom;
    for n=1:back

       noise(n)=prom2(n);
       prom2(n)=0;

    end

    noise=mean(noise);
    prom2=prom2-noise;
    vmax=find(prom2==max(prom2));
    vmin=find(prom2==min(prom2(1:200)));

    h= figure(4)
    plot(t,prom2,'blue')
    hold on
    %y=[-60,80]
    plot(x,y,'red')
    
    plot(t(vmin),prom2(vmin),'o');
    plot(t(vmax),prom2(vmax),'o');
    title(sprintf('Promediado de Ventanas filtrado del Canal %d',z));
    xlabel('Tiempo (ms)');
    ylabel('Voltaje (mV)');
    %saveas(h,sprintf('Promediado filtrado %d.png',z))
    hold off
    pause
end
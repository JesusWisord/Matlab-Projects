%Se grafican los valores de Peso vs RMS o Peso vs AUC. Es necesario haber
%ejecutado RMS y Prueba2 antes.

h=plot(Peso,RMSBiceps)
xlabel('Peso (Kg)')
ylabel('RMS')
saveas(h,'PesovsRMSBiceps.png','png')

h=plot(Peso,RMSTriceps)
xlabel('Peso (Kg)')
ylabel('RMS')
saveas(h,'PesovsRMSTriceps.png','png')

h=plot(Peso,AUCBiceps)
xlabel('Peso (Kg)')
ylabel('AUC')
saveas(h,'PesovsAUCBiceps.png','png')

h=plot(Peso,AUCTriceps)
xlabel('Peso (Kg)')
ylabel('AUC')
saveas(h,'PesovsAUCTriceps.png','png')


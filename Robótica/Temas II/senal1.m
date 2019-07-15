clear all
close all 
clc
[signal, states, parameters, total_samples, file_samples]...
 =load_bcidat ('c:\Users\Catha\Desktop\Practica\LPS\LPS001\LPSS001R02.dat');
k=find(states.StimulusCode,7, 'first');
v1=k-51; 
v2=k+102;
k2=find (states.StimulusCode,3, 'first');


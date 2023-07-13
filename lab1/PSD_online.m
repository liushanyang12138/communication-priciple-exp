
clear; 
Fs=1000; %����Ƶ�� 
n=0:1/Fs:1; 
carrier=cos(2*pi*100*n);
x=sqrt(2)*cos(2*pi*10*n).*carrier;       %DSB����
 
%������������������ 
xn=x %+3*cos(2*pi*100*n)+randn(size(n)); 
window=boxcar(length(xn)); %���δ� 
nfft=1024; 
[Pxx,f]=periodogram(xn,window,nfft,Fs); %ֱ�ӷ� 
plot(f,Pxx);
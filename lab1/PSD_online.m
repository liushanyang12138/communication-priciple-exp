
clear; 
Fs=1000; %采样频率 
n=0:1/Fs:1; 
carrier=cos(2*pi*100*n);
x=sqrt(2)*cos(2*pi*10*n).*carrier;       %DSB调制
 
%产生含有噪声的序列 
xn=x %+3*cos(2*pi*100*n)+randn(size(n)); 
window=boxcar(length(xn)); %矩形窗 
nfft=1024; 
[Pxx,f]=periodogram(xn,window,nfft,Fs); %直接法 
plot(f,Pxx);
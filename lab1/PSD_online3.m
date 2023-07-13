clear all;
fs = 1000;
t = 0:1/fs:1-1/fs;
x = cos(2*pi*50*t); 
N = length(x);
freq = 0:fs/length(x):fs/2;
periodogram(x,rectwin(N),N,fs);  %ans
%plot(freq,ans)  % 这个是正常的幅值表示
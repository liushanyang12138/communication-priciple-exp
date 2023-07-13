t=0:0.001:0.6;a=length(t)
x=sin(2*pi*60*t)  %+sin(2*pi*150*t)+2*randn(size(t));
plot(1000*t(1:400),x(1:400))
title('signal of randn noise')
xlabel('time(ms)')
ylabel('rad')
grid on;
y=fft(x,a);
psd=y.*conj(y)/a;%Ë«±ß¹¦ÂÊÆ×ÃÜ¶È
f=1000*(1:a)/a;
figure;
plot(f,psd(1:a))
title('psd of the signal')
xlabel('frequency(HZ)')
ylabel('rad^2/hz')
grid on;
clear all;
t=linspace(0,0.6,1024);
A=3;
mt=0.5*cos(40*pi*t);

subplot(2,2,1);
plot(t,mt);
xlabel('t');
ylabel('幅值');
title('经过AWGN信道之前的信号的波形图');

subplot(2,2,2);
[f,sf]=T2F(t,mt);
plot(f,abs(sf));grid;
xlabel('f/Hz')
ylabel('幅值');
title('经过AWGN信道之前的信号的频谱图');
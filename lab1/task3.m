
clear all;
t=linspace(0,0.6,1024);
x=0.4*sin(100*pi*t)+0.4*sin(640*pi*t)+randn(1,length(t));  %信号加上 （0，1）的高斯白噪声   +randn(1,length(t))

subplot(2,1,1);
plot(t,x);grid;
xlabel('t/s')
ylabel('x(t)+u（n）');
title('波形图')

subplot(2,1,2);
[f,sf]=T2F(t,x);     %进行时域到频域的转换
plot(f,abs(sf));grid;
xlabel('f/Hz')
ylabel('幅值');
title('频谱图')
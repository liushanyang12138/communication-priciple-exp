clear all;
t=linspace(0,0.6,1024);
A=3;
mt=0.1*cos(15*pi*t)+1.5*sin(25*pi*t)+0.5*cos(40*pi*t);
carrier=cos(250*pi*t);

power1=5.1275;   %s(t) 的功率
power2=10;          %s'(t)的功率，这是经过增益的功率
G=sqrt(power2/power1)   %信号的增益
st=G*(A+mt).*carrier;  %最后信号的表达式

subplot(2,2,1);
plot(t,st);
xlabel('t');
ylabel('幅值');
title('经过AWGN信道之前的信号的波形图');


subplot(2,2,2);
[f,sf]=T2F(t,st);    % 时域和频域的转换
plot(f,abs(sf));grid;
xlabel('f/Hz')
ylabel('幅值');
title('经过AWGN信道之前的信号的频谱图');



power_noise=1;   %题目给出的噪声
st2=st+sqrt(power_noise)*randn(1,length(t));       %经过信道之后，加上噪声的信号
subplot(2,2,3);
plot(t,st2);
xlabel('t');
ylabel('幅值');
title('经过AWGN信道之后的信号的波形图');

subplot(2,2,4);
[f,sf]=T2F(t,st2);  % 时域和频域的转换
plot(f,abs(sf));grid;
xlabel('f/Hz')
ylabel('幅值');
title('经过AWGN信道之后的信号的频谱图');


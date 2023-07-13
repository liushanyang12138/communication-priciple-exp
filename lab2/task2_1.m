clear all;
t=linspace(0,5,1024);
mt=cos(2*pi*t);
A=2;
fc=10;
fm=1.2;
carrier=cos(10*2*pi*t);
AM=(A+mt).*carrier;             %得到AM调制信号
subplot(4,1,1);
plot(t,AM);
xlabel('t/s');
title('AM已调信号的时域波形');

[f,sf]=T2F(t,AM);              %转换到频域
subplot(4,1,2);
plot(f,abs(sf));
axis([-30,30,-0.2,1.5]);
xlabel('f/Hz');
title('AM已调信号的频谱');

subplot(4,1,3);
fs=1024/5;
n0=0.01;
P=n0*fs/2;
AM_n=AM+sqrt(P).*randn(1,length(t));   %加上高斯白噪声
[f,sf]=T2F(t,AM_n);
[f,sf]=ideal_bandpassing(f,sf,fc-fm,fc+fm);   %经过带通滤波器

[t,st]=F2T(f,sf); 
st=st.*carrier;              %乘上载波

[f,sf]=T2F(t,st);
[f,sf]=ideal_bandpassing(f,sf,0,fm);   %经过低通滤波器
[t,st]=F2T(f,sf);   %得到时域的信号
plot(t,st-A/2);
axis([0,5,-1.2,1.2]);
xlabel('t/s');
title('AM相干解调后的时域波形');

subplot(4,1,4);
[f,sf]=T2F(t,st-A/2);
plot(f,abs(sf));
xlabel('f/Hz');
title('AM相干解调后的频域波形');
axis([-30,30,0,0.3]);
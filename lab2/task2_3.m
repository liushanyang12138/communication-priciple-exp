clear all ;
fm=20;
fc=100;
fh=25;  %(稍微比20Hz大一点)
T=1/fm;
t=linspace(0,5*T,1024);
dt=t(2)-t(1);
fs=1/dt;
Am=sqrt(2);
mt=sqrt(2)*cos(2*pi*20*t);  % 功率1，频率是20Hz
carrier=cos(2*pi*fc*t);
%使用相移法 得到单边带信号

%上边带
USB=0.5*Am*cos(2*pi*fm*t).*cos(2*pi*fc*t)-0.5*Am*sin(2*pi*fm*t).*sin(2*pi*fc*t);
subplot(3,2,1);
plot(t,USB);
xlabel('t/s');
ylabel('幅度');
axis([0,0.2,-1,1]);
title('SSB上边带信号的时域波形');

[f,sf]=T2F(t,USB);
subplot(3,2,2);
plot(f,abs(sf));
xlabel('f/Hz');
ylabel('幅度');
axis([-150,150,0,1]);
title('SSB上边带信号的频域波形');

%下边带
LSB=0.5*Am*cos(2*pi*fm*t).*cos(2*pi*fc*t)+0.5*Am*sin(2*pi*fm*t).*sin(2*pi*fc*t);
subplot(3,2,3);
plot(t,LSB);
xlabel('t/s');
ylabel('幅度');
axis([0,0.2,-1,1]);
title('SSB下边带信号的时域波形');

[f,sf]=T2F(t,LSB);
subplot(3,2,4);
plot(f,abs(sf));
xlabel('f/Hz');
ylabel('幅度');
axis([-150,150,0,1]);
title('SSB下边带信号的频域波形');

n0=0.001;
P=n0*fs/2;
USB_n=USB+sqrt(P).*randn(1,length(t));   %信道添加高斯白噪声
[f,sf]=T2F(t,USB_n);
[f,sf]=ideal_bandpassing(f,sf,fc,fc+fh);   %经过带通滤波器

[t,st]=F2T(f,sf); 
st=st.*carrier;     %乘上载波解调

[f,sf]=T2F(t,st);
[f,sf]=ideal_bandpassing(f,sf,0,fh);   %经过低通滤波器
[t,st]=F2T(f,sf);   %得到时域的信号
subplot(3,2,5);
% plot(t,mt/4);
% hold;
plot(t,st);
xlabel('t/s');
axis([0,0.2,-0.5,0.5]);
title('SSB(上边带)相干解调后的时域波形');

subplot(3,2,6);
plot(f,abs(sf));
xlabel('f/Hz');
title('SSB(上边带)相干解调后的频域波形');
axis([-100,100,0,0.2]);



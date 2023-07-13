clear all ;
f=10;
fc=100;
fh=15;  %(稍微比10Hz大一点)
T=1/f;
t=linspace(0,5*T,1024);
dt=t(2)-t(1);
fs=1/dt;
mt=sqrt(2)*cos(2*pi*10*t);  % 功率1，频率是10Hz
carrier=cos(2*pi*fc*t);
DSB=mt.*carrier;       %DSB调制
subplot(5,1,1);
plot(t,DSB);
xlabel('t/s');
ylabel('幅度');
title('时域波形图');

[f,sf]=T2F(t,DSB);   %频谱密度
subplot(5,1,2);
plot(f,abs(sf));
xlabel('f/Hz');
ylabel('幅度');
title('频谱图');
axis([-150,150,-0.02,0.5]);


N=length(t);    %功率谱密度
Y = fft(DSB,N)/N;% 
sf_psd=abs(Y).^2; 
f_psd = 1/dt*(0:(N-1)/2)/N;
subplot(5,1,3); 
plot(f_psd,2*sf_psd(1:((N-1)/2+1)));% 注意区间长度  
xlabel('f/Hz');
ylabel('PSD/J');
title('功率谱密度');
axis([0,200,-0.02,0.4]);


n0=0.001;
P=n0*fs/2;
DSB_n=DSB+sqrt(P).*randn(1,length(t));  %加上信道高斯白噪声
[f,sf]=T2F(t,DSB_n);
[f,sf]=ideal_bandpassing(f,sf,fc-fh,fc+fh);   %经过带通滤波器

[t,st]=F2T(f,sf); 
st=st.*carrier;      %乘上载波解调

[f,sf]=T2F(t,st);
[f,sf]=ideal_bandpassing(f,sf,0,fh);   %经过低通滤波器
[t,st]=F2T(f,sf);   %得到时域的信号
subplot(5,1,4);
plot(t,st);
xlabel('t/s');
ylabel('幅度');
title('DSB相干解调后的时域波形');

subplot(5,1,5);
plot(f,abs(sf));       %绘制信号的频域
xlabel('f/Hz');
ylabel('幅度');
title('DSB相干解调后的频域波形');
axis([-100,100,0,0.5]);

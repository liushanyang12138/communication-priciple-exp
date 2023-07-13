%求解功率谱密度
clear all 
dt=0.0001;
t = 0:dt:0.6; % 时域信号的时间范围 
x = cos(2*pi*50*t); % 余弦信号 
y = x %+randn(size(t)); % 余弦信号+噪声 x+randn(size(t));
subplot(2,1,1); 
plot(t(1:100),y(1:100)); 
title('0均值的随机信号')
xlabel('时间 (秒)') 
Nf=length(t); 
Y = fft(y,Nf)/Nf;% 求有限长（余弦+噪声）信号的傅里叶变换 
Pyy=abs(Y).^2; % 求傅里叶变换模平方的均值 
f = 1/dt*(0:(Nf-1)/2)/Nf;
subplot(2,1,2); 
plot(f,2*Pyy(1:((Nf-1)/2+1)));% 注意区间长度 
title('信号的单边功率谱密度'); 
xlabel('频率(Hz)')

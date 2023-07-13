%产生一个(0,1)上均匀分布的白噪声信号 
clear;% 清除内存中可能保留的 MATLAB 变量 
N=500000;%  的长度 
u=randn(1,N);% 调用 rand，得到均匀分布的随机数  
disp('均值')
u_mean=mean(u)% 求 均值 
disp('方差')
power_u=var(u)% 求 方差 
subplot(211) 
plot(u(1:200));
grid on;%在一个图上分上下两个子图 
ylabel('u(n) ');% 给y轴加坐标 
xlabel('n'); % 给x轴加坐标 
subplot(212) 
hist(u,50); % 对 做直方图，检验其分布，50 是对取值范围[0 1]均分等分 50 份
grid on;% 网格 
ylabel('histogram of u(n) ');

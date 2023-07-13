%产生均值为0、方差为1的高斯白噪声
clear;% 清除内存中可能保留的 MATLAB 变量 
N=100000;%  生成序列的长度的长度 
u=sqrt(0.1)*randn(1,N);%  randn：产生均值为0、方差为1的高斯白噪声，sqrt(0.1)使得方差减小到0.1倍
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
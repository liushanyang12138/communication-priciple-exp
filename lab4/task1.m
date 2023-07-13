clear all;
t=0:0.01:20;
%模拟生成连续信号
xt=cos(0.15*pi*t)+sin(2.5*pi*t)+cos(4*pi*t);
subplot(3,1,1);
plot(t,xt);
title('低通信号的波形');
%对信号已4Hz进行采样
t_=0:1/4:20;
xt_=cos(0.15*pi*t_)+sin(2.5*pi*t_)+cos(4*pi*t_);
subplot(3,1,2);
stem(t_,xt_);
title('fs=4Hz的抽样序列波形');
T=1/4;
x=zeros(1,2001);  
%通过插值重构得到原信号
for i=1:length(t_)
    x=x+xt_(i)*sinc((t-i*T+T)/T);
end 
subplot(3,1,3);
plot(t,x);
title('通过序列恢复的原始信号');
xlabel('t/s');
ylabel('U/V');



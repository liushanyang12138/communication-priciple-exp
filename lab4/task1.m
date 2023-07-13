clear all;
t=0:0.01:20;
%ģ�����������ź�
xt=cos(0.15*pi*t)+sin(2.5*pi*t)+cos(4*pi*t);
subplot(3,1,1);
plot(t,xt);
title('��ͨ�źŵĲ���');
%���ź���4Hz���в���
t_=0:1/4:20;
xt_=cos(0.15*pi*t_)+sin(2.5*pi*t_)+cos(4*pi*t_);
subplot(3,1,2);
stem(t_,xt_);
title('fs=4Hz�ĳ������в���');
T=1/4;
x=zeros(1,2001);  
%ͨ����ֵ�ع��õ�ԭ�ź�
for i=1:length(t_)
    x=x+xt_(i)*sinc((t-i*T+T)/T);
end 
subplot(3,1,3);
plot(t,x);
title('ͨ�����лָ���ԭʼ�ź�');
xlabel('t/s');
ylabel('U/V');



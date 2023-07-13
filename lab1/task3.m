
clear all;
t=linspace(0,0.6,1024);
x=0.4*sin(100*pi*t)+0.4*sin(640*pi*t)+randn(1,length(t));  %�źż��� ��0��1���ĸ�˹������   +randn(1,length(t))

subplot(2,1,1);
plot(t,x);grid;
xlabel('t/s')
ylabel('x(t)+u��n��');
title('����ͼ')

subplot(2,1,2);
[f,sf]=T2F(t,x);     %����ʱ��Ƶ���ת��
plot(f,abs(sf));grid;
xlabel('f/Hz')
ylabel('��ֵ');
title('Ƶ��ͼ')
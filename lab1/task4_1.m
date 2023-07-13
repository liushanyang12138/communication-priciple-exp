clear all;
t=linspace(0,0.6,1024);
A=3;
mt=0.1*cos(15*pi*t)+1.5*sin(25*pi*t)+0.5*cos(40*pi*t);
carrier=cos(250*pi*t);

power1=5.1275;   %s(t) �Ĺ���
power2=10;          %s'(t)�Ĺ��ʣ����Ǿ�������Ĺ���
G=sqrt(power2/power1)   %�źŵ�����
st=G*(A+mt).*carrier;  %����źŵı��ʽ

subplot(2,2,1);
plot(t,st);
xlabel('t');
ylabel('��ֵ');
title('����AWGN�ŵ�֮ǰ���źŵĲ���ͼ');


subplot(2,2,2);
[f,sf]=T2F(t,st);    % ʱ���Ƶ���ת��
plot(f,abs(sf));grid;
xlabel('f/Hz')
ylabel('��ֵ');
title('����AWGN�ŵ�֮ǰ���źŵ�Ƶ��ͼ');



power_noise=1;   %��Ŀ����������
st2=st+sqrt(power_noise)*randn(1,length(t));       %�����ŵ�֮�󣬼����������ź�
subplot(2,2,3);
plot(t,st2);
xlabel('t');
ylabel('��ֵ');
title('����AWGN�ŵ�֮����źŵĲ���ͼ');

subplot(2,2,4);
[f,sf]=T2F(t,st2);  % ʱ���Ƶ���ת��
plot(f,abs(sf));grid;
xlabel('f/Hz')
ylabel('��ֵ');
title('����AWGN�ŵ�֮����źŵ�Ƶ��ͼ');


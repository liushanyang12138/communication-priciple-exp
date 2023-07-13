clear all;
t=linspace(0,5,1024);
mt=cos(2*pi*t);
A=2;
fc=10;
fm=1.2;
carrier=cos(10*2*pi*t);
AM=(A+mt).*carrier;             %�õ�AM�����ź�
subplot(4,1,1);
plot(t,AM);
xlabel('t/s');
title('AM�ѵ��źŵ�ʱ����');

[f,sf]=T2F(t,AM);              %ת����Ƶ��
subplot(4,1,2);
plot(f,abs(sf));
axis([-30,30,-0.2,1.5]);
xlabel('f/Hz');
title('AM�ѵ��źŵ�Ƶ��');

subplot(4,1,3);
fs=1024/5;
n0=0.01;
P=n0*fs/2;
AM_n=AM+sqrt(P).*randn(1,length(t));   %���ϸ�˹������
[f,sf]=T2F(t,AM_n);
[f,sf]=ideal_bandpassing(f,sf,fc-fm,fc+fm);   %������ͨ�˲���

[t,st]=F2T(f,sf); 
st=st.*carrier;              %�����ز�

[f,sf]=T2F(t,st);
[f,sf]=ideal_bandpassing(f,sf,0,fm);   %������ͨ�˲���
[t,st]=F2T(f,sf);   %�õ�ʱ����ź�
plot(t,st-A/2);
axis([0,5,-1.2,1.2]);
xlabel('t/s');
title('AM��ɽ�����ʱ����');

subplot(4,1,4);
[f,sf]=T2F(t,st-A/2);
plot(f,abs(sf));
xlabel('f/Hz');
title('AM��ɽ�����Ƶ����');
axis([-30,30,0,0.3]);
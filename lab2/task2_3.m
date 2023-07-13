clear all ;
fm=20;
fc=100;
fh=25;  %(��΢��20Hz��һ��)
T=1/fm;
t=linspace(0,5*T,1024);
dt=t(2)-t(1);
fs=1/dt;
Am=sqrt(2);
mt=sqrt(2)*cos(2*pi*20*t);  % ����1��Ƶ����20Hz
carrier=cos(2*pi*fc*t);
%ʹ�����Ʒ� �õ����ߴ��ź�

%�ϱߴ�
USB=0.5*Am*cos(2*pi*fm*t).*cos(2*pi*fc*t)-0.5*Am*sin(2*pi*fm*t).*sin(2*pi*fc*t);
subplot(3,2,1);
plot(t,USB);
xlabel('t/s');
ylabel('����');
axis([0,0.2,-1,1]);
title('SSB�ϱߴ��źŵ�ʱ����');

[f,sf]=T2F(t,USB);
subplot(3,2,2);
plot(f,abs(sf));
xlabel('f/Hz');
ylabel('����');
axis([-150,150,0,1]);
title('SSB�ϱߴ��źŵ�Ƶ����');

%�±ߴ�
LSB=0.5*Am*cos(2*pi*fm*t).*cos(2*pi*fc*t)+0.5*Am*sin(2*pi*fm*t).*sin(2*pi*fc*t);
subplot(3,2,3);
plot(t,LSB);
xlabel('t/s');
ylabel('����');
axis([0,0.2,-1,1]);
title('SSB�±ߴ��źŵ�ʱ����');

[f,sf]=T2F(t,LSB);
subplot(3,2,4);
plot(f,abs(sf));
xlabel('f/Hz');
ylabel('����');
axis([-150,150,0,1]);
title('SSB�±ߴ��źŵ�Ƶ����');

n0=0.001;
P=n0*fs/2;
USB_n=USB+sqrt(P).*randn(1,length(t));   %�ŵ���Ӹ�˹������
[f,sf]=T2F(t,USB_n);
[f,sf]=ideal_bandpassing(f,sf,fc,fc+fh);   %������ͨ�˲���

[t,st]=F2T(f,sf); 
st=st.*carrier;     %�����ز����

[f,sf]=T2F(t,st);
[f,sf]=ideal_bandpassing(f,sf,0,fh);   %������ͨ�˲���
[t,st]=F2T(f,sf);   %�õ�ʱ����ź�
subplot(3,2,5);
% plot(t,mt/4);
% hold;
plot(t,st);
xlabel('t/s');
axis([0,0.2,-0.5,0.5]);
title('SSB(�ϱߴ�)��ɽ�����ʱ����');

subplot(3,2,6);
plot(f,abs(sf));
xlabel('f/Hz');
title('SSB(�ϱߴ�)��ɽ�����Ƶ����');
axis([-100,100,0,0.2]);



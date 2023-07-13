clear all ;
f=10;
fc=100;
fh=15;  %(��΢��10Hz��һ��)
T=1/f;
t=linspace(0,5*T,1024);
dt=t(2)-t(1);
fs=1/dt;
mt=sqrt(2)*cos(2*pi*10*t);  % ����1��Ƶ����10Hz
carrier=cos(2*pi*fc*t);
DSB=mt.*carrier;       %DSB����
subplot(5,1,1);
plot(t,DSB);
xlabel('t/s');
ylabel('����');
title('ʱ����ͼ');

[f,sf]=T2F(t,DSB);   %Ƶ���ܶ�
subplot(5,1,2);
plot(f,abs(sf));
xlabel('f/Hz');
ylabel('����');
title('Ƶ��ͼ');
axis([-150,150,-0.02,0.5]);


N=length(t);    %�������ܶ�
Y = fft(DSB,N)/N;% 
sf_psd=abs(Y).^2; 
f_psd = 1/dt*(0:(N-1)/2)/N;
subplot(5,1,3); 
plot(f_psd,2*sf_psd(1:((N-1)/2+1)));% ע�����䳤��  
xlabel('f/Hz');
ylabel('PSD/J');
title('�������ܶ�');
axis([0,200,-0.02,0.4]);


n0=0.001;
P=n0*fs/2;
DSB_n=DSB+sqrt(P).*randn(1,length(t));  %�����ŵ���˹������
[f,sf]=T2F(t,DSB_n);
[f,sf]=ideal_bandpassing(f,sf,fc-fh,fc+fh);   %������ͨ�˲���

[t,st]=F2T(f,sf); 
st=st.*carrier;      %�����ز����

[f,sf]=T2F(t,st);
[f,sf]=ideal_bandpassing(f,sf,0,fh);   %������ͨ�˲���
[t,st]=F2T(f,sf);   %�õ�ʱ����ź�
subplot(5,1,4);
plot(t,st);
xlabel('t/s');
ylabel('����');
title('DSB��ɽ�����ʱ����');

subplot(5,1,5);
plot(f,abs(sf));       %�����źŵ�Ƶ��
xlabel('f/Hz');
ylabel('����');
title('DSB��ɽ�����Ƶ����');
axis([-100,100,0,0.5]);

%��⹦�����ܶ�
clear all 
dt=0.0001;
t = 0:dt:0.6; % ʱ���źŵ�ʱ�䷶Χ 
x = cos(2*pi*50*t); % �����ź� 
y = x %+randn(size(t)); % �����ź�+���� x+randn(size(t));
subplot(2,1,1); 
plot(t(1:100),y(1:100)); 
title('0��ֵ������ź�')
xlabel('ʱ�� (��)') 
Nf=length(t); 
Y = fft(y,Nf)/Nf;% �����޳�������+�������źŵĸ���Ҷ�任 
Pyy=abs(Y).^2; % ����Ҷ�任ģƽ���ľ�ֵ 
f = 1/dt*(0:(Nf-1)/2)/Nf;
subplot(2,1,2); 
plot(f,2*Pyy(1:((Nf-1)/2+1)));% ע�����䳤�� 
title('�źŵĵ��߹������ܶ�'); 
xlabel('Ƶ��(Hz)')

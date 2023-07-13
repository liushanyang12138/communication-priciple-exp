%³¬¼¶¼òµ¥µÄµÍÍ¨ÂË²¨Æ÷
% clear all;
% t=0:0.01:5;
% x=randn(1,length(t));
% subplot(4,1,1);
% plot(t,x);
% [f,sf]=T2F(t,x);
% subplot(4,1,2);
% plot(f,abs(sf));
% %-------------------------------
% % fs=100;
% % fc=30;                                         %½ØÖ¹ÆµÂÊ 3Hz
% % [b,a]=butter(6,[20,30]/50,'bandpass');  % 
% % x1=filter(b,a,x);
% %---------
% x1=lowpass(20,100,x);
% subplot(4,1,3);
% plot(t,x1);
% subplot(4,1,4);
% [f,sf]=T2F(t,x1);
% plot(f,abs(sf));
% axis([-50,50,0,0.2]);
dt=0.01;
t=0:dt:10;
x=cos(2*pi*30*t)+cos(2*pi*20*t);

[f,sf]=T2F(t,x);
subplot(2,1,1);
plot(f,abs(sf));

xt=bandpass(25,35,100,x);
[f,sf]=T2F(t,xt);
subplot(2,1,2);
plot(f,abs(sf));


clear all;
t=linspace(0,1,2000);
x=0.4*sin(100*pi*t)+0.4*sin(640*pi*t);  



subplot(2,2,1);
plot(t,x);grid;
xlabel('t/s')
ylabel('x(t)');
title('����ͼ')

subplot(2,2,2);
[f,sf]=T2F(t,x);     %����ʱ��Ƶ���ת��
plot(f,abs(sf));grid;
xlabel('f/Hz')
ylabel('��ֵ');
title('Ƶ��ͼ,T=0-1��fs=2000');

sum=0;
for x=1200:1500
    if abs(sf(x))<0.1
        continue;
    else 
         sum=sum+abs(sf(x));
    end 
end 
sum

t=linspace(0,2,4000);
x=0.4*sin(100*pi*t)+0.4*sin(640*pi*t);  


subplot(2,2,3);
plot(t,x);grid;
xlabel('t/s')
ylabel('x(t)');
title('����ͼ')

subplot(2,2,4);
[f,sf]=T2F(t,x);     %����ʱ��Ƶ���ת��
plot(f,abs(sf));grid;
xlabel('f/Hz')
ylabel('��ֵ');
title('Ƶ��ͼ,T=0-2��fs=2000');


sum=0;
for x=2400:2800
    if abs(sf(x))<0.1
        continue;
    else 
         sum=sum+abs(sf(x));
    end 
end 
sum


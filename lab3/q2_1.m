clear all;
%------------------------------
%����256 bit������
bitlist(256)=0;
for i=1 :256
    x=rand(1);
    bit=0;
    if x>0.5
        bit=1;
    else
        bit=-1;
    end 
    bitlist(i)=bit;
end
%--------------------------------------
%���������źţ���������1s
dt=0.001;   %�������Ե�����ϸһ�㣬ȡֵ���Ӻ����ܵĸ���
t=0:dt:128-dt;  %128����Ԫ��ʱ��
t1=0:dt:256-dt;  %256�����ص�ʱ��
xt=zeros(1,length(t1));
for i=1 :256
    if bitlist(i)==1
        xt(1+(i-1)*(1/dt):i*(1/dt) )=1;
    else 
        xt(1+(i-1)*(1/dt):i*(1/dt) )=0;
    end
end  
subplot(3,2,1);
plot(t1,xt);
title('�����ź�(256bit��)');
axis([0,20,-0.5,1.2]);
grid;

%-----------------------------
%����ÿ1���е�ȡֵ��ֵ
st=zeros(1,length(t));
for i=1 :128
    %����ת��
    a=bitlist(2*i-1);
    b=bitlist(2*i);
    %QPSK����
    %1+(i-1)*(1/dt):i*(1/dt) ���� i-1 �� iʱ����Ƭ������������i=1 ����0-1ʱ�������
    st(1+(i-1)*(1/dt):i*(1/dt) )=a*cos(2*pi*20*t(1+(i-1)*(1/dt):i*(1/dt)))-b*sin(2*pi*20*t(1+(i-1)*(1/dt):i*(1/dt)));
   
end
subplot(3,2,2);
plot(t,st);
title('QPSK�����ź�');
xlabel('t/s');
ylabel('st/V');
axis([0,2,-1.5,1.5]);

%------------------------------
%ģ��AWGN�ŵ�����Ӹ�˹����������ͨ����ͨ�˲���
%�����Ϊ0db��A=sqrt(2)  ����������1  (��Ϊ�źŵĹ����� 1,�������1��)
  P=1; 
  st=st+sqrt(P*(1/dt/2/4)).*randn(1,length(t));   %ģ���ŵ��������Ĺ����ɽ�������źŹ����Ƴ� �� fs/2=50 �� B=4 ���Թ�����50/4
  [f,sf]=T2F(t,st);
  [f,sf]=ideal_bandpassing(f,sf,18,22);
  [t,st]=F2T(f,sf);
%----------------------------------------
%�������ز����н������Ϊ����֮·
st_up=st.*cos(2*pi*20*t);
st_low=st.*-sin(2*pi*20*t);
[f,sf_up]=T2F(t,st_up);
[f,sf_low]=T2F(t,st_low);
%-------------------------------------
%��ͨ�˲����� ��Ϊ���ֻ����źŵ�Ƶ���� 0-fB
[f,sf_up]=ideal_bandpassing(f,sf_up,0,2);
[f,sf_low]=ideal_bandpassing(f,sf_low,0,2);
[t,st_up]=F2T(f,sf_up);
[t,st_low]=F2T(f,sf_low);

subplot(3,2,3);
plot(t,st_up);
axis([0,10,-2,2]);
title('QPSK��֧·��ͨ�˲��������');
xlabel('t/s');
ylabel('st/V');

subplot(3,2,4);
plot(t,st_low);
axis([0,10,-2,2]);
title('QPSK��֧·��ͨ�˲��������');
xlabel('t/s');
ylabel('st/V');
%------------------------
%��ÿһ��֧·���г����о�
newblist(256)=0;
for i =1:128
    if st_up(1/dt*1/2+(1/dt)*(i-1))>0
        a=1;
    else 
        a=-1;
    end
    if st_low(1/dt*1/2+(1/dt)*(i-1))>0
        b=1;
    else 
        b=-1;
    end
    %------
    %����ת�������ɽ����ı�������
    newblist(2*i-1)=a;
    newblist(2*i)=b;
end
%-----------------
%���ɽ����������ź�
xt_after=zeros(1,length(t1));
for i=1 :256
    if newblist(i)==1
        xt_after(1+(i-1)*(1/dt):i*(1/dt) )=1;
    else 
        xt_after(1+(i-1)*(1/dt):i*(1/dt) )=0;
    end
end  
subplot(3,2,5);
plot(t1,xt_after);
title('��ɽ���ź�');
axis([0,20,-0.5,1.2]);
xlabel('t/s');
ylabel('st/V');
grid;


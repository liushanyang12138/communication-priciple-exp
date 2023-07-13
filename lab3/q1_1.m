clear all;
%--------------------------
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
%-------------------------------------
%����256bit�������źţ�����Ƶ�� 1/dt
dt=1/160;   %�������Ե�����ϸһ�㣬ȡֵ���Ӻ����ܵĸ���
t=0:dt:256-dt;
xt=zeros(1,length(t));
%����ÿ1���е�ȡֵ��ֵ
for i=1 :256
    if bitlist(i)==1
        xt(1+(i-1)*(1/dt):i*(1/dt) )=1;
    else 
        xt(1+(i-1)*(1/dt):i*(1/dt) )=-1;
    end
end
subplot(2,2,1);
plot(t,xt);
title('�����ź�');
xlabel('t/s');
ylabel('st/V');
axis([0,20,-1.2,1.2]);
%--------------------
%���ز����е���
carrier=cos(2*pi*20*t);  %Ƶ��20
%����֮��
st=xt.*carrier;
subplot(2,2,2);
plot(t,st);

axis([0,5,-1.2,1.2]);
title('BPSK�ѵ��ź�');
xlabel('t/s');
ylabel('st/V');
%--------------------------
%ģ��AWGN�ŵ�������ͨ����ͨ�˲���
%�����Ϊ0��A=1 ����������1/2
P=1/2; 
out=P*(1/dt/2/4);
  st=st;%+sqrt(P*(1/dt/2/4)).*randn(1,length(t));   %ģ���ŵ�������  �� fs/2=50 �� B=4 ���Թ�����50/4
  [f,sf]=T2F(t,st);
  [f,sf]=ideal_bandpassing(f,sf,18,22);   %ͨ����ͨ�˲���
  [t,st]=F2T(f,sf);
%----------------
%���н����ͨ����ͨ�˲����� ��Ϊ���ֻ����źŵ�Ƶ���� 0-fB  fB��Ϊ2
st=st.*carrier;
[f,sf]=T2F(t,st);
[f,sf]=ideal_bandpassing(f,sf,0,2);
[t,st]=F2T(f,sf);

subplot(2,2,3);
plot(t,st);
axis([0,20,-2,2]);
title('��ͨ�˲��������');
xlabel('t/s');
ylabel('st/V');
%---------------------------------
%��ʱ�����õ��������У������ĵ���ʱ�����е�
newblist(256)=0;
for i =1:256
    if st(1/dt*1/2+(1/dt)*(i-1))>0
        newblist(i)=1;
    else
        newblist(i)=-1;   %������0��Ҳ������1
    end
end
%------------------------------
%ͨ���������У����ɽ���������ź�
xt_after=zeros(1,length(t));
for i=1 :256
    if newblist(i)==1
        xt_after(1+(i-1)*(1/dt):i*(1/dt) )=1;
    else 
        xt_after(1+(i-1)*(1/dt):i*(1/dt) )=-1;
    end
end  
subplot(2,2,4);
plot(t,xt);
title('����ź�');
axis([0,20,-1.2,1.2]);
xlabel('t/s');
ylabel('st/V');
%---------------------------


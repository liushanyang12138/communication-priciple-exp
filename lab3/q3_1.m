clear all;
%---------------------
%����256 bit������
bitlist(256)=0;
for i=1 :256
    x=rand(1);
    bit=0;
    if x>0.5
        bit=1;
    else
        bit=0;
    end 
    bitlist(i)=bit;
end
dt=0.001;   %�������Ե�����ϸһ�㣬ȡֵ���Ӻ����ܵĸ���
t=0:dt:64-dt;  %64����Ԫ��ʱ��
t1=0:dt:256-dt;  %256�����ص�ʱ��
%-------------------
%����256���������ź�
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
axis([0,20,-0.5,1.2]);
title('�����ź�(256bit��)');
grid;
%---------------------------
%16QAM����
st=zeros(1,length(t));
for i=1 :64
    %����ת��
    a=bitlist(4*i-3);
    b=bitlist(4*i-2);
    c=bitlist(4*i-1);
    d=bitlist(4*i);
    ac=a*2+c;
    bd=b*2+d;
    %ac�Ķ��ĵ�ƽת��������Ϊ������
    if ac==2  % 10 
        Ak=2;
    elseif ac==3   %11
        Ak=1;
    elseif ac==1  %01
        Ak=-1;
    else    %00 
        Ak=-2;
    end
    %bd�Ķ��ĵ�ƽת��������Ϊ������
    if bd==2  % 10 
        Bk=2;
    elseif bd==3   %11
        Bk=1;
    elseif bd==1  %01
        Bk=-1;
    else    %00 
        Bk=-2;
    end
    %����16QAM�ź� 
    st(1+(i-1)*(1/dt):i*(1/dt) )=Ak*cos(2*pi*20*t(1+(i-1)*(1/dt):i*(1/dt)))-Bk*sin(2*pi*20*t(1+(i-1)*(1/dt):i*(1/dt)));
   
end
subplot(3,2,2);
plot(t,st);
title('16QAM�����ź�');
xlabel('t/s');
ylabel('st/V');
axis([0,2,-3,3]);
var(st);
%---------------------------
%ģ��AWGN�źţ���Ӹ�˹����������ͨ����ͨ�˲���
%�����Ϊ0db��   ,�źŹ��� ��2.5 ����������������2.5
  P=2.5; 
  st=st+sqrt(P*(1/dt/2/4)).*randn(1,length(t));   %ģ���ŵ��������Ĺ����ɽ�������źŹ����Ƴ� �� fs/2=50 �� B=4 ���Թ�����50/4
  [f,sf]=T2F(t,st);
  [f,sf]=ideal_bandpassing(f,sf,18,22);
  [t,st]=F2T(f,sf);
 %----------------------
%�������ز���16QAM���н�����õ�����֧·���ź�
st_up=st.*cos(2*pi*20*t)*2;
st_low=st.*-sin(2*pi*20*t)*2;
%-------------------
%ͨ����ͨ�˲���
[f,sf_up]=T2F(t,st_up);
[f,sf_low]=T2F(t,st_low);
%��ͨ�˲����� ��Ϊ���ֻ����źŵ�Ƶ���� 0-fB
[f,sf_up]=ideal_bandpassing(f,sf_up,0,2);
[f,sf_low]=ideal_bandpassing(f,sf_low,0,2);
[t,st_up]=F2T(f,sf_up);
[t,st_low]=F2T(f,sf_low);


subplot(3,2,3);
plot(t,st_up);
xlim([0,64]);
title('16QAM��֧·��ͨ�˲��������');
xlabel('t/s');
ylabel('st/V');

subplot(3,2,4);
plot(t,st_low);
xlim([0,64]);
title('16QAM��֧·��ͨ�˲��������');
xlabel('t/s');
ylabel('st/V');

%--------------------------------------
%��ÿһ��֧·���г����о���������42��ƽת���������д���ת��
newblist(256)=0;
for i =1:64
    %�����о�
    ak=st_up(1/dt*1/2+(1/dt)*(i-1));
    bk=st_low(1/dt*1/2+(1/dt)*(i-1));
    %��֧·4��2ת��
    if ak>1.5
        a=1; c=0;
    elseif  ak>0
        a=1;c=1;
    elseif ak>-1.5
        a=0;c=1;
    else
        a=0;c=0;
    end
    %��֧·4��2ת��
    if bk>1.5
        b=1; d=0;
    elseif  bk>0
        b=1;d=1;
    elseif bk>-1.5
        b=0;d=1;
    else
        b=0;d=0;
    end
    %���в���ת�������ɽ�������������
    newblist(4*i-3)=a;
    newblist(4*i-2)=b;
    newblist(4*i-1)=c;
    newblist(4*i)=d;
    
end
%---------
%�������������ź�
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


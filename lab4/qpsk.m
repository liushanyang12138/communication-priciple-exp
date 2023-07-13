function [ newblist] = qpsk(rb,bitlist)
%SIM_Q2 ���������rb/db������������У��õ�����������

r=db2pow(rb);  %��dB->power
bitlen=length(bitlist);     %�������г���
baudlen=bitlen/2; %��Ԫ��
fs=100;     %����Ƶ��
dt=1/fs;   %�������Ե�����ϸһ�㣬ȡֵ���Ӻ����ܵĸ���
t=0:dt:baudlen-dt;  %��Ԫ������ʱ��
    %����QPSK����
    st=zeros(1,length(t));
    for i=1 :baudlen
        %����ת��
        a=bitlist(2*i-1);
        b=bitlist(2*i);
        if a==0     %��0�ı���ת���� -1,�������
            a=-1;
        end 
        if b==0
            b=-1;
        end 
        st(1+(i-1)*(1/dt):i*(1/dt) )=a*cos(2*pi*20*t(1+(i-1)*(1/dt):i*(1/dt)))-b*sin(2*pi*20*t(1+(i-1)*(1/dt):i*(1/dt)));

    end
        
       %ģ��AWGN�ŵ�����Ӹ�˹����������ͨ����ͨ�˲���
       %�����Ϊr db��A=sqrt(2)  ����������1
      P=1/r; 
      st=st+sqrt(P*(1/dt/2/4)).*randn(1,length(t));   %ģ���ŵ��������Ĺ����ɽ�������źŹ����Ƴ� �� fs/2=50 �� B=4 ���Թ�����50/4
      st=bandpass(18,22,1/dt,st);
    
    %----------------------------------------
    %�������ز����н������Ϊ����֮·
    st_up=st.*cos(2*pi*20*t);
    st_low=st.*-sin(2*pi*20*t);
    %-------------------------------------
    %��ͨ�˲����� ��Ϊ���ֻ����źŵ�Ƶ���� 0-fB
    st_up=lowpass(2,1/dt,st_up);     %0-2 Hz�ĵ�ͨ�˲���
    st_low=lowpass(2,1/dt,st_low);

    %------------------------
    %��ÿһ��֧·���г����о�
    newblist(bitlen)=0;
    for i =1:baudlen
        if st_up((1/dt)*(i)-(1/5)*(1/dt) )>0
            a=1;
        else 
            a=0;
        end
        if st_low((1/dt)*(i)-(1/5)*(1/dt))>0
            b=1;
        else 
            b=0;
        end
        %����ת��
        newblist(2*i-1)=a;
        newblist(2*i)=b;
    end



end


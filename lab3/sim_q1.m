function [ Pe] = sim_q1(r)
%SIM_Q1 ���������r/db���õ�һ��2PSK��������,Pe/db
%   �˴���ʾ��ϸ˵��
%����256 bit������
sim_times=20;   %ģ�����
allwrongbit=0;  %�ܴ���bit
bitlen=256;
r=db2pow(r);   %����
for i1=1:sim_times
    %-------------------
    %����256��������
    bitlist(bitlen)=0;
    for i=1 :bitlen
        x=rand(1);
        bit=0;
        if x>0.5
            bit=1;
        else
            bit=-1;
        end 
        bitlist(i)=bit;
    end

    %---------------------------
    %���������ź�
   
    dt=0.01;   %�������Ե�����ϸһ�㣬ȡֵ���Ӻ����ܵĸ���
    t=0:dt:bitlen-dt;
    xt=zeros(1,length(t));
    %����ÿ1���е�ȡֵ��ֵ
    for i=1 :bitlen
        if bitlist(i)==1
            xt(1+(i-1)*(1/dt):i*(1/dt) )=1;
        else 
            xt(1+(i-1)*(1/dt):i*(1/dt) )=-1;
        end
    end
    %--------------------------------
    %�����ز��������ز�
    carrier=cos(2*pi*20*t);
    st=xt.*carrier;

    %�����Ϊ0��A=1 ����������1/2

    %------------
    %ģ��AWGN�źţ����ϸ�˹��������ͨ����ͨ�˲���
     P=0.5/r;
    st=st+sqrt(P*(50/4)).*randn(1,length(t));   %ģ���ŵ�������  �� fs/2=50 �� B=4 ���Թ�����50/4
    st=bandpass(18,22,1/dt,st);
    %------------------------------
    %���ز����н������ͨ����ͨ�˲�����
    st=st.*carrier;
    st=lowpass(2,1/dt,st);
    %----------------------------
    %��ʱ����
    newblist(bitlen)=0;
    for i =1:bitlen
        if st((1/dt)*(i)-(1/5)*(1/dt))>0
            newblist(i)=1;
        else
            newblist(i)=-1;   %������0��Ҳ������1
        end
    end
    %------------------------------
    %������������
    wrongbit=0;
    for i=1:bitlen
        if bitlist(i)~=newblist(i)
            wrongbit=wrongbit+1; 
        end
    end
    allwrongbit=allwrongbit+wrongbit;
end 
%---------------------------------
%������������
Pe=allwrongbit/(bitlen*sim_times);
Pe=pow2db(Pe);
end


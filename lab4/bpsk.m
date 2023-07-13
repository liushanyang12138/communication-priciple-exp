function [ newblist] = bpsk(rb,bitlist)
%���������r/db���õ�һ��2PSK��������,Pe
%   �˴���ʾ��ϸ˵��

bitlen=length(bitlist);
r=db2pow(rb);  

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
    st=st+sqrt(P*(1/dt/2/4)).*randn(1,length(t));   %ģ���ŵ�������  �� fs/2=50 �� B=4 ���Թ�����50/4
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
            newblist(i)=0;   %������0��Ҳ������1
        end
    end
    %------------------------------
    
end


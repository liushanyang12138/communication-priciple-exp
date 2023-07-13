function [ Pe] = sim_q3(r)
%SIM_Q1 ���������r/db���õ�һ��16QAM��������,Pe/db
%   �˴���ʾ��ϸ˵��
%����256 bit������
sim_times=20;  %ģ�����
allwrongbit=0;  %�ܴ������
r=db2pow(r);
bitlen=256;     
baudlen=bitlen/4;
fs=80;          %�������źŵĲ���Ƶ��
dt=1/fs;   %�������Ե�����ϸһ�㣬ȡֵ���Ӻ����ܵĸ���
t=0:dt:baudlen-dt;  %64����Ԫ��ʱ��
t1=0:dt:bitlen-dt;  %256�����ص�ʱ��
for i1=1:sim_times
    %---------------------------
    %�õ�256��������
    bitlist(bitlen)=0;
    for i=1 :bitlen
        x=rand(1);
        if x>0.5
            bit=1;
        else
            bit=0;
        end 
        bitlist(i)=bit;
    end
    %--------------------------
    %����16QAM����
    st=zeros(1,length(t));
    for i=1 :baudlen
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
    %----------------------------------------------
    %ģ��AWGN�źţ���Ӹ�˹����������ͨ����ͨ�˲���
    %�����Ϊr  ,�źŹ�����2.5 ����������������2.5/r
      P=2.5/r; 
      st=st+sqrt(P*(1/dt/2/4)).*randn(1,length(t));   %ģ���ŵ��������Ĺ����ɽ�������źŹ����Ƴ� 
      st=bandpass(18,22,1/dt,st);
    %-------------------------------------
    %�������ز���16QAM���н�����õ�����֧·���ź�
    st_up=st.*cos(2*pi*20*t)*2;
    st_low=st.*-sin(2*pi*20*t)*2;
    %������ͨ�˲���
    st_up=lowpass(2,1/dt,st_up);     %0-2 Hz�ĵ�ͨ�˲���
    st_low=lowpass(2,1/dt,st_low);
    %----------------------------
    
    %--------------------------------------
    %��ÿһ��֧·���г����о���������42��ƽת���������д���ת��
    newblist(bitlen)=0;
    for i =1:baudlen
        %%�����о�
        ak=st_up((1/dt)*(i)-(1/dt)*0.1);
        bk=st_low((1/dt)*(i)-(1/dt)*0.1);
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
        % ���в���ת�������ɽ�������������
        newblist(4*i-3)=a;
        newblist(4*i-2)=b;
        newblist(4*i-1)=c;
        newblist(4*i)=d;
    end
    wrongbit=0;
    %����һ��ģ��Ĵ��������
    for i=1:bitlen
        if bitlist(i)~=newblist(i)
            wrongbit=wrongbit+1; 
        end
    end
    allwrongbit=allwrongbit+wrongbit;
end 

%����ģ�� sim_times ������ƽ��������
Pe=allwrongbit/(bitlen*sim_times);

end


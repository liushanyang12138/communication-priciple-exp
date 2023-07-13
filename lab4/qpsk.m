function [ newblist] = qpsk(rb,bitlist)
%SIM_Q2 输入信噪比rb/db，输入比特序列，得到解调后的序列

r=db2pow(rb);  %将dB->power
bitlen=length(bitlist);     %比特序列长度
baudlen=bitlen/2; %码元数
fs=100;     %采样频率
dt=1/fs;   %参数可以调，调细一点，取值更加合理，跑的更慢
t=0:dt:baudlen-dt;  %码元持续的时间
    %进行QPSK调制
    st=zeros(1,length(t));
    for i=1 :baudlen
        %串并转换
        a=bitlist(2*i-1);
        b=bitlist(2*i);
        if a==0     %将0的比特转换成 -1,方便调制
            a=-1;
        end 
        if b==0
            b=-1;
        end 
        st(1+(i-1)*(1/dt):i*(1/dt) )=a*cos(2*pi*20*t(1+(i-1)*(1/dt):i*(1/dt)))-b*sin(2*pi*20*t(1+(i-1)*(1/dt):i*(1/dt)));

    end
        
       %模拟AWGN信道，添加高斯白噪声，并通过带通滤波器
       %信噪比为r db，A=sqrt(2)  噪声功率是1
      P=1/r; 
      st=st+sqrt(P*(1/dt/2/4)).*randn(1,length(t));   %模拟信道的噪声的功率由解调器的信号功率推出 ， fs/2=50 ， B=4 所以功率是50/4
      st=bandpass(18,22,1/dt,st);
    
    %----------------------------------------
    %用两个载波进行解调，分为上下之路
    st_up=st.*cos(2*pi*20*t);
    st_low=st.*-sin(2*pi*20*t);
    %-------------------------------------
    %低通滤波器， 因为数字基带信号的频率是 0-fB
    st_up=lowpass(2,1/dt,st_up);     %0-2 Hz的低通滤波器
    st_low=lowpass(2,1/dt,st_low);

    %------------------------
    %对每一个支路进行抽样判决
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
        %并串转换
        newblist(2*i-1)=a;
        newblist(2*i)=b;
    end



end


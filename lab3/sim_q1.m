function [ Pe] = sim_q1(r)
%SIM_Q1 输入信噪比r/db，得到一次2PSK的误码率,Pe/db
%   此处显示详细说明
%产生256 bit的数据
sim_times=20;   %模拟次数
allwrongbit=0;  %总错误bit
bitlen=256;
r=db2pow(r);   %输入
for i1=1:sim_times
    %-------------------
    %生成256比特序列
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
    %生成数字信号
   
    dt=0.01;   %参数可以调，调细一点，取值更加合理，跑的更慢
    t=0:dt:bitlen-dt;
    xt=zeros(1,length(t));
    %对于每1秒中的取值赋值
    for i=1 :bitlen
        if bitlist(i)==1
            xt(1+(i-1)*(1/dt):i*(1/dt) )=1;
        else 
            xt(1+(i-1)*(1/dt):i*(1/dt) )=-1;
        end
    end
    %--------------------------------
    %生成载波并调制载波
    carrier=cos(2*pi*20*t);
    st=xt.*carrier;

    %信噪比为0，A=1 噪声功率是1/2

    %------------
    %模拟AWGN信号，加上高斯白噪声，通过带通滤波器
     P=0.5/r;
    st=st+sqrt(P*(50/4)).*randn(1,length(t));   %模拟信道的噪声  ， fs/2=50 ， B=4 所以功率是50/4
    st=bandpass(18,22,1/dt,st);
    %------------------------------
    %用载波进行解调，并通过低通滤波器，
    st=st.*carrier;
    st=lowpass(2,1/dt,st);
    %----------------------------
    %定时抽样
    newblist(bitlen)=0;
    for i =1:bitlen
        if st((1/dt)*(i)-(1/5)*(1/dt))>0
            newblist(i)=1;
        else
            newblist(i)=-1;   %可以是0，也可以是1
        end
    end
    %------------------------------
    %计算错误比特数
    wrongbit=0;
    for i=1:bitlen
        if bitlist(i)~=newblist(i)
            wrongbit=wrongbit+1; 
        end
    end
    allwrongbit=allwrongbit+wrongbit;
end 
%---------------------------------
%计算总误码率
Pe=allwrongbit/(bitlen*sim_times);
Pe=pow2db(Pe);
end


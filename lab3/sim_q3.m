function [ Pe] = sim_q3(r)
%SIM_Q1 输入信噪比r/db，得到一次16QAM的误码率,Pe/db
%   此处显示详细说明
%产生256 bit的数据
sim_times=20;  %模拟次数
allwrongbit=0;  %总错误比特
r=db2pow(r);
bitlen=256;     
baudlen=bitlen/4;
fs=80;          %对数字信号的采样频率
dt=1/fs;   %参数可以调，调细一点，取值更加合理，跑的更慢
t=0:dt:baudlen-dt;  %64个码元的时间
t1=0:dt:bitlen-dt;  %256个比特的时间
for i1=1:sim_times
    %---------------------------
    %得到256比特序列
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
    %进行16QAM调制
    st=zeros(1,length(t));
    for i=1 :baudlen
        %串并转换
        a=bitlist(4*i-3);
        b=bitlist(4*i-2);
        c=bitlist(4*i-1);
        d=bitlist(4*i);
        ac=a*2+c;
        bd=b*2+d;
        %ac的二四电平转换，编码为格雷码
        if ac==2  % 10 
            Ak=2;
        elseif ac==3   %11
            Ak=1;
        elseif ac==1  %01
            Ak=-1;
        else    %00 
            Ak=-2;
        end
        %bd的二四电平转换，编码为格雷码
        if bd==2  % 10 
            Bk=2;
        elseif bd==3   %11
            Bk=1;
        elseif bd==1  %01
            Bk=-1;
        else    %00 
            Bk=-2;
        end
         %生成16QAM信号
        st(1+(i-1)*(1/dt):i*(1/dt) )=Ak*cos(2*pi*20*t(1+(i-1)*(1/dt):i*(1/dt)))-Bk*sin(2*pi*20*t(1+(i-1)*(1/dt):i*(1/dt)));

    end
    %----------------------------------------------
    %模拟AWGN信号，添加高斯白噪声，并通过带通滤波器
    %信噪比为r  ,信号功率是2.5 ，所以噪声功率是2.5/r
      P=2.5/r; 
      st=st+sqrt(P*(1/dt/2/4)).*randn(1,length(t));   %模拟信道的噪声的功率由解调器的信号功率推出 
      st=bandpass(18,22,1/dt,st);
    %-------------------------------------
    %用两个载波对16QAM进行解调，得到上下支路的信号
    st_up=st.*cos(2*pi*20*t)*2;
    st_low=st.*-sin(2*pi*20*t)*2;
    %经过低通滤波器
    st_up=lowpass(2,1/dt,st_up);     %0-2 Hz的低通滤波器
    st_low=lowpass(2,1/dt,st_low);
    %----------------------------
    
    %--------------------------------------
    %对每一个支路进行抽样判决，并进行42电平转换，最后进行串并转换
    newblist(bitlen)=0;
    for i =1:baudlen
        %%抽样判决
        ak=st_up((1/dt)*(i)-(1/dt)*0.1);
        bk=st_low((1/dt)*(i)-(1/dt)*0.1);
         %上支路4，2转换
        if ak>1.5
            a=1; c=0;
        elseif  ak>0
            a=1;c=1;
        elseif ak>-1.5
            a=0;c=1;
        else
            a=0;c=0;
        end
        %下支路4，2转换
        if bk>1.5
            b=1; d=0;
        elseif  bk>0
            b=1;d=1;
        elseif bk>-1.5
            b=0;d=1;
        else
            b=0;d=0;
        end
        % 进行并串转换，生成解调后的数字序列
        newblist(4*i-3)=a;
        newblist(4*i-2)=b;
        newblist(4*i-1)=c;
        newblist(4*i)=d;
    end
    wrongbit=0;
    %计算一次模拟的错误比特数
    for i=1:bitlen
        if bitlist(i)~=newblist(i)
            wrongbit=wrongbit+1; 
        end
    end
    allwrongbit=allwrongbit+wrongbit;
end 

%计算模拟 sim_times 次数的平均误码率
Pe=allwrongbit/(bitlen*sim_times);

end


clear all;
%---------------------
%产生256 bit的数据
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
dt=0.001;   %参数可以调，调细一点，取值更加合理，跑的更慢
t=0:dt:64-dt;  %64个码元的时间
t1=0:dt:256-dt;  %256个比特的时间
%-------------------
%生成256比特数字信号
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
title('调制信号(256bit串)');
grid;
%---------------------------
%16QAM调制
st=zeros(1,length(t));
for i=1 :64
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
subplot(3,2,2);
plot(t,st);
title('16QAM调制信号');
xlabel('t/s');
ylabel('st/V');
axis([0,2,-3,3]);
var(st);
%---------------------------
%模拟AWGN信号，添加高斯白噪声，并通过带通滤波器
%信噪比为0db，   ,信号功率 是2.5 ，所以噪声功率是2.5
  P=2.5; 
  st=st+sqrt(P*(1/dt/2/4)).*randn(1,length(t));   %模拟信道的噪声的功率由解调器的信号功率推出 ， fs/2=50 ， B=4 所以功率是50/4
  [f,sf]=T2F(t,st);
  [f,sf]=ideal_bandpassing(f,sf,18,22);
  [t,st]=F2T(f,sf);
 %----------------------
%用两个载波对16QAM进行解调，得到上下支路的信号
st_up=st.*cos(2*pi*20*t)*2;
st_low=st.*-sin(2*pi*20*t)*2;
%-------------------
%通过低通滤波器
[f,sf_up]=T2F(t,st_up);
[f,sf_low]=T2F(t,st_low);
%低通滤波器， 因为数字基带信号的频率是 0-fB
[f,sf_up]=ideal_bandpassing(f,sf_up,0,2);
[f,sf_low]=ideal_bandpassing(f,sf_low,0,2);
[t,st_up]=F2T(f,sf_up);
[t,st_low]=F2T(f,sf_low);


subplot(3,2,3);
plot(t,st_up);
xlim([0,64]);
title('16QAM上支路低通滤波器的输出');
xlabel('t/s');
ylabel('st/V');

subplot(3,2,4);
plot(t,st_low);
xlim([0,64]);
title('16QAM下支路低通滤波器的输出');
xlabel('t/s');
ylabel('st/V');

%--------------------------------------
%对每一个支路进行抽样判决，并进行42电平转换，最后进行串并转换
newblist(256)=0;
for i =1:64
    %抽样判决
    ak=st_up(1/dt*1/2+(1/dt)*(i-1));
    bk=st_low(1/dt*1/2+(1/dt)*(i-1));
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
    %进行并串转换，生成解调后的数字序列
    newblist(4*i-3)=a;
    newblist(4*i-2)=b;
    newblist(4*i-1)=c;
    newblist(4*i)=d;
    
end
%---------
%重新生成数字信号
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
title('相干解调信号');
axis([0,20,-0.5,1.2]);
xlabel('t/s');
ylabel('st/V');
grid;


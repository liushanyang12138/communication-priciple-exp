clear all;
%------------------------------
%产生256 bit的数据
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
%--------------------------------------
%生成数字信号，持续周期1s
dt=0.001;   %参数可以调，调细一点，取值更加合理，跑的更慢
t=0:dt:128-dt;  %128个码元的时间
t1=0:dt:256-dt;  %256个比特的时间
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
title('调制信号(256bit串)');
axis([0,20,-0.5,1.2]);
grid;

%-----------------------------
%对于每1秒中的取值赋值
st=zeros(1,length(t));
for i=1 :128
    %串并转换
    a=bitlist(2*i-1);
    b=bitlist(2*i);
    %QPSK调制
    %1+(i-1)*(1/dt):i*(1/dt) 就是 i-1 到 i时间切片的索引，比如i=1 就是0-1时间的索引
    st(1+(i-1)*(1/dt):i*(1/dt) )=a*cos(2*pi*20*t(1+(i-1)*(1/dt):i*(1/dt)))-b*sin(2*pi*20*t(1+(i-1)*(1/dt):i*(1/dt)));
   
end
subplot(3,2,2);
plot(t,st);
title('QPSK调制信号');
xlabel('t/s');
ylabel('st/V');
axis([0,2,-1.5,1.5]);

%------------------------------
%模拟AWGN信道，添加高斯白噪声，并通过带通滤波器
%信噪比为0db，A=sqrt(2)  噪声功率是1  (因为信号的功率是 1,信噪比是1，)
  P=1; 
  st=st+sqrt(P*(1/dt/2/4)).*randn(1,length(t));   %模拟信道的噪声的功率由解调器的信号功率推出 ， fs/2=50 ， B=4 所以功率是50/4
  [f,sf]=T2F(t,st);
  [f,sf]=ideal_bandpassing(f,sf,18,22);
  [t,st]=F2T(f,sf);
%----------------------------------------
%用两个载波进行解调，分为上下之路
st_up=st.*cos(2*pi*20*t);
st_low=st.*-sin(2*pi*20*t);
[f,sf_up]=T2F(t,st_up);
[f,sf_low]=T2F(t,st_low);
%-------------------------------------
%低通滤波器， 因为数字基带信号的频率是 0-fB
[f,sf_up]=ideal_bandpassing(f,sf_up,0,2);
[f,sf_low]=ideal_bandpassing(f,sf_low,0,2);
[t,st_up]=F2T(f,sf_up);
[t,st_low]=F2T(f,sf_low);

subplot(3,2,3);
plot(t,st_up);
axis([0,10,-2,2]);
title('QPSK上支路低通滤波器的输出');
xlabel('t/s');
ylabel('st/V');

subplot(3,2,4);
plot(t,st_low);
axis([0,10,-2,2]);
title('QPSK下支路低通滤波器的输出');
xlabel('t/s');
ylabel('st/V');
%------------------------
%对每一个支路进行抽样判决
newblist(256)=0;
for i =1:128
    if st_up(1/dt*1/2+(1/dt)*(i-1))>0
        a=1;
    else 
        a=-1;
    end
    if st_low(1/dt*1/2+(1/dt)*(i-1))>0
        b=1;
    else 
        b=-1;
    end
    %------
    %并串转换，生成解调后的比特序列
    newblist(2*i-1)=a;
    newblist(2*i)=b;
end
%-----------------
%生成解调后的数字信号
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


clear all;
%--------------------------
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
%-------------------------------------
%生成256bit的数字信号，采样频率 1/dt
dt=1/160;   %参数可以调，调细一点，取值更加合理，跑的更慢
t=0:dt:256-dt;
xt=zeros(1,length(t));
%对于每1秒中的取值赋值
for i=1 :256
    if bitlist(i)==1
        xt(1+(i-1)*(1/dt):i*(1/dt) )=1;
    else 
        xt(1+(i-1)*(1/dt):i*(1/dt) )=-1;
    end
end
subplot(2,2,1);
plot(t,xt);
title('调制信号');
xlabel('t/s');
ylabel('st/V');
axis([0,20,-1.2,1.2]);
%--------------------
%对载波进行调制
carrier=cos(2*pi*20*t);  %频率20
%调制之后
st=xt.*carrier;
subplot(2,2,2);
plot(t,st);

axis([0,5,-1.2,1.2]);
title('BPSK已调信号');
xlabel('t/s');
ylabel('st/V');
%--------------------------
%模拟AWGN信道，并且通过带通滤波器
%信噪比为0，A=1 噪声功率是1/2
P=1/2; 
out=P*(1/dt/2/4);
  st=st;%+sqrt(P*(1/dt/2/4)).*randn(1,length(t));   %模拟信道的噪声  ， fs/2=50 ， B=4 所以功率是50/4
  [f,sf]=T2F(t,st);
  [f,sf]=ideal_bandpassing(f,sf,18,22);   %通过带通滤波器
  [t,st]=F2T(f,sf);
%----------------
%进行解调，通过低通滤波器， 因为数字基带信号的频率是 0-fB  fB设为2
st=st.*carrier;
[f,sf]=T2F(t,st);
[f,sf]=ideal_bandpassing(f,sf,0,2);
[t,st]=F2T(f,sf);

subplot(2,2,3);
plot(t,st);
axis([0,20,-2,2]);
title('低通滤波器的输出');
xlabel('t/s');
ylabel('st/V');
%---------------------------------
%定时抽样得到比特序列，抽样的点是时间点的中点
newblist(256)=0;
for i =1:256
    if st(1/dt*1/2+(1/dt)*(i-1))>0
        newblist(i)=1;
    else
        newblist(i)=-1;   %可以是0，也可以是1
    end
end
%------------------------------
%通过比特序列，生成解调的数字信号
xt_after=zeros(1,length(t));
for i=1 :256
    if newblist(i)==1
        xt_after(1+(i-1)*(1/dt):i*(1/dt) )=1;
    else 
        xt_after(1+(i-1)*(1/dt):i*(1/dt) )=-1;
    end
end  
subplot(2,2,4);
plot(t,xt);
title('解调信号');
axis([0,20,-1.2,1.2]);
xlabel('t/s');
ylabel('st/V');
%---------------------------


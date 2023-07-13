clear all;
N=10000; % 二进制序列的长度 
dsource =(sign(rand(1,N)-0.5+eps)+1)/2; % 生成N码元的0、1序列 
n=10; % 每周期采样数为10 
temp1=ones(1,n);% 表示1码 
temp0=zeros(1,n);% 表示0码 
new_dsource=[];
for i=1:length(dsource) 
if dsource(i)==0 
new_dsource=[new_dsource temp0]; 
else 
new_dsource=[new_dsource temp1]; 
end 
end 
T=0.10; % 每码元周期 
t=0:T/n:T/n*(length(new_dsource)-1); % 时间轴，new_dsource序号从1开始 到(length(new_dsource)，而t是从0开始，故要减去1 (N*T的结果)
plot(t,new_dsource);
axis([min(t)-0.01,max(t)+0.01,min(new_dsource)-0.01,max(new_dsource)+0.01]) ;

clear all;
N=10000; % ���������еĳ��� 
dsource =(sign(rand(1,N)-0.5+eps)+1)/2; % ����N��Ԫ��0��1���� 
n=10; % ÿ���ڲ�����Ϊ10 
temp1=ones(1,n);% ��ʾ1�� 
temp0=zeros(1,n);% ��ʾ0�� 
new_dsource=[];
for i=1:length(dsource) 
if dsource(i)==0 
new_dsource=[new_dsource temp0]; 
else 
new_dsource=[new_dsource temp1]; 
end 
end 
T=0.10; % ÿ��Ԫ���� 
t=0:T/n:T/n*(length(new_dsource)-1); % ʱ���ᣬnew_dsource��Ŵ�1��ʼ ��(length(new_dsource)����t�Ǵ�0��ʼ����Ҫ��ȥ1 (N*T�Ľ��)
plot(t,new_dsource);
axis([min(t)-0.01,max(t)+0.01,min(new_dsource)-0.01,max(new_dsource)+0.01]) ;

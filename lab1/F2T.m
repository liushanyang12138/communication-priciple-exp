function [t,st]= F2T (f,sf) % f����ɢ��Ƶ�ʣ�sf���źŵ�Ƶ�� 
df=f(2)-f(1) ; % Ƶ�ʷֱ��� 
Fmx=f(end)-f(1)+df ;% Ƶ�����䳤�� 
dt=1/Fmx ; % ��֪Ƶ�����䳤��ʱ����ʱ��ֱ��ʣ���ǰ��Ƶ�ʷֱ��ʹ�ʽ��f=df=1/T�� T=dt*N���õ���f=df=1/(dt*N)����dt=1/(df*N)=1/Fmx����ʱ��ֱ��� 
N=length(sf) ; 
T=dt*N; % �źų���ʱ�� 
t=0:dt:T-dt; % ��ɢ����Ҷ���任����T2F������� 
sff=fftshift(sf); % �ѶԳƵ�Ƶ�׽���ƽ�ƣ�ƽ�ƺ�ͬT2F�е�sf 
st=N*ifft(sff);
end


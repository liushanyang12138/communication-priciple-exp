function [f,sf]=T2F(t,st)% ���Ӻ�����Ҫ��������t��st��t����ɢʱ�䣬st����ɢ�ź� 
dt=t(2)-t(1) ;% ʱ��ֱ��� 
T=t(end) ;
df=1/T ;% Ƶ�ʷֱ��� 
N=length(st) ;% ��ɢ����Ҷ�任���� 
f=-N/2*df :df :N/2*df-df ;% �趨Ƶ�����䣬ע��Ҫ����ԭ��Գƣ�����N���㣬����0�㣬��Ҫ��ȥһ�� df 
sf=fft(st);
sf=1/N*fftshift(sf);% �źŵ�Ƶ������ɢ����Ҷ�任֮��Ĺ�ϵ��fftshift(x)�ǽ��źŵ�Ƶ��x������λ����ԭ��Գ�
end 
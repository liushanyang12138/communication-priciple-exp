%����һ��(0,1)�Ͼ��ȷֲ��İ������ź� 
clear;% ����ڴ��п��ܱ����� MATLAB ���� 
N=500000;%  �ĳ��� 
u=randn(1,N);% ���� rand���õ����ȷֲ��������  
disp('��ֵ')
u_mean=mean(u)% �� ��ֵ 
disp('����')
power_u=var(u)% �� ���� 
subplot(211) 
plot(u(1:200));
grid on;%��һ��ͼ�Ϸ�����������ͼ 
ylabel('u(n) ');% ��y������� 
xlabel('n'); % ��x������� 
subplot(212) 
hist(u,50); % �� ��ֱ��ͼ��������ֲ���50 �Ƕ�ȡֵ��Χ[0 1]���ֵȷ� 50 ��
grid on;% ���� 
ylabel('histogram of u(n) ');

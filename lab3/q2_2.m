clear all;

r_db=-15:0.5:5;
r_pow=db2pow(r_db);
%ͨ����ʽ�������۵�����Ⱥ������ʵĺ���
Pe_pow=0.5*erfc(sqrt(r_pow/2) ) 
hold on ;
plot(r_db,Pe_pow);
xlabel('r/dB');
ylabel('Pe');
title('QPSK���������������');
%���� sim_q2 �õ������������
sim_Pe=zeros(1,length(r_db));
for i=1:length(r_db)
   sim_Pe(i)=sim_q2(r_db(i));
end 
plot(r_db,sim_Pe);
title('QPSK���������������');
% axis([-15,5,-15,0]);
legend(['�����������';'���۵�������']);
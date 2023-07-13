clear all;

r_db=-15:0.1:5;
r_pow=db2pow(r_db);
%ͨ����ʽ����������������ʵĹ�ϵ���õ���������
% Pe_pow = (1/4)*3/2*erfc(sqrt(4*0.1*(r_pow)));
Pe_pow=(3/8)*erfc(sqrt(2/5*r_pow));
hold on ;
plot(r_db,Pe_pow);
xlabel('r/db');
ylabel('Pe');
%ͨ������������������Ⱥ������ʵ�����
sim_Pe=zeros(1,length(r_db));
for i=1:length(r_db)
   sim_Pe(i)=sim_q3(r_db(i));
end 

plot(r_db,sim_Pe);
xlabel('r/db');
ylabel('Pe');
legend(['�����������';'ʵ�ʵ�������']);
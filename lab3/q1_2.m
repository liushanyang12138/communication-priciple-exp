clear all;

r_db=-15:0.1:5;
r_pow=db2pow(r_db);
%---------------------------
%ͨ����ʽ���������ʣ� �õ�������������
Pe_pow=0.5*erfc(sqrt(r_pow));
Pe_db=pow2db(Pe_pow);
hold on;
plot(r_db,Pe_db);
xlabel('r/db');
ylabel('Pe/db');
title('2PSK���������������');
%------------------------------------
%ͨ��ģ�⺯�����������ʣ� �õ�������������
sim_Pe=zeros(1,length(r_db));
for i=1:length(r_db)
   sim_Pe(i)=sim_q1(r_db(i));  %����r/db ,�õ���Ӧ����ȵ�������
end 
plot(r_db,sim_Pe);
xlabel('r/db');
ylabel('Pe/db');
title('2PSK���������������');
axis([-15,5,-30,0]);
legend(['�����������';'���۵�������']);
%-------------------------------
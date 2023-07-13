clear all;

r_db=-15:0.1:5;
r_pow=db2pow(r_db);
%通过公式计算信噪比与误码率的关系，得到理论曲线
% Pe_pow = (1/4)*3/2*erfc(sqrt(4*0.1*(r_pow)));
Pe_pow=(3/8)*erfc(sqrt(2/5*r_pow));
hold on ;
plot(r_db,Pe_pow);
xlabel('r/db');
ylabel('Pe');
%通过仿真结果，生成信噪比和误码率的曲线
sim_Pe=zeros(1,length(r_db));
for i=1:length(r_db)
   sim_Pe(i)=sim_q3(r_db(i));
end 

plot(r_db,sim_Pe);
xlabel('r/db');
ylabel('Pe');
legend(['理想的误码率';'实际的误码率']);
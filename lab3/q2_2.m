clear all;

r_db=-15:0.5:5;
r_pow=db2pow(r_db);
%通过公式计算理论的信噪比和误码率的函数
Pe_pow=0.5*erfc(sqrt(r_pow/2) ) 
hold on ;
plot(r_db,Pe_pow);
xlabel('r/dB');
ylabel('Pe');
title('QPSK理想的误码率曲线');
%调用 sim_q2 得到仿真的误码率
sim_Pe=zeros(1,length(r_db));
for i=1:length(r_db)
   sim_Pe(i)=sim_q2(r_db(i));
end 
plot(r_db,sim_Pe);
title('QPSK仿真的误码率曲线');
% axis([-15,5,-15,0]);
legend(['理想的误码率';'理论的误码率']);
clear all;

r_db=-15:0.1:5;
r_pow=db2pow(r_db);
%---------------------------
%通过公式计算误码率， 得到理论误码曲线
Pe_pow=0.5*erfc(sqrt(r_pow));
Pe_db=pow2db(Pe_pow);
hold on;
plot(r_db,Pe_db);
xlabel('r/db');
ylabel('Pe/db');
title('2PSK理想的误码率曲线');
%------------------------------------
%通过模拟函数计算误码率， 得到理论误码曲线
sim_Pe=zeros(1,length(r_db));
for i=1:length(r_db)
   sim_Pe(i)=sim_q1(r_db(i));  %输入r/db ,得到对应信噪比的误码率
end 
plot(r_db,sim_Pe);
xlabel('r/db');
ylabel('Pe/db');
title('2PSK仿真的误码率曲线');
axis([-15,5,-30,0]);
legend(['理想的误码率';'理论的误码率']);
%-------------------------------
clear all;
r_db=-15:0.1:5;
r_pow=db2pow(r_db);
%通过公式计算信噪比与误码率的关系，得到理论曲线
% Pe_pow = (1/4)*3/2*erfc(sqrt(4*0.1*(r_pow)));
Pe_pow1=(3/8)*erfc(sqrt(4/5*r_pow));  %BER
Pe_pow1=4.*Pe_pow1.*(1-Pe_pow1).^3+6.*Pe_pow1.^2.*(1-Pe_pow1).^2+6.*Pe_pow1.^3.*(1-Pe_pow1).^1+4.*Pe_pow1.^3.*(1-Pe_pow1).^1;
Pe_pow2=1-(1-(3/4)*erfc(sqrt(1/10*r_pow))).^2;
hold on;
plot(r_db,Pe_pow1);
plot(r_db,Pe_pow2);

legend(['BER换算SER';'直接公式计算..']);
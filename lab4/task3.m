clear all;
n = 7; % Codeword length
k = 4; % Message length
r=-15:0.5:10;
bitlen=1000;
data = randi([0 1],1,bitlen);
BER=zeros(1,length(r));
for i=1:length(r)
encData = encode(data,n,k,'hamming/binary');   %进行海明编码
decModuleData=qpsk(r(i),encData);               %经过信噪比 r的 AWGN信道，得到的QPSK解调之后的比特串
decData = decode(decModuleData,n,k,'hamming/binary');       %进行海明编码的译码
numerr = biterr(data,decData);      %计算比特错误率
ber=numerr/bitlen;
BER(i)=ber;
end 
hold on;
plot(r,BER);

r_db=-15:0.5:10;
r_pow=db2pow(r_db);
%通过公式计算理论的信噪比和误码率的函数
Pe_pow=0.5*erfc(sqrt(r_pow/2) ) ;   
plot(r_db,Pe_pow);
legend('采用Haming编码的误码率','不采用Haming编码的理论的误码率');
xlabel('SNR /dB');
ylabel('Pe');
clear all;
%这里是硬编码
trellis = poly2trellis(7,[171 133]);  %生成多项式，约束是7 
tb = 30;

r=-15:0.5:10;
bitlen=100000;
data = randi([0 1],1,bitlen);
BER=zeros(1,length(r));
for i=1:length(r)
[encData,fstate_a] = convenc(data,trellis);
decModuleData=bpsk(r(i),encData);
decData = vitdec(decModuleData,trellis,tb,'trunc','hard');
numerr = biterr(data,decData);
ber=numerr/bitlen;
BER(i)=ber;
end 
% subplot(2,1,1);
hold on;
plot(r,BER);





%采用软编码
r=-15:0.5:10;

data = randi([0 1],1,bitlen);
BER=zeros(1,length(r));
for i=1:length(r)
[encData,fstate_a] = convenc(data,trellis);
decModuleData=bpsk(r(i),encData);
decData = vitdec(decModuleData,trellis,tb,'trunc','soft',1);

numerr = biterr(data,decData);
ber=numerr/bitlen;
BER(i)=ber;
end 

plot(r,BER);



r_db=-15:0.5:10;
r_pow=db2pow(r_db);
%通过公式计算理论的信噪比和误码率的函数
Pe_pow=0.5*erfc(sqrt(r_pow));
plot(r_db,Pe_pow);



legend('采用卷积编码（硬解码）的误码率','采用卷积编码（软解码）的误码率','不采用卷积编码的理论的误码率');
xlabel('SNR /dB');
ylabel('Pe');



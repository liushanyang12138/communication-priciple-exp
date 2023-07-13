clear all;
n = 7; % Codeword length
k = 4; % Message length
r=-15:0.5:10;
bitlen=1000;
data = randi([0 1],1,bitlen);
BER=zeros(1,length(r));
for i=1:length(r)
encData = encode(data,n,k,'hamming/binary');   %���к�������
decModuleData=qpsk(r(i),encData);               %��������� r�� AWGN�ŵ����õ���QPSK���֮��ı��ش�
decData = decode(decModuleData,n,k,'hamming/binary');       %���к������������
numerr = biterr(data,decData);      %������ش�����
ber=numerr/bitlen;
BER(i)=ber;
end 
hold on;
plot(r,BER);

r_db=-15:0.5:10;
r_pow=db2pow(r_db);
%ͨ����ʽ�������۵�����Ⱥ������ʵĺ���
Pe_pow=0.5*erfc(sqrt(r_pow/2) ) ;   
plot(r_db,Pe_pow);
legend('����Haming�����������','������Haming��������۵�������');
xlabel('SNR /dB');
ylabel('Pe');
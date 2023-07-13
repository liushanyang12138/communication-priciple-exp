clear all;
%������Ӳ����
trellis = poly2trellis(7,[171 133]);  %���ɶ���ʽ��Լ����7 
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





%���������
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
%ͨ����ʽ�������۵�����Ⱥ������ʵĺ���
Pe_pow=0.5*erfc(sqrt(r_pow));
plot(r_db,Pe_pow);



legend('���þ�����루Ӳ���룩��������','���þ�����루����룩��������','�����þ����������۵�������');
xlabel('SNR /dB');
ylabel('Pe');



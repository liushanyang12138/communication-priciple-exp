%采用软编码
trellis = poly2trellis(7,[171 133]);  %生成多项式，约束是7 
tb = 30;
r=-15:0.5:10;
bitlen=1000
data = randi([0 1],1,bitlen);
BER=zeros(1,length(r));

[encData,fstate_a] = convenc(data,trellis);
decModuleData=bpsk(10,encData);
decData = vitdec(decModuleData,trellis,tb,'trunc','soft',8);
numerr = biterr(data,decData)
ber=numerr/bitlen;




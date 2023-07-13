G=-70:1:0;
y=zeros(1,length(G));
A0=1;
for i =1:length(G)
    %因为A0是1，所以可以直接这样转换
    Ac=sqrt(db2pow(G(i)))*A0;
    SN=quantityOnce(Ac);
    SN=pow2db(SN);
    y(i)=SN;
end
plot(G,y);
title('信噪比和量噪比的关系')
xlabel('$\frac{Ac^2}{A_0^2}/dB$','interpreter','latex');
ylabel('量噪比qSNR/dB');
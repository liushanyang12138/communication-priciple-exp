G=-70:1:0;
y=zeros(1,length(G));
A0=1;
for i =1:length(G)
    %��ΪA0��1�����Կ���ֱ������ת��
    Ac=sqrt(db2pow(G(i)))*A0;
    SN=quantityOnce(Ac);
    SN=pow2db(SN);
    y(i)=SN;
end
plot(G,y);
title('����Ⱥ�����ȵĹ�ϵ')
xlabel('$\frac{Ac^2}{A_0^2}/dB$','interpreter','latex');
ylabel('�����qSNR/dB');
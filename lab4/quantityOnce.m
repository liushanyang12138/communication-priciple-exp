function [ qSNR ] = quantityOnce( Ac )
%QUANTITYONCE ����ò�ͬAc����������������
%   ���� Ac ����������
    t=0:0.01:10;
xt=Ac*sin(2*pi*t);  % 0-1     0--4096
delta=1/4096;
qxt=xt/delta;
decode=zeros(1,length(qxt));
for i=1:length(qxt)  %��������
    temp=qxt(i);
    if temp>=0 && temp<32
        temp=floor(temp/2)*2+1;
    elseif temp>=32 && temp<64
        temp=floor(temp/2)*2+1;
    
    elseif temp>=64 && temp<128
        temp=floor(temp/4)*4+2;
        
    elseif temp>=128 && temp<256
        temp=floor(temp/8)*8+4;
    
    elseif temp>=256 && temp<512
        temp=floor(temp/16)*16+8;
    
    elseif temp>=512 && temp<1024
        temp=floor(temp/32)*32+16;
    
    elseif temp>=1024 && temp<2048
        temp=floor(temp/64)*64+32;
    elseif temp>=2048 && temp<4096
        temp=floor(temp/128)*128+64;
    end 
    
    if temp<0
        temp=-temp;
            if temp>=0 && temp<32
            temp=floor(temp/2)*2+1;
        elseif temp>=32 && temp<64
            temp=floor(temp/2)*2+1;

        elseif temp>=64 && temp<128
            temp=floor(temp/4)*4+2;

        elseif temp>=128 && temp<256
            temp=floor(temp/8)*8+4;

        elseif temp>=256 && temp<512
            temp=floor(temp/16)*16+8;

        elseif temp>=512 && temp<1024
            temp=floor(temp/32)*32+16;

        elseif temp>=1024 && temp<2048
            temp=floor(temp/64)*64+32;
        elseif temp>=2048 && temp<4096
            temp=floor(temp/128)*128+64;
            end 
        temp=-temp;
    end 
    decode(i)=temp;
end
decode=decode*delta;    
varNoise=mean((decode-xt).^2);   %������������
varSignal=var(xt);               %�����ź�����
qSNR =varSignal/varNoise;       %���������
end


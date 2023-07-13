dt=0.0011;
t=0:dt:10-dt;   
xt=sin(2*pi*t);            %�滭��ԭ�ź�
hold on;
plot(t,xt);       

 
dt_=0.1;    
t_=0:dt_:10-dt_;        %��ԭ�źŽ��г���������Ƶ����10Hz
xt_=sin(2*pi*t_);
delta=1/4096;   %��������С�ֶ�
qxt=xt_/delta;
decode=zeros(1,length(qxt));
for i=1:length(qxt)     %��������
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
    elseif temp==4096
        temp=4032;
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
        elseif temp==4096
            temp=4032;
            end 
            
        temp=-temp;
    end 
    decode(i)=temp;
end
decode=decode*delta;     
plot(t_,decode);
xlabel('t/s');
ylabel('U/v');
title('ԭʼ�źź;���PCM���Ƶ��ź�');
legend('ԭʼ�ź�','����PCM���롢����֮��Ľ��');
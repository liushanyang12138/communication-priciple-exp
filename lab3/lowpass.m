function [ x1 ] = lowpass( fc,fs,signal )
%LOWPASS  ��ͨ�˲��������ð�����˹�˲���
%   fc =�ǽ���Ƶ�ʣ� fs=�ǲ���Ƶ�ʣ�sigal ��ʱ���ź�
  
    [b,a]=butter(3,fc/(fs/2),'low');  % �Ľ׵İ�����˹��ͨ�˲�
    x1=filter(b,a,signal);

end


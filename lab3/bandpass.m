function [x1] = bandpass( fl,fh,fs,signal )
%LOWPASS  ��ͨ�˲��������ð�����˹�˲���
%   fl =�Ǵ�ͨ�˲����ĵ�Ƶ�� fh�Ǵ�ͨ�˲����ĸ�Ƶ��fs�ǲ���Ƶ�� sigal ��ʱ���ź�  ����� x1ҲΪʱ���ź�
  
    [b,a]=butter(10,[fl,fh]/(fs/2),'bandpass');  % �Ľ׵İ�����˹��ͨ�˲�
    x1=filter(b,a,signal);

end


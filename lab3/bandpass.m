function [x1] = bandpass( fl,fh,fs,signal )
%LOWPASS  低通滤波器，采用巴特沃斯滤波器
%   fl =是带通滤波器的低频， fh是带通滤波器的高频，fs是采样频率 sigal 是时域信号  ，输出 x1也为时域信号
  
    [b,a]=butter(10,[fl,fh]/(fs/2),'bandpass');  % 四阶的巴特沃斯低通滤波
    x1=filter(b,a,signal);

end


function [ x1 ] = lowpass( fc,fs,signal )
%LOWPASS  低通滤波器，采用巴特沃斯滤波器
%   fc =是截至频率， fs=是采样频率，sigal 是时域信号
  
    [b,a]=butter(3,fc/(fs/2),'low');  % 四阶的巴特沃斯低通滤波
    x1=filter(b,a,signal);

end


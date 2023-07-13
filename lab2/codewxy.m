clear all;
%------------------2.1DSB已调信号时域波形图
N = 1024;
Ts = 1 / (N - 1);
fs = 1/Ts ;
t = 0: Ts: 1; % 5 / 10 = 0.5s
mt = sqrt(2) * cos (20 * pi * t);
%var(mt)验证功率为1
ct = cos( 200 * pi * t);
S_DSBt = mt .* ct;
subplot(221);
plot(t, S_DSBt);grid on;
title('DSB已调信号时域波形');
xlabel('t'); ylabel('S_{DSB}(t)');xlim([0,0.5]);
hold on;
plot(t, mt);
legend('S_{DSB}(t)', 'm(t)');
%------------------2.2 DSB已调信号功率谱密度何频谱图
S_DSBf = fft(S_DSBt);
xdft = S_DSBf(1:N/2+1);
psdx = (1 /(N * fs)) * abs(xdft) .^ 2;
psdx(2:end - 1) = 2 * psdx(2:end - 1);
subplot(222);
freq = 0:fs / N:fs/2;
plot(freq, psdx);
title('单边带功率谱密度');grid on;
xlabel('f'); ylabel('P(f)/(W/Hz)');
xlim([0,200]);
f = (-N/2: N/2-1) / N * fs;
subplot(223);
plot(f, fftshift(abs(S_DSBf)/N));
title('已调信号频谱');grid on;
xlim([-200,200]);
xlabel('f');ylabel('S_{DSB}(f)');

x=0:0.001:2*pi;
y1=2*exp(-0.5*x);   %����y1��ֵ
y2=cos(4*pi*x);     %����y2��ֵ
plot(x,y1);
xlabel('x');
hold on;
plot(x,y2);
title('y_1=2e^{-0.5x}  and y_2=cos(4\pix)');
legend('y_1=2e^{-0.5x} ' ,' y_2=cos(4\pix)');   %��ͼ�α�ע




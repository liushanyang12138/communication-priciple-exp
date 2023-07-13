x=0:0.001:2*pi;
y1=2*exp(-0.5*x);   %计算y1的值
y2=cos(4*pi*x);     %计算y2的值
plot(x,y1);
xlabel('x');
hold on;
plot(x,y2);
title('y_1=2e^{-0.5x}  and y_2=cos(4\pix)');
legend('y_1=2e^{-0.5x} ' ,' y_2=cos(4\pix)');   %对图形标注




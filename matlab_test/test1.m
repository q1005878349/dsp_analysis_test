clc
clear all
% ##### 生成正弦波
fs = 100; % 采样频率
N = 128;
f_0 = 10; % 原始频率
n = 0:N-1;
t = n/fs; % 各个点的采样时间 = 序号 / 采样频率
x = sin(2 * pi * f_0 * t); % 生成正弦波形
figure(1)
subplot(231)
plot(t, x)
xlabel('时间/s');
ylabel('幅值');
title('时域波形');
grid;

% ##### 对正弦波做fft并画出频谱图
y = fft(x, N);
magnitude = abs(y); %求幅值
f = (0:length(y)-1) * fs/length(y);
subplot(232)
plot(f, magnitude);
xlabel('频率');
ylabel('幅值');
title('频域波形');

% ##### 用ifft恢复信号
xifft = ifft(y);
magx = real(xifft); % 取出实数部分的赋值
ti = [0:length(xifft)-1]/fs;  % x坐标恢复成时间
subplot(233);
plot(ti, magx);
xlabel('时间/s')
ylabel('幅值')
title('ifft后的时域波形')
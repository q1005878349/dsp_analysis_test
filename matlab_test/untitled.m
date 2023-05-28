close all; clear; clc;
fs = 5120; % 采样频率
f = fs/2.56;
T = 1/f; % 信号周期
L=8192; % 采样点数
n = 0:L-1; % 采样时长=采样点数/采样频率
t = n/fs;
df = fs/L; % 频谱分辨率, 决定了fft点数?
fft_num = f/df; % fft点数, 是原采样频率/频谱分辨率
loading_data=importdata('signal.txt');
signal=loading_data';
figure
subplot(3,1,1)
plot(t,signal);
w = hanning(length(n), 'periodic');
% 加汉宁窗后, 幅值成为原来的一半, 乘上2将幅值修正
Y = abs(fft(signal.*w' * 2, L))/(L/2);
% 傅里叶变换完了取一半, 然后要根据频谱分辨率做一次x轴的变换
f_n = (0:fft_num-1) * df;
Y = Y(1:fft_num);
subplot(3,1,2);
plot(f_n, Y);


% 窗口大小，推荐取 2 的幂次
wlen = 256;
% hop size 即移动步长，一般要取一个小于 wlen 的数，推荐取 2 的幂次
hop = wlen/4;
% FFT 点数，理论上应该不小于wlen，推荐取 2 的幂次
nfft = 256;
[S, F, T, P] = spectrogram(signal, w, wlen - hop, nfft, fs);
subplot(3,1,3);
imagesc(T, F, P);xlabel('Samples'); ylabel('Freqency');
title('spectrogram');

wname = 'db4';
[wt,ft,coi] = cwt(signal,'amor',fs);
pcolor(t,ft,abs(wt));shading interp




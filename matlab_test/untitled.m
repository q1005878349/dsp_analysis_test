close all; clear; clc;
fs = 5120; % ����Ƶ��
f = fs/2.56;
T = 1/f; % �ź�����
L=8192; % ��������
n = 0:L-1; % ����ʱ��=��������/����Ƶ��
t = n/fs;
df = fs/L; % Ƶ�׷ֱ���, ������fft����?
fft_num = f/df; % fft����, ��ԭ����Ƶ��/Ƶ�׷ֱ���
loading_data=importdata('signal.txt');
signal=loading_data';
figure
subplot(3,1,1)
plot(t,signal);
w = hanning(length(n), 'periodic');
% �Ӻ�������, ��ֵ��Ϊԭ����һ��, ����2����ֵ����
Y = abs(fft(signal.*w' * 2, L))/(L/2);
% ����Ҷ�任����ȡһ��, Ȼ��Ҫ����Ƶ�׷ֱ�����һ��x��ı任
f_n = (0:fft_num-1) * df;
Y = Y(1:fft_num);
subplot(3,1,2);
plot(f_n, Y);


% ���ڴ�С���Ƽ�ȡ 2 ���ݴ�
wlen = 256;
% hop size ���ƶ�������һ��Ҫȡһ��С�� wlen �������Ƽ�ȡ 2 ���ݴ�
hop = wlen/4;
% FFT ������������Ӧ�ò�С��wlen���Ƽ�ȡ 2 ���ݴ�
nfft = 256;
[S, F, T, P] = spectrogram(signal, w, wlen - hop, nfft, fs);
subplot(3,1,3);
imagesc(T, F, P);xlabel('Samples'); ylabel('Freqency');
title('spectrogram');

wname = 'db4';
[wt,ft,coi] = cwt(signal,'amor',fs);
pcolor(t,ft,abs(wt));shading interp




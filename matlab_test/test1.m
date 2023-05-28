clc
clear all
% ##### �������Ҳ�
fs = 100; % ����Ƶ��
N = 128;
f_0 = 10; % ԭʼƵ��
n = 0:N-1;
t = n/fs; % ������Ĳ���ʱ�� = ��� / ����Ƶ��
x = sin(2 * pi * f_0 * t); % �������Ҳ���
figure(1)
subplot(231)
plot(t, x)
xlabel('ʱ��/s');
ylabel('��ֵ');
title('ʱ����');
grid;

% ##### �����Ҳ���fft������Ƶ��ͼ
y = fft(x, N);
magnitude = abs(y); %���ֵ
f = (0:length(y)-1) * fs/length(y);
subplot(232)
plot(f, magnitude);
xlabel('Ƶ��');
ylabel('��ֵ');
title('Ƶ����');

% ##### ��ifft�ָ��ź�
xifft = ifft(y);
magx = real(xifft); % ȡ��ʵ�����ֵĸ�ֵ
ti = [0:length(xifft)-1]/fs;  % x����ָ���ʱ��
subplot(233);
plot(ti, magx);
xlabel('ʱ��/s')
ylabel('��ֵ')
title('ifft���ʱ����')
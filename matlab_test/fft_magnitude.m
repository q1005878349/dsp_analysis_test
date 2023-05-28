N = 256;
t = linspace(0,2*pi,256);
Fs = 100;
t = [0:N-1]./Fs;

wave = 1*cos(2*pi*10.*t) ...
    + 2*sin(2*pi*15.*t + deg2rad(30)) ...
    + 3*cos(2*pi*20.*t + deg2rad(-30)) ...
    + 4*sin(2*pi*26.5.*t + deg2rad(60)) ...
    ;
Fs = 1/(t(2)-t(1));  
figure
plot(t,wave);
set(gcf,'color','w');
xlabel('time (s)');
ylabel('Amp');
title('пе╨е');

Y = fft(wave);
figure
plot(abs(Y));
set(gcf,'color','w');

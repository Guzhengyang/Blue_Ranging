clc; clear; close all;

path = 'C:\Users\zgu4\Documents\MATLAB\ranging\calibration\';
structs = dir([path '*.log']);
cells = struct2cell(structs);
files =  cells(1,:);

pair = 1;
dd = 1 : 0.01: 10;

file = strcat(path, char(files(1)));
[y, yr, yt] = readFile(file);
R = covariance1(y{pair});
Rr = covariance1(yr{pair});
Rt = covariance1(yt{pair});

%% IFFT
s = IFFT(y{pair}, dd);
sr = IFFT(yr{pair}, dd);
st = IFFT(yt{pair}, dd);
figure; hold on; grid on;
plot(dd, s, 'r');
plot(dd, st, 'g');
plot(dd, sr, 'b');

%% MUSIC
figure; hold on; grid on;

s = MUSIC(R, dd);
plot(dd, s, 'r');

sr = MUSIC(Rr, dd);
st= MUSIC(Rt, dd);
plot(dd, st, 'g');
plot(dd, sr, 'b');


%%
N = 80;
window1 = ones(N,1);
n = 0:N-1; n = n(:);
window2 = sin(pi*n/(N-1)).^2;

nfft = 1024;
s1 = fft(window1,nfft);
s2 = fft(window2, nfft);


semilogx((0:nfft-1)/nfft, 20*log10(abs(s1)), 'b', 'LineWidth', 2)
hold on; grid on;
semilogx((0:nfft-1)/nfft, 20*log10(abs(s2)), 'r', 'LineWidth', 2)
title('Réponse Fréquentielle'); xlabel('Fréquence normalisée')
legend('Rectangle', 'Hanning')


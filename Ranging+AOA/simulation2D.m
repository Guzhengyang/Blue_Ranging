%% Signal
clc; clear; close all;

f = (2400 : 2479)*1e6; f = f(:);
c = 3e8;
k = -c/2/pi;

% Multipath
a = [1, 0.8, 0.5];
d = [3, 7, 12];
theta = [-pi/10, 0, pi/10];
M = 6;
sigma = 0.01;
y = generator2D( a, d, theta, M, sigma );

% Covariance
R = covariance2D(y, M);

% Resolution
dd = linspace(0, 15, 50);
dtheta = linspace(-pi/2, pi/2, 100); 

tic 
s = MUSICAL( R, M, dd, dtheta );
tcalcul = toc;

%% Image
figure
imagesc(dd, dtheta, 10*log10(s))
title('MUSICAL'); xlabel('Distance: m'); ylabel('\theta: rad');

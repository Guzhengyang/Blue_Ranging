clc; clear; close all;

a = [1, 1];
theta = [0, 10];
sigma = 0.1;
dtheta = -45 : 0.05: 45;

% y = generator(a, theta, sigma);
% R = covariance1(y);

Nobs = 10;
Y = generatorN(a, theta, sigma, Nobs);
R = covariance(Y);

% MUSIC vs  GC
figure;
s1 = MUSIC(R, dtheta);
subplot(2,1,1); plot(dtheta, s1); title('MUSIC'); grid on

s2 = GC( R, dtheta );
subplot(2,1,2); plot(dtheta, s2); title('GC'); grid on




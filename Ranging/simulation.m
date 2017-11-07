%% Signal
clc; clear; close all;

f = (2400 : 2479)*1e6; 
% f1 = linspace(2.412, 2.462, 11)*1e9; 
% f2 = linspace(5.18, 5.32, 29)*1e9;
% f3 = linspace(5.5, 5.7, 41)*1e9;
% f4 = linspace(5.745, 5.825, 17)*1e9;
% f = [f1, f2, f3, f4]; f = f(:);
% f = f(:);
c = 3e8;

a = [1, 0.9];
d = [2, 6];
sigma = 0.1;
yc = generator(a, d, sigma);


% Quantification
bits = 12;
yz = quantification(yc, bits);


% Normalisation
yn = yc./ abs(yc);


% Matrice de covariance
% 1 observation
y = yc;
R = covariance1(y);

% plusieurs observations
% Nobs = 10;
% Y = zeros(length(y), Nobs);
% for i = 1 : Nobs
%     Y(:, i) = generator(a, d, sigma);
% end
% R = covariance(Y);

% Precision
dd = 0 : 0.05: 15;

% nombre de composantes
p = 2;

%% SLOPE avec regression

% ang = angle(yc);
% for i = 2 : length(ang)
%     if(ang(i)>ang(i-1))
%         ang(i:end) = ang(i:end)-2*pi;
%     end
% end
%    
% figure; grid on; hold on;
% plot(f/1e6, ang, '.b'); 
% xlabel('Frequency: MHz'); ylabel('Phase: rad')
% X = [ones(size(f)), f];
% beta = (X'*X)\X'*ang;
% 
% plot(f/1e6, beta(1)+f*beta(2), 'r', 'LineWidth', 2)
% dhat = -beta(2)*c/2/pi;

%% SLOPE avec R
dhat = SLOPE(R);
dhat

%% IFFT
tic
s = IFFT( y, dd );
[ peaks, indexs ] = findPeaks( s );
tcalcul = toc;

figure; grid on; hold on;
plot(dd, s, 'b', 'linewidth', 2); 
plot(dd(indexs), peaks, 'color', 'r', 'Marker', '*', 'MarkerSize', 10, 'linewidth', 2, 'LineStyle','none'); 
xlabel('Distance: m'); 
title(['IFFT     t = ' num2str(tcalcul) 's     d_1 = ' num2str(dd(indexs(1))) 'm, d_2 = ' num2str(dd(indexs(2))) 'm' ]); 
axis([0 max(dd) 0 1.2*max(s)])

%% FISTA
alpha = 20; kmax = 1e3; 
tic
s = FISTA(y, dd, alpha, kmax);
[ peaks, indexs ] = findPeaks( s );
tcalcul = toc;

figure; grid on; hold on;
plot(dd, s, 'b', 'linewidth', 2); 
plot(dd(indexs), peaks, 'color', 'r', 'Marker', '*', 'MarkerSize', 10, 'linewidth', 2, 'LineStyle','none'); 
xlabel('Distance: m'); 
title(['FISTA     t = ' num2str(tcalcul) 's     d_1 = ' num2str(dd(indexs(1))) 'm, d_2 = ' num2str(dd(indexs(2))) 'm' ]); 
axis([0 max(dd) 0 1.2*max(s)])

%% FISTA2
alpha = 20;
tic
[ s, dfista2 ] = FISTA2( yc, alpha );
[ peaks, indexs ] = findPeaks( s );
tcalcul = toc;

figure; grid on; hold on;
plot(dfista2, s, 'b', 'linewidth', 2); 
plot(dfista2(indexs), peaks, 'color', 'r', 'Marker', '*', 'MarkerSize', 10, 'linewidth', 2, 'LineStyle','none'); 
xlabel('Distance: m'); 
title(['FISTA2     t = ' num2str(tcalcul) 's     d_1 = ' num2str(dfista2(indexs(1))) 'm, d_2 = ' num2str(dfista2(indexs(2))) 'm' ]); 
axis([0 max(dd) 0 1.2*max(s)])

%% MUSIC
tic
s = MUSIC( R, dd, p );
[ peaks, indexs ] = findPeaks( s );
tcalcul = toc;

figure; grid on; hold on;
plot(dd, s, 'b', 'linewidth', 2); 
plot(dd(indexs), peaks, 'color', 'r', 'Marker', '*', 'MarkerSize', 10, 'linewidth', 2, 'LineStyle','none'); 
xlabel('Distance: m'); 
title(['MUSIC     t = ' num2str(tcalcul) 's     d_1 = ' num2str(dd(indexs(1))) 'm, d_2 = ' num2str(dd(indexs(2))) 'm' ]);
axis([0 max(dd) 0 1.2*max(s)])

%% Min-Norm
tic
s = Min_Norm( R, dd, p );
[ peaks, indexs ] = findPeaks( s );
tcalcul = toc;

figure; grid on; hold on;
plot(dd, s, 'b', 'linewidth', 2);
plot(dd(indexs), peaks, 'color', 'r', 'Marker', '*', 'MarkerSize', 10, 'linewidth', 2, 'LineStyle','none');
xlabel('Distance: m'); 
title(['Min-Norm     t = ' num2str(tcalcul) 's     d_1 = ' num2str(dd(indexs(1))) 'm, d_2 = ' num2str(dd(indexs(2))) 'm' ]);
axis([0 max(dd) 0 1.2*max(s)])

%% Root-MUSIC
tic
dhat = Root_MUSIC( R, p );
dhat = sort(dhat);
tcalcul = toc;

figure; grid on; hold on;
stem(dhat, ones(size(dhat))/2, 'b', 'linewidth', 2);
xlabel('Distance: m'); 

title(['Root-MUSIC     t = ' num2str(tcalcul) 's,     d_1 = ' num2str(dhat(1)) 'm, d_2 = ' num2str(dhat(2)) 'm']); 
axis([0 max(dd) 0 1])

%% ESPRIT
tic
dhat  = ESPRIT( R, p );
dhat = sort(dhat);
tcalcul = toc;

figure; grid on; hold on;
stem(dhat, ones(size(dhat))/2, 'b', 'linewidth', 2);
xlabel('Distance: m'); 
title(['ESPRIT     t = ' num2str(tcalcul) 's,     d_1 = ' num2str(dhat(1)) 'm, d_2 = ' num2str(dhat(2)) 'm']); 
axis([0 max(dd) 0 1])

%% OPM
tic 
s = OPM( R, dd, p );
[ peaks, indexs ] = findPeaks( s );
tcalcul = toc;

figure; grid on; hold on;
plot(dd, s, 'b', 'linewidth', 2);
plot(dd(indexs), peaks, 'color', 'r', 'Marker', '*', 'MarkerSize', 10, 'linewidth', 2, 'LineStyle','none');
xlabel('Distance: m'); 
title(['OPM     t = ' num2str(tcalcul) 's     d_1 = ' num2str(dd(indexs(1))) 'm, d_2 = ' num2str(dd(indexs(2))) 'm']); 
axis([0 max(dd) 0 1.2*max(s)])

%% Root-OPM
tic 
dhat = Root_OPM(R, p);
dhat = sort(dhat);
tcalcul = toc;

figure; grid on; hold on;
stem(dhat, ones(size(dhat))/2, 'b', 'linewidth', 2);
xlabel('Distance: m'); 
title(['Root-OPM     t = ' num2str(tcalcul) 's     d_1 = ' num2str(dhat(1)) 'm, d_2 = ' num2str(dhat(2)) 'm']); 
axis([0 max(dd) 0 1])

%% SWEDE
tic
s = SWEDE( R, dd, 4 );
[ peaks, indexs ] = findPeaks( s );
tcalcul = toc;

figure; grid on; hold on;
plot(dd, s, 'b', 'linewidth', 2);
plot(dd(indexs), peaks, 'color', 'r', 'Marker', '*', 'MarkerSize', 10, 'linewidth', 2, 'LineStyle', 'none');
xlabel('Distance: m'); 
title(['SWEDE     t = ' num2str(tcalcul) 's     d_1 = ' num2str(dd(indexs(1))) 'm, d_2 = ' num2str(dd(indexs(2))) 'm']); 
axis([0 max(dd) 0 1.2*max(s)])

%% ESPRITWED
tic
dhat = ESPRITWED(R, 4);
dhat = sort(dhat);
tcalcul = toc;

figure; grid on; hold on;
stem(dhat, ones(size(dhat))/2, 'b', 'linewidth', 2);
xlabel('Distance: m'); 
title(['ESPRITWED     t = ' num2str(tcalcul) 's     d_1 = ' num2str(dhat(1)) 'm, d_2 = ' num2str(dd(indexs(2))) 'm']  ); 
axis([0 max(dd) 0 1])

%% GC
tic 
s = GC( R, dd, p );
[ peaks, indexs ] = findPeaks( s );
tcalcul = toc;

figure; grid on; hold on;
plot(dd, s, 'b', 'linewidth', 2);
plot(dd(indexs), peaks, 'color', 'r', 'Marker', '*', 'MarkerSize', 10, 'linewidth', 2, 'LineStyle', 'none');
xlabel('Distance: m'); 
title(['GC     t = ' num2str(tcalcul) 's     d_1 = ' num2str(dd(indexs(1))) 'm, d_2 = ' num2str(dd(indexs(2))) 'm']); 
axis([0 max(dd) 0 1.2*max(s)])
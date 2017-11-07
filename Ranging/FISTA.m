function s = FISTA( y, dd, alpha, kmax )
%FISTA Summary of this function goes here
%   Detailed explanation goes here

f = (2400 : 2479)*1e6; f = f(:);

% f1 = linspace(2.412, 2.462, 11)*1e9; 
% f2 = linspace(5.18, 5.32, 29)*1e9;
% f3 = linspace(5.5, 5.7, 41)*1e9;
% f4 = linspace(5.745, 5.825, 17)*1e9;
% f = [f1, f2, f3, f4]; f = f(:);

c = 3e8;
dt = dd/c;

F = zeros(length(y), length(dd));
for i = 1 : length(y)
    for j = 1 : length(dd)
        F(i, j) = exp(-1i * 2*pi * f(i) * dt(j));
    end
end
t = 1/norm(F)^2;
lambda = t * alpha;


xold = rand(length(dd), 1);
xnew = prox(xold-t*F'*(F*xold-y), lambda);
k = 2;

fig = figure;
while(k < kmax)
	xtemp = xnew + (k-1)/(k+2) * (xnew-xold);
	xold = xnew;
	xnew = prox(xtemp - t*F'*(F*xtemp-y), lambda);

    figure(fig);
    plot(dd, abs(xnew)); grid on;
    title(['k = ' num2str(k)]); 
    pause(0.01);
    k = k + 1;
end

s = abs(xnew);
s = s/max(s);

end


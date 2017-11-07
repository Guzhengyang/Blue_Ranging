function [ s, dd ] = FISTA2( y, alpha )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
f = (2400 : 2479)*1e6; f = f(:);
c = 3e8;
dd = 0 : 1 : 10;
kmax = [1000, 1000];
% fig = figure;

layer = 1;
while layer <= 2 
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
    while(k < kmax(layer))
        xtemp = xnew + (k-1)/(k+2) * (xnew-xold);
        xold = xnew;
        xnew = prox(xtemp - t*F'*(F*xtemp-y), lambda);      
%         figure(fig);
%         plot(dd, abs(xnew)); grid on;
%         title(['k = ' num2str(k)]);
%         pause(0.01);
        k = k + 1;
    end
    
    s = abs(xnew);
    [ peaks, indexs ] = findPeaks( s );
    Npeak = length(peaks); 
    ddtemp = [];
    if layer == 1
        for i = 1 : Npeak
            ddtemp = [ddtemp,dd(indexs(i))-1 : 0.05: dd(indexs(i))+1];
        end
        dd = ddtemp;
    end
    
    layer = layer + 1;
end


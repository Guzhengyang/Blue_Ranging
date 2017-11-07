function d = SLOPE( R )
%PENTE Summary of this function goes here
%   Detailed explanation goes here

f = (2400 : 2479)*1e6; f = f(:);
c = 3e8;
k = -c/2/pi;

N = size(R, 1);
R2 = R(2:N, 1:N-1);
d = trace(angle(R2))/(f(N)-f(1)) * k;

end


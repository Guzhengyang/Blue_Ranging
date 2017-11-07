function s = Min_Norm( R, dd, p )
%MIN_NORM Summary of this function goes here
%   Detailed explanation goes here

f = (2400 : 2479)*1e6; f = f(:);
c = 3e8;
dt = dd/c;
s = zeros(size(dt));
[ Es, Eb ] = decomposition( R, p );
N = size(Es, 1);

gt = Es(1, :);
g = gt(:);
G = Es(2:end, :);
w1 = G*conj(g)/(1-g'*g);
w = [1; -w1];

for i = 1 : length(dt)
   v = exp(-2*1i*pi*f(1:N)*dt(i));
   s(i) = 1/ (abs(v'*w))^2;
end

s = s/max(s);

end


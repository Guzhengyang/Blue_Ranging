function s = MUSIC( R, dd, p )
%MUSIC Summary of this function goes here
%   Detailed explanation goes here

f = (2400 : 2479)*1e6; f = f(:);
c = 3e8;
dt = dd/c;
s = zeros(size(dt));

[ Es, Eb ] = decomposition( R, p );
N = size(Es, 1);

for i = 1 : length(dt)
    v = exp(-2*1i*pi*f(1:N)*dt(i));
    s(i) = 1/(v'*(Eb*Eb')*v);
end

s = abs(s);
s = s/max(s);
end


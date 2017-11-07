function s = MUSIC( R, dtheta )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

dtheta = dtheta/180 * pi;
f = 2.4e9;
c = 3e8;
D = c/f/2;
s = zeros(size(dtheta));

[ Es, Eb ] = decomposition( R );
M = size(Es, 1);

for i = 1 : length(dtheta)
    v = exp(2*1i*pi*f * D*sin(dtheta(i))/c * (0:M-1)');
    s(i) = 1/(v'*(Eb*Eb')*v);
end

s = abs(s);
s = s/max(s);

end


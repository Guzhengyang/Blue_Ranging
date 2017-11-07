function s = SWEDE( R, dd, p )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

f = (2400 : 2479)*1e6; f = f(:);
c = 3e8;
dt = dd/c;
s = zeros(size(dt));

N = size(R, 1);
range1 = 1:p;
range2 = p+1 : 2*p;
range3 = 2*p+1 : N;
R12 = R(range1, range2);
R21 = R(range2, range1);
R31 = R(range3, range1);
R32 = R(range3, range2);

U = [R21, R32'*R31/((R31'*R31)')*R12, R32']';
Pv = eye(N) - U/(U'*U)*U';

for i = 1 : length(dt)
    v = exp(-2*1i*pi*f(1:N)*dt(i));
    s(i) = 1/(v'*Pv*v);
end

s = abs(s);
s = s/max(s);
end


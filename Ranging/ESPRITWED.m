function d = ESPRITWED( R, p )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
f = (2400 : 2479)*1e6; f = f(:);
c = 3e8;
df = f(2) - f(1);

N = size(R, 1);
range1 = 1:p;
range2 = p+1 : 2*p;
range3 = 2*p+1 : N;
R12 = R(range1, range2);
R21 = R(range2, range1);
R31 = R(range3, range1);
R13 = R(range1, range3);
R32 = R(range3, range2);

G = [R12; R21/(R13*R31)*R13*R32; R32];
U1 = G(1:N-1, :);
U2 = G(2:N, :);

K = (U2'*U2)\U2'*U1;
vp = eig(K);
t = angle(vp)/2/pi/df;



d = t * c;
d = d(d>0);

end


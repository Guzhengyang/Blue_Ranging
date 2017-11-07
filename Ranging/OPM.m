function s = OPM( R, dd, p )
%OMP Summary of this function goes here
%   Detailed explanation goes here

f = (2400 : 2479)*1e6; f = f(:);
c = 3e8;
dt = dd/c;
s = zeros(size(dt));

N = size(R, 1);
G = R(:,1:p);
H = R(:,p+1:end);
P = (G'*G)\G'*H;
Q = [P', -eye(N-p)]';

Q0 = Q*((Q'*Q))^(-0.5);


for i = 1 : length(dt)
    v = exp(-2*1i*pi*f(1:N)*dt(i));
    s(i) = 1/abs(v'*(Q0*Q0')*v);
end

s = s/max(s);

end


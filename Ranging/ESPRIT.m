function d = ESPRIT( R, p)
%ESPRIT Summary of this function goes here
%   Detailed explanation goes here

f = (2400 : 2479)*1e6; f = f(:);
df = f(2) - f(1);

c = 3e8;

[Es, Eb] = decomposition(R, p);
Es1 = Es(1:end-1, :);
Es2 = Es(2:end, :);

% LS
% K = inv(Es1'*Es1) * Es1' * Es2;
% t = (-angle(eig(K))/2/pi/df);

% TLS
X = [Es2, Es1];
[U,S,V] = svd(X);
V12 = V(1:p,p+1:end);
V22 = V(p+1:end,p+1:end);
K = -V12/V22;
vp = eig(K);
t = angle(vp)/2/pi/df;

d = t * c;
d = d(d>0);

end


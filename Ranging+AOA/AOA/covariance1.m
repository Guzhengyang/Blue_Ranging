function R = covariance1( y, effec )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    effec = 2/3;
end


N = length(y);
L = round(N*effec);
Nobs = N+1-L;
Y = zeros(L,Nobs);
for i = 1 : Nobs
    Y(:,i) = y(i:i+L-1);
end
R = 1/Nobs * (Y*Y');


end


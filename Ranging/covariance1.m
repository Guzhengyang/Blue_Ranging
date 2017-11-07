function R = covariance1( y, L, dN )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    L = 60;
    dN = 1;
end
% N = length(y);
% L = round(N*effec);
% Nobs = N+1-L;
% Y = zeros(L,Nobs);
% for i = 1 : Nobs
%     Y(:,i) = y(i:i+L-1);
% end
% R = 1/Nobs * (Y*Y');

N = size(y, 1);
M = N - (L-1)*dN;
Y = zeros(L,M);

for i = 1 : M
    Y(:,i) = y(i:dN:i+(L-1)*dN);
end
R = 1/M * (Y*Y');

end


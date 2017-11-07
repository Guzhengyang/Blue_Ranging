function R = covariance2D( y, M, effec )
%COVARIANCE2D Summary of this function goes here
%   Detailed explanation goes here
if nargin < 3
    effec = 2/3;
end

N = length(y)/M;
L = round(N*effec);
Nobs = N+1-L;

Y = zeros(L*M, Nobs);
for i = 1 : Nobs
    yTemp = zeros(L*M, 1);
    for m = 1 : M
        yTemp((m-1)*L+1 : m*L) = y((m-1)*N+i: (m-1)*N+i+L-1);
    end
    Y(:,i) = yTemp;
end

R = 1/Nobs * (Y*Y');

end


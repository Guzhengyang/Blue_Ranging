function R = covariance( Y, effec )
%COVARIANCE Summary of this function goes here
%   Detailed explanation goes here
if nargin < 2
    effec = 0.8;
end


[N, Nobs] = size(Y);

L = round(N * effec);
M = N + 1 - L;
Rm = zeros(L,L,M);

for i = 1 : M
    Ym = Y(i:i+L-1,:);
    Rm(:,:,i) = 1/Nobs * (Ym * Ym');
end 

% MSSP
% J = fliplr(eye(L));
% R = zeros(L, L);
% for i = 1 : M
%     R = R + J*conj(Rm(:,:,i))*J;
% end
% R = 1/2/M * R;

% SSP
R = mean(Rm, 3);

% Toeplitz
% R = 1/Nobs * (Y * Y');
% R = toeplitz(R(:,1), R(1,:));

end


function s = IFFT( y, dd )
%IFFT Summary of this function goes here
%   Detailed explanation goes here
if nargin < 2
    dd = 0 : 0.05: 15;
end

f = (2400 : 2479)*1e6; f = f(:);
c = 3e8;
dt = dd/c;
s = zeros(size(dt));

% 
% N = length(y);
% n = 0:N-1; n = n(:);
% window = sin(pi*n/(N-1)).^2;
% y = y.*window;

for i = 1 : length(dt)
    s(i) = sum(y .* exp(2*1i*pi*f(:)*dt(i)));
end

s = abs(s);
s = s/max(s);

% nfft = 2048;
% dd = (0 : nfft-1)/nfft * 300;
% s = abs(ifft(y, nfft));


end


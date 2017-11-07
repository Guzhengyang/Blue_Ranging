function yz = quantification( yc, bits )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
e = exp(1);
bits = bits + 1;

delta = 2*e / (2^bits);
I = round((real(yc)+e)/delta) - 2^(bits-1);
Q = round((imag(yc)+e)/delta) - 2^(bits-1);

yz = I + 1i * Q;

end


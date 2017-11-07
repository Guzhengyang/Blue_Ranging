function s = GC( R, dd, p )
%GC Summary of this function goes here
%   Detailed explanation goes here

f = (2400 : 2479)*1e6; f = f(:); c = 3e8;
s = zeros(size(dd));


L = size(R, 1);

a = exp(-2*1i*pi*f(1:L)* dd(1)/c);
b = R*a/norm(R*a);
[ GBefore, gBefore ] = Krylov( R, b, p );

for i = 2 : length(dd)
    a = exp(-2*1i*pi*f(1:L)* dd(i)/c);
    b = R*a/norm(R*a);
    [ GTemp, gTemp ] = Krylov( R, b, p );
    s(i) = 1/norm(gTemp'*[GBefore,gBefore])^2 ;
    GBefore = GTemp;
    gBefore = gTemp;
end

s = s/max(s);


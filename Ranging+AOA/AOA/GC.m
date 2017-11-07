function s = GC( R, dtheta )
%GC Summary of this function goes here
%   Detailed explanation goes here
p = 2;

f = 2.4e9; 
c = 3e8; 
D = c/f/2; 

s = zeros(length(dtheta), 1);
M = size(R, 1);

a = exp(2*1i*pi*f * D*sin(dtheta(1))/c * (0:M-1)');
b = R*a/norm(R*a);
[ GBefore, gBefore ] = Krylov( R, b, p );

for i = 2 : length(dtheta)
    a = exp(2*1i*pi*f * D*sin(dtheta(i))/c * (0:M-1)');
    b = R*a/norm(R*a);
    [ GTemp, gTemp ] = Krylov( R, b, p );
    s(i) = 1/norm(gTemp'*[GBefore,gBefore])^2 ;
    GBefore = GTemp;
    gBefore = gTemp;
end

s = s/max(s);


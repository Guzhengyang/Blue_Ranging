function y = generator2D( a, d, theta, M, sigma )
%GENERATOR Summary of this function goes here
%   Detailed explanation goes here
f = (2400 : 2479)*1e6; 
c = 3e8; 
p = length(a);
N = length(f);
h = zeros(N*M, p);
b = sigma*(randn(N*M, 1) + 1i*randn(N*M, 1));
Delta = c/max(f)/2; 

for i = 1 : p
    for n = 1 : N
        for m = 1 : M
            h((m-1)*N+n, i) = a(i)*exp(-1i*2*pi*f(n)* (d(i)/c + (m-1)*Delta*sin(theta(i))/c));
        end
    end
end

y = sum(h, 2) + b ;
            
end


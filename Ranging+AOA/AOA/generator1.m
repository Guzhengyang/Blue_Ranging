function y = generator1( a, theta, sigma )
%GENERATOR Summary of this function goes here
%   Detailed explanation goes here
f = 2.4e9; 
c = 3e8; 
M = 10;
theta = theta/180 * pi;
p = length(a);
h = zeros(M, p);
b = sigma*(randn(M, 1) + 1i*randn(M, 1));
D = c/f/2; 

for i = 1 : p
     h(:,i) = a(i) * exp(1i*2*pi*f * D*sin(theta(i))/c * (0:M-1)');
end

y = sum(h, 2) + b ;
            
end
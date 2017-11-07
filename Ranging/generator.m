function y = generator(a, d, sigma)


f = (2400 : 2479)*1e6; 
% 
% f1 = linspace(2.412, 2.462, 11)*1e9; 
% f2 = linspace(5.18, 5.32, 29)*1e9;
% f3 = linspace(5.5, 5.7, 41)*1e9;
% f4 = linspace(5.745, 5.825, 17)*1e9;
% f = [f1, f2, f3, f4]; f = f(:);

c = 3e8; 
t = d/c;
p = length(a);
N = length(f);
h = zeros(N, p);
b = sigma*(randn(N, 1) + 1i*randn(N, 1));

for i = 1 : p
    h(:,i) = a(i) * exp(-1i * 2*pi* f(:) * t(i));
end

y = sum(h, 2) + b;

end


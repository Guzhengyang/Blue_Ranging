function d = Root_MUSIC( R, p )
%ROOT_MUSIC Summary of this function goes here
%   Detailed explanation goes here
f = (2400 : 2479)*1e6; f = f(:); 

df = f(2) - f(1);
c = 3e8;

[Es, Eb] = decomposition(R, p);
N = size(Es, 1);
p = size(Es, 2);
Pb = Eb*Eb';
A = zeros(N, 2*N-1);

for i = 1 : N
    A(i,:) = [zeros(1,N-i), Pb(i,:), zeros(1,i-1)];
end
a = fliplr(sum(A));
r0 = roots(a);
r1 = r0(abs(r0)<=1);
[~, index] = sort(1-abs(r1), 'ascend');
rp = r1(index(1:p));

h = figure;
ang = 0 : 0.01 : 2*pi;
figure(h); hold on; grid on;
plot(cos(ang), sin(ang), 'r');
plot(real(r0), imag(r0), 'ob');
plot(real(rp), imag(rp), 'r*');
xlabel('Real'); ylabel('Imag'); title('Zéros')

d = -angle(rp)/2/pi/df * c;
d = d(d>0);

end


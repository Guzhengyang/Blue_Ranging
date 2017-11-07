function s = MUSICAL( R, M, dd, dtheta )
%MUSICAL Summary of this function goes here
%   Detailed explanation goes here
if nargin < 3 
    dd = linspace(0, 15, 50);
    dtheta = linspace(-pi/2, pi/2, 100); 
end


f = (2400 : 2479)*1e6; f = f(:);
c = 3e8;
Delta = c/max(f)/2; 

[V, D] = eig(R);
lambdas = sort(diag(D), 'descend');

% figure; plot(lambdas, 'o'); title('Valeurs Propres : \lambda'); grid on;

p = sum(lambdas>mean(lambdas(lambdas>0)));
NTotal = size(R, 1);
Eb = V(:, 1:NTotal-p);

N = NTotal/M;
s = zeros(length(dtheta), length(dd));

for id = 1 : length(dd)
    for itheta = 1 : length(dtheta)
        v = zeros(NTotal, 1);
        for m = 1 : M
            v((m-1)*N+1: m*N) = exp(-2*1i*pi*f(1:N)*(dd(id)/c+(m-1)*Delta*sin(dtheta(itheta))/c));
        end
        s(itheta, id) = 1/abs((v'*(Eb*Eb')*v));
    end
end
           
       
end


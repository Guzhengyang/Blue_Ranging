function [ Es, Eb ] = decomposition( R )
%DECOMPOSITION Summary of this function goes here
%   Detailed explanation goes here

N = size(R, 1);
[V, D] = eig(R);

% figure
% plot(lambdas, 'o'); title('Valeurs Propres : \lambda'); grid on;

% p = sum(lambdas>mean(lambdas(lambdas>0)));
% p = findDimension( lambdas, 10 )

p = 2;

Es = V(:, N-p+1:end);
Eb = V(:, 1:N-p);

end


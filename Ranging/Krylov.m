function [ G, g ] = Krylov( R, b, D )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
G = zeros(size(R, 1), D);

d = b; G(:,1) = b; rho = norm(G(:,1))^2;

for i = 2 : D
    v = R * d;
    alpha = rho/(d'*v);
    G(:,i) = G(:,i-1) - alpha*v;
    rho = norm(G(:,i))^2;
    beta = norm(G(:,i))^2 / norm(G(:,i-1))^2;
    d = beta*d + G(:,i);
end

v = R * d;
alpha = rho/(d'*v);
g = G(:,D) - alpha*v;

for i = 1 : D
    G(:,i) = G(:,i)/norm(G(:,i));
end


function p = findDimension( lambdas )
%AIC Summary of this function goes here
%   Detailed explanation goes here
%L = length(lambdas);


% AIC
% cost = zeros(L, 1);
% for k = 1 : L
%     lognum = prod(lambdas(k+1:L).^(1/(L-k)));
%     logdenum = 1/(L-k)*sum(lambdas(k+1:L));
%     cost(k) = -2*Nobs*(L-k)*log(lognum/logdenum) + 2*k*(2*L-k);
% end
% [~, p] = min(cost);

% MDL
% cost = zeros(L, 1);
% for k = 1 : L
%     lognum = prod(lambdas(k+1:L).^(1/(L-k)));
%     logdenum = 1/(L-k)*sum(lambdas(k+1:L));
%     cost(k) = -Nobs*(L-k)*log(lognum/logdenum) + 0.5*k*(2*L-k)*log(Nobs);
% end
% [~, p] = min(cost);

% g1 - g2
L = length(lambdas);
g1 = zeros(L-1, 1);
g2 = zeros(L-1, 1);
u = zeros(L-1, 1);
epsi = zeros(L-1, 1);

for k = 1 : L-1
    u(k) = (1/(L-k)) * sum(lambdas(k+1:L));
end

a = 1/ max((lambdas(1:L-1)-u)./u);

for k = 1 : L-1
    g1(k) = lambdas(k+1) / sum(lambdas(2:L));
    epsi(k) = 1 - a*(lambdas(k)-u(k))/u(k);
end
 
for k = 1 : L-1
    g2(k) = epsi(k)/ sum(epsi);
end
cost = g1 - g2;
p = find(cost<0, 1, 'first') - 1;

figure
subplot(2,1,1); hold on; grid on;
plot(1:10, g1(1:10), 'b-s', 'lineWidth', 2)
plot(1:10, g2(1:10), 'g-d', 'lineWidth', 2);
legend('g_1(k)', 'g_2(k)'); title('Fonctions Discriminantes')
subplot(2,1,2); hold on; grid on;
plot(1:10, cost(1:10), 'b-*', 'lineWidth', 2);
plot(0:10, zeros(1,11), 'r');
legend('C_{new}(k)', 'Référence'); title('Fonction de coût')

end



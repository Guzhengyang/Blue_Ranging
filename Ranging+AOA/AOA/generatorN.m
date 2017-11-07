function Y = generatorN( a, theta, sigma, Nobs )
%GENERATORN Summary of this function goes here
%   Detailed explanation goes here
for i = 1 : Nobs
    Y(:,i) = generator1(a, theta, sigma);
end

end


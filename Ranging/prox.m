function xnew = prox(xold, lambda)

M = length(xold);
xnew = zeros(M, 1);

for i = 1 : M
    if(abs(xold(i)) < lambda)
        xnew(i) = 0;
    else
        xnew(i) = xold(i) * (abs(xold(i)) - lambda)/((abs(xold(i))));
    end
end

end

	

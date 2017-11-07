function [ peaks, indexs ] = findPeaks( s )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
N = length(s);
indexs = [];
peaks = [];
seuil = max(mean(s));

if (s(1)>s(2) && s(1)>seuil)
    indexs = [indexs, 1];
    peaks = [peaks, s(1)];
end

for i = 2 : N-1
    if(s(i)>s(i-1) && s(i)>s(i+1) && s(i)>seuil)
        indexs = [indexs, i];
        peaks = [peaks, s(i)];
    end
end

if (s(N)>s(N-1) && s(i)>seuil)
    indexs = [indexs, N];
    peaks = [peaks, s(N)];
end

end


function [ peak, index ] = findPeak( s )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

% N = length(s);
% index = 1;
% peak = s(index);
% seuil = max(0.2, mean(s));
% 
% for i = 2 : N-1  
%     if(s(i)>s(i-1) && s(i)>s(i+1) && s(i)>seuil)
%         index = i;
%         peak = s(i);
%         break;
%     end    
% end

[ peaks, indexs ] = findPeaks( s );
% [peak, idx] = max(peaks);
% index = indexs(idx);

peak = peaks(1);
index = indexs(1);



end


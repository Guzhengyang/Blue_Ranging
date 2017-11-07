function theta = ESPRIT( R )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

f = 2.4e9; 
c = 3e8; 
D = c/f/2; 

[Es, ~] = decomposition(R);
Es1 = Es(1:end-1, :);
Es2 = Es(2:end, :);


% LS
K = (Es1'*Es1)\Es1' * Es2;
sinTheta = (angle(eig(K))/2/pi/f/D*c);
theta = asin(sinTheta)/pi * 180;


end


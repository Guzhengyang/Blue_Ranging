function [y, yr, yt] = readFile( file )
%READFILE Summary of this function goes here
%   Detailed explanation goes here
fileID = fopen(file);
while(strncmpi(fgets(fileID),'FIRMWARE',8))
end

y = cell(4,1); yr = cell(4,1); yt = cell(4,1);
M11 = textscan(fileID, '%f%f%f%f%f%f%f%f%f', 'HeaderLines',1, 'Delimiter', ',');
M12 = textscan(fileID, '%f%f%f%f%f%f%f%f%f', 'HeaderLines',1, 'Delimiter', ',');
M21 = textscan(fileID, '%f%f%f%f%f%f%f%f%f', 'HeaderLines',1, 'Delimiter', ',');
M22 = textscan(fileID, '%f%f%f%f%f%f%f%f%f', 'HeaderLines',1, 'Delimiter', ',');
fclose(fileID);
M = {M11, M12, M21, M22};
for k = 1 : 4
    CSIr = M{k}{7} + 1i*M{k}{9};
    CSIt = M{k}{6} + 1i*M{k}{8};
    y{k} = CSIt.*exp(-1i*angle(CSIr))/abs(CSIt(1));
    yr{k} = M{k}{7} + 1i*M{k}{9};
    yt{k} = M{k}{6} + 1i*M{k}{8};
end

end


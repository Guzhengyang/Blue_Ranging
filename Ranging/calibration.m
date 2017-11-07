clc; clear; close all;
structs = dir('calibration\*.log');
cells = struct2cell(structs);
files =  cells(1,:);
path = 'C:\Users\zgu4\Documents\MATLAB\ranging\calibration\';

dd = 0 : 0.05: 30;
distances = 50 : 50 : 700; 
distances = distances(:);
destimes = zeros(length(distances), 4);
stds = zeros(length(distances), 4);
dTemps = cell(length(distances), 1); 
fig = figure; 

for i = 1 : length(distances)
    str = strcat(num2str(distances(i)), '_');
    filesTemp = files(strncmp(str, files, length(str)));
    dTemp = zeros(length(filesTemp), 4);
    for j = 1 : length(filesTemp)
        y = readFile(strcat(path, char(filesTemp(j))));
        for k = 1 : 4
            R = covariance1(y{k});
            
            s = MUSIC(R, dd);
            [ peak, index ] = findPeak( s );
            dTemp(j, k) = dd(index);
            
            figure(fig); clf; grid on; hold on;
            plot(dd, s, 'b', 'linewidth', 2);
            plot(dd(index), peak, 'color', 'r', 'Marker', '*', 'MarkerSize', 10, 'linewidth', 2);
            axis([0 max(dd) 0 1.2*max(s)]);
            title([filesTemp(j) ' ' num2str(k)])

%             res = Root_OPM(R);
%             dTemp(j, k) = res(1);
%             figure(fig); clf; grid on; hold on;
%             stem(res, ones(size(res)), 'b', 'linewidth', 2);
%             plot(dTemp(j, k), 1, 'color', 'r', 'Marker', '*', 'MarkerSize', 10, 'linewidth', 2);
%             axis([0 max(dd) 0 1.2]);
%             title([filesTemp(j) ' ' num2str(k)])
            
        end
    end
    dTemps{i} = dTemp;
    destimes(i,:) = mean(dTemp);
    stds(i,:) = std(dTemp);
end

%% 
beta = zeros(2, 4);
for i = 1 : 4
    X = [ones(size(destimes(:,i))) destimes(:,i)];
    y = distances/100;
    beta(:,i) = (X'*X)\X'*y;
end
    

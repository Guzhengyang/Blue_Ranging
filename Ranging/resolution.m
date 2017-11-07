clc; clear;

a = [1, 0.8];
d1 = 2;
sigma = 0.1;
d2 = 7 : -0.05: 2;
f = (2400 : 2479)*1e6; f = f(:);

Nobs = 1;
YY = cell(length(d2), 1);
for i = 1 : length(d2)
    Y = zeros(length(f), Nobs);
    for j = 1 : Nobs
        
        Y(:,j) = generator(a, [d1, d2(i)], sigma);
    end
    YY{i} = Y;
end

% Résolution
dd = 0 : 0.05: 15;
p = 2;
%% Comparaison
fig1 = figure;
methodes = {'IFFT', 'MUSIC', 'Min-Norm', 'OPM', 'SWEDE', 'GC', 'Root-MUSIC', 'ESPRIT', 'Root-OPM', 'ESPRITWED'};
choix = [1, 4, 8];
erreur = zeros(length(d2), length(methodes));

for k = choix
    disp(methodes(k))
    for i = 1 : length(d2)
        switch k
            case 1
                y = YY{i};
%                 y = quantification(y, Nbit);
                s = IFFT( y );
                [ peak, index ] = findPeak( s );
                destime1 = dd(index);
            case 2
                %                 Y = YY(:,:,i);
                %                 R = covariance(Y);
                y = YY{i};
%                 y = quantification(y, Nbit);
                R = covariance1(y);
                s = MUSIC( R, dd, p );
                [ peak, index ] = findPeak( s );
                destime1 = dd(index);
            case 3
                %                 Y = YY(:,:,i);
                %                 R = covariance(Y);
                y = YY{i};
%                 y = quantification(y, Nbit);
                R = covariance1(y);
                s = Min_Norm( R, dd, p );
                [ peak, index ] = findPeak( s );
                destime1 = dd(index);
            case 4
                %                 Y = YY(:,:,i);
                %                 R = covariance(Y);
                y = YY{i};
%                 y = quantification(y, Nbit);
                R = covariance1(y);
                s = OPM(R, dd, p);
                [ peak, index ] = findPeak( s );
                destime1 = dd(index);
            case 5
                %                 Y = YY(:,:,i);
                %                 R = covariance(Y);
                y = YY{i};
%                 y = quantification(y, Nbit);
                R = covariance1(y);
                s = SWEDE(R, dd, p);
                [ peak, index ] = findPeak( s );
                destime1 = dd(index);
            case 6
                %                                 Y = YY(:,:,i);
                %                                 R = covariance(Y);
                y = YY{i};
%                 y = quantification(y, Nbit);
                R = covariance1(y);
                s = GC(R, dd, p);
                [ peak, index ] = findPeak( s );
                destime1 = dd(index);
            case 7
                %                 Y = YY(:,:,i);
                %                 R = covariance(Y);
                y = YY{i};
%                 y = quantification(y, Nbit);
                R = covariance1(y);
                destime = Root_MUSIC( R, p );
                destime1 = min(destime);
            case 8
                %                                 Y = YY(:,:,i);
                %                                 R = covariance(Y);
                y = YY{i};
%                 y = quantification(y, Nbit);
                R = covariance1(y);
                destime = ESPRIT( R, p );
                destime1 = min(destime);
                if(isempty(destime1))
                    destime1 = 0;
                end
            case 9
                %                 Y = YY(:,:,i);
                %                 R = covariance(Y);
                y = YY{i};
%                 y = quantification(y, Nbit);
                R = covariance1(y);
                destime = Root_OPM( R, p );
                destime1 = min(destime);
            case 10
                %                 Y = YY(:,:,i);
                %                 R = covariance(Y);
                y = YY{i};
%                 y = quantification(y, Nbit);
                R = covariance1(y);
                destime = ESPRITWED( R, p );
                destime1 = min(destime);
            otherwise
        end
        erreur(i,k) = destime1 - d1;
        
        figure(fig1); clf; grid on; hold on;
        if k <= 6
            plot(dd, s, 'b', 'linewidth', 2);
            plot(destime1, peak, 'color', 'r', 'Marker', '*', 'MarkerSize', 10, 'linewidth', 2);
            axis([0 max(dd) 0 1.2*max(s)])
        else
            stem(destime, ones(size(destime)), 'b', 'linewidth', 2);
            plot(destime1, 1, 'color', 'r', 'Marker', '*', 'MarkerSize', 10, 'linewidth', 2);
            axis([0 max(dd) 0 1.5])
        end
        stem([d1, d2(i)], zeros(1,2),'MarkerFaceColor',[1 0 0],'Marker','^',...
            'LineWidth',2,'Color',[1 0 0]);
        title([char(methodes(k)), ':  d1 = ', num2str(d1), ' , d2 = ', num2str(d2(i)), ', \Delta d = ', num2str(erreur(i,k))]);
        xlabel('Distance: m');
        
    end
end


%%
type = {'r-o', 'b-s', 'g-h', 'k-p', 'm-d', 'y-+', 'c-*'};
figure; hold on; grid on;
for i = 1 : length(choix)
    plot(d2, erreur(:,choix(i)) , type{i}, 'LineWidth', 1.5);
end
xlabel('Deuxième chemin: m'); ylabel('Erreur sur le premier chemin: m');
legend(methodes(choix));
ylim([-1, 1])


%% FISTA FISTA2
erreur_fista = zeros(length(d2), 1);
fig = figure;
alpha = 15; kmax = 2e3;
for i = 1 : length(d2)
    y = YY{i};
    s = FISTA(y, dd, alpha, kmax);
    [ peak, index ] = findPeak( s );
    destime1 = dd(index);
    erreur_fista(i) = destime1 - d1;
    
    figure(fig); clf; grid on; hold on;
    plot(dd, s, 'b', 'linewidth', 2);
    plot(destime1, peak, 'color', 'r', 'Marker', '*', 'MarkerSize', 10, 'linewidth', 2);
    stem([d1, d2(i)], mean(s)*zeros(1,2),'MarkerFaceColor',[1 0 0],'Marker','^',...
        'LineWidth',2,'Color',[1 0 0]);
    title(['FISTA', ':  d1 = ', num2str(d1), ' , d2 = ', num2str(d2(i)), ', \Delta d = ', num2str(erreur_fista(i))]);
    xlabel('Distance: m');
end

%% FISTA2
erreur_fista2 = zeros(length(d2), 1);
fig = figure;
alpha = 10;
for i = 1 : length(d2)
    y = YY{i};
    [ s, dfista2 ] = FISTA2( y, alpha );
    [ peak, index ] = findPeak( s );
    destime1 = dfista2(index);
    erreur_fista2(i) = destime1 - d1;
    
    figure(fig); clf; grid on; hold on;
    plot(dfista2, s, 'b', 'linewidth', 2);
    plot(destime1, peak, 'color', 'r', 'Marker', '*', 'MarkerSize', 10, 'linewidth', 2);
    stem([d1, d2(i)], mean(s)*zeros(1,2),'MarkerFaceColor',[1 0 0],'Marker','^',...
        'LineWidth',2,'Color',[1 0 0]);
    title(['FISTA2', ':  d1 = ', num2str(d1), ' , d2 = ', num2str(d2(i)), ', \Delta d = ', num2str(erreur_fista2(i))]);
    xlabel('Distance: m');
end

figure; hold on; grid on;
plot(d2-d1, [erreur(:,1), erreur_fista, erreur_fista2], 'LineWidth', 1.5);
xlabel('Multipath: m'); ylabel('Erreur: m');
legend('IFFT', 'FISTA', 'FISTA2');

%%

type = {'r-o', 'b-s', 'g-h', 'k-p', 'm-d', 'y-+', 'c-*'};
figure; hold on; grid on;
for i = 1 : length(choix)
    plot(d2, erreur(:,choix(i)) , type{i}, 'LineWidth', 1.5);
end
plot(d2, erreur_fista, type{4}, 'LineWidth', 1.5)
xlabel('Deuxième chemin: m'); ylabel('Erreur sur le premier chemin: m');
legend(methodes(choix), 'FISTA');






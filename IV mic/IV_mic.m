close all;
figure; hold on;

load('IV ABM-707-RC/mat_R_10k.csv');
load('IV ABM-707-RC/mat_R_1k.csv');
load('IV AOM-5024L-HD-R/mat_AOM_2024L_R_1k.csv');

I = mat_R_10k(:,1);
V = mat_R_10k(:,2) - I * 10e3;
%plot(V, I*1e6);

I = mat_R_1k(:,1);
V = mat_R_1k(:,2) - I * 1e3;
plot(V, I*1e6);

I = mat_AOM_2024L_R_1k(:,1);
V = mat_AOM_2024L_R_1k(:,2) - I * 1e3;
plot(V, I*1e6);

legend('ABM-707-RC', 'AOM-5024L-HD-R', 'Location', 'SouthEast');
xlabel('Voltage [V]');
ylabel('Current [micro A]');
ylim([0 350]);
xlim([0 5]);

ind = 222;
%plot(V(ind), I(ind), 'g.', 'MarkerSize', 10);

matlab2tikz('IV_mic.tex')
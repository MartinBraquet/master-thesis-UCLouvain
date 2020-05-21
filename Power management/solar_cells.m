close all;

%% Daily luminosity (March 1, cloudy weather) 

data = [17.5 200,
        8.75 855,
        9.5  1550,
        10   1940,
        10.5 1300,
        11.7 3500,
        12   4000,
        14.5 3040,
        14.6 3680,
        14.7 3230,
        14.8 4500,
        14.9 4400,
        15   3500,
        15.2 2800,
        15.5 1700,
        15.8 3050,
        16   2500,
        16.3 2200,
        16.6 1880,
        17   1650,
        17.3 640,
        17.6 1150,
        18   340,
        18.2 150,
        18.3 70,
        18.5 30,
        10   1030,
        10.5 925,
        11   2350,
        11.5 1800,
        12   2000,
        12.5 1600,
        13   2300,
        13.5 2740,
        14   2000,
        9    800,
        9.5  1000,
        10.5 1650,
        10.8 4000,
        11.6 1600,
        12   3000,
        12.5 4700,
        12.8 1900,
        13   950,
        13.5 1400,
        14   680,
        14.5 1500,
        16   1900,
        16.5 2200,
        17   1100,
        8.2  400,
        18.6 0,
        8    0];

data = sortrows(data,1);
    
n = 2000;
t = linspace(0, 24, n);
L = polyval(polyfit(data(:,1), data(:,2),2), t);
L(L<0) = 0;

F = griddedInterpolant(t,L);
fun = @(x) F(x);
L_mean = integral(fun, t(1), t(end)) / 24;

figure; hold on;
plot(data(:,1), data(:,2), '.r', 'MarkerSize', 10);
plot(t, L, '--', 'LineWidth', 2);
%plot([min(data(:,1)), max(data(:,1))], L_mean * ones(1,2), 'c--', 'LineWidth', 2);

t = 8 /11 * (t - 13.35) + 13.35;
dt = t(2) - t(1);
L = [zeros(size(0:dt:t(1),2),1)' L zeros(size(t(end)+dt:dt:24,2),1)'];
t = [0:dt:t(1) t t(end)+dt:dt:24];
size_t = size(t,2);
%plot(t, L, 'LineWidth', 2);

legend('Experimental data', 'Approx. curve (11h)', 'Approx. curve (8h)'); %, 'Average over full day');
xlabel('Time [hours]');
ylabel('Illuminance [lux]');
xlim([7 22]);
grid;
% matlab2tikz('daily_luminosity.tex')

% KXOB25_14X1F: 55 mA/sun = 53*1e-3 mA/(W/m^2) @ 0.56V  (23.00mm x 8.00mm x 1.80mm)
I_sun = 55e-3;
V_mppt = 0.56;
n_cells = 35;

% SLMD481H08L-ND: 178 mA/sun = 178*1e-3 mA/(W/m^2) @ 4V (89.00mm x 55.00mm x 2.00mm)
I_sun = 178e-3;
V_mppt = 4;
n_cells = 2;

% SM141K06L-ND: 55.1 mA/sun = 55.1*1e-3 mA/(W/m^2) @ 3.35V (42.00mm x 23.00mm x 2.10mm)
I_sun = 55.1e-3;
V_mppt = 3.35;
n_cells = 6;

I_out = 0.0015;
VDD = 2.5;
V_BATT_min = VDD + 0.3;
V_BATT_max = 4.5;
C = 200;

k = 6;
j = 10;
I_out_cycle = 1e-3 * repmat([repmat([9],1,j) repmat(0.3*ones(1,k),1,j)],1,ceil(size(t,2)/(k+1)));
I_out_cycle = I_out_cycle(1:size(t,2));

% 1 lux [lx] =  0.0079 w/m^2
% 1 sun = 1e3 W/m^2 
I_in = I_sun * 1e-3 * 0.0079 * L;

P_in = I_in * V_mppt * n_cells;
P_out_min = I_out * V_BATT_min;

%% Comparison of P_in and I_out (indep. of V_batt)
figure;
subplot(2,1,1); hold on;
plot(t, 1e3*P_in, 'LineWidth', 2);
ylabel('Input power [mW]');
grid;
subplot(2,1,2);
plot(t, 1e3*I_out_cycle, 'LineWidth', 2);
xlabel('Time [hours]');
ylabel('Output current [mA]');
grid;
%matlab2tikz('P_in_I_out.tex')

% Power of 1 solar cell
figure;
plot(t, 1e3*I_in * V_mppt, 'LineWidth', 2);
xlabel('Time [hours]');
ylabel('Harvested power [mW]');
grid;
matlab2tikz('P_cell.tex')

%% Solve V_supercap(t) depending on Pin and Pout
t_0 = t(P_in > P_out_min);
t_0 = t_0(1);
ind_t0 = find(t == t_0);

figure; hold on;
plot(t, P_in, 'LineWidth', 2);
plot([t(1) t(end)], P_out_min * ones(1,2), 'LineWidth', 2);
xlabel('Time [hours]');
ylabel('P in [W]');
grid;
% matlab2tikz('P_in.tex')

% Explicit Euler scheme: solution of dx/dt = f(x,t) is x(t+1) = x(t) + dt * f(x,t) 

V_BATT = zeros(size(t))';
V_BATT(ind_t0) = V_BATT_min;
dt_sec = dt * 3600;

for i = 0:(size_t-2)
    t_old = mod(i + ind_t0 - 1, size_t) + 1;
    t_new = mod(t_old,size_t) + 1;
    V_BATT(t_new) = V_BATT(t_old) + ...
        dt_sec / C * (V_mppt / V_BATT(t_old) * I_in(t_old) * n_cells - I_out_cycle(t_old));
end

figure; hold on;
plot(t, V_BATT, 'LineWidth', 2);
xlabel('Time [hours]');
ylabel('Supercap voltage [V]');
grid;
%matlab2tikz('Supercap_voltage.tex')

% Variation with n_cells
% figure; hold on;
% plot(t(1:2:end), V_BATT_4(1:2:end),'.', 'MarkerSize', 5);
% plot(t(1:2:end), V_BATT_6(1:2:end),'.', 'MarkerSize', 5);
% plot(t(1:2:end), V_BATT_8(1:2:end),'.', 'MarkerSize', 5);
% xlabel('Time [hours]');
% ylabel('Supercap voltage [V]');
% legend('4 cells', '6 cells', '8 cells');
% grid;
% matlab2tikz('Supercap_voltage.tex')

% Variation with C
figure; hold on;
plot(t(1:2:end), V_BATT_C_50(1:2:end),'.', 'MarkerSize', 5);
plot(t(1:2:end), V_BATT_C_100(1:2:end),'.', 'MarkerSize', 5);
plot(t(1:2:end), V_BATT_C_200(1:2:end),'.', 'MarkerSize', 5);
xlabel('Time [hours]');
ylabel('Supercap voltage [V]');
legend('50F', '100F', '200V');
grid;
matlab2tikz('Supercap_voltage_C.tex')

%% Rough estimate of Pout (although not constant in reality: i_out * V_batt(t))

P_out = I_out * 3.4;

t(P_in < P_out & t < 12) = t(P_in < P_out & t < 12) + 24;
t = t - min(t);
A = sortrows([t; P_in]',1);
t = A(:,1);
P_in = A(:,2);

E = cumtrapz(t*3600, P_in - P_out);

figure;
subplot(2,1,1); hold on;
plot(t, 1e3*P_in, 'LineWidth', 2);
plot(t, 1e3*P_out * ones(size(t,1),1), 'LineWidth', 2);
xlabel('Time [hours]');
ylabel('Power [mW]');
legend('Harvested', 'Consumed');
grid;

subplot(2,1,2);
plot(t, E, 'LineWidth', 2);
xlabel('Time [hours]');
ylabel('Energy [J]');
grid;

V_batt_approx = sqrt(V_BATT_min^2 + 2 * E / C);

figure;
plot(t, V_batt_approx, 'LineWidth', 2);
xlabel('Time [hours]');
ylabel('V batt [V]');
grid;
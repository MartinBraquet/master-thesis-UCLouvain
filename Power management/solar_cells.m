close all;

%% Daily luminosity (March 1, cloudy weather) 

%save('daily_luminosity_tab', 'daily_luminosity_tab');
load('daily_luminosity_tab');

daily_luminosity_tab = sortrows(daily_luminosity_tab,1);
    
n = 2000;
t = linspace(0, 24, n);
L = polyval(polyfit(daily_luminosity_tab(:,1), daily_luminosity_tab(:,2),2), t);
L(L<0) = 0;

F = griddedInterpolant(t,L);
fun = @(x) F(x);
L_mean = integral(fun, t(1), t(end)) / 24;

figure; hold on;
plot(daily_luminosity_tab(:,1), daily_luminosity_tab(:,2), '.r', 'MarkerSize', 10);
plot(t, L, '--', 'LineWidth', 2);
%plot([min(data(:,1)), max(data(:,1))], L_mean * ones(1,2), 'c--', 'LineWidth', 2);

t = 8 /11 * (t - 13.35) + 13.35;
dt = t(2) - t(1);
L = [zeros(size(0:dt:t(1),2),1)' L zeros(size(t(end)+dt:dt:24,2),1)'];
t = [0:dt:t(1) t t(end)+dt:dt:24];
size_t = size(t,2);
plot(t, L, 'LineWidth', 2);

legend('Experimental data', 'Approx. curve (11h)', 'Approx. curve (8h)'); %, 'Average over full day');
xlabel('Time [hours]');
ylabel('Illuminance [lux]');
xlim([7 22]);
grid;
matlab2tikz('daily_luminosity.tex')

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
C = 90;
eta_boost = 0.92;

% k = 2;
% j = 10;
% I_out_cycle = 1e-3 * repmat([repmat([9],1,j) repmat(0.3*ones(1,k),1,j)],1,ceil(size(t,2)/(k+1)));
% I_out_cycle = I_out_cycle(1:size(t,2));

VCC = 2.5;
I1_MCU = xlsread('current_consumption_FFT.xlsx', 'Sheet1', 'B285:B574') / VCC / 1e3;
I1_MCU = I1_MCU(1:10:end);
I_out_cycle_MCU = repmat(I1_MCU,100,1);
I_out_cycle_MCU = I_out_cycle_MCU(1:size(t,2));
t_min = 7; t_max = 17;
I_out_cycle_MCU(t<t_min | t>t_max) = 0;
I_other = 1e-3; % other current consumptions (from supercap leakage, PMU and sensing)
I_out_cycle = I_out_cycle_MCU + I_other;

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
matlab2tikz('P_in_I_out.tex')

% Power of 1 solar cell
figure;
plot(t, 1e3*I_in * V_mppt, 'LineWidth', 2);
xlabel('Time [hours]');
ylabel('Harvested power [mW]');
grid;
matlab2tikz('P_cell.tex')


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

%% Solve V_supercap(t) depending on Pin and Pout

% Variation with C

V_BATT_C_50 = supercap_voltage(n_cells, 50, I_in, V_mppt, P_out_min, t, eta_boost, I_out_cycle, V_BATT_min, dt, size_t);
V_BATT_C_100 = supercap_voltage(n_cells, 100, I_in, V_mppt, P_out_min, t, eta_boost, I_out_cycle, V_BATT_min, dt, size_t);
V_BATT_C_200 = supercap_voltage(n_cells, 200, I_in, V_mppt, P_out_min, t, eta_boost, I_out_cycle, V_BATT_min, dt, size_t);

figure; hold on;
plot(t(1:2:end), V_BATT_C_50(1:2:end),'.', 'MarkerSize', 5);
plot(t(1:2:end), V_BATT_C_100(1:2:end),'.', 'MarkerSize', 5);
plot(t(1:2:end), V_BATT_C_200(1:2:end),'.', 'MarkerSize', 5);
xlabel('Time [hours]');
ylabel('Supercap voltage [V]');
legend('50F', '100F', '200V', 'Location', 'SouthEast');
grid;
matlab2tikz('Supercap_voltage_C.tex')

% Variation with n_cells

V_BATT_4 = supercap_voltage(4, C, I_in, V_mppt, P_out_min, t, eta_boost, I_out_cycle, V_BATT_min, dt, size_t);
V_BATT_6 = supercap_voltage(6, C, I_in, V_mppt, P_out_min, t, eta_boost, I_out_cycle, V_BATT_min, dt, size_t);
V_BATT_8 = supercap_voltage(8, C, I_in, V_mppt, P_out_min, t, eta_boost, I_out_cycle, V_BATT_min, dt, size_t);

figure; hold on;
plot(t(1:2:end), V_BATT_4(1:2:end),'.', 'MarkerSize', 5);
plot(t(1:2:end), V_BATT_6(1:2:end),'.', 'MarkerSize', 5);
plot(t(1:2:end), V_BATT_8(1:2:end),'.', 'MarkerSize', 5);
xlabel('Time [hours]');
ylabel('Supercap voltage [V]');
legend('4 cells', '6 cells', '8 cells', 'Location', 'SouthEast');
grid;
matlab2tikz('Supercap_voltage.tex')

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

function V_BATT = supercap_voltage(n_cells, C, I_in, V_mppt, P_out_min, t, eta_boost, I_out_cycle, V_BATT_min, dt, size_t)
    P_in = I_in * V_mppt * n_cells;
    t_0 = t(P_in > P_out_min);
    t_0 = t_0(1);
    ind_t0 = find(t == t_0);

    % Explicit Euler scheme: solution of dx/dt = f(x,t) is x(t+1) = x(t) + dt * f(x,t) 

    V_BATT = zeros(size(t))';
    V_BATT(ind_t0) = V_BATT_min;
    dt_sec = dt * 3600;

    for i = 0:(size_t-2)
        t_old = mod(i + ind_t0 - 1, size_t) + 1;
        t_new = mod(t_old,size_t) + 1;
        V_BATT(t_new) = V_BATT(t_old) + ...
            dt_sec / C * (eta_boost * V_mppt / V_BATT(t_old) * I_in(t_old) * n_cells - I_out_cycle(t_old));
    end
end
close all;

data = xlsread('Discharge_supercap.xlsx', '4.2V', 'A2:B28');
t = data(:,1);
V = data(:,2);
I_discharge = 0.5;

plot(t, V, 'b--*', 'LineWidth', 2, 'MarkerSize', 8);
xlabel('Time [s]');
ylabel('Supercap voltage [V]');
grid;
matlab2tikz('Discharge_supercap_exp.tex');

F = griddedInterpolant(t,V);
fun = @(x) F(x);
E = I_discharge * integral(fun, t(1), t(end));
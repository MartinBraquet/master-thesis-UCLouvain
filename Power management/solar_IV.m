I0 = 0.00002;
IL = 58.6;
V = 0:0.004:0.7;
a = 22;

I = IL - I0 * exp(a*V);
I(I<0) = 0;

figure;
yyaxis left
plot(V,I, 'LineWidth', 2); hold on;
xlabel('Voltage [V]');
ylabel('Current [mA]');
yyaxis right
plot(V,I.*V, 'LineWidth', 2);
grid;
ylabel('Power [mW]');

% matlab2tikz('solar_IV.tex')
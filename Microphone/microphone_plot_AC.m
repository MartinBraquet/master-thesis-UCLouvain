close all;
data = load('microphone.txt');
f = data(:,1);
H = data(:,2);
A = data(:,3);
A(44:end) = A(44:end) - 360;

figure;
yyaxis left
semilogx(f,H, 'LineWidth', 2); hold on;
xlabel('Frequency [Hz]');
ylabel('Magnitude [dB]');
yyaxis right
semilogx(f,A, '--', 'LineWidth', 2);
grid;
ylabel('Phase [deg]');

matlab2tikz('microphone_AC.tex')
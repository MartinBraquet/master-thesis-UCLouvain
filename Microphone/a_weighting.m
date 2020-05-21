close all;
f = logspace(log10(20),log10(20e3),100)

R = 12194^2 * f.^4 ./ ((f.^2 + 20.6^2) .* (f.^2 + 12194^2) .* sqrt((f.^2 + 107.7^2) .* (f.^2 + 737.9^2)));
A = 20 * log10(R) + 2;

semilogx(f, A, 'LineWidth', 2);
xlabel('Frequency [Hz]');
ylabel('Gain [dB]');
grid;
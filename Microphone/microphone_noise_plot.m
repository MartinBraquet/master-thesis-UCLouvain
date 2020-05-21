close all;
A = importdata('microphone_noise.txt');
f = A.data(:,1);
N = A.data(:,2);

loglog(f,N*1e6, 'LineWidth', 2);
grid;
xlabel('Frequency [Hz]');
ylabel('Noise spectral density [micro V/sqrt(Hz)]');

matlab2tikz('output_noise_freq.tex')

sB = sqrt(13.5e3);
V_N_theor = 2.52e-3;
E_N_theor = V_N_theor / sB;

fL = 20;
fH = 20e3;

F = griddedInterpolant(f,N.^2);
fun = @(x) F(x);
V_N_simu = sqrt(integral(fun, fL/1.57, 1.57*fH));
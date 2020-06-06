close all;

% Use RMS values for AC variables (Pa, V, I)
VCC = 2.5; % [V]
V_STM = VCC; % [V]
V_STM_AC_P = V_STM / 2; % [V] Peak voltage variation around the mean
V_STM_AC_RMS = V_STM_AC_P / sqrt(2); % [V] RMS voltage variation around the mean
V_mic = 2; % [V]
I_mic = 0.21e-3; % [A]
S_dB = -24; % [dB]
SNR = 80; % [dB]
R_load = 2.2e3; % [Ω]

%S_dB = -40:-20; % [dB]


I_bias_amp = 70e-9;
R3_max = 0.01 * VCC / (2 * I_bias_amp); % [Ω]
R3 = floor(R3_max/50e3) * 50e3; % [Ω] multiple of 50k
I_B = VCC / (2 * R3); % [A]

% Microphone noise
self_noise_dB = 94 - SNR; % [dB_SPL]
p_SN = 20e-6 * 10^(self_noise_dB/20); % [Pa]

R1 = (VCC - V_mic) / I_mic; % [Ω]
S = 10.^(S_dB/20); % [V/Pa]
S_I = S / R_load; % [A/Pa]

% AC drain current for the lowest input sound pressure 50 - 20*log(50) = 16 dB SPL 
Pa_source = 50; % [dB SPL]
Pa_mic_dB = Pa_source - 20 * log10(50); % [dB SPL]
Pa_mic = 20e-6 * 10^(Pa_mic_dB/20); % [Pa]
I_min = S_I * Pa_mic; % [A]

% Minimum voltage (for ADC) to output at the minimum sound pressure: V_STM/2^12
n_bit = 12;
V_STM_res = V_STM / 2^n_bit; % [V] Resolution of STM32
V_out_min = V_STM_res / 2 / sqrt(2) * 2^6; % [V] RMS value (peak-to-peak < res -> peak value < res/2) with 6 bits of resolution
V_out_min_dB = 20 * log10(V_out_min);
R2 = V_out_min ./ I_min; % [Ω] Transimpedance gain: V_out = R2 * I + V_B
G_V = R2 / R_load; % Voltage gain: (V_out - V_B) / V_mic
G_V_dB = 20 * log10(G_V); % Voltage gain: (V_out - V_B) / V_mic

I_max = V_STM_AC_RMS ./ R2; % [A]
Pa_max = I_max / S_I;
Pa_max_dB = 20*log10(Pa_max / 20e-6); % [dB SPL]

% High-pass pole (20 kHz)
%fp_2 = 20e3 / sqrt((1/0.989)^2 - 1); % [Hz]
fp_2 = 20e3; % [Hz]
C2 = 1 ./ (2 * pi * fp_2 * R2); % [F]

% Low-pass pole (20 Hz)
C1 = 1 / (2 * pi * 20 * R1); % [F]

% Low-pass pole (5 Hz)
C3 = 1 / (2 * pi * 5 * R3/2); % [F]

%% Op amp design with noise characterization

Slew_rate = 10 * (2*pi * 20e3 * V_STM_AC_P); % [V/s] swipe from 0 to VSTM in 1/(2f), 10 times higher to remove slew-induced distortion

% Impose a noise due to amplification lower than 1/5 of the STM resolution
%V_N_max = V_out_min / 5; % [V] RMS
%V_N_max_f = V_N_max / sqrt(13.5e3); % [V/sqrt(Hz)] Voltage noise spectral density

A_N = 1 + R2/R1; % Noise gain

kB = 1.381e-23; % Boltzmann constant
T = 298; % [K]
V_NR = sqrt(4 * kB * T * 1./(1/R1+1./R2)); % [V/sqrt(Hz)] thermal noise contribution from the feedback network

%V_NV_max = sqrt((V_N_max_f./A_N).^2 - V_NR.^2); % [V/sqrt(Hz)] Op amp voltage noise contribution

%% Plot E_NV vs Sens

% figure; hold on;
% plot(S_dB,V_NV_max*1e9);
% plot(S_dB(17),V_NV_max(17)*1e9, '-ob');
% xlabel('Sensitivity [dB]');
% ylabel('E_{NV,max} [nV/Hz^{1/2}]');
% 
% ind = find(S_dB == -24);
% S_dB = S_dB(ind); % [dB]
% A_N = A_N(ind);
% R2 = R2(ind);
% V_NR = V_NR(ind);

%% Plot E_NV vs I_C

input_noise(12, R1, R2, S_I, p_SN) / sqrt(13.5e3)
input_noise(12, R1, R2, S_I, p_SN)

figure;
semilogx([10 10000], 16 * [1 1], '--', 'LineWidth', 2); hold on;
%semilogx(15500, input_noise(0.69, R1, R2, S_I, p_SN), '.', 'MarkerSize', 25);
semilogx(1001, input_noise(1.8, R1, R2, S_I, p_SN), '.', 'MarkerSize', 25);
semilogx(650, input_noise(4.2, R1, R2, S_I, p_SN), '.', 'MarkerSize', 25);
semilogx(385, input_noise(8.8, R1, R2, S_I, p_SN), '.', 'MarkerSize', 25);
semilogx(170, input_noise(12, R1, R2, S_I, p_SN), '.', 'MarkerSize', 25);
semilogx(130, input_noise(14, R1, R2, S_I, p_SN), 'c.', 'MarkerSize', 25);
semilogx(110, input_noise(17, R1, R2, S_I, p_SN), 'k.', 'MarkerSize', 25);
semilogx(60, input_noise(30, R1, R2, S_I, p_SN), 'b.', 'MarkerSize', 25);
semilogx(37, input_noise(70, R1, R2, S_I, p_SN), 'g.', 'MarkerSize', 25);
%semilogx(0.55, input_noise(264, R1, R2, S_I, p_SN), '.', 'MarkerSize', 25);
%semilogx(0.32, input_noise(450, R1, R2, S_I, p_SN), '.', 'MarkerSize', 25);
grid;
xlabel('Quiescent current [micro A]');
ylabel('Input-referred noise [dB SPL]');
legend('Min. signal', 'OPA838', 'OPA1692', 'OPA2188', 'OPA2834', 'OPA314', 'LMV651', 'TLV9001', 'LMV551', 'TLV854x');
% matlab2tikz('input_noise.tex')

%% Use of TLV9001

V_NI_TLV9001 = 1/(1/R1+1/R2) * 23e-15; % [V/sqrt(Hz)]
V_NV_TLV9001 = 30e-9; % [V/sqrt(Hz)]

V_N_TLV9001_f = A_N * sqrt(V_NR^2 + V_NI_TLV9001^2 + V_NV_TLV9001^2) % [V/sqrt(Hz)]
V_N_TLV9001 = V_N_TLV9001_f * sqrt(13.5e3); % [V]

%% Use of OPA2834 (BEST)

V_NI_OPA2834 = 1/(1/R1+1/R2) * 200e-15; % [V/sqrt(Hz)]
V_NV_OPA2834 = 12e-9; % [V/sqrt(Hz)]

V_N_OPA2834_f = A_N * sqrt(V_NR^2 + V_NI_OPA2834^2 + V_NV_OPA2834^2) % [V/sqrt(Hz)]
V_N_OPA2834 = V_N_OPA2834_f * sqrt(13.5e3); % [V]

%V_NV_max(ind)

%% ADC input noise (from AFE and microphone)

p_IRN_dB = input_noise(12, R1, R2, S_I, p_SN);
p_IRN = 20e-6 * 10^(p_IRN_dB / 20);
V_N_ADC = p_IRN * S_I * R2


%% Input voltage noise
% Compute input noise based on op amp voltage noise density (expressed in
% percent of V_out_min)
function p_IRN_dB = input_noise(V_NV, R1, R2, S_I, p_SN)

    V_NV = V_NV * 1e-9; % V_NV was expressed in nV/sqrt(Hz)

    A_N = 1 + R2/R1; % Noise gain

    kB = 1.381e-23; % Boltzmann constant
    T = 298; % [K]
    V_NR = sqrt(4 * kB * T * 1/(1/R1+1/R2)); % [V/sqrt(Hz)] thermal noise contribution from the feedback network

    V_N_f = A_N * sqrt(V_NV^2 + V_NR^2); % [V/sqrt(Hz)] Voltage noise spectral density
    
    % Microphone noise at ADC input
    %V_N_mic = S * G_V * 10^(-SNR/20); % [V] RMS
    
    V_N = V_N_f * sqrt(13.5e3); % [V] Output voltage noise (RMS)
    
    p_IRN_AFE = V_N / (S_I .* R2); % [Pa]
    
    % Total IRN noise
    p_IRN = sqrt(p_IRN_AFE^2 + p_SN^2); % [Pa]
    p_IRN_dB = 20 * log10(p_IRN / 20e-6); % [dB SPL]

end
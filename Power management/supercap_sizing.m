close all;

V_MCU = 2.5; % [V]
V_batt_max = 4.5; % [V]
V_gap_PMU = 0.3; % [V]

I_power_sensing = (170 + 358 + 50) * 1e-6; % [A] for microphone, op amp and others
I_MCU = 11.2588098189213e-3; % [A]
I_TX = 6.74187387117299e-3; % [A]

DC_MCU = 0.2; % duty cycle MCU
DC_TX = 0.1; % duty cycle TX

I_avg = I_power_sensing + DC_MCU * I_MCU + DC_TX * I_TX; % [A]

dt = 3600 * 16; % [s] 16 hours in the winter
C = I_avg * dt / (V_batt_max - (V_MCU + V_gap_PMU)) % [F]


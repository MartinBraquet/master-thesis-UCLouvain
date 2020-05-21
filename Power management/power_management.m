close all;

%% AEM10941
Vovch = 4.5; % [V]
Vchrdy = 3.5; % [V]
Vovdis = 3.3; % [V]
Vhv = 3; % [V]

% Adapt RT and RV to have typical resistance values for R1,...,R6
RT = 50e6; % [Ω]
RV = 35e6; % [Ω]

R1 = RT/Vovch; % [Ω]
R2 = RT * (1/Vchrdy - 1/Vovch); % [Ω]
R3 = RT * (1/Vovdis - 1/Vchrdy); % [Ω]
R4 = RT * (1 - 1/Vovdis); % [Ω]

R5 = RV/Vhv; % [Ω]
R6 = RV * (1 - 1/Vhv); % [Ω]

%% Storage element -> MCU (voltage divider)
R_stor = 1e6;
R_stor1 = R_stor * Vhv / Vovch;
R_stor2 = R_stor - R_stor1;
V_batt_MCU_min = Vovdis * R_stor1 / R_stor;


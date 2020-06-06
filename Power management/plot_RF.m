close all;

data = xlsread('current_consumption_MCU_RF.xlsx', 'Lorawan TX', 'A2:C34068');
data = data(1:40:end,:);
t = data(:,1);
I = sum(data(:,2:3),2);

figure;
plot(t, I, '.', 'MarkerSize', 5);
xlabel('Time [s]');
ylabel('Current [mA]');
%ylim([0 30]);
grid;
matlab2tikz('current_consumption_MCU_RF_lorawan_TX.tex');

F = griddedInterpolant(t,I);
fun = @(x) F(x);
I_avg_TX = integral(fun, t(1), t(end)) / (t(end) - t(1));

%%

data = xlsread('current_consumption_MCU_RF.xlsx', 'ClassC', 'A2:D9758');
data = data(1:10:end,:);
t = data(:,1);
I = sum(data(:,2:4),2);

figure;
plot(t, I, '.', 'MarkerSize', 5);
xlabel('Time [s]');
ylabel('Current [mA]');
ylim([0 30]);
grid;
matlab2tikz('current_consumption_MCU_RF_FUOTA.tex');

F = griddedInterpolant(t,I);
fun = @(x) F(x);
I_avg_FUOTA_receive = integral(fun, t(1), t(end)) / t(end) - t(1);
receive_time = 259;

%%

data = xlsread('current_consumption_MCU_RF.xlsx', 'processing', 'A2:D42512');
data = data(1:100:end,:);
t = data(:,1);
I = sum(data(:,2:4),2);

figure;
plot(t, I, '.', 'MarkerSize', 5);
xlabel('Time [s]');
ylabel('Current [mA]');
ylim([0 30]);
grid;
matlab2tikz('current_consumption_MCU_RF_FUOTA_processing.tex');

F = griddedInterpolant(t,I);
fun = @(x) F(x);
process_time = t(end) - t(1);
I_avg_FUOTA_proc = integral(fun, t(1), t(end)) / process_time;

VCC = 2.5;
I_avg_FUOTA = (I_avg_FUOTA_receive * receive_time + I_avg_FUOTA_proc * process_time) / (receive_time + process_time);
energy =  I_avg_FUOTA * (receive_time + process_time) * VCC; % [mJ]
receive_time + process_time
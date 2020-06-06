close all;

data = xlsread('current_consumption_FFT.xlsx', 'Sheet1', 'A285:B574');
t1 = data(:,1); t1 = t1 - t1(1);
VCC = 2.5;
I1 = data(:,2) / VCC;

n = 10;
t = zeros(length(t1)*n,1);
I = repmat(I1,n,1);
for i=0:n-1
    t(length(t1)*i+1:length(t1)*(i+1)) = t1+(t1(end)+eps)*i;
end

figure;
plot(t*1000, I, 'Linewidth', 2);
xlabel('Time [ms]');
ylabel('Current [mA]');
%ylim([0 30]);
grid;
matlab2tikz('current_consumption_FFT.tex');

F = griddedInterpolant(t,I);
fun = @(x) F(x);
I_avg = integral(fun, t(1), t(end)) / (t(end) - t(1));
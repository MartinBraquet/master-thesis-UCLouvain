close all;

load('f_mean.mat');
temp = f_mean(4,:);
f_mean(3:4,:) = f_mean(2:3,:);
f_mean(2,:) = temp;

bird_list = ["Pigeon (learning)", "Pigeon (test)", "Blackbird (learning)", "Blackbird (test)", "Great tit (learning)", "Great tit (test)", "Blue tit (learning)", "Blue tit (test)"];
n_songs = 6;

f_mean_tested = [515 735 515;
                 1700 2000 1859;
                 4063 3965 3520;
                 5237 5741 5294];

figure; hold on;
for j = 1:length(bird_list)/2
    h = plot(f_mean(j,:)/1e3, 0*ones(1, n_songs), '.', 'Markersize', 15);
    plot(f_mean_tested(j,:)/1e3, j*ones(1, size(f_mean_tested,2)), 'x', 'Markersize', 5, 'color', get(h,'Color'));
end
xlabel('Weighted average frequency [kHz]');
ylim([0 20]);
legend(bird_list);
matlab2tikz('test_freq_detection.tex');
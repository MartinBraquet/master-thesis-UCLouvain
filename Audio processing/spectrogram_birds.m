close all;

bird_list = ["pigeon", "greattit", "bluetit", "blackbird"];

n_songs = 6;

f_mean = zeros(length(bird_list),n_songs);

for j = 1:length(bird_list)
    bird = bird_list(j);
    for i = 1:n_songs
        
        [audio1, fs] = audioread(sprintf('%s%d.wav', bird, i));

        N = 1024;
        [s,f,t] = spectrogram(audio1,N,N-400,N,fs,'yaxis');
        %spectrogram(audio1,N,N-400,N,fs,'yaxis'); 
        % hold on;
        % xlabel('Time [s]');
        % ylabel('Frequency [kHz]');
        % 
        % c = gray;
        % c = flipud(c);
        % c = c.^(1/3);
        % colormap(c);
        % 
        % matlab2tikz('greattit_full.tex');

    %     figure;
    %     plot(f/1e3,mean(abs(s),2));
    
        f = f(f<10e3);
        size_f = length(f);
        s = s(1:size_f,:);

        mean_s_time = mean(abs(s),2);
        mean_s_time = mean_s_time - min(mean_s_time);
        new_f_mean = sum(mean_s_time .* f) / sum(mean_s_time);
        %new_f_median = f(find(mean_s_time == median(mean_s_time)))
        f_mean(j,i) = new_f_mean
    end
end

save(f_mean);

figure; hold on;
for j = 1:length(bird_list)
    plot(f_mean(j,:)/1e3, 0*ones(1, n_songs), '.', 'Markersize', 15);
end
xlabel('Weighted average frequency [kHz]');
ylim([0 eps]);
legend(bird_list);
matlab2tikz('weight_mean_freq.tex');
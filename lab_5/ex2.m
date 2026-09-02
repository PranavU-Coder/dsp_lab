clc; close all;
Fs = 2000;
fp1 = 400; fp2 = 500; fs1 = 300; fs2 = 600;
Rp = 0.5; As = 40;
wp = [fp1, fp2] * (2*pi / Fs);
ws = [fs1, fs2] * (2*pi / Fs);
dw = min((wp(1) - ws(1)), (ws(2) - wp(2))); 
wc = [(ws(1) + wp(1))/2, (wp(2) + ws(2))/2]; 
N_ham = ceil(6.6*pi / dw); 
if mod(N_ham, 2) == 0, N_ham = N_ham + 1; end 
f_edges = [fs1, fp1, fp2, fs2] / (Fs/2); 
devs = [10^(-As/20), (10^(Rp/20)-1), 10^(-As/20)];

[N_kai, Wn, beta, ~] = kaiserord(f_edges, [0 1 0], devs);
if mod(N_kai, 2) == 0, N_kai = N_kai + 1; end
beta = beta(1); 
b_ham = fir1(N_ham - 1, wc/pi, 'bandpass', hamming(N_ham));
b_kai = fir1(N_kai - 1, wc/pi, 'bandpass', kaiser(N_kai, beta));
[H_ham, w] = freqz(b_ham, 1, 1024, Fs);
H_kai      = freqz(b_kai, 1, 1024, Fs);
subplot(3, 1, 1);
plot(w, 20*log10(abs(H_ham)), 'Color', '#00FFFF', 'LineWidth', 1.5); hold on;
xline([fs1 fp1 fp2 fs2], '--', 'Color', '#888888'); yline(-As, ':', 'Color', '#FF5555');
title(sprintf('(a) Hamming Window Band-Pass Filter (N = %d)', N_ham));
ylabel('dB'); xlabel('Frequency (Hz)'); ylim([-80 5]); xlim([0 Fs/2]); grid on;
subplot(3, 1, 2);
plot(w, 20*log10(abs(H_kai)), 'Color', '#00FF66', 'LineWidth', 1.5); hold on;
xline([fs1 fp1 fp2 fs2], '--', 'Color', '#888888'); yline(-As, ':', 'Color', '#FF5555');
title(sprintf('(b) Kaiser Window Band-Pass Filter (N = %d, \\beta = %.2f)', N_kai, beta));
ylabel('dB'); xlabel('Frequency (Hz)'); ylim([-80 5]); xlim([0 Fs/2]); grid on;
subplot(3, 1, 3);
plot(w, unwrap(angle(H_ham)), 'Color', '#00FFFF', 'LineWidth', 1.5); hold on;
plot(w, unwrap(angle(H_kai)), '--', 'Color', '#00FF66', 'LineWidth', 1.5);
title('(c) Passband Linear Phase Response');
ylabel('Phase (rad)'); xlabel('Frequency (Hz)'); xlim([400 500]); grid on;
legend('Hamming', 'Kaiser', 'Location', 'best');

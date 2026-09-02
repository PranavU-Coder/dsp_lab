clc; close all;
wp = 0.2*pi; ws = 0.4*pi; wc = (wp + ws) / 2; dw = ws - wp;
N_rect = ceil(1.8*pi / dw); if mod(N_rect,2)==0, N_rect = N_rect+1; end
N_hann = ceil(6.6*pi / dw); if mod(N_hann,2)==0, N_hann = N_hann+1; end
[N_kaiser, beta] = kaiserord([wp/pi, ws/pi], [1 0], [0.01 0.01]);
if mod(N_kaiser,2)==0, N_kaiser = N_kaiser+1; end
b_rect   = fir1(N_rect-1, wc/pi, rectwin(N_rect));
b_hann   = fir1(N_hann-1, wc/pi, hann(N_hann));
b_kaiser = fir1(N_kaiser-1, wc/pi, kaiser(N_kaiser, beta));
[H_rect, w] = freqz(b_rect, 1, 1024);
H_hann      = freqz(b_hann, 1, 1024);
H_kaiser    = freqz(b_kaiser, 1, 1024);
subplot(3, 1, 1);
plot(w/pi, 20*log10(abs(H_rect)), 'Color', '#00FFFF', 'LineWidth', 1.5); hold on;
xline(wp/pi, '--', 'Color', '#888888'); xline(ws/pi, '--', 'Color', '#888888');
yline(-21, ':', 'Color', '#FF5555'); 
title(sprintf('(a) Rectangular Window (N = %d)', N_rect));
ylabel('dB'); xlabel('\omega (\times\pi rad)'); ylim([-80 5]); xlim([0 1]); grid on;
subplot(3, 1, 2);
plot(w/pi, 20*log10(abs(H_hann)), 'Color', '#00FF66', 'LineWidth', 1.5); hold on;
xline(wp/pi, '--', 'Color', '#888888'); xline(ws/pi, '--', 'Color', '#888888');
yline(-44, ':', 'Color', '#FF5555');
title(sprintf('(b) Hanning Window (N = %d)', N_hann));
ylabel('dB'); xlabel('\omega (\times\pi rad)'); ylim([-80 5]); xlim([0 1]); grid on;
subplot(3, 1, 3);
plot(w/pi, 20*log10(abs(H_kaiser)), 'Color', '#FF9900', 'LineWidth', 1.5); hold on;
xline(wp/pi, '--', 'Color', '#888888'); xline(ws/pi, '--', 'Color', '#888888');
yline(-50, ':', 'Color', '#FF5555'); 
title(sprintf('(c) Kaiser Window (N = %d, \\beta = %.1f)', N_kaiser, beta));
ylabel('dB'); xlabel('\omega (\times\pi rad)'); ylim([-80 5]); xlim([0 1]); grid on;

clc; close all; clearvars;
fp = 200;               
fs = 700;              
Rp = 1;                  
Rs = 50;                 
wp = 2 * pi * fp;
ws = 2 * pi * fs;
[n_butt, wn_butt] = buttord(wp, ws, Rp, Rs, 's');
[b_butt, a_butt] = butter(n_butt, wn_butt, 's');
[n_cheb1, wp_cheb1] = cheb1ord(wp, ws, Rp, Rs, 's');
[b_cheb1, a_cheb1] = cheby1(n_cheb1, Rp, wp_cheb1, 's');
[n_cheb2, ws_cheb2] = cheb2ord(wp, ws, Rp, Rs, 's');
[b_cheb2, a_cheb2] = cheby2(n_cheb2, Rs, ws_cheb2, 's');
[n_ellip, wp_ellip] = ellipord(wp, ws, Rp, Rs, 's');
[b_ellip, a_ellip] = ellip(n_ellip, Rp, Rs, wp_ellip, 's');
w_eval = 2 * pi * linspace(0, 1000, 2000);
f_eval = w_eval / (2 * pi);
h_butt  = freqs(b_butt, a_butt, w_eval);
h_cheb1 = freqs(b_cheb1, a_cheb1, w_eval);
h_cheb2 = freqs(b_cheb2, a_cheb2, w_eval);
h_ellip = freqs(b_ellip, a_ellip, w_eval);
plot(f_eval, 20*log10(abs(h_butt)),  'Color', '#0072BD', 'LineWidth', 1.8); hold on;
plot(f_eval, 20*log10(abs(h_cheb1)), 'Color', '#D95319', 'LineWidth', 1.8);
plot(f_eval, 20*log10(abs(h_cheb2)), 'Color', '#7E2F8E', 'LineWidth', 1.8);
plot(f_eval, 20*log10(abs(h_ellip)), 'Color', '#00FF66', 'LineWidth', 1.8);
xline(fp, 'k--', 'LineWidth', 1.2);
xline(fs, 'k--', 'LineWidth', 1.2);
yline(-Rp, 'r:', 'LineWidth', 1.2);
yline(-Rs, 'r:', 'LineWidth', 1.2);
title('Analog Lowpass Filter Responses Comparison');
xlabel('Frequency (Hz)');
ylabel('Magnitude Response (dB)');
ylim([-80 5]); xlim([0 1000]);

legend({sprintf('Butterworth (Order N=%d)', n_butt), ...
    sprintf('Chebyshev Type I (Order N=%d)', n_cheb1), ...
    sprintf('Chebyshev Type II (Order N=%d)', n_cheb2), ...
    sprintf('Elliptic (Order N=%d)', n_ellip)}, ...
    'Location', 'southwest');

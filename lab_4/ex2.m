clc; close all; 
fp = 1000;             
fs = 500;                
Rp = 1;              
Rs = 50;                 
wp = 2 * pi * fp;
ws = 2 * pi * fs;
[n_butt, wn_butt] = buttord(wp, ws, Rp, Rs, 's');
[b_butt, a_butt] = butter(n_butt, wn_butt, 'high', 's');
[n_cheb1, wp_cheb1] = cheb1ord(wp, ws, Rp, Rs, 's');
[b_cheb1, a_cheb1] = cheby1(n_cheb1, Rp, wp_cheb1, 'high', 's');
w_eval = 2 * pi * linspace(0, 2000, 2000); 
f_eval = w_eval / (2 * pi);
h_butt  = freqs(b_butt, a_butt, w_eval);
h_cheb1 = freqs(b_cheb1, a_cheb1, w_eval);
plot(f_eval, 20*log10(abs(h_butt)),  'Color', '#00FFFF', 'LineWidth', 1.8); hold on; 
plot(f_eval, 20*log10(abs(h_cheb1)), 'Color', '#00FF66', 'LineWidth', 1.8);         
xline(fs, '--', 'Color', '#888888', 'LineWidth', 1.2);
xline(fp, '--', 'Color', '#888888', 'LineWidth', 1.2);
yline(-Rs, ':', 'Color', '#FF5555', 'LineWidth', 1.2);
yline(-Rp, ':', 'Color', '#FF5555', 'LineWidth', 1.2);
title('Analog High-Pass Filter Responses Comparison');
xlabel('Frequency (Hz)');
ylabel('Magnitude Response (dB)');
ylim([-80 5]); xlim([0 2000]);
legend({sprintf('Butterworth (Order N=%d)', n_butt), ...
    sprintf('Chebyshev Type I (Order N=%d)', n_cheb1)}, ...
    'Location', 'southeast');

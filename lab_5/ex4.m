clc; close all;
Fs = 2000; fc1 = 350; fc2 = 550;
N = 51;                         
k = 0:(N-1); f_k = k * (Fs / N);
H_mag = zeros(1, N);
for i = 1:N
    if (f_k(i) >= fc1 && f_k(i) <= fc2) || (f_k(i) >= (Fs - fc2) && f_k(i) <= (Fs - fc1))
        H_mag(i) = 1;
    end
end
alpha = (N - 1) / 2;
H_k = H_mag .* exp(-1i * 2*pi * alpha * k / N);
h = real(ifft(H_k));             
[H, w] = freqz(h, 1, 1024, Fs);
subplot(3,1,1);
plot(w, 20*log10(abs(H)), 'Color', '#00FFFF', 'LineWidth', 1.8); hold on;
stem(f_k(1:ceil(N/2)), 20*log10(H_mag(1:ceil(N/2)) + 1e-3), 'filled', 'Color', '#FF9900');
title(sprintf('Frequency Sampling Method (dB Scale, N = %d)', N));
ylabel('dB'); xlabel('Frequency (Hz)'); ylim([-60 10]); xlim([0 Fs/2]); grid on;
legend('Designed |H(f)|', 'Sampled Points (H_k)', 'Location', 'southwest');
subplot(3,1,2);
plot(w, abs(H), 'Color', '#00FF66', 'LineWidth', 1.8); hold on;
stem(f_k(1:ceil(N/2)), H_mag(1:ceil(N/2)), 'filled', 'Color', '#FF9900');
title('Magnitude Response (Linear Scale)');
ylabel('|H(f)|'); xlabel('Frequency (Hz)'); ylim([0 1.3]); xlim([0 Fs/2]); grid on;
subplot(3,1,3);
plot(w, unwrap(angle(H)), 'Color', '#00FFFF', 'LineWidth', 1.5);
title('Passband Phase Response (Linear Phase)');
ylabel('Phase (rad)'); xlabel('Frequency (Hz)'); xlim([400 500]); grid on;

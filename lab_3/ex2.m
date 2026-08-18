clc; close all;
filters = {
    struct('b', [0.16, -0.48, 0.48, -0.16], 'a', [1, 0.13, 0.52, 0.3], 'name', '(a) High-Pass Filter (HPF)'), ...
    struct('b', [0.634, 0, -0.634],         'a', [1, 0, -0.268],       'name', '(b) Band-Pass Filter (BPF)'), ...
    struct('b', [0.634, 0, 0.634],          'a', [1, 0, 0.268],        'name', '(c) Band-Stop / Notch Filter'), ...
    struct('b', [1, -5, 10],                'a', [10, -5, 1],          'name', '(d) All-Pass Filter')
    };

for k = 1:length(filters)
    b = filters{k}.b;
    a = filters{k}.a;
    title_str = filters{k}.name;
    [H, w] = freqz(b, a, 512);
    mag = abs(H);
    phase = angle(H);
    subplot(4, 2, 2*k - 1);
    plot(w/pi, mag, 'b', 'LineWidth', 1.2);
    title([title_str, ' - Magnitude']);
    ylabel('|H(\omega)|'); xlabel('\omega (\times\pi rad)'); grid on;
    ylim([0, max(1.2, max(mag)*1.1)]); 
    subplot(4, 2, 2*k);
    plot(w/pi, phase, 'r', 'LineWidth', 1.2);
    title([title_str, ' - Phase']);
    ylabel('Phase (rad)'); xlabel('\omega (\times\pi rad)'); grid on;
end

clc; close all;
test_cases = {
    {[0.5; -0.5], [0.8; -0.8], 2, 'Spec 1: Real Poles/Zeros'}, ...
    {[exp(1i*pi/3); exp(-1i*pi/3)], [0.95*exp(1i*pi/3); 0.95*exp(-1i*pi/3)], 1, 'Spec 2: Notch Filter'}
    };

for i = 1:length(test_cases)
    z = test_cases{i}{1};
    p = test_cases{i}{2};
    k = test_cases{i}{3};
    label = test_cases{i}{4};
    [b, a] = zp2tf(z, p, k);
    disp('Numerator (b):'); disp(b);
    disp('Denominator (a):'); disp(a);
    subplot(2, 2, 2*i - 1);
    zplane(b, a);
    title([label, '(Pole-Zero Plot)']); grid on;

    subplot(2, 2, 2*i);
    [H, w] = freqz(b, a);
    plot(w/pi, abs(H), 'LineWidth', 1.2);
    title([label, '(Magnitude Response)']);
    xlabel('Normalized Frequency (\times\pi rad/sample)');
    ylabel('|H(\omega)|'); grid on;
end

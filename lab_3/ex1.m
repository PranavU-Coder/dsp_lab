clc; close all; 
n = 0:15;                              
x = 0.9 * exp(1i * 3 * pi * n / 10);   
w = -2*pi : 0.005 : 2*pi;               
X = x * exp(-1i * (n' * w));
wshift = w + 2*pi;
Xshifted = x * exp(-1i * (n' * wshift));
max_error = max(abs(X - Xshifted));
if max_error < 1e-12
    disp('Periodicity has been verified');
else
    disp('Periodicity has not been verified.');
end
subplot(2,1,1);
plot(w/pi, abs(X), 'b', 'LineWidth', 1.5);
title('DTFT Magnitude');
xlabel('Frequency \omega (\times\pi rad/sample)');
ylabel('Magnitude');
subplot(2,1,2);
plot(w/pi, angle(X), 'r', 'LineWidth', 1.2);
title('DTFT Phase Angle');
xlabel('Frequency \omega (\times\pi rad/sample)');
ylabel('Phase');

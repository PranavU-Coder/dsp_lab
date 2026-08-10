clc; close all;
n = 0:15;                       
a = [1, -0.6, -0.16];           
b = [5, 0, 0];                  
x = [1, zeros(1, length(n)-1)]; 
h = filter(b, a, x);            
stem(n, h);          
title('unit-impulse response');
ylabel('amplitude'); xlabel('n--->');

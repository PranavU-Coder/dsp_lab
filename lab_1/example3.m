clc; close all;
% lab manual code for this is wrong
n = 0:10;
u = n >= 0;        
u5 = (n-5) >= 0;   
x = u - u5;        
y = [1, 2, 3, 4, 5];
z = conv(x, y);
nz = 0 : (length(z) - 1);
stem(nz, z);

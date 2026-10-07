#include <stdio.h>
#include <math.h>
#include "L138_LCDK_aic3106_init.h"

#define N 8
#define PI 3.14159265358979323846

const float X_real[N] = {1.0f, 1.0f, 2.0f, -2.0f, 3.0f, 0.0f, 5.0f, 1.0f};
const float X_imag[N] = {0.0f, 0.0f, 0.0f,  0.0f, 0.0f, 0.0f, 0.0f, 0.0f};

float x_real[N] = {0};
float x_imag[N] = {0};

void compute_idft(void)
{
    int n, k;
    
    for (n = 0; n < N; n++)
    {
        x_real[n] = 0.0f;
        x_imag[n] = 0.0f;
        
        for (k = 0; k < N; k++)
        {
            float theta = (2.0f * PI * k * n) / N;
            x_real[n] += X_real[k] * cosf(theta) - X_imag[k] * sinf(theta);
            x_imag[n] += X_real[k] * sinf(theta) + X_imag[k] * cosf(theta);
        }
        
        x_real[n] /= N;
        x_imag[n] /= N;
    }
}

int main(void)
{
    int n;
    L138_LCDK_aic3106_init(FS_48KHZ, AIC3106_HP_OUT);
    compute_idft();
    printf(" n |    Reconstructed Real x_R[n]   |   Imaginary Residual x_I[n]\n");
    for (n = 0; n < N; n++)
    {
        printf("%2d | %29.4f | %27.4f\n", n, x_real[n], x_imag[n]);
    }

    while (1)
    {}
}

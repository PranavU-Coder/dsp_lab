#include <stdio.h>
#include <math.h>
#include "L138_LCDK_aic3106_init.h"

#define N 8
#define PI 3.14159265358979323846

const float x[N] = {1.0f, 1.0f, 2.0f, -2.0f, 3.0f, 0.0f, 5.0f, 1.0f};

float X_real[N] = {0};
float X_imag[N] = {0};
float X_mag[N]  = {0};
float X_phase[N] = {0};

void compute_dft(void)
{
    int k, n;
    for (k = 0; k < N; k++)
    {
        X_real[k] = 0.0f;
        X_imag[k] = 0.0f;
        
        for (n = 0; n < N; n++)
        {
            float theta = (2.0f * PI * k * n) / N;
            X_real[k] += x[n] * cosf(theta);
            X_imag[k] -= x[n] * sinf(theta);
        }        
      X_mag[k]   = sqrtf(X_real[k] * X_real[k] + X_imag[k] * X_imag[k]);
      X_phase[k] = atan2f(X_imag[k], X_real[k]);
    }
}

int main(void)
{
    int k;
    L138_LCDK_aic3106_init(FS_48KHZ, AIC3106_HP_OUT);
    compute_dft();

    printf(" k |      Real X_R[k]   |   Imaginary X_I[k] |   Magnitude |X[k]| |   Phase (rad)\n");
    for (k = 0; k < N; k++)
    {
        printf("%2d | %18.4f | %18.4f | %16.4f | %13.4f\n", 
                k, X_real[k], X_imag[k], X_mag[k], X_phase[k]);
    }
    while (1)
    {}
}

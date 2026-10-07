#include "L138_LCDK_aic3106_init.h"

#define SINE_TABLE_SIZE 48
#define AMPLITUDE       10000   // 16-bit audio range: -32768 to 32767

const int16_t sine_table[SINE_TABLE_SIZE] = {
        0,   1305,   2588,   3826,   5000,   6087,   7071,   7933,
     8660,   9238,   9659,   9914,  10000,   9914,   9659,   9238,
     8660,   7933,   7071,   6087,   5000,   3826,   2588,   1305,
        0,  -1305,  -2588,  -3826,  -5000,  -6087,  -7071,  -7933,
    -8660,  -9238,  -9659,  -9914, -10000,  -9914,  -9659,  -9238,
    -8660,  -7933,  -7071,  -6087,  -5000,  -3826,  -2588,  -1305
};

volatile uint16_t sample_index = 0;

interrupt void interrupt4(void)
{
    int16_t current_sample = sine_table[sample_index];
    output_left_sample(current_sample);
    output_right_sample(current_sample);
    sample_index = (sample_index + 1) % SINE_TABLE_SIZE;
    return;
}

int main(void)
{
    L138_LCDK_aic3106_init(FS_48KHZ, AIC3106_HP_OUT)
    while(1)
    {}
}

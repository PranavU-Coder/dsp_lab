#include <stdlib.h>
#include "L138_LCDK_aic3106_init.h"

#define MAX_AMPLITUDE 10000    // Peak amplitude scale (-10000 to +10000)
interrupt void interrupt4(void)
{
    int16_t random_sample = (int16_t)(((float)rand() / RAND_MAX) * 2.0f * MAX_AMPLITUDE) - MAX_AMPLITUDE;
    output_left_sample(random_sample);
    output_right_sample(random_sample);
    return;
}

int main(void)
{
    srand(1);
    L138_LCDK_aic3106_init(FS_48KHZ, AIC3106_HP_OUT);
    while(1)
    {}
}

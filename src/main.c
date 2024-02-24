/**
 * @file    main.c
 * @author  Łukasz Łaguna
 * @brief   Main file
 */

#include "stm32f103xg.h"
#include "gpio.h"

int main(void)
{
    gpio_init();

    while(1)
    {
        GPIOA->BSRR = GPIO_BSRR_BS5;
        for (int i = 0; i < 1000000; i++);
        GPIOA->BSRR = GPIO_BSRR_BR5;
        for (int i = 0; i < 1000000; i++);
    }

    return 0;
}
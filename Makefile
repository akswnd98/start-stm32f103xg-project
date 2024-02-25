SRCS := $(filter %.c, $(shell ls src))
HAL_SRCS := stm32f1xx_hal.c stm32f1xx_hal_cortex.c stm32f1xx_hal_rcc.c stm32f1xx_hal_rcc_ex.c stm32f1xx_hal_pwr.c stm32f1xx_hal_flash.c stm32f1xx_hal_flash_ex.c stm32f1xx_hal_msp.c stm32f1xx_hal_exti.c stm32f1xx_hal_tim.c stm32f1xx_hal_tim_ex.c stm32f1xx_hal_timebase_rtc_alarm.c stm32f1xx_hal_rtc.c stm32f1xx_hal_rtc_ex.c stm32f1xx_hal_gpio.c

all: firmware.elf

firmware.elf:
	arm-none-eabi-gcc \
		-DSTM32F103xB \
		-DUSE_HAL_DRIVER \
		$(foreach file, $(SRCS), src/$(file)) \
		$(foreach file, $(HAL_SRCS), STM32F1xx_HAL_Driver/Src/$(file)) \
		./cmsis_device_f1/Source/Templates/system_stm32f1xx.c \
		./cmsis_device_f1/Source/Templates/gcc/startup_stm32f103xb.s \
		-o firmware.elf \
		-T ./cmsis_device_f1/Source/Templates/gcc/linker/STM32F103XB_FLASH.ld \
		-mcpu=cortex-m3 -mthumb \
		-Icmsis_device_f1/Include \
		-ICMSIS_5-5.9.0/CMSIS/Core/Include \
		-ISTM32F1xx_HAL_Driver/Inc \
		-Iinclude \
		-specs=nosys.specs

clean:
	rm -f firmware.elf

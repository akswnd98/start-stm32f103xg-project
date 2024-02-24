SRCS := $(filter %.c, $(shell ls src))

all: firmware.elf

firmware.elf:
	arm-none-eabi-gcc \
		$(foreach file, $(SRCS), src/$(file)) \
		-o firmware.elf \
		./cmsis_device_f1/Source/Templates/system_stm32f1xx.c \
		./cmsis_device_f1/Source/Templates/gcc/startup_stm32f103xg.s \
		-T ./cmsis_device_f1/Source/Templates/gcc/linker/STM32F103XB_FLASH.ld \
		-mcpu=cortex-m3 -mthumb \
		-Icmsis_device_f1/Include \
		-ICMSIS_5-5.9.0/CMSIS/Core/Include \
		-Iinclude \
		-DSTM32F103xG \
		-specs=nosys.specs

clean:
	rm -f firmware.elf

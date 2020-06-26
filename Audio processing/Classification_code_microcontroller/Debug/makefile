################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include Drivers/STM32L0xx_HAL_Driver/Src/subdir.mk
-include Drivers/CMSIS/Source/TransformFunctions/subdir.mk
-include Drivers/CMSIS/Source/SupportFunctions/subdir.mk
-include Drivers/CMSIS/Source/StatisticsFunctions/subdir.mk
-include Drivers/CMSIS/Source/MatrixFunctions/subdir.mk
-include Drivers/CMSIS/Source/FilteringFunctions/subdir.mk
-include Drivers/CMSIS/Source/FastMathFunctions/subdir.mk
-include Drivers/CMSIS/Source/ControllerFunctions/subdir.mk
-include Drivers/CMSIS/Source/ComplexMathFunctions/subdir.mk
-include Drivers/CMSIS/Source/CommonTables/subdir.mk
-include Drivers/CMSIS/Source/BasicMathFunctions/subdir.mk
-include Core/Startup/subdir.mk
-include Core/Src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
EXECUTABLES += \
Master_thesis_test.elf \

SIZE_OUTPUT += \
default.size.stdout \

OBJDUMP_LIST += \
Master_thesis_test.list \

OBJCOPY_BIN += \
Master_thesis_test.bin \


# All Target
all: Master_thesis_test.elf secondary-outputs

# Tool invocations
Master_thesis_test.elf: $(OBJS) $(USER_OBJS) C:\Users\marti\Desktop\Master_thesis_test\STM32L072CZYX_FLASH.ld
	arm-none-eabi-gcc -o "Master_thesis_test.elf" @"objects.list" $(USER_OBJS) $(LIBS) -mcpu=cortex-m0plus -T"C:\Users\marti\Desktop\Master_thesis_test\STM32L072CZYX_FLASH.ld" --specs=nosys.specs -Wl,-Map="Master_thesis_test.map" -Wl,--gc-sections -static -specs=rdimon.specs --specs=nano.specs -mfloat-abi=soft -mthumb -u _printf_float -u _scanf_float -Wl,--start-group -lc -lm -Wl,--end-group
	@echo 'Finished building target: $@'
	@echo ' '

default.size.stdout: $(EXECUTABLES)
	arm-none-eabi-size  $(EXECUTABLES)
	@echo 'Finished building: $@'
	@echo ' '

Master_thesis_test.list: $(EXECUTABLES)
	arm-none-eabi-objdump -h -S $(EXECUTABLES) > "Master_thesis_test.list"
	@echo 'Finished building: $@'
	@echo ' '

Master_thesis_test.bin: $(EXECUTABLES)
	arm-none-eabi-objcopy  -O binary $(EXECUTABLES) "Master_thesis_test.bin"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) *
	-@echo ' '

secondary-outputs: $(SIZE_OUTPUT) $(OBJDUMP_LIST) $(OBJCOPY_BIN)

.PHONY: all clean dependents
.SECONDARY:

-include ../makefile.targets

ARCH ?= arm
CROSS_COMPILE ?= /opt/gcc-arm-none-eabi-7-2018-q2-update/bin/arm-none-eabi-

SRC = $(wildcard src/*.c)
SRCASM = $(wildcard src/*.s)
OBJS = $(patsubst %,build/%,$(subst .c,.o, $(SRC)))
OBJS += $(patsubst %,build/%,$(subst .s,.o, $(SRCASM)))
INCLUDE = -ICMSIS/ -Iinc/

FLAGS = -mcpu=cortex-m7 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra -g3
CFLAGS  := $(FLAGS) -DSTM32F746xx -std=gnu11 -Wno-missing-prototypes -Wno-missing-declarations -MMD -MP
LDFLAGS := $(FLAGS) -T linker.ld -Xlinker --gc-sections --specs=nosys.specs

all: dir build/bootloader.hex

dir:
	mkdir -p build/src

build/%.o: %.s
	@echo "CC   " $^
	$(CROSS_COMPILE)gcc $(CFLAGS) $(INCLUDE) -c $^ -o $@

build/%.o: %.c
	@echo "CC   " $^
	$(CROSS_COMPILE)gcc $(CFLAGS) $(INCLUDE) -c $^ -o $@

build/bootloader.elf: $(OBJS)
	@echo "LD   " $^
	$(CROSS_COMPILE)g++ $(LDFLAGS) $^ -o $@

%.hex: %.elf
	$(CROSS_COMPILE)objcopy -O ihex $^ $@

clean:
	rm -f build/src/*.o build/*.elf build/*.hex build/*.elf

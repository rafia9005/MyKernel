OUTPUT = build/output
OS_IMAGE = $(OUTPUT)/os-image.bin

all: $(OS_IMAGE)

$(OUTPUT):
	mkdir -p $(OUTPUT)

$(OUTPUT)/boot.bin: $(OUTPUT)
	nasm -f bin boot/boot.asm -o $(OUTPUT)/boot.bin

$(OUTPUT)/kernel.bin: $(OUTPUT)
	nasm -f bin kernel/kernel.asm -o $(OUTPUT)/kernel.bin

$(OUTPUT)/main.bin: $(OUTPUT)
	nasm -f bin loader/main.asm -o $(OUTPUT)/main.bin

$(OUTPUT)/memory.bin: $(OUTPUT)
	nasm -f bin loader/memory.asm -o $(OUTPUT)/memory.bin

$(OS_IMAGE): $(OUTPUT)/boot.bin $(OUTPUT)/kernel.bin $(OUTPUT)/main.bin $(OUTPUT)/memory.bin
	cat $(OUTPUT)/boot.bin $(OUTPUT)/kernel.bin $(OUTPUT)/main.bin $(OUTPUT)/memory.bin > $(OS_IMAGE)

clean:
	rm -rf $(OUTPUT)

run:
	qemu-system-i386 -fda $(OUTPUT)/os-image.bin

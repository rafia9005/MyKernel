all: os-image

boot.bin: boot/boot.asm
	nasm -f bin boot/boot.asm -o boot.bin

main.bin: loader/main.asm
	nasm -f bin loader/main.asm -o main.bin

memory.bin: loader/memory.asm
	nasm -f bin loader/memory.asm -o memory.bin

kernel.bin: kernel/kernel.asm
	nasm -f bin kernel/kernel.asm -o kernel.bin

# kernel.bin: kernel/kernel.c
# 	i686-elf-gcc -ffreestanding -c kernel/kernel.c -o kernel.bin

os-image: boot.bin main.bin memory.bin kernel.bin
	cat boot.bin main.bin memory.bin kernel.bin > os-image.bin

run:
	qemu-system-i386 -fda os-image.bin

clean:
	rm -f *.bin

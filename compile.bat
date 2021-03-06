@echo off
nasmw -f bin bootsect.asm -o bootsect.bin

gcc -ffreestanding -c main.c -o main.o
gcc -c video.c -o video.o
gcc -c ports.c -o ports.o

ld -e _principal -Ttext 0x1000 -o kernel.o main.o video.o ports.o

objcopy -R .note -R .comment -S -O binary kernel.o kernel.bin

makeboot a.img bootsect.bin kernel.bin
miso boot.iso -ab "a.img"
FILE = frogger
#-----------------------------------------------------------------------
ABS_DIRECTORY = Directory/EFI/BOOT/
DIRECTORY_FILE = Directory/
FINAL_FILE = BOOTX64
IMAGE_NAME = fat

all:	efi img bin

efi:
		fasm $(FILE).asm

img:
		mv $(FILE).efi $(FINAL_FILE).efi
		dd if=/dev/zero of=fat.img bs=1k count=1440
		mformat -i fat.img -f 1440 ::
		mmd -i fat.img ::/EFI
		mmd -i fat.img ::/EFI/BOOT
		mcopy -i $(IMAGE_NAME).img $(FINAL_FILE).efi ::/EFI/BOOT
		mkgpt -o hdimage.bin --image-size 4096 --part fat.img --type system

bin:
		qemu-system-x86_64 -L /home/danny/Descargas/ovmf-1\ 202002-1-any.pkg/ -pflash /home/danny/Descargas/ovmf-1\ 202002-1-any.pkg/usr/share/ovmf/x64/OVMF_CODE.fd -hda hdimage.bin

.PHONY clean:
		rm BOOTX64.efi
		rm hdimage.bin
		rm fat.img

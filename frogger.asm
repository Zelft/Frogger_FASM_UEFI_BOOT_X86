;
;*       Frogger UEFI application X86
;*       Principios de Sistemas Oprativos - Ingenieria en Computacion
;*       Danny Andres Piedra Acuna 
;*       06/04/2021
;*
;*

format pe64 dll efi
entry main

section '.text' code executable readable

; To use the uefi Input/Output functions
include 'uefi.inc'


main:
 	; Initialize UEFI library
	InitializeLib

	; Equivalent to SystemTable->ConOut->OutputString(SystemTable->ConOut, "Message")
	uefi_call_wrapper ConOut, ClearScreen, ConOut, 1
	uefi_call_wrapper ConOut, OutputString, ConOut, _hello
	;uefi_call_wrapper ConOut, OutputString, ConOut, input_message
 
ret
section '.data' data readable writeable

Handle      dq ?
SystemTable dq ?
_hello      du 'Hello World',13,10,'(From EFI app written in FASM)',13,10,0

section '.reloc' fixups data discardable
;///////////////////////////////////////////////////////////////////////
;
;	dyncall_x86_nasm.nasm
;	Copyright 2007 Daniel Adler.
;
;	X86 Calls for nasm assembler
;
;///////////////////////////////////////////////////////////////////////


    BITS 32
    section .text

;///////////////////////////////////////////////////////////////////////
; CSYM macro
;///////////////////////////////////////////////////////////////////////

%ifdef DC_PERFIX_SYMBOLS

%macro CSYM 1
  global _%1
_%1:
%endmacro

%else

%macro CSYM 1
  global %1
%1:
%endmacro

%endif

; -----------------------------------------------------------------------------
; Calling Convention x86 standard C
; - all arguments are on the stack
; - caller cleans up stack
;
; C proto 
;   dcCallC(DCptr funptr, DCptr args, DCsize size)
; -----------------------------------------------------------------------------

CSYM dcCall_x86_cdecl

    push ebp              ; prolog 
    mov  ebp, esp         

    ; arguments:
    ;
    ; funptr  ebp+8
    ; args    ebp+12
    ; size    ebp+16
    ; result  ebp+20
  
    push esi              ; save esi, edi
    push edi

    mov  esi, [ebp+12]    ; esi = pointer on args
    mov  ecx, [ebp+16]    ; ecx = size

    sub  esp, ecx         ; cdecl call: allocate 'size' bytes on stack
    mov  edi, esp         ; edi = stack args
    
    rep movsb             ; copy arguments

    call [ebp+8]          ; call function

    add  esp, [ebp+16]    ; cdecl call: cleanup stack

    pop  edi              ; restore edi, esi
    pop  esi

    mov  esp, ebp         ; epilog
    pop  ebp

    ret

; -----------------------------------------------------------------------------
; Calling Convention x86 microsoft thiscall
; - thispointer is in ECX, rest is on the stack
; - callee cleans up stack
;  
; C proto
;   dcCallThisMS(DCptr funptr, DCptr args, DCsize size)
; -----------------------------------------------------------------------------
CSYM dcCall_x86_win32_msthis
    
    push ebp              ; prolog 
    mov  ebp, esp         

    ; arguments:
    ;
    ; funptr  ebp+8
    ; args    ebp+12
    ; size    ebp+16
  
    push esi              ; save esi, edi
    push edi

    mov  esi, [ebp+12]    ; esi = pointer on args
    mov  ecx, [ebp+16]    ; ecx = size

    mov  eax, [esi]       ; eax = this pointer
    add  esi, 4           ; increment args pointer by thisptr
    sub  ecx, 4           ; decrement size by sizeof(thisptr)

    sub  esp, ecx         ; allocate argument-block on stack
    mov  edi, esp         ; edi = stack args
    
    rep movsb             ; copy arguments

    mov  ecx, eax         ; ecx = this pointer

    call [ebp+8]          ; call function (thiscall: cleanup by callee)

    pop  edi              ; restore edi, esi
    pop  esi

    mov  esp, ebp         ; epilog
    pop  ebp

    ret    
    
; -----------------------------------------------------------------------------
; Calling Convention x86 win32 stdcall
; - all arguments are passed by stack
; - callee cleans up stack
; 
; C proto
;   dcCallStd(DCptr funptr, DCptr args, DCsize size)
; -----------------------------------------------------------------------------
CSYM dcCall_x86_win32_std
    push ebp              ; prolog 
    mov  ebp, esp         

    ; arguments:
    ;
    ; funptr  ebp+8
    ; args    ebp+12
    ; size    ebp+16
  
    push esi              ; save esi, edi
    push edi

    mov  esi, [ebp+12]    ; esi = pointer on args
    mov  ecx, [ebp+16]    ; ecx = size

    sub  esp, ecx         ; stdcall: allocate 'size'-8 bytes on stack
    mov  edi, esp         ; edi = stack args
    
    rep movsb             ; copy arguments

    call [ebp+8]          ; call function (stdcall: cleanup by callee)

    pop  edi              ; restore edi, esi
    pop  esi

    mov  esp, ebp         ; epilog
    pop  ebp

    ret

; -----------------------------------------------------------------------------
; Calling Convention x86 win32 fastcall
; - first two integer (up to 32bits) are passed in ECX and EDX
; - others are passed on the stack
; - callee cleans up stack
; 
; C proto
;   dcCallFast(DCptr funptr, DCptr args, DCsize size)
; -----------------------------------------------------------------------------
CSYM dcCall_x86_win32_fast

    push ebp              ; prolog 
    mov  ebp, esp

    ; arguments:
    ;
    ; funptr  ebp+8
    ; args    ebp+12
    ; size    ebp+16
  
    push esi              ; save esi, edi
    push edi

    mov  esi, [ebp+12]    ; esi = pointer on args
    mov  ecx, [ebp+16]    ; ecx = size
    mov  eax, [esi]       ; eax = first argument
    mov  edx, [esi+4]     ; edx = second argument
    add  esi, 8           ; increment source pointer
    sub  ecx, 8           ; decrement size by 8

    sub  esp, ecx         ; fastcall: allocate 'size'-8 bytes on stack
    mov  edi, esp         ; edi = stack args
    
    rep movsb             ; copy arguments

    mov  ecx, eax         ; ecx = first argument

    call [ebp+8]          ; call function (fastcall: cleanup by callee)

    pop  edi              ; restore edi, esi
    pop  esi

    mov  esp, ebp         ; epilog
    pop  ebp

    ret    

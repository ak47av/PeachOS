section .asm

extern int21h_handler
extern no_interrupt_handler
extern isr80h_handler

global int21h
global idt_load
global no_interrupt
global enable_interrupts
global disable_interrupts
global isr80h_wrapper

enable_interrupts:
    sti
    ret

disable_interrupts:
    cli
    ret

idt_load:
    push ebp
    mov ebp, esp

    mov ebx, [ebp+8]
    lidt [ebx]
    pop ebp
    ret

int21h:
    pushad
    call int21h_handler
    popad
    iret

no_interrupt:
    pushad
    call no_interrupt_handler
    popad
    iret

isr80h_wrapper:
    ; INTERRUPT FRAME START
    ; already pushed top us by the processor upon entry this interrupt
    ; uint32_t ip
    ; uint32_t cs;
    ; uint32_t flags;
    ; uint32_t sp;
    ; uin32_t ss;
    ; pushes the general purpose registers to the stack
    pushad

    ; interrupt frame ends

    ; push the stack pointer so that we are pointing to the interrupt frame
    push esp

    ; eax has the command, since the c functions see eax as the argument
    push eax 
    call isr80h_handler
    mov dword[tmp_res], eax ; c functions return value in eax reg
    add esp, 8 ; restore stack to the state before we pushed interrupt frame and command
    
    ; restore general purpose registers for user land
    popad
    mov eax, [tmp_res]
    iretd

section .data
; inside here is stored the return result from isr80h_handler
tmp_res: dd 0


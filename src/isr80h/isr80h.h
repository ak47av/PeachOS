#ifndef ISR80H_H
#define ISR80H_H

#include "idt/idt.h"

enum SystemCommands
{
    SYSTEM_COMMAND0_SUM
};
void isr80h_register_commands();

#endif
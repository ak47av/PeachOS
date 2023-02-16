#ifndef PROCESS_H
#define PROCESS_H
#include <stdint.h>
#include "task.h"
#include "config.h"

struct process
{
    // the process id
    uint16_t id;

    char filename[PEACHOS_MAX_PATH];

    // the main process task
    struct task* task;

    //keep track of all allocations
    void* allocations[PEACHOS_MAX_PROGRAMS_ALLOCATIONS];
    
    // physical pointer to the process memory
    void* ptr; 

    // physical pointer to the stack memory
    void* stack;

    // the size of the data pointed to by the pointer
    uint32_t size;
};
int process_load_for_slot(const char* filename, struct process** process, int process_slot);

int process_load(const char* filename, struct process** process);

#endif
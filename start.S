#
# Copyright © 2023 inpyjama.com. All Rights Reserved.
# Author: Mahmad Bharmal <mahmad@inpyjama.com>
#
# ARM Data Processing instruction format is, INSTRUCTION Rd(destination register) Rn(Operend_1) Operend_2(Can be immediate operend, register)

.section ".init"
_start:
    mrs     x1, mpidr_el1    ;Copies system register mpdir_el1 into 64 bit General register x1
                             ;MIPIDR_EL1 The Multi-Processor Affinity Register, it enables software to detrermine 
                             ;on which core and in which cluster its running
                             ;we are copying current coreID into x1 register
    and     x1, x1, #3       ;x1 is destination, after this operation if current running core no is 0 then 0 will be stored in X1
                             ;for remaining core1, core2 and core3 some non-zero value will be present in x1
    cbnz    x1, 1f           ;Compare and branch if x1 register is not zero then jump to location 1
    ldr     x1, =_start      ;load 8 byte from location start into x1 register, 
    mov     sp, x1           ;Move address of _start present in X1 register into stack pointers 
    bl      main             ;branch to location of main function
1:
    wfe                      ;wait for event
    b       1b

0 Multicore Processor: Multi Core SoCs have more than one processor where each processor has its own specific application.
  For eg. Most of the industries SoC integrates primary core (Booting core) ,application/system core , networking cores on a 
single die to handlevarious data from different peripherals (Master/Slave) 
Booting sequence: Multi core booting sequence helps to understand, How actually SoC works and what are the sequence of SoC wakeup once POR assert .
POR => Power on Reset is nothing but a hardware reset logic.
o BOOT ROM, Boot loader, Image/hex generation using linker file, Boot options (boot from different devices like SPI/SDIO/PCI etc) .
  Also talked about multi core boot form various memories (SRAM/GRAM/FLASH). Apart from those also discussed the challenges and faced
  issues during multi core booting at initial level and approaches to handle those issues/challenges. 
o In Multi core SoCs, first primary core (also called booting core) start up in boot process and then secondary cores are enabled by
    software.
    Primary core => Booting core. Heart of any SOC that handles the booting and maximum functionality
    but for heavy traffic data (Ethernet/TDM) and high frequencies(CSI-2,QSPI) applications, 
      we need to have specific application core such as CORTEX-A cores to process the data .

      reset vector location => Also called Boot ROM

o The reset vector is the location is mapped to the ROM start address (also called boot ROM), 
from where the core will start execution after POR.
    > The reset vector is the address where a processor goes to find the first instruction to execute when it resets. 
      It's a pointer or address in non-volatile memory, like BIOS or Boot ROM, that contains instructions to start the 
      CPU's operation.
    > The reset vector of a processor is the default location where, upon a reset, the processor will go to find the 
      first instruction to execute. In other words, the reset vector is a pointer or address where the processor should 
      always begin its execution.

Booting Flow:
    POR => begin execution starting from the on-chip Boot ROM => Boot ROM code uses the given boot select options

1.When the device gets POR
2.the primary core(Booting core) jump to reset vector location(boot ROM).
3. Once primary core (like ARM Coretx-M) is out of reset it will start executing from memory address location 0x00000000.
4. The primary core loads the program counter and starts executing from address 0xSP(Primary core stack pointer , 
inside ROM at 0xSP location it’s stack pointer will be loaded) which instructs the core to load its reset handler 
(stack pointer, vector table) and read processor Start Address(PSA) to get application boot address and jump to that location.
  
o Program counter/instruction pointer:A program counter (PC) is a register in a computer's processor that stores the memory address
    of the next instruction to be executed. Stores the memory address of the next instruction to be executed.The CPU uses the PC to fetch instructions from 
    memory one at a time, and then increases the PC by 1 to point to the next instruction.
o Stack pointer: A stack pointer is a register that stores the address of the last item added to a stack.
    The stack pointer is located at the top of the stack and is used to access stack memory.
    A stack is a temporary storage area in a computer's memory that uses a last in, first out (LIFO) data structure.
    The two main operations on a stack are push, which adds an item to the stack, and pop, which removes the most recently added item.
o reset handler: A reset handler, also known as startup code, is the first software to run after a system reset. 
  It's responsible for setting up configuration data for the C startup code, which then branches into the C startup code.
  The reset handler or startup code is the first piece of software to execute after a system reset. Typically,
  the reset handler is used for setting up configuration data for the C startup code (such as address range for stack and 
  heap memories), which then branches into C startup code.

5. At the PSA, the hex file or image is loaded by boot loader. This address can be of SRAM/GRAM or FLASH.
6. CORE will execute the Image/.hex from PSA which is likely to load at SRAM/GRAM or FLASH as directed by Boot Loader.
    The loading of Image/.hex into memory (FLASH/SRAM/GRAM) is done by boot loader. This loader can be inbuilt with BOOT ROM or 
    can be external loader.



    Toolchain: You need a compiler (and an assembler and a linker), also known as a toolchain.

The compiler converts your C program source code into executable object code for your target machine. This object code can be represented as a series of hex digits in a .hex file.
 toolchain. There are a number of steps which have to happen between the C code you have and loading data onto the device:

The preprocessor converts #include and #define macros, and also processes any conditional compilation (#if) symbols.
The compiler converts each .c file into assembly code.
The assembler converts those into object files. These files use relative addressing.
The linker puts all the object files together into the series of hex digits in the .hex file, and gives them the addresses required by the device. It also brings in any external object files for which you don't have the source code (or have already compiled it in a previous iteration).
This is generally referred to as a toolchain, but may be informally referred to as a compiler.







          

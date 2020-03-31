# Operating Systems

## Chapter 3

1. a **program** is inert, passive - a **process** is active, executing
2. Process States (Names are arbitrary and vary across OSes)
    * New - process is created
    * Running - being executed (ONLY ONE MAY BE AT A TIME PER PROCESSOR!)
    * Waiting - sleeping
    * Ready - waiting to be assigned to a processor
    * Terminated - finished execution
3. **PCB** - Process Control Block
    * Process State
    * Program Counter
    * CPU registers
    * CPU-scheduling information
    * Memory-management information
    * Accounting information
    * I/O Status information
4. Program Counter - indicates the address of the next instruction to be executed
5. Process Scheduler:
    * As processes enter the system they are put into a "Job Queue"
    * Processes that are wating and ready to execute are kept in a list called the "Ready Queue"
    * Processes waiting on I/O for a particular device are put into a "Device Queue"
    * selecting a process for execution is called "dispatched"
    * swapping - ie swap on unix
6. Context Switching
    * perform "State Save" and "State Restore"
    * ^-- this action is called a "context switch"
7. Process Termination
    * Cascading Termination - When a system does not allow children to 
        exist if parent is terminated
    * **Zombie** process - process that has terminated but its parent has not called `wait()`
    * **Orphan** process - parent has terminated and didn't call wait, it now has no parent.
        On UNIX systems, **PID 1**, *(init)*, is the "reaper of orphaned children"
8. Interprocess Communication
    * "independent" - if a process cannot be affected by other processes
    * "cooperating" - if a process can affect OR be affected by other processes
    * IPC - Inter-Process Communication
        a) Shared Memory - can be faster
        b) Message Passing - easier to implement
    * Synchronization
        a) blocking
        b) non-blocking
9. **RPC** - Remote Procedure Calls

## Chapter 4

1. Parallelism
    * Data Parallelism - splitting data across cores performing the same task on each
    * Task Parallelism - splitting different tasks among cores
2. Multithread Modeling
    * Many-to-One - maps many user-level threads to one kernel thread
    * One-to-One - every user-level thread has a kernel thread (Linux + Windows)
    * Many-to-Many
3. `fork()` vs `exec()`
    * `exec()` - replace current process with argument
    * `fork()` - create a new process
4. Thread Cancellation
    * Target Thread - thread that is to be cancelled 
    * Asynchronous Cancellation - One thread immediately (forcively) terminates another
    * Deferred Cancellation - Thread continuously checks whether it should terminate itself

## Chapter 5 - Process Synchronization

1. Critical Section Problem
    * Section of a program where it it may be changing data
    * States that NO other process may be executing its own critical section
        during this time (to avoid collisions)
    * 3 sections:
        a) entry section
        b) exit section
        c) remainder section
    * Requirements for Critical-Section Solution
        a) Mutual Exclusion - if executing C.S., no other process can be executing their C.S.
        b) Progress - if no process is executing its critical section and some
                      processes wish to enter their critical sections, then only
                      those that are NOT executing their Remainder Sections can
                      paricipate which will enter their critical section next
        c) Bounded Waiting - A bound, or upper limit, exists on the number of times
                             that processes are allowed to enter their C.S. after
                             a process has made a request to enter its C.S. and
                             before that C.S. request is granted
    * Approaches to handling critical sections:
        a) preemptive kernels - allows a process to be "preempted" while in kernel mode.
                                difficult to implement on SMP architectures
        b) non-premptive kernels - does not allow --^
2. Peterson's Solution to Critical Section Problem
    * requires two processes share two data items:  
        `int turn;`  
        `boolean flag[2];`
    * the variable "turn" indicates whose turn it is to enter their critical section
    * the flag array indicates if a process is ready to enter its critical section
3. Synchronization Hardware
    * atomically - "one uninterruptible unit"
    * functions: `test_and_set()` + `compare_and_swap()`
4. Mutex Locks
    * mutex - "mutual exclusion"
    * functions: `acquire()` and `release()`
    * requires "busy waiting", often called a *"spinlock"*
5. Semaphores
    * an integer variable accessed only through two standard functions: `wait()` and `signal()`
    * two types:
        a) counting semaphore - counts up to infinite
        b) binary sempahore - 0 or 1 (thus behaving much like a mutex lock)
6. Requirements for Deadlock
    * mutual exclusion - only one thread at a time can use a resource
    * hold and wait - "holding a resource while waiting for another resource"
    * no preemption - resources are released voluntarily only when thread is finished with it
    * circular wait
7. Methods for handling Deadlocks
    * use a protocol to ensure system will *never* enter a deadlocked state
    * allow system to enter deadlock, detect it, and recover
    * ignore the problem - (UNIX / Windows, it is up to the app dev to prevent)

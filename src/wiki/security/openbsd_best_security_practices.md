# OpenBSD - Best Security Practices

* Natively spoof/randomize MAC addresses:  
  
    `ifconfig if0 lladdr random`
    
* Use `freezero(3)` over `free(3)`:  
  
    overwrites memory with zeroes rather than just freeing it
    
* mount with the `noexec` flag:  
  
    no binaries on partitions mounted with this flag may be executed
    
* simple intrusion detection system method:
    1. `mtree -cK sha256digest -p {...} >some_file`
    2. `mtree -p {...} <some_file`
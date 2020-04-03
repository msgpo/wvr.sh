# OpenBSD - Best Security Practices

## # Networking

#### 1. Natively spoof/randomize MAC addresses:

`ifconfig if0 lladdr random`

## # Programming

#### 1. Use `freezero(3)` over `free(3)`:

overwrites memory with zeroes rather than just freeing it

## # System Management

#### 1. mount with the `noexec` flag:

no binaries on partitions mounted with this flag may be executed

#### 2. simple intrusion detection system method:

To create the hash:
`mtree -cK sha256digest -p {...} >some_file`

To check the hash:
`mtree -p {...} <some_file`

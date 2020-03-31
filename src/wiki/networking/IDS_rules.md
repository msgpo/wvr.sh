# IDS Rules 

*<sub>(Snort / Suricata / etc)</sub>*

### Example rule

```
alert tcp SOURCE_NET 23 -> EXTERNAL_NET any
```

### Actions

1. `alert` - log traffic, let it through
2. `pass` - just let it through
3. `drop` - drop packet, do not inform sender
4. `reject` - drop packet, inform sender

### Protocol

1. TCP,UDP,ICMP
2. IP
    * (works like wildcard, any protocol)
3. Suricata specific
    * HTTP, FTP, TLS, SMB, DNS

### Source and Destination IPs

1. IPv4 or IPv6
2. can also negate addresses
    * "not X"
3. built in variables:
    * `$HOME_NET` and `$EXTERNAL_NET`

### Source and Destination Ports

1. can be ranges
    * `80,82` - 80 and 82
    * `80:82` - 80 through 82
    * `1024:` - 1024 and higher
    * `!80` - any except 80
    * `any` - ALL
2. Note, for destination you will usually always use `any`
    * this is because the destination is an [ephemeral port](https://unix.stackexchange.com/questions/65475/ephemeral-port-what-is-it-and-what-does-it-do)

### Direction

* which way the signature has to match
* packets must flow in the direction
* almost always will be `->` (left to right)
* but can also be bi-directional, `<>`

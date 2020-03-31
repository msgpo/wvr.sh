# IDS Rules 

##### *(Snort / Suricata / etc)*

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

-------

## Contents of parameters

### Message

`msg: "GPL TELNET Bad Login";`

* Descriptive message
* Perhaps type of malware found, DDOS, etc

### Flow

`flow:from_server,established`

* Describes from what location a rule should apply
* More than just source and dest ip
* Server here is the *responder*
* `to_server`   === `from_client`
* `from_server` === `to_client`
* Most **TCP** rules will also use `established`
* **UDP** rules will just state the direction

### Rule Headers

* Do not affect how the packets are matched
* Messages to describe the rule
* Aid the analyst, provide more information

*<sub>Examples:</sub>*

1. **Classtype** - (Optional)
2. **SID** - Signature Identifier (Required)
3. **Rev** - Revision of the rule (Optional)
4. **Metadata** - any key/value pair you want

### Content

* Unique packet contents
* Can have multiple content sections
* Can be string based and/or hex based

### Content Modifiers

Many options:

1. `Nocase`
2. `Distance`
3. `Dsize`
4. `lsdataat`

<sub>*Example:*</sub>

```
alert tcp $HOME_NET 23 -> $EXTERNAL_NET any
(msg:"Some Message"; flow:from_server,established;
content:"A string to SeArCh for"; nocase; fast_pattern:only;
classtype:bad-unknown; sid:999999999; rev:9;
metadata:created_at 2000_01_01, updated_at 2001_01_01;)
```

Here we search for a packet at a certain date,
containing a certain string, case-insensitive.

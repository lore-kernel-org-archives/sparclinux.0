From: Jan Engelhardt <jengelh@medozas.de>
Date: Mon, 15 Nov 2010 03:28:26 +0000
Subject: Re: Linux 2.6.36-rc8 won't boot
Message-Id: <alpine.LNX.2.01.1011130628470.19482@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Tuesday 2010-11-02 14:48, Jan Engelhardt wrote:
>>
>>I just compiled 2.6.36-rc8 and observe a hang on boot. My previous 
>>working version was 2.6.34-rc1/gcc 4.4.1, and I checked that gcc isn't 
>>at fault by recompiling 2.6.34-rc1 with gcc 4.5.0 (it boots).
>
>I tried bisecting today, booted a number of kernels already, and upon 
>the latest reboot I only get this - very frustrating.
>
>SPARC Enterprise T1000, No Keyboard
>Copyright (c) 1998, 2010, Oracle and/or its affiliates. All rights 
>reserved.
>OpenBoot 4.30.4.b, 8064 MB memory available, Serial #81908004.
>Ethernet address 0:14:4f:e1:d1:24, Host ID: 84e1d124.
>(T1000 firmware 6.7.10)
>
>{0} ok boot
>Boot device: disk  File and args: 
>SILO Version 1.4.14
>ERROR: Last Trap: Illegal Instruction
>{0} ok

My SILO seems to have had a few cosmic Sun rays..
rerunning silo(8) from a netbooted kernel seems to have fixed it.

Speaking of net kernel, it was a bit of an annoyance to build a
crosscompiler. Other than using ^C or waiting for a compile error
to happen, how is one supposed to stop building gcc after xgcc
has been built? Seems there is no make target for it. I also
tried gcc configure --without-headers, but it still tried to
compile libgcc. How does one get the headers from Glibc in the
first place, given one can't run ./configure on glibc with
--host=sparc64 because that very crosscompiler isn't built yet.
There ought to be something akin to Linux's headers_install in
Glibc too somewhere.

Back to bisecting the boot hang...

7c1f6afcf98fe95fb3f2b70ce01cf66f6db53b5e is the first bad commit
commit 7c1f6afcf98fe95fb3f2b70ce01cf66f6db53b5e
Author: David S. Miller <davem@davemloft.net>
Date:   Tue May 25 23:51:17 2010 -0700

    sunserial: Don't call add_preferred_console() when console= is specified.
    
    Reported-by: Frans Pop <elendil@planet.nl>
    Signed-off-by: David S. Miller <davem@davemloft.net>

:040000 040000 827bf16df16b16a0dc938f2dc7483bc3cf5d44d3
69e6b8fb55a416204e599554f5af821cc612325e M      drivers


$ cat /proc/cmdline 
console=ttyS0

(ttyS0 is in fact the sun4v ttyHV0.) This "turning off earlyprom0"
at the end of the kernel boot log is worrysome, and seems to be
the cause for the stop. (I have seen similar when booting a kernel
to a filesystem that has no /dev/console.)

---
Allocated 64 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.6.34
Loading initial ramdisk (4724814 bytes at 0xC800000 phys, 0x40C00000 virt)...
\
PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.b 2010/07/09 13:43'
PROMLIB: Root node compatible: sun4v
Initializing cgroup subsys cpuset
Linux version 2.6.34-ts (jengelh@ares) (gcc version 4.5.0 20100604 [gcc-4_5-branch revision 160292] (SUSE Linux) ) #26 SMP Mon Nov 15 04:24:00 CET 2010
bootconsole [earlyprom0] enabled
ARCH: SUN4V
Ethernet address: 00:14:4f:e1:d1:24
Kernel: Using 4 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /virtual-devices@100/console@1
PROM: Built device tree with 67484 bytes of memory.
MDESC: Size is 33456 bytes.
PLATFORM: banner-name [SPARC Enterprise T1000]
PLATFORM: name [SUNW,SPARC-Enterprise-T1000]
PLATFORM: hostid [84e1d124]
PLATFORM: serial# [00ab4130]
PLATFORM: stick-frequency [3b9aca00]
PLATFORM: mac-address [144fe1d124]
PLATFORM: watchdog-resolution [1000 ms]
PLATFORM: watchdog-max-timeout [31536000000 ms]
PLATFORM: max-cpus [32]
Top of RAM: 0x1ffdb4000, Total RAM: 0x1f79a4000
Memory hole size: 132MB
[0000010000000000-fffff80009800000] page_structs1072 node=0 entry=0/8192
[0000010000000000-fffff80009c00000] page_structs1072 node=0 entry=1/8192
[0000010000800000-fffff8000a000000] page_structs1072 node=0 entry=2/8192
[0000010000800000-fffff8000a400000] page_structs1072 node=0 entry=3/8192
[0000010001000000-fffff8000a800000] page_structs1072 node=0 entry=4/8192
[0000010001000000-fffff8000ac00000] page_structs1072 node=0 entry=5/8192
[0000010001800000-fffff8000b000000] page_structs1072 node=0 entry=6/8192
[0000010001800000-fffff8000b400000] page_structs1072 node=0 entry=7/8192
[0000010002000000-fffff8000b800000] page_structs1072 node=0 entry=8/8192
[0000010002000000-fffff8000bc00000] page_structs1072 node=0 entry=9/8192
[0000010002800000-fffff8000c000000] page_structs1072 node=0 entry/8192
[0000010002800000-fffff8000c400000] page_structs1072 node=0 entry/8192
[0000010003000000-fffff8000d000000] page_structs1072 node=0 entry/8192
[0000010003000000-fffff8000d400000] page_structs1072 node=0 entry/8192
[0000010003800000-fffff8000d800000] page_structs1072 node=0 entry/8192
[0000010003800000-fffff8000dc00000] page_structs1072 node=0 entry/8192
Zone PFN ranges:
  Normal   0x00004200 -> 0x000ffeda
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0: 0x00004200 -> 0x000ffec2
    0: 0x000ffeca -> 0x000ffeda
Booting Linux...
PERCPU: Embedded 230 pages/cpu @fffff8000e000000 s1854400 r8192 d21568 u2097152
pcpu-alloc: s1854400 r8192 d21568 u2097152 alloc=1*4194304
pcpu-alloc: [0] 00 01 [0] 02 03 [0] 04 05 [0] 06 07 
pcpu-alloc: [0] 08 09 [0] 10 11 [0] 12 13 [0] 14 15 
pcpu-alloc: [0] 16 17 [0] 18 19 [0] 20 21 [0] 22 23 
pcpu-alloc: [0] 24 25 [0] 26 27 [0] 28 29 [0] 30 31 
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1023320
Policy zone: Normal
Kernel command line: console=ttyS0
PID hash table entries: 4096 (order: 2, 32768 bytes)
Memory: 8104352k available (3856k kernel code, 2296k data, 2000k init) [fffff80000000000,00000001ffdb4000]
SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs2, Nodes
Hierarchical RCU implementation.
        RCU debugfs-based tracing is enabled.
        Verbose stalled-CPUs detection is disabled.
NR_IRQS:255
clocksource: mult[80000000] shift[31]
clockevent: mult[80000000] shift[31]
Console: colour dummy device 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     16384
... MAX_LOCKDEP_CHAINS:      32768
... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 6335 kB
 per task-struct memory footprint: 2688 bytes
Calibrating delay using timer specific routine.. 2008.48 BogoMIPS (lpj@16976)
Security Framework initialized
Dentry cache hash table entries: 1048576 (order: 10, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 9, 4194304 bytes)
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Initializing cgroup subsys devices
Initializing cgroup subsys blkio
Brought up 24 CPUs
ldc.c:v1.1 (July 22, 2008)
ldc: Domaining disabled.
NET: Registered protocol family 16
VIO: Adding device channel-devices
VIO: Adding device vldc-port-0-0
VIO: Adding device vldc-port-0-1
VIO: Adding device vldc-port-0-2
VIO: Adding device vldc-port-1-0
VIO: Adding device vldc-port-3-0
VIO: Adding device vldc-port-3-8
VIO: Adding device ds-1
VIO: Adding device ds-0
Testing NMI watchdog ... OK.
Performance events: Supported PMU type is 'niagara'
pci_sun4v: Registered hvapi major[1] minor[0]
/pci@780: SUN4V PCI Bus Module
/pci@780: On NUMA node -1
/pci@780: PCI IO[e810000000] MEM[ea00000000]
/pci@780: Unable to request IOMMU resource.
/pci@780: MSI Queue first[0] num[36] count[128] devino[0x18]
/pci@780: MSI first[0] num[256] mask[0xff] width[32]
/pci@780: MSI addr32[0x7fff0000:0x10000] addr64[0x3ffff0000:0x10000]
/pci@780: MSI queues at RA [00000001fdc00000]
PCI: Scanning PBM /pci@780
/pci@7c0: SUN4V PCI Bus Module
/pci@7c0: On NUMA node -1
/pci@7c0: PCI IO[f010000000] MEM[f200000000]
/pci@7c0: Unable to request IOMMU resource.
/pci@7c0: MSI Queue first[0] num[36] count[128] devino[0x18]
/pci@7c0: MSI first[0] num[256] mask[0xff] width[32]
/pci@7c0: MSI addr32[0x7fff0000:0x10000] addr64[0x3ffff0000:0x10000]
/pci@7c0: MSI queues at RA [00000001fdd00000]
PCI: Scanning PBM /pci@7c0
ds.c:v1.0 (Jul 11, 2007)
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
Switching to clocksource stick
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 8, 2097152 bytes)
TCP established hash table entries: 524288 (order: 10, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 9, 4718592 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
UDP hash table entries: 4096 (order: 6, 655360 bytes)
UDP-Lite hash table entries: 4096 (order: 6, 655360 bytes)
NET: Registered protocol family 1
Unpacking initramfs...
Freeing initrd memory: 4614k freed
audit: initializing netlink socket (disabled)
type 00 audit(1.168:1): initialized
HugeTLB registered 4 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
msgmni has been set to 15837
alg: No test for cipher_null (cipher_null-generic)
cryptomgr_test used greatest stack depth: 12560 bytes left
alg: No test for ecb(cipher_null) (ecb-cipher_null)
alg: No test for digest_null (digest_null-generic)
alg: No test for compress_null (compress_null-generic)
cryptomgr_test used greatest stack depth: 11344 bytes left
cryptomgr_test used greatest stack depth: 11024 bytes left
cryptomgr_test used greatest stack depth: 10064 bytes left
cryptomgr_test used greatest stack depth: 9536 bytes left
alg: No test for fcrypt (fcrypt-generic)
alg: No test for stdrng (krng)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci-stub: invalid id string ""
f027a84c: ttyS0 at I/O 0x0 (irq = 1) is a SUN4V HCONS
Fusion MPT base driver 3.04.15
Copyright (c) 1999-2008 LSI Corporation
Fusion MPT SAS Host driver 3.04.15
mptbase: ioc0: Initiating bringup
ioc0: LSISAS1064 A3: Capabilities={Initiator}
scsi0 : ioc0: LSISAS1064 A3, FwRev0a0000h, Ports=1, MaxQQ1, IRQ%
mptsas: ioc0: attaching sata device: fw_channel 0, fw_id 0, phy 0, sas_addr 0x1221000000000000
scsi 0:0:0:0: Direct-Access     ATA      Hitachi HDS72202 A28A PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.81 TiB)
mice: PS/2 mouse device common for all mice
rtc-sun4v rtc-sun4v: rtc core: registered sun4v as rtc0
sd 0:0:0:0: [sda] Write Protect is off
TCP hybla registered
NET: Registered protocol family 10
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
lo: Disabled Privacy Extensions
turn off boot console earlyprom0

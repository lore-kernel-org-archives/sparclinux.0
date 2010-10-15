From: Jan Engelhardt <jengelh@medozas.de>
Date: Fri, 15 Oct 2010 17:14:54 +0000
Subject: Linux 2.6.36-rc8 won't boot
Message-Id: <alpine.LNX.2.01.1010151559250.28469@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


I just compiled 2.6.36-rc8 and observe a hang on boot. My previous 
working version was 2.6.34-rc1/gcc 4.4.1, and I checked that gcc isn't 
at fault by recompiling 2.6.34-rc1 with gcc 4.5.0 (it boots).

silo SILO
boot: ares36
Allocated 64 Megs of memory at 0x40000000 for kernel
Loaded kernel version 2.6.36
Loading initial ramdisk (4724778 bytes at 0xC800000 phys, 0x40C00000 virt)...
/
PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.a 2010/01/06 14:54'
PROMLIB: Root node compatible: sun4v
Initializing cgroup subsys cpuset
Linux version 2.6.36-rc8 (jengelh@ares) (gcc version 4.5.0 20100604 [gcc-4_5-branch revision 160292] (SUSE Linux) ) #3 SMP Fri Oct 15 15:45:00 CEST 2010
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
PERCPU: Embedded 231 pages/cpu @fffff8000e000000 s1855552 r8192 d28608 u2097152
pcpu-alloc: s1855552 r8192 d28608 u2097152 alloc=1*4194304
pcpu-alloc: [0] 00 01 [0] 02 03 [0] 04 05 [0] 06 07 
pcpu-alloc: [0] 08 09 [0] 10 11 [0] 12 13 [0] 14 15 
pcpu-alloc: [0] 16 17 [0] 18 19 [0] 20 21 [0] 22 23 
pcpu-alloc: [0] 24 25 [0] 26 27 [0] 28 29 [0] 30 31 
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1023320
Policy zone: Normal
Kernel command line: console=ttyS0
PID hash table entries: 4096 (order: 2, 32768 bytes)
Memory: 8104152k available (3880k kernel code, 2216k data, 2000k init) [fffff80000000000,00000001ffdb4000]
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
Calibrating delay using timer specific routine.. 2007.88 BogoMIPS (lpj@15773)
pid_max: default: 32768 minimum: 301
Security Framework initialized
Dentry cache hash table entries: 1048576 (order: 10, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 9, 4194304 bytes)
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
Initializing cgroup subsys devices
Initializing cgroup subsys blkio
<hangs here>

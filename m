From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 05 Dec 2009 13:00:33 +0000
Subject: Re: Sparc release requalification
Message-Id: <20091205130032.GA22610@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Dec 05, 2009 at 12:18:22PM +0000, Jurij Smakov wrote:
> > Hm, OK, but that doesn't help explain why that exact image, a lenny
> > backport, didn't work here...
> 
> I've upgraded to the latest unstable on my box today, and this pulled in the
> stock Debian 2.6.31 kernel, which, amusingly, boots just fine:
> 
> jurij@debian:~$ uname -a
> Linux debian 2.6.31-1-sparc64-smp #1 SMP Mon Nov 16 14:12:48 UTC 2009 sparc GNU/Linux
> jurij@debian:~$ zcat /boot/vmlinuz-2.6.31-1-sparc64-smp | strings | grep gcc | head -1
> Linux version 2.6.31-1-sparc64-smp (Debian 2.6.31-2) (ben@decadent.org.uk) (gcc version 4.3.4 (Debian 4.3.4-6) ) #1 SMP Mon Nov 16 14:12:48 UTC 2009
> 
> Can you try whether it works for you as well?

I've tried that one right now, and this is what I got:

boot: Linux
Allocated 8 Megs of memory at 0x40000000 for kernel
Uncompressing image...
Loaded kernel version 2.6.31
Loading initial ramdisk (7069568 bytes at 0x1200000000 phys, 0x40C00000 virt)...
/
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.11.4 2003/07/23 08:04'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 2.6.31-1-sparc64-smp (Debian 2.6.31-2) (ben@decadent.org.uk) (gcc version 4.3.4 (Debian 4.3.4-6) ) #1 SMP Mon Nov 16 14:12:48 UTC 2009
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:5a:53:a5
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 85794 bytes of memory.
[    0.000000] Top of RAM: 0x123fedc000, Total RAM: 0xffed0000
[    0.000000] Memory hole size: 70656MB
[    0.000000] [0000000200000000-fffff80000400000] page_structs1072 node=0 entry=0/0
[    0.000000] [0000000200000000-fffff80000800000] page_structs1072 node=0 entry=1/0
[    0.000000] [0000000204000000-fffff80000c00000] page_structs1072 node=0 entry/0
[    0.000000] [0000000204000000-fffff80001000000] page_structs1072 node=0 entry/0
[    0.000000] [0000000220000000-fffff80001400000] page_structs1072 node=0 entry8/0
[    0.000000] [0000000220000000-fffff80001800000] page_structs1072 node=0 entry9/0
[    0.000000] [0000000224000000-fffff80001c00000] page_structs1072 node=0 entry4/0
[    0.000000] [0000000224000000-fffff80002000000] page_structs1072 node=0 entry5/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x0091ff6e
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[7] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00020000
[    0.000000]     0: 0x00100000 -> 0x00120000
[    0.000000]     0: 0x00800000 -> 0x00820000
[    0.000000]     0: 0x00900000 -> 0x0091f7ff
[    0.000000]     0: 0x0091f800 -> 0x0091fef3
[    0.000000]     0: 0x0091fef5 -> 0x0091ff5e
[    0.000000]     0: 0x0091ff61 -> 0x0091ff6e
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 449385
[    0.000000] Kernel command line: root=/dev/md1 ro rootdelay console=ttyS0,9600n1
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)[    0.000000] Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
[    0.000000] Memory: 4140168k available (3440k kernel code, 1336k data, 216k init) [fffff80000000000,000000123fedc000]
[    0.000000] NR_IRQS:255
[    0.000000] clocksource: mult[535555] shift[16]
[    0.000000] clockevent: mult[3126e97] shift[32]
[   40.900976] Console: colour dummy device 80x25
[   41.039420] Calibrating delay using timer specific routine.. 24.01 BogoMIPS (lpjH029)
[   41.144787] Security Framework initialized
[   41.198547] SELinux:  Disabled at boot.
[   41.248905] Mount-cache hash table entries: 512
[   41.308793] Initializing cgroup subsys ns
[   41.361476] Initializing cgroup subsys cpuacct
[   41.419802] Initializing cgroup subsys devices
[   41.478128] Initializing cgroup subsys freezer
[   41.536458] Initializing cgroup subsys net_cls
[   41.596728] CPU 0: synchronized TICK with master CPU (last diff 1 cycles, maxerr 6 cycles)
[   41.596742] Brought up 2 CPUs
[   41.744948] regulator: core version 0.5
[   41.795563] NET: Registered protocol family 16
[   

There it hung. Doesn't look much different from before.

-- 
     2. That which causes joy or happiness.

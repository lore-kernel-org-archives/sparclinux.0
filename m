From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Thu, 19 Jun 2008 14:07:46 +0000
Subject: 2.6.26-rc: SPARC: Sun Ultra 10 can not boot
Message-Id: <a4423d670806190707k7ae6da8cud80a826a1603d941@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, kernel-testers@vger.kernel.org, sparclinux@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>

Hi

Sun Ultra 10 can not boot the last 2.6.26-rc6-git, it hangs right after

Console: colour dummy device 80x25
console handover: boot [earlyprom0] -> real [tty0]

netconsole does not work at this early stage.
It is a boot log of the closest to bad commit  working kernel:

PROMLIB: Sun IEEE Boot Prom 'OBP 3.25.3 2000/06/29 14:12'
PROMLIB: Root node compatible:
Linux version 2.6.26-rc3-00123-g3651751 (alexb@sparky) (gcc version
4.1.2 (Gentoo 4.1.2 p1.0.1)) #21 PREEMPT Thu Jun 19 17:42:45 MSD 2008
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 08:00:20:ff:e6:ff
Kernel: Using 3 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@1f,0/pci@1,1/SUNW,m64B@2
PROM: Built device tree with 42083 bytes of memory.
Top of RAM: 0x1ff46000, Total RAM: 0x1ff44000
Memory hole size: 0MB
Entering add_active_range(0, 0, 65407) 0 entries of 256 used
Entering add_active_range(0, 65408, 65443) 1 entries of 256 used
[0000000200000000-fffff80001000000] page_structs1072 node=0 entry=0/0
[0000000200000000-fffff80001400000] page_structs1072 node=0 entry=1/0
Allocated 532480 bytes for kernel page tables.
Zone PFN ranges:
  Normal          0 ->    65443
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0:        0 ->    65407
    0:    65408 ->    65443
On node 0 totalpages: 65442
  Normal zone: 447 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 64995 pages, LIFO batch:15
  Movable zone: 0 pages used for memmap
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64995
Kernel command line: root=/dev/sda2
Preemptible RCU implementation.
PID hash table entries: 2048 (order: 11, 16384 bytes)
clocksource: mult[245d1] shift[16]
clockevent: mult[70a3d70a] shift[32]
Console: colour dummy device 80x25
console handover: boot [earlyprom0] -> real [tty0]
==== It hangs here! ===Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 1648 kB
 per task-struct memory footprint: 2688 bytes


I have done bisect:

a051bc5bb1ac6dc138d529077fa20cbbc6622d95 is first bad commit
commit a051bc5bb1ac6dc138d529077fa20cbbc6622d95
Author: David S. Miller <davem@davemloft.net>
Date:   Wed May 21 18:14:28 2008 -0700

    sparc64: Fix kernel thread stack termination.

    Because of the silly way I set up the initial stack for
    new kernel threads, there is a loop at the top of the
    stack.

    To fix this, properly add another stack frame that is copied
    from the parent and terminate it in the child by setting
    the frame pointer in that frame to zero.

    Signed-off-by: David S. Miller <davem@davemloft.net>

:040000 040000 beba7e8c740188a7c19a3569f08b1edd25b8000d
aed42d5af3ab9a84ccb3dfe07eb444a78f9001fa M      arch

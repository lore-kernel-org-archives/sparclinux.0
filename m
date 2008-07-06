From: Andrew Morton <akpm@linux-foundation.org>
Date: Sun, 06 Jul 2008 20:20:49 +0000
Subject: Re: [Bug 11046] New: Kernel bug in mm/bootmem.c on Sparc machines
Message-Id: <20080706132049.4019e09f.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Sun,  6 Jul 2008 13:02:28 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id046
> 
>            Summary: Kernel bug in mm/bootmem.c on Sparc machines
>            Product: Memory Management
>            Version: 2.5
>      KernelVersion: 2.6.25.10
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: blocking
>           Priority: P1
>          Component: Other
>         AssignedTo: akpm@osdl.org
>         ReportedBy: lomp0101@gmx.net
> 
> 
> Latest working kernel version:
> Earliest failing kernel version:
> Distribution: 
> Hardware Environment: Sparc Blade B100s ( Ultra Sparc IIe 650 Mhz )
> Software Environment: 
> Problem Description: Kernel Bug
> 
> Steps to reproduce: Create default kernel config for Sparc. Change this config
> that the kernel can do rarpd and change the network driver to be included in
> kernel (Cassini). Well set the kernel to be loaded over the net via tftpboot. I
> di this on my other Sparc machines and it worked there.
> 
> Here is the BUG:
> 
> [    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.11.5 2003/11/12 10:40'
> [    0.000000] PROMLIB: Root node compatible: 
> [    0.000000] Linux version 2.6.25.10 (root@sparc1) (gcc version 4.1.2
> 20061115 (prerelease) (Debian 4.1.1-21)) #5 SMP Sun Jul 6 21:05:42 CEST 2008
> [    0.000000] console [earlyprom0] enabled
> [    0.000000] ARCH: SUN4U
> [    0.000000] Ethernet address: 00:03:ba:7a:f3:d6
> [    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
> [    0.000000] Remapping the kernel... done.
> [    0.000000] kernel BUG at mm/bootmem.c:125!
> [    0.000000]               \|/ ____ \|/
> [    0.000000]               "@'/ .. \`@"
> [    0.000000]               /_| \__/ |_\
> [    0.000000]                  \__U_/
> [    0.000000] swapper(0): Kernel bad sw trap 5 [#1]
> [    0.000000] TSTATE: 0000000080f01604 TPC: 00000000007ae2c4 TNPC:
> 00000000007ae2c8 Y: 00000000    Not tainted
> [    0.000000] TPC: <reserve_bootmem_core+0x38/0xd8>
> [    0.000000] g0: 0000000000000000 g1: 0000000000000001 g2: 000000000075ac00
> g3: 000000000075afa8
> [    0.000000] g4: 00000000007563c0 g5: 0000000000000000 g6: 00000000007523c0
> g7: 0000000000000000
> [    0.000000] o0: 0000000000000032 o1: 00000000007044e0 o2: 000000000000007d
> o3: fffff80000438000
> [    0.000000] o4: 0000000000000000 o5: 000000000075ef80 sp: 00000000007557c1
> ret_pc: 00000000007ae2bc
> [    0.000000] RPC: <reserve_bootmem_core+0x30/0xd8>
> [    0.000000] l0: 000000000075ef50 l1: 0000000000000030 l2: 0000000000000000
> l3: 0000000000000010
> [    0.000000] l4: 0000000000000000 l5: 0000000000000010 l6: 0000000000000000
> l7: 0000000000000000
> [    0.000000] i0: 000000000081c5c0 i1: 0000000000438000 i2: 0000000000000000
> i3: 0000000000000000
> [    0.000000] i4: 0000000000000000 i5: 0000000000438000 i6: 0000000000755881
> i7: 00000000007ab7c8
> [    0.000000] I7: <paging_init+0xd50/0xee8>
> [    0.000000] Caller[00000000007ab7c8]: paging_init+0xd50/0xee8
> [    0.000000] Caller[00000000007a3da0]: setup_arch+0x2d8/0x2e0
> [    0.000000] Caller[00000000007a0810]: start_kernel+0x7c/0x300
> [    0.000000] Caller[00000000006860f0]: auxio_probe+0x0/0xd0
> [    0.000000] Caller[0000000000000000]: 0x8
> [    0.000000] Instruction DUMP: 11001c11  7ff1ee23  901220e0 <91d02005>
> 8406401a  b5307033  8200801a  8330700d  80a04003 
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] Press Stop-A (L1-A) to return to the boot prom
> 
> 
> Any help would be nice. If you need further information please tell me.
> This is my firs bug report and i hope i did it right.
> 


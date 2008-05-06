From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 06 May 2008 07:54:05 +0000
Subject: [BUG] 2.6.26-rc1 hangs during boot on UltraSPARC 5
Message-Id: <18464.3741.133714.308327@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

2.6.25 works fine on my Ultra5, but 2.6.26-rc1 hangs
early in boot. I don't have a serial cable to capture
early kernel messages, but extrapolating from 2.6.25 I get:

PROMLIB: Sun IEEE Boot Prom 'OBP 3.25.3 2000/06/29 14:12'
PROMLIB: Root node compatible: 
Linux version 2.6.25 (mikpe@sparge) (gcc version 4.2.3) #1 Thu Apr 17 19:53:16 CEST 2008
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 08:00:20:fd:ec:1f
Kernel: Using 1 locked TLB entries for main kernel image.
Remapping the kernel... done.
[0000000200000000-fffff80000400000] page_structs&2144 node=0 entry=0/0
[0000000200000000-fffff80000800000] page_structs&2144 node=0 entry=1/0
[0000000200000000-fffff80000c00000] page_structs&2144 node=0 entry=2/0
[0000000200000000-fffff80001000000] page_structs&2144 node=0 entry=3/0
OF stdout device is: /pci@1f,0/pci@1,1/SUNW,m64B@2
PROM: Built device tree with 46848 bytes of memory.
On node 0 totalpages: 32298
  Normal zone: 335 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 31963 pages, LIFO batch:7
  Movable zone: 0 pages used for memmap
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 31963
Kernel command line: ro root=/dev/sda5
PID hash table entries: 1024 (order: 10, 8192 bytes)
clocksource: mult[28000] shift[16]
clockevent: mult[66666666] shift[32]
Console: colour dummy device 80x25
console handover: boot [earlyprom0] -> real [tty0]

*** 2.6.26-rc1 gets as far as the line above, then hangs

Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 4, 131072 bytes)
Memory: 237256k available (1928k kernel code, 744k data, 144k init) [fffff80000000000,0000000017f46000]
SLUB: Genslabs, HWalign2, Order=0-2, MinObjects=8, CPUs=1, Nodes=1
Calibrating delay using timer specific routine.. 800.81 BogoMIPS (lpj@04065)
...

Full config is available in <http://user.it.uu.se/~mikpe/linux/sparge/>.

If anyone has patches to try I can try them this evening, otherwise
I'll start the painful bisection process tomorrow.

/Mikael

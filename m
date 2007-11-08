From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 08 Nov 2007 10:00:51 +0000
Subject: [BUG 2.6.24-rc2] sparc64 sysctl table check failed
Message-Id: <200711081000.lA8A0pex016234@alkaid.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Booting 2.6.24-rc2 on my Ultra5 results in:

PROMLIB: Sun IEEE Boot Prom 'OBP 3.25.3 2000/06/29 14:12'
PROMLIB: Root node compatible: 
Linux version 2.6.24-rc2 (mikpe@sparge) (gcc version 4.2.2) #1 Thu Nov 8 01:14:09 CET 2007
ARCH: SUN4U
Ethernet address: 08:00:20:fd:ec:1f
[0000000200000000-fffff80000400000] page_structs&2144 node=0 entry=0/0
[0000000200000000-fffff80000800000] page_structs&2144 node=0 entry=1/0
[0000000200000000-fffff80000c00000] page_structs&2144 node=0 entry=2/0
[0000000200000000-fffff80001000000] page_structs&2144 node=0 entry=3/0
OF stdout device is: /pci@1f,0/pci@1,1/SUNW,m64B@2
PROM: Built device tree with 46617 bytes of memory.
On node 0 totalpages: 32300
  Normal zone: 335 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 31965 pages, LIFO batch:7
  Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 31965
Kernel command line: ro root=/dev/sda5
PID hash table entries: 1024 (order: 10, 8192 bytes)
clocksource: mult[28000] shift[16]
clockevent: mult[66666666] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled
Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 4, 131072 bytes)
Memory: 241016k available (1928k kernel code, 744k data, 104k init) [fffff80000000000,0000000017f46000]
SLUB: Genslabs, HWalign2, Order=0-2, MinObjects=8, CPUs=1, Nodes=1
Calibrating delay using timer specific routine.. 800.67 BogoMIPS (lpj@03390)
Mount-cache hash table entries: 512
net_namespace: 120 bytes
sysctl table check failed: /kernel/scons-poweroff .1.64 procname does not match binary path procname
Call Trace:
 [000000000046bb88] sysctl_check_table+0x650/0x690
 [000000000046bb9c] sysctl_check_table+0x664/0x690
 [00000000006afe80] sysctl_init+0x20/0x28
 [00000000006a8200] kernel_init+0xf0/0x270
 [0000000000427344] kernel_thread+0x38/0x48
 [00000000005e2954] rest_init+0x18/0x58
NET: Registered protocol family 16
...

Apart from this, the kernel seems to be working fine.

/Mikael

From: William Lee Irwin III <wli@holomorphy.com>
Date: Sun, 22 Feb 2004 04:34:48 +0000
Subject: oops in sched_init() on E3000
Message-Id: <20040222043448.GG703@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

PROMLIB: Sun IEEE Boot Prom 3.2.30 2002/10/25 14:03
Remapping the kernel... done.
Booting Linux...
Linux version 2.6.3 (wli@monad) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 @PV@)) #2 SMP Sat Feb 21 20:26:41 PST 2004
ARCH: SUN4U
Ethernet address: 08:00:20:89:ed:b7
On node 0 totalpages: 490251
  DMA zone: 490251 pages, LIFO batch:8
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
CENTRAL: Detected 4 slot Enterprise system. cfreg[a8] cver[fc]
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] (CENTRAL)
FHC(board 3): Version[1] PartID[fa0] Manuf[3e] (JTAG Master)
   FHC(board 5): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 7): Version[1] PartID[fa0] Manuf[3e] 
FHC(board 1): Version[1] PartID[fa0] Manuf[3e] 
Built 1 zonelists
 Kernel command line: nfsroot=/mnt/f/e3k/gentoo ip=:::::eth0:dhcp profile=1
kernel profiling enabled
PID hash table entries: 4096 (order 12: 65536 bytes)
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000000
tsk->{mm,active_mm}->pgd = fffff8000000ec00
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
TSTATE: 0000009980f01603 TPC: 000000000043ff9c TNPC: 000000000043ffa0 Y: 00000000    Not tainted
TPC: <wake_up_forked_process+0x1dc/0x280>
g0: 000000000071c000 g1: 0000000000000002 g2: fffffffffffffffb g3: 0000000000989680
g4: 000000000067e6c0 g5: 0000000000000006 g6: 000000000067a6c0 g7: 0000000000000000
o0: 00000000000007f0 o1: 000000000067e6f8 o2: 000000000067e6f8 o3: 0000000000000000
o4: 0000000000000000 o5: 0000000000000008 sp: 000000000067dba1 ret_pc: 000000000043ff18
RPC: <wake_up_forked_process+0x158/0x280>
l0: 00000000006f91a0 l1: 000000000071c000 l2: 000000000071c000 l3: 0000000000687de0
l4: 0000000000077e8b l5: 0000000000000003 l6: 0000000000000003 l7: 0000000000000000
i0: 000000000067e6c0 i1: 000000000067a6c0 i2: 0000000000000006 i3: 00000000006f91a0
i4: 0000000000000000 i5: fffff80002cd3680 i6: 000000000067dc71 i7: 00000000006e4290
I7: <sched_init+0x130/0x1a0>
Instruction DUMP: 9a032008  90030008  90022020 <d25a2008> d0762038  d4722008  d4724000  d272a008  92102001 
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 <0>Press L1-A to return to the boot prom
[detached]
The mail in /var/spool/mail/wli has been read.
$ 

Script done on Sat Feb 21 20:30:38 2004

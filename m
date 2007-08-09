From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Thu, 09 Aug 2007 09:08:45 +0000
Subject: 2.6.18 dual sparc64 oops
Message-Id: <200708091108.45475.m.kozlowski@tuxland.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

	Not sure this is still important as the kernel is a bit old (2.6.18-4-sparc64-smp)
but I run into an oops on dual sparc64. The box is SUN ULTRA 60 - USII 2 x 450MHZ.

Unable to handle kernel paging request at virtual address 00000000703ce000
tsk->{mm,active_mm}->context = 000000000000021c
tsk->{mm,active_mm}->pgd = fffff8009ac02000
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
kswapd0(123): Oops [#1]
TSTATE: 0000009980009606 TPC: 00000000004b3544 TNPC: 00000000004b355c Y: 00000000    Not tainted
TPC: <iput+0x24/0xa0>
g0: fffff8008b9ee8d0 g1: 00000000703cea28 g2: 0000000000000000 g3: fffff800b7845f70
g4: fffff8008103a960 g5: fffff800803934c0 g6: fffff800bf318000 g7: fffff800b7845f08
o0: fffff800b7845f00 o1: 0000000000000400 o2: 0000000000000000 o3: 0000000000000000
o4: 0000000000000000 o5: 0000000000714000 sp: fffff800bf31b0e1 ret_pc: 00000000004b13fc
RPC: <dentry_iput+0xb0/0xcc>
l0: fffff800b7845f00 l1: fffff800bfbcec98 l2: 0000000000000001 l3: 800000008996cfb2
l4: fffff800803a92b0 l5: 0000000000000001 l6: 00000000007490c8 l7: fffff800941fc388
i0: fffff800bfbcec98 i1: 0000000000000000 i2: 00000000006abdb0 i3: 0000000000200200
i4: 0000000000100100 i5: 00000000006b1800 i6: fffff800bf31b1a1 i7: 00000000004b22cc
I7: <prune_one_dentry+0x7c/0xac>
Caller[00000000004b22cc]: prune_one_dentry+0x7c/0xac
Caller[00000000004b246c]: prune_dcache+0x170/0x1c0
Caller[00000000004b24e4]: shrink_dcache_memory+0x28/0x5c
Caller[0000000000481ef0]: shrink_slab+0xcc/0x164
Caller[0000000000482290]: kswapd+0x308/0x458
Caller[00000000004630b4]: kthread+0xbc/0xe8
Caller[0000000000417a38]: kernel_thread+0x38/0x48
Caller[0000000000462eb0]: keventd_create_kthread+0x18/0x84
Instruction DUMP: c45e2220  80a0a020  12680007 <c2586038> 11001992  92102473  7ffd9c09  90122370  91d02005

The kernel is default from debian etch.

Second issue is that kernel hangs from time to time but it looks like the i/o to the scsi disk is dead.
I installed fresh etch, downloaded 2.6.23-rc1-mm2, started compiling allmodconfig and it hung after a while.
After reboot the ext3 partition was messed up and reinstall was needed.

Is this a known issue? Should I just upgrade and forget?

Regards,

	Mariusz

$ cat /proc/cpuinfo 
cpu             : TI UltraSparc II  (BlackBird)
fpu             : UltraSparc II integrated FPU
prom            : OBP 3.17.0 1998/10/23 11:26
type            : sun4u
ncpus probed    : 2
ncpus active    : 2
D$ parity tl1   : 0
I$ parity tl1   : 0
Cpu0Bogo        : 900.41
Cpu0ClkTck      : 000000001ad1d08f
Cpu2Bogo        : 899.96
Cpu2ClkTck      : 000000001ad1d08f
MMU Type        : Spitfire
State:
CPU0:           online
CPU2:           online

$ lspci 
0000:80:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus Module
0001:00:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus Module
0001:00:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
0001:00:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy Meal (rev 01)
0001:00:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)
0001:00:03.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 14)

$ cat /proc/meminfo 
MemTotal:      1034176 kB
MemFree:         13384 kB
Buffers:         47064 kB
Cached:         860456 kB
SwapCached:          0 kB
Active:         429072 kB
Inactive:       500544 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      1034176 kB
LowFree:         13384 kB
SwapTotal:      457832 kB
SwapFree:       457728 kB
Dirty:            6384 kB
Writeback:           0 kB
AnonPages:       21888 kB
Mapped:           7280 kB
Slab:            86264 kB
PageTables:        944 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:    974920 kB
Committed_AS:    43776 kB
VmallocTotal:  4194304 kB
VmallocUsed:       176 kB
VmallocChunk:  4194128 kB

$ cat /proc/interrupts 
           CPU0       CPU2       
  0:   12355899          0     <NULL>  timer	<--------------- NULL?
  2:          0          0      sun4u  PSYCHO UE
  3:          0          0      sun4u  PSYCHO CE
  6:          0          0      sun4u  PSYCHO PCIERR-A
  7:          0          0      sun4u  sab
  8:          5          0      sun4u  su(kbd)
  9:          0          0      sun4u  su(mouse)
 14:          0      34244      sun4u  eth0
 15:          0     113689      sun4u  sym53c8xx
 16:         30          0      sun4u  sym53c8xx
 17:          0          0      sun4u  PSYCHO PCIERR-B

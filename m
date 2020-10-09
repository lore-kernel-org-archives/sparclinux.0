From: Wolf Ruediger Spielmann <RSpielmann@gmx.de>
Date: Fri, 09 Oct 2020 14:19:24 +0000
Subject: SMP is broken on sparc64 with kernel 4.x/5.x
Message-Id: <20201009161924.c8f031c079dd852941307870@gmx.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi @all,

I freshly installed linux on my SUN Ultra 60 /w 2x 450MHz CPUs.

First I tested kernel 5.8.x and couldn't get SMP to work on both CPUs - jus=
t the first CPU will be activated.
Same results with kernel 4.19.146 .
Kernel 3.18.140 runs perfectly on both CPUs.

Might be the problem that the CPUs numbering scheme is not linear:
CPU1 is #0 and CPU2 is #2 (NOT #1)

Below you find some infos.

With kernel 5.8.14 (also tested 5.4.66 and 4.19.146) :

dmesg (cutted)

[    0.000335] Linux version 5.8.14-gentoo (root@compilenode1) (sparc64-unk=
nown-linux-gnu-gcc (Gentoo Hardened 9.3.0-r1 p3) 9.3.0, GNU ld (Gentoo 2.34=
 p6) 2.34.0) #2 SMP Thu Oct 8 10:40:33 CEST 2020
...
[    0.918138] percpu: Embedded 10 pages/cpu s42648 r8192 d31080 u2097152
[    0.942080] pcpu-alloc: s42648 r8192 d31080 u2097152 alloc=3D1*4194304
[    0.942090] pcpu-alloc: [0] 0 1=20
...
[    1.252126] rcu: Hierarchical RCU implementation.
[    1.268124] rcu:     RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_ids=
=3D2.
[    1.288896] rcu: RCU calculated value of scheduler-enlistment delay is 1=
00 jiffies.
[    1.312586] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D2
[    1.334035] NR_IRQS: 2048, nr_irqs: 2048, preallocated irqs: 1
...
[    1.532316] Calibrating delay using timer specific routine.. 905.89 Bogo=
MIPS (lpj=3D452945)
...
[    1.539394] rcu: Hierarchical SRCU implementation.
[    1.540102] smp: Bringing up secondary CPUs ...
[    1.540120] smp: Brought up 1 node, 1 CPU

########

ultra60-1 ~ # lscpu
Architecture:        sparc64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Big Endian
CPU(s):              1
On-line CPU(s) list: 0
Thread(s) per core:  1
Core(s) per socket:  1
Socket(s):           1
NUMA node(s):        1
Model name:          TI UltraSparc II  (BlackBird)
NUMA node0 CPU(s):   0
Flags:               sun4u

########

ultra60-1 ~ # cat /proc/cpuinfo=20
cpu		: TI UltraSparc II  (BlackBird)
fpu		: UltraSparc II integrated FPU
pmu		: ultra12
prom		: OBP 3.31.0 2001/07/25 20:31
type		: sun4u
ncpus probed	: 2
ncpus active	: 1
D$ parity tl1	: 0
I$ parity tl1	: 0
cpucaps		: flush,stbar,swap,muldiv,v9,mul32,div32,v8plus,vis
Cpu0ClkTck	: 000000001ad38c39
MMU Type	: Spitfire
MMU PGSZs	: 8K,64K,512K,4MB
State:
CPU0:		online

########

ultra60-1 ~ # cat /sys/devices/system/cpu/offline=20
1
ultra60-1 ~ # cat /sys/devices/system/cpu/online
0

#################################################################

With kernel 3.18.140

dmesg (cutted)

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:31'
...
[    0.000000] Linux version 3.18.140 (root@compilenode1) (gcc version 9.3.=
0 (Gentoo Hardened 9.3.0-r1 p3) ) #7 SMP Thu Oct 8 15:37:47 CEST 2020
...
[    0.000000] PERCPU: Embedded 8 pages/cpu @fffff800bf800000 s21760 r8192 =
d35584 u2097152
[    0.000000] pcpu-alloc: s21760 r8192 d35584 u2097152 alloc=3D1*4194304
[    0.000000] pcpu-alloc: [0] 0 2=20
...
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=3D4 to nr_cpu_ids=3D3.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D3
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
...
[   82.644201] CPU 2: synchronized TICK with master CPU (last diff 0 cycles=
, maxerr 535 cycles)
[   82.644302] Brought up 2 CPUs

########

ultra60-1 ~ # lscpu
Architecture:        sparc64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Big Endian
CPU(s):              2
On-line CPU(s) list: 0,2
Thread(s) per core:  1
Core(s) per socket:  1
Socket(s):           2
NUMA node(s):        1
Model name:          TI UltraSparc II  (BlackBird)
NUMA node0 CPU(s):   0-3
Flags:               sun4u

########

ultra60-1 ~ # cat /proc/cpuinfo=20
cpu		: TI UltraSparc II  (BlackBird)
fpu		: UltraSparc II integrated FPU
pmu		: ultra12
prom		: OBP 3.31.0 2001/07/25 20:31
type		: sun4u
ncpus probed	: 2
ncpus active	: 2
D$ parity tl1	: 0
I$ parity tl1	: 0
cpucaps		: flush,stbar,swap,muldiv,v9,mul32,div32,v8plus,vis
Cpu0ClkTck	: 000000001ad37db2
Cpu2ClkTck	: 000000001ad37db2
MMU Type	: Spitfire
MMU PGSZs	: 8K,64K,512K,4MB
State:
CPU0:		online
CPU2:		online

########

ultra60-1 ~ # cat /sys/devices/system/cpu/offline=20

ultra60-1 ~ # cat /sys/devices/system/cpu/online
0,2

best regards,
R=FCdiger

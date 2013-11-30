From: Meelis Roos <mroos@linux.ee>
Date: Sat, 30 Nov 2013 21:42:10 +0000
Subject: Re: RED state exception (trap type 0x64) on U5 reboot
Message-Id: <alpine.SOC.1.00.1311302330490.8846@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310151347070.902@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> > > Another strange symptom is that the problem did not happen when
> > > openpromfs is compiled in statically, not loaded as module. When load=
ed
> > > as module, its memory is vmalloc()ed... but that's probably too weak
> > > connection to conclude anything.
> >=20
> > What happens with the not-even-compile-tested debug patch below?
>=20
> Now I have the results of that test. It does not trigger at all during=20
> normal shutdown since module is not unloaded. When I unmount openpromfs=20
> and rmmod openpromfs, both lines are promted to dmesg. After that, the=20
> RED state still happens on reboot.

Played around some more (to reproduce the slab BUG with newer kernel=20
for reporting) and found 2 things:

1. When I apply the kzmalloc vs vmalloc revert patch to 3.12.0, it=20
breaks the serial layer with fireworks - did not investigate further.

2. When trying plain 3.12 with no debug patches but most debug options=20
except SLAB ones, the RED state exception is still present but I do get=20
a meaningful lockdep warning just before the exception. This is very=20
similar to the warning I posted today for sparc64 startup on another=20
machine (copied below). Maybe this is just some unannotated irq stuff=20
(or 2 independent ones) but it happens in exactly the right spot...

The warning from Ultra 5 with RED State Exception (full dmesg and=20
config are below):

[info] Will now restart.
sd 0:0:0:0: [sda] Synchronizing SCSI cache
reboot: Restarting system
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2826 at kernel/lockdep.c:3535 check_flags+0x7c/0x240()
DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
Modules linked in: openpromfs
CPU: 0 PID: 2826 Comm: reboot Tainted: G        W    3.12.0 #133
Call Trace:
 [0000000000454b6c] warn_slowpath_common+0x4c/0x80
 [0000000000454c4c] warn_slowpath_fmt+0x2c/0x40
 [0000000000499e3c] check_flags+0x7c/0x240
 [000000000049d000] lock_acquire+0x20/0x80
 [000000000077afe8] _raw_spin_lock+0x28/0x40
 [00000000005f8ef4] p1275_cmd_direct+0x14/0x60
 [00000000005f8980] prom_reboot+0x20/0x40
 [0000000000434c88] machine_restart+0x48/0x60
 [000000000047d9cc] kernel_restart+0x4c/0x60
 [000000000047db34] SyS_reboot+0x134/0x200
 [00000000004060b4] linux_sparc_syscall32+0x34/0x40
---[ end trace 4759822ebc3658d5 ]---
possible reason: unannotated irqs-off.
irq event stamp: 3799
hardirqs last  enabled at (3799): [<0000000000404b1c>] rtrap_xcall+0x18/0x20
hardirqs last disabled at (3797): [<0000000000459380>] __do_softirq+0x100/0=
x180
softirqs last  enabled at (3798): [<00000000004593dc>] __do_softirq+0x15c/0=
x180
softirqs last disabled at (3791): [<000000000042b89c>] do_softirq+0x5c/0xa0

RED State Exception

TL=0000.0000.0000.0005 TT=0000.0000.0000.0064
   TPC=0000.0000.f000.4c80 TnPC=0000.0000.f000.4c84 TSTATE=0000.0099.1104.1=
403
TL=0000.0000.0000.0004 TT=0000.0000.0000.0064
   TPC=0000.0000.f000.4c80 TnPC=0000.0000.f000.4c84 TSTATE=0000.0099.1104.1=
403
TL=0000.0000.0000.0003 TT=0000.0000.0000.0064
   TPC=0000.0000.f000.4c80 TnPC=0000.0000.f000.4c84 TSTATE=0000.0099.1104.1=
403
TL=0000.0000.0000.0002 TT=0000.0000.0000.0064
   TPC=0000.0000.f000.0c80 TnPC=0000.0000.f000.0c84 TSTATE=0000.0099.1104.1=
403
TL=0000.0000.0000.0001 TT=0000.0000.0000.0064
   TPC=0000.0000.f004.55c0 TnPC=0000.0000.f004.55c4 TSTATE=0000.0099.1100.1=
603


The warning from Sun E3500 startup:

WARNING: CPU: 6 PID: 1 at kernel/locking/lockdep.c:3535 check_flags+0x7c/0x=
240()                    =20
DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)                             =
                         =20
Modules linked in:                                                         =
                         =20
CPU: 6 PID: 1 Comm: swapper/6 Not tainted 3.13.0-rc1-dirty #17             =
                         =20
Call Trace:                                                                =
                         =20
 [00000000004585cc] warn_slowpath_common+0x4c/0x80                         =
                         =20
 [00000000004586ac] warn_slowpath_fmt+0x2c/0x40                            =
                         =20
 [0000000000498d9c] check_flags+0x7c/0x240                                 =
                         =20
 [000000000049bf40] lock_acquire+0x20/0x80                                 =
                         =20
 [000000000081e188] _raw_spin_lock+0x28/0x40                               =
                         =20
 [000000000061bd74] p1275_cmd_direct+0x14/0x60                             =
                         =20
 [000000000061bc0c] prom_startcpu+0x2c/0x40                                =
                         =20
 [000000000043e3bc] __cpu_up+0x5c/0x180                                    =
                         =20
 [0000000000458830] _cpu_up.constprop.1+0xd0/0x160                         =
                         =20
 [0000000000458958] cpu_up+0x58/0x80                                       =
                         =20
 [00000000009fe2b4] smp_init+0x74/0xbc                                     =
                         =20
 [00000000009f49e4] kernel_init_freeable+0x7c/0x110                        =
                         =20
 [000000000080af24] kernel_init+0x4/0x120                                  =
                         =20
 [00000000004060c4] ret_from_fork+0x1c/0x2c                                =
                         =20
 [0000000000000000]           (null)                                       =
                         =20
---[ end trace e61cc8445001155f ]---                                       =
                         =20
possible reason: unannotated irqs-off.                                     =
                         =20
irq event stamp: 2051                                                      =
                         =20
hardirqs last  enabled at (2051): [<000000000081e9d8>] _raw_spin_unlock_irq=
restore+0x38/0x60        =20
hardirqs last disabled at (2050): [<000000000081e234>] _raw_spin_lock_irqsa=
ve+0x14/0x60             =20
softirqs last  enabled at (398): [<000000000045d098>] __do_softirq+0x178/0x=
200                      =20
softirqs last disabled at (393): [<000000000042bb8c>] do_softirq_own_stack+=
0x2c/0x40

Full dmesg from Ultra 5:

PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:36'
PROMLIB: Root node compatible:=20
Linux version 3.12.0 (mroos@mandariin) (gcc version 4.6.4 (Debian 4.6.4-4) =
) #133 Sat Nov 30 22:14:37 EET 2013
debug: ignoring loglevel setting.
bootconsole [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 08:00:20:f8:c7:72
Kernel: Using 4 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@1f,0/pci@1,1/ebus@1/se@14,400000:a
PROM: Built device tree with 42056 bytes of memory.
Top of RAM: 0x1ff40000, Total RAM: 0x1ff30000
Memory hole size: 0MB
Allocated 1056768 bytes for kernel page tables.
Zone ranges:
  Normal   [mem 0x00000000-0x1ff3ffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x00000000-0x1fefdfff]
  node   0: [mem 0x1ff00000-0x1ff2bfff]
  node   0: [mem 0x1ff3a000-0x1ff3ffff]
On node 0 totalpages: 65432
  Normal zone: 576 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 65432 pages, LIFO batch:15
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
CPU CAPS: [vis]
pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
pcpu-alloc: [0] 0=20
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64856
Kernel command line: root=3D/dev/sda1 ro debug ignore_loglevel
PID hash table entries: 2048 (order: 1, 16384 bytes)
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Sorting __ex_table...
Memory: 493944K/523456K available (3551K kernel code, 345K rwdata, 1184K ro=
data, 256K init, 9803K bss, 29512K reserved)
NR_IRQS:255
kmemleak: Kernel memory leak detector disabled
clocksource: mult[2c71c72] shift[24]
clockevent: mult[5c28f5c3] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
PROMLIB: Sun IEEE Boot Prom 'OBP 3.31.0 2001/07/25 20:36'
PROMLIB: Root node compatible:=20
Linux version 3.12.0 (mroos@mandariin) (gcc version 4.6.4 (Debian 4.6.4-4) =
) #133 Sat Nov 30 22:14:37 EET 2013
debug: ignoring loglevel setting.
bootconsole [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 08:00:20:f8:c7:72
Kernel: Using 4 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@1f,0/pci@1,1/ebus@1/se@14,400000:a
PROM: Built device tree with 42056 bytes of memory.
Top of RAM: 0x1ff40000, Total RAM: 0x1ff30000
Memory hole size: 0MB
Allocated 1056768 bytes for kernel page tables.
Zone ranges:
  Normal   [mem 0x00000000-0x1ff3ffff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x00000000-0x1fefdfff]
  node   0: [mem 0x1ff00000-0x1ff2bfff]
  node   0: [mem 0x1ff3a000-0x1ff3ffff]
On node 0 totalpages: 65432
  Normal zone: 576 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 65432 pages, LIFO batch:15
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
CPU CAPS: [vis]
pcpu-alloc: s0 r0 d32768 u32768 alloc=3D1*32768
pcpu-alloc: [0] 0=20
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 64856
Kernel command line: root=3D/dev/sda1 ro debug ignore_loglevel
PID hash table entries: 2048 (order: 1, 16384 bytes)
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Sorting __ex_table...
Memory: 493944K/523456K available (3551K kernel code, 345K rwdata, 1184K ro=
data, 256K init, 9803K bss, 29512K reserved)
NR_IRQS:255
kmemleak: Kernel memory leak detector disabled
clocksource: mult[2c71c72] shift[24]
clockevent: mult[5c28f5c3] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     16384
... MAX_LOCKDEP_CHAINS:      32768
... CHAINHASH_SIZE:          16384
 memory used by lock dependency info: 5855 kB
 per task-struct memory footprint: 1920 bytes
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                  initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |  ok  |
           recursive read-lock #2:             |  ok  |             |  ok  |
            mixed read-write-lock:             |  ok  |             |  ok  |
            mixed write-read-lock:             |  ok  |             |  ok  |
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
       sirq-safe-A =3D> hirqs-on/12:  ok  |  ok  |  ok  |
       sirq-safe-A =3D> hirqs-on/21:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
  --------------------------------------------------------------------------
  | Wound/wait tests |
  ---------------------
                  ww api failures:  ok  |  ok  |  ok  |
               ww contexts mixing:  ok  |  ok  |
             finishing ww context:  ok  |  ok  |  ok  |  ok  |
               locking mismatches:  ok  |  ok  |  ok  |
                 EDEADLK handling:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  =
|  ok  |  ok  |  ok  |  ok  |
           spinlock nest unlocked:  ok  |
  -----------------------------------------------------
                                 |block | try  |context|
  -----------------------------------------------------
                          context:  ok  |  ok  |  ok  |
                              try:  ok  |  ok  |  ok  |
                            block:  ok  |  ok  |  ok  |
                         spinlock:  ok  |  ok  |  ok  |
-------------------------------------------------------
Good, all 253 testcases passed! |
---------------------------------
ODEBUG: 10 of 10 active objects replaced
ODEBUG: selftest passed
kmemleak: Early log buffer exceeded (1261), please increase DEBUG_KMEMLEAK_=
EARLY_LOG_SIZE
Calibrating delay using timer specific routine.. 723.70 BogoMIPS (lpj618502)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
Performance events: No support for PMU type 'ultra12'
devtmpfs: initialized
kworker/u2:0 (11) used greatest stack depth: 9392 bytes left
atomic64 test passed
NET: Registered protocol family 16
/pci@1f,0: PCI IO[1fe02000000] MEM[1ff00000000]
/pci@1f,0: SABRE PCI Bus Module ver[0:0]
PCI: Scanning PBM /pci@1f,0
sabre f005f9c0: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1fe02000000-0x1fe02ffffff] (bus a=
ddress [0x0000-0xffffff])
pci_bus 0000:00: root bus resource [mem 0x1ff00000000-0x1ffffffffff] (bus a=
ddress [0x00000000-0xffffffff])
pci_bus 0000:00: root bus resource [bus 00-02]
bio: create slab <bio-0> at 0
vgaarb: device added: PCI:0000:01:02.0,decodes=3Dio+mem,owns=3Dnone,locks=
=3Dnone
vgaarb: loaded
vgaarb: bridge control possible 0000:01:02.0
SCSI subsystem initialized
libata version 3.00 loaded.
/pci@1f,0/pci@1,1/ebus@1/eeprom@14,0: Mostek regs at 0x1fff1000000
DMA-API: preallocated 32768 debug entries
DMA-API: debugging enabled by kernel config
AUXIO: Found device at /pci@1f,0/pci@1,1/ebus@1/auxio@14,726000
Switched to clocksource tick
NET: Registered protocol family 2
TCP established hash table entries: 4096 (order: 3, 65536 bytes)
TCP bind hash table entries: 4096 (order: 5, 262144 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP: reno registered
UDP hash table entries: 256 (order: 2, 40960 bytes)
UDP-Lite hash table entries: 256 (order: 2, 40960 bytes)
NET: Registered protocol family 1
PCI: CLS 64 bytes, default 64
power: Control reg at 1fff1724000
Initializing RT-Tester: OK
=3D=3D[ backtrace testing ]=3D=3D=3D=3D=3DTesting a backtrace from process =
context.
The following trace is a kernel self test and not a bug!
CPU: 0 PID: 1 Comm: swapper Not tainted 3.12.0 #133
Call Trace:
 [00000000004aa86c] backtrace_regression_test+0x2c/0x100
 [0000000000426d30] do_one_initcall+0x70/0x140
 [00000000009048d8] do_basic_setup+0x9c/0xd4
 [000000000090497c] kernel_init_freeable+0x6c/0xf0
 [00000000007694a4] kernel_init+0x4/0x100
 [0000000000405fc4] ret_from_fork+0x1c/0x2c
 [0000000000000000]           (null)
Testing a backtrace from irq context.
The following trace is a kernel self test and not a bug!
CPU: 0 PID: 3 Comm: ksoftirqd/0 Not tainted 3.12.0 #133
Call Trace:
 [00000000004aa824] backtrace_test_irq_callback+0x4/0x20
 [0000000000458d90] tasklet_action+0x70/0xc0
 [000000000045932c] __do_softirq+0xac/0x180
 [0000000000459424] run_ksoftirqd+0x24/0x80
 [000000000047f1a8] smpboot_thread_fn+0x1e8/0x200
 [0000000000476660] kthread+0x80/0xa0
 [0000000000405fc4] ret_from_fork+0x1c/0x2c
 [0000000000000000]           (null)
Testing a saved backtrace.
The following trace is a kernel self test and not a bug!
 [<00000000004aa908>] backtrace_regression_test+0xc8/0x100
 [<0000000000426d30>] do_one_initcall+0x70/0x140
 [<00000000009048d8>] do_basic_setup+0x9c/0xd4
 [<000000000090497c>] kernel_init_freeable+0x6c/0xf0
 [<00000000007694a4>] kernel_init+0x4/0x100
 [<0000000000405fc4>] ret_from_fork+0x1c/0x2c
 [<          (null)>]           (null)
=3D=3D[ end of backtrace testing ]=3D=3D
msgmni has been set to 964
io scheduler noop registered
io scheduler cfq registered (default)
list_sort_test: start testing list_sort()
test_string_helpers: Running tests...
f0061c64: ttyS0 at MMIO 0x1fff1400000 (irq =3D 5, base_baud =3D 115200) is =
a SAB82532 V3.2
Console: ttyS0 (SAB82532)
console [ttyS0] enabled
f0061c64: ttyS1 at MMIO 0x1fff1400040 (irq =3D 5, base_baud =3D 115200) is =
a SAB82532 V3.2
[sched_delayed] sched: RT throttling activated
Floppy drive(s): fd0 is 1.44M
loop: module loaded
scsi0 : pata_cmd64x
scsi1 : pata_cmd64x
ata1: PATA max MWDMA2 cmd 0x1fe02c00000 ctl 0x1fe02c00008 bmdma 0x1fe02c000=
20 irq 14
ata2: PATA max MWDMA2 cmd 0x1fe02c00010 ctl 0x1fe02c00018 bmdma 0x1fe02c000=
28 irq 14
pata_cmd64x: active 10 recovery 10 setup 3.
pata_cmd64x: active 10 recovery 10 setup 3.
PCI: Enabling device: (0000:01:01.1), cmd 2
sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
FDC 0 is a National Semiconductor PC87306
eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:f8:c7:72
ata1.00: HPA detected: current 234375000, native 234441648
ata1.00: ATA-5: WDC WD1200JB-75CRA0, 16.06V16, max UDMA/100
ata1.00: 234375000 sectors, multi 0: LBA=20
pata_cmd64x: active 3 recovery 1 setup 1.
pata_cmd64x: active 3 recovery 1 setup 1.
mousedev: PS/2 mouse device common for all mice
rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
TCP: cubic registered
NET: Registered protocol family 17
registered taskstats version 1
rtc-m48t59 rtc-m48t59.0: setting system clock to 2013-11-30 21:21:05 UTC (1=
385846465)
ata1.00: configured for MWDMA2
scsi 0:0:0:0: Direct-Access     ATA      WDC WD1200JB-75C 16.0 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 234375000 512-byte logical blocks: (120 GB/111 GiB)
pata_cmd64x: active 10 recovery 10 setup 3.
pata_cmd64x: active 10 recovery 10 setup 3.
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
ata2.00: ATAPI: CRD-8322B, 1.06, max MWDMA2
pata_cmd64x: active 3 recovery 1 setup 1.
pata_cmd64x: active 3 recovery 1 setup 1.
ata2.00: configured for MWDMA2
 sda: sda1 sda2 sda3
scsi 1:0:0:0: CD-ROM               LG    CD-ROM CRD-8322B 1.06 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] Attached SCSI disk
sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray
cdrom: Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext3 filesystem) readonly on device 8:1.
devtmpfs: mounted
Mount failed for selinuxfs on /sys/fs/selinux:  No such file or directory
??
stty (371) used greatest stack depth: 4992 bytes left
[info] Using makefile-style concurrent boot in runlevel S.
ps (467) used greatest stack depth: 32 bytes left
[....] Starting the hotplug events dispatcher: udevdsystemd-udevd[482]: sta=
rting version 204
[ ok .
[....] Synthesizing the initial hotplug events...tput (536) used greatest s=
tack depth: 8 bytes left
[ ok done.
[....] Waiting for /dev to be fully populated...[ ok done.
[....] Setting parameters of disc: (none)[ ok .
[....] Activating swap...Adding 1843624k swap on /dev/sda2.  Priority:-1 ex=
tents:1 across:1843624k=20
[ ok done.
EXT4-fs (sda1): re-mounted. Opts: (null)
[....] Checking root file system...fsck from util-linux 2.20.1
mandariin-root: clean, 143609/14446080 files, 22345083/28835840 blocks
[ ok done.
EXT4-fs (sda1): re-mounted. Opts: errors=3Dremount-ro
[....] Cleaning up temporary files... /tmp[ ok .
[info] Loading kernel module fuse.
FATAL: Module fuse not found.
[info] Loading kernel module snd-sun-cs4231.
FATAL: Module snd-sun-cs4231 not found.
[info] Loading kernel module snd-seq.
FATAL: Module snd-seq not found.
[....] Activating lvm and md swap...[ ok done.
[....] Checking file systems...fsck from util-linux 2.20.1
[ ok done.
[....] Mounting local filesystems...[ ok done.
[....] Activating swapfile swap...[ ok done.
[....] Cleaning up temporary files...[ ok .
[....] Setting kernel variables ...[ ok done.
[....] Setting up resolvconf...[ ok done.
[....] Configuring network interfaces...Internet Systems Consortium DHCP Cl=
ient 4.2.4
Copyright 2004-2012 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listenin------------[ cut here ]------------
WARNING: CPU: 0 PID: 1564 at lib/dma-debug.c:937 check_unmap+0x784/0x840()
hme 0000:01:01.1: DMA-API: device driver failed to check map error[device a=
ddress=3D0x00000000c1b96802] [size42 bytes] [mapped as single]
Modules linked in: openpromfs
CPU: 0 PID: 1564 Comm: dhclient Not tainted 3.12.0 #133
Call Trace:
 [0000000000454b6c] warn_slowpath_common+0x4c/0x80
 [0000000000454c4c] warn_slowpath_fmt+0x2c/0x40
 [000000000061c964] check_unmap+0x784/0x840
 [000000000061cac4] debug_dma_unmap_page+0x44/0x60
 [00000000006a53c8] happy_meal_tx+0x128/0x260
 [00000000006a59b8] happy_meal_interrupt+0x78/0xc0
 [000000000048a524] handle_irq_event_percpu+0x44/0x1a0
 [000000000048a6b8] handle_irq_event+0x38/0x80
 [000000000048d068] handle_fasteoi_irq+0x108/0x1c0
 [0000000000489da0] generic_handle_irq+0x40/0x60
 [000000000042b814] handler_irq+0x94/0xc0
 [0000000000426acc] valid_addr_bitmap_patch+0x14/0x1c8
 [0000000000459190] local_bh_enable+0xd0/0xe0
 [00000000006dddec] dev_queue_xmit+0x72c/0x7c0
 [000000000075fb88] packet_sendmsg_spkt+0x388/0x4c0
 [00000000006c1558] sock_sendmsg+0x58/0x80
---[ end trace 4759822ebc3658d4 ]---
Mapped at:
 [<00000000006a5dd8>] happy_meal_start_xmit+0x1b8/0x4a0
 [<00000000006dd574>] dev_hard_start_xmit+0x354/0x4a0
 [<00000000006f6de4>] sch_direct_xmit+0x44/0x2a0
 [<00000000006dda58>] dev_queue_xmit+0x398/0x7c0
 [<000000000075fb88>] packet_sendmsg_spkt+0x388/0x4c0
g on LPF/eth0/08:00:20:f8:c7:72
Sending on   LPF/eth0/08:00:20:f8:c7:72
Sending on   Socket/fallback
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 4
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 5
DHCPREQUEST on eth0 to 255.255.255.255 port 67
DHCPOFFER from 192.168.78.1
DHCPACK from 192.168.78.1
bound to 192.168.78.18 -- renewal in 34631 seconds.
[ ok done.
[....] Cleaning up temporary files...[ ok .
[....] Setting up ALSA...[ ok done (none loaded).
[info] Setting console screen modes and fonts.
setterm: cannot (un)set powersave mode: Inappropriate ioctl for device
Running 0dns-down to make sure resolv.conf is ok...done.
[....] Setting up X socket directories... /tmp/.X11-unix /tmp/.ICE-unix[ ok=
 .
IE_?H?info] Using makefile-style concurrent boot in runlevel 2.
[....] Mounted debugfs on /sys/kernel/debug[ ok .
[....] touch: invalid date format '@0'
Starting enhanced syslogd: rsyslogd[ ok .
[....] Setting sysfs variables...[ ok .
[....] Starting deferred execution scheduler: atd[ ok .
[....] Starting periodic command scheduler: cron[ ok .
[info] Not starting internet superserver: no services enabled.
[....] Starting system message bus: dbus[ ok .
Starting openntpd: ntpd.
[....] [....] Starting RARP lookup daemon: rarpd[ ok .
Starting Postfix Mail Transport Agent: postfixpostmulti: warning: inet_prot=
ocols: disabling IPv6 name/address support: Address family not supported by=
 protocol
postmulti: warning: inet_protocols: disabling IPv6 name/address support: Ad=
dress family not supported by protocol
postmulti: warning: inet_protocols: disabling IPv6 name/address support: Ad=
dress family not supported by protocol
postmulti: warning: inet_protocols: disabling IPv6 name/address support: Ad=
dress family not supported by protocol
postmulti: warning: inet_protocols: disabling IPv6 name/address support: Ad=
dress family not supported by protocol
postmulti: warning: inet_protocols: disabling IPv6 name/address support: Ad=
dress family not supported by protocol
postmulti: warning: inet_protocols: disabling IPv6 name/address support: Ad=
dress family not supported by protocol
postmulti: warning: inet_protocols: disabling IPv6 name/address support: Ad=
dress family not supported by protocol
postfix: warning: inet_protocols: disabling IPv6 name/address support: Addr=
ess family not supported by protocol
[ ok .
[....] Starting OpenBSD Secure Shell server: sshd[ ok .
INIT: S{CC??
[info] Using makefile-style concurrent boot in runlevel 6.
[....] Shutting down ALSA...[ ok done (none loaded).
[....] Stopping deferred execution scheduler: atd[ ok .
[....] Stopping periodic command scheduler: cron[ ok .
[....] Unmounted debugfs from /sys/kernel/debug[ ok .
[....] Stopping internet superserver: inetd[ ok .
Stopping openntpd: ntpd.
[....] Stopping Postfix Mail Transport Agent: postfixpostmulti: warning: in=
et_protocols: disabling IPv6 name/address support: Address family not suppo=
rted by protocol
[....] Stopping RARP lookup daemon: rarpd[ ok .
postmulti: warning: inet_protocols: disabling IPv6 name/address support: Ad=
dress family not supported by protocol
postfix: warning: inet_protocols: disabling IPv6 name/address support: Addr=
ess family not supported by protocol
[....] Stopping resolvconf...[ ok done.
[ ok .
[....] Stopping S.M.A.R.T. daemon: smartd[ ok .
[....] Asking all remaining processes to terminate...[ ok done.
[....] All processes ended within 1 seconds...[ ok done.
[....] Stopping enhanced syslogd: rsyslogd[ ok .
[info] Saving the system clock.
[info] Hardware Clock updated to Sat Nov 30 23:23:59 EET 2013.
[....] Deconfiguring network interfaces...Internet Systems Consortium DHCP =
Client 4.2.4
Copyright 2004-2012 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/

Listening on LPF/eth0/08:00:20:f8:c7:72
Sending on   LPF/eth0/08:00:20:f8:c7:72
Sending on   Socket/fallback
DHCPRELEASE on eth0 to 192.168.78.1 port 67
[ ok done.
[....] Deactivating swap...[ ok done.
EXT4-fs (sda1): re-mounted. Opts: (null)
[info] Will now restart.
sd 0:0:0:0: [sda] Synchronizing SCSI cache
reboot: Restarting system
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2826 at kernel/lockdep.c:3535 check_flags+0x7c/0x240()
DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
Modules linked in: openpromfs
CPU: 0 PID: 2826 Comm: reboot Tainted: G        W    3.12.0 #133
Call Trace:
 [0000000000454b6c] warn_slowpath_common+0x4c/0x80
 [0000000000454c4c] warn_slowpath_fmt+0x2c/0x40
 [0000000000499e3c] check_flags+0x7c/0x240
 [000000000049d000] lock_acquire+0x20/0x80
 [000000000077afe8] _raw_spin_lock+0x28/0x40
 [00000000005f8ef4] p1275_cmd_direct+0x14/0x60
 [00000000005f8980] prom_reboot+0x20/0x40
 [0000000000434c88] machine_restart+0x48/0x60
 [000000000047d9cc] kernel_restart+0x4c/0x60
 [000000000047db34] SyS_reboot+0x134/0x200
 [00000000004060b4] linux_sparc_syscall32+0x34/0x40
---[ end trace 4759822ebc3658d5 ]---
possible reason: unannotated irqs-off.
irq event stamp: 3799
hardirqs last  enabled at (3799): [<0000000000404b1c>] rtrap_xcall+0x18/0x20
hardirqs last disabled at (3797): [<0000000000459380>] __do_softirq+0x100/0=
x180
softirqs last  enabled at (3798): [<00000000004593dc>] __do_softirq+0x15c/0=
x180
softirqs last disabled at (3791): [<000000000042b89c>] do_softirq+0x5c/0xa0

RED State Exception

TL=0000.0000.0000.0005 TT=0000.0000.0000.0064
   TPC=0000.0000.f000.4c80 TnPC=0000.0000.f000.4c84 TSTATE=0000.0099.1104.1=
403
TL=0000.0000.0000.0004 TT=0000.0000.0000.0064
   TPC=0000.0000.f000.4c80 TnPC=0000.0000.f000.4c84 TSTATE=0000.0099.1104.1=
403
TL=0000.0000.0000.0003 TT=0000.0000.0000.0064
   TPC=0000.0000.f000.4c80 TnPC=0000.0000.f000.4c84 TSTATE=0000.0099.1104.1=
403
TL=0000.0000.0000.0002 TT=0000.0000.0000.0064
   TPC=0000.0000.f000.0c80 TnPC=0000.0000.f000.0c84 TSTATE=0000.0099.1104.1=
403
TL=0000.0000.0000.0001 TT=0000.0000.0000.0064
   TPC=0000.0000.f004.55c0 TnPC=0000.0000.f004.55c4 TSTATE=0000.0099.1100.1=
603


SIR Reset

SIR Reset
...

Config from Ultra 5 with this dmesg:

#
# Automatically generated file; DO NOT EDIT.
# Linux/sparc64 3.12.0 Kernel Configuration
#
CONFIG_64BIT=3Dy
CONFIG_SPARC=3Dy
# CONFIG_SPARC32 is not set
CONFIG_SPARC64=3Dy
CONFIG_ARCH_DEFCONFIG=3D"arch/sparc/configs/sparc64_defconfig"
CONFIG_IOMMU_HELPER=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
CONFIG_AUDIT_ARCH=3Dy
CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
CONFIG_MMU=3Dy
CONFIG_NEED_DMA_MAP_STATE=3Dy
CONFIG_NEED_SG_DMA_LENGTH=3Dy
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=3Dy

#
# General setup
#
CONFIG_BROKEN_ON_SMP=3Dy
CONFIG_INIT_ENV_ARG_LIMIT2
CONFIG_CROSS_COMPILE=3D""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=3D""
CONFIG_LOCALVERSION_AUTO=3Dy
CONFIG_DEFAULT_HOSTNAME=3D"(none)"
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SYSCTL=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
# CONFIG_FHANDLE is not set
# CONFIG_AUDIT is not set

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_SHOW=3Dy
CONFIG_IRQ_PREFLOW_FASTEOI=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
CONFIG_GENERIC_CMOS_UPDATE=3Dy

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ_COMMON=3Dy
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=3Dy
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=3Dy
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_TASKSTATS=3Dy
CONFIG_TASK_DELAY_ACCT=3Dy
CONFIG_TASK_XACCT=3Dy
CONFIG_TASK_IO_ACCOUNTING=3Dy

#
# RCU Subsystem
#
CONFIG_TINY_RCU=3Dy
# CONFIG_PREEMPT_RCU is not set
# CONFIG_RCU_STALL_COMMON is not set
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
CONFIG_LOG_BUF_SHIFT=17
# CONFIG_CGROUPS is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=3Dy
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
# CONFIG_NET_NS is not set
# CONFIG_UIDGID_STRICT_TYPE_CHECKS is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=3Dy
CONFIG_ANON_INODES=3Dy
CONFIG_HAVE_UID16=3Dy
CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
# CONFIG_EXPERT is not set
CONFIG_UID16=3Dy
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_ALL=3Dy
CONFIG_PRINTK=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SIGNALFD=3Dy
CONFIG_TIMERFD=3Dy
CONFIG_EVENTFD=3Dy
CONFIG_SHMEM=3Dy
CONFIG_AIO=3Dy
CONFIG_PCI_QUIRKS=3Dy
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=3Dy
CONFIG_PERF_USE_VMALLOC=3Dy

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=3Dy
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=3Dy
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=3Dy
# CONFIG_SLUB is not set
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=3Dy
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=3Dy
CONFIG_HAVE_64BIT_ALIGNED_ACCESS=3Dy
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
CONFIG_HAVE_NMI_WATCHDOG=3Dy
CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
CONFIG_HAVE_DMA_ATTRS=3Dy
CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
CONFIG_HAVE_DMA_API_DEBUG=3Dy
CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=3Dy
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
CONFIG_MODULES_USE_ELF_RELA=3Dy
CONFIG_ODD_RT_SIGACTION=3Dy
CONFIG_OLD_SIGSUSPEND=3Dy
CONFIG_COMPAT_OLD_SIGACTION=3Dy

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=3Dy
CONFIG_RT_MUTEXES=3Dy
CONFIG_BASE_SMALL=3D0
CONFIG_MODULES=3Dy
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=3Dy
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_BLOCK=3Dy
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_BLK_DEV_BSGLIB is not set
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_CMDLINE_PARSER is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
CONFIG_MINIX_SUBPARTITION=3Dy
CONFIG_SOLARIS_X86_PARTITION=3Dy
CONFIG_UNIXWARE_DISKLABEL=3Dy
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=3Dy
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
CONFIG_BLOCK_COMPAT=3Dy

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=3Dy
# CONFIG_IOSCHED_DEADLINE is not set
CONFIG_IOSCHED_CFQ=3Dy
CONFIG_DEFAULT_CFQ=3Dy
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED=3D"cfq"
CONFIG_UNINLINE_SPIN_UNLOCK=3Dy
# CONFIG_FREEZER is not set

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_HZ_100=3Dy
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=3Dy
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
CONFIG_GENERIC_HWEIGHT=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_EARLYFB=3Dy
# CONFIG_SECCOMP is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set
# CONFIG_US3_MC is not set
CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_SPARSEMEM_MANUAL=3Dy
CONFIG_SPARSEMEM=3Dy
CONFIG_HAVE_MEMORY_PRESENT=3Dy
CONFIG_SPARSEMEM_EXTREME=3Dy
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
CONFIG_SPARSEMEM_VMEMMAP=3Dy
CONFIG_HAVE_MEMBLOCK=3Dy
CONFIG_HAVE_MEMBLOCK_NODE_MAP=3Dy
CONFIG_NO_BOOTMEM=3Dy
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_PAGEFLAGS_EXTENDED=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=999999
CONFIG_COMPACTION=3Dy
CONFIG_MIGRATION=3Dy
CONFIG_PHYS_ADDR_T_64BIT=3Dy
CONFIG_ZONE_DMA_FLAG=3D0
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR@96
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_NEED_PER_CPU_KM=3Dy
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
# CONFIG_ZBUD is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM_RUNTIME is not set
CONFIG_PREEMPT_NONE=3Dy
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=3Dy
# CONFIG_CMDLINE_BOOL is not set

#
# Bus options (PCI etc.)
#
CONFIG_SBUS=3Dy
CONFIG_SBUSCHAR=3Dy
# CONFIG_SUN_LDOMS is not set
CONFIG_PCI=3Dy
CONFIG_PCI_DOMAINS=3Dy
CONFIG_PCI_SYSCALL=3Dy
# CONFIG_PCI_MSI is not set
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set

#
# PCI host controller drivers
#
# CONFIG_PCCARD is not set
CONFIG_SUN_OPENPROMFS=3Dm
CONFIG_SPARC64_PCI=3Dy

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_COMPAT_BINFMT_ELF=3Dy
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
CONFIG_BINFMT_SCRIPT=3Dy
# CONFIG_HAVE_AOUT is not set
CONFIG_BINFMT_MISC=3Dy
CONFIG_COREDUMP=3Dy
CONFIG_COMPAT=3Dy
CONFIG_SYSVIPC_COMPAT=3Dy
CONFIG_NET=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=3Dy
# CONFIG_UNIX_DIAG is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
# CONFIG_NET_IP_TUNNEL is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_LRO is not set
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=3Dy
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_MMAP is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_NET_MPLS_GSO is not set
CONFIG_NET_RX_BUSY_POLL=3Dy
CONFIG_BQL=3Dy
# CONFIG_BPF_JIT is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_HAVE_BPF_JIT=3Dy

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
CONFIG_DEVTMPFS=3Dy
CONFIG_DEVTMPFS_MOUNT=3Dy
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
CONFIG_FW_LOADER=3Dy
CONFIG_FIRMWARE_IN_KERNEL=3Dy
CONFIG_EXTRA_FIRMWARE=3D""
CONFIG_FW_LOADER_USER_HELPER=3Dy
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
# CONFIG_DMA_SHARED_BUFFER is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
CONFIG_OF=3Dy

#
# Device Tree and Open Firmware support
#
# CONFIG_OF_SELFTEST is not set
CONFIG_OF_PROMTREE=3Dy
CONFIG_OF_NET=3Dy
CONFIG_OF_PCI=3Dy
CONFIG_PARPORT=3Dy
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_SUNBPP=3Dy
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=3Dy
CONFIG_PARPORT_NOT_PC=3Dy
CONFIG_BLK_DEV=3Dy
CONFIG_BLK_DEV_FD=3Dy
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=3Dy
CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ATMEL_SSC is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_PCH_PHUB is not set
# CONFIG_SRAM is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#

#
# Altera FPGA firmware download module
#
CONFIG_HAVE_IDE=3Dy
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=3Dy
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=3Dy
CONFIG_SCSI_DMA=3Dy
# CONFIG_SCSI_TGT is not set
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=3Dy
CONFIG_BLK_DEV_SR_VENDOR=3Dy
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_MULTI_LUN=3Dy
CONFIG_SCSI_CONSTANTS=3Dy
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=3Dy

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=3Dy
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=3Dy
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=3Dy

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=3Dy

#
# SATA SFF controllers with BMDMA
#
# CONFIG_ATA_PIIX is not set
# CONFIG_SATA_HIGHBANK is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_RCAR is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
CONFIG_PATA_CMD64X=3Dy
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
# CONFIG_PATA_CS5536 is not set
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SC1200 is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_LEGACY is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# CONFIG_I2O is not set
CONFIG_NETDEVICES=3Dy
CONFIG_NET_CORE=3Dy
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# CONFIG_NET_DSA_MV88E6XXX is not set
# CONFIG_NET_DSA_MV88E6060 is not set
# CONFIG_NET_DSA_MV88E6XXX_NEED_PPU is not set
# CONFIG_NET_DSA_MV88E6131 is not set
# CONFIG_NET_DSA_MV88E6123_61_65 is not set
CONFIG_ETHERNET=3Dy
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_GRETH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_CADENCE is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_CALXEDA_XGMAC is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_EXAR is not set
# CONFIG_NET_VENDOR_HP is not set
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_IP1000 is not set
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
# CONFIG_NET_PACKET_ENGINE is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_SH_ETH is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_SFC is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_STMICRO is not set
CONFIG_NET_VENDOR_SUN=3Dy
CONFIG_HAPPYMEAL=3Dy
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PHYLIB is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dy
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Yv8
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
# CONFIG_KEYBOARD_ATKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SUNKBD=3Dy
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=3Dy
# CONFIG_INPUT_AD714X is not set
CONFIG_INPUT_SPARCSPKR=3Dy
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_CMA3000 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dy
# CONFIG_SERIO_I8042 is not set
# CONFIG_SERIO_SERPORT is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_SERIO_OLPC_APSP is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=3Dy
CONFIG_VT=3Dy
CONFIG_CONSOLE_TRANSLATIONS=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
CONFIG_VT_HW_CONSOLE_BINDING=3Dy
CONFIG_UNIX98_PTYS=3Dy
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_DEVKMEM=3Dy

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MFD_HSU is not set
CONFIG_SERIAL_SUNCORE=3Dy
# CONFIG_SERIAL_SUNZILOG is not set
# CONFIG_SERIAL_SUNSU is not set
CONFIG_SERIAL_SUNSAB=3Dy
CONFIG_SERIAL_SUNSAB_CONSOLE=3Dy
# CONFIG_SERIAL_SUNHV is not set
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_TIMBERDALE is not set
# CONFIG_SERIAL_GRLIB_GAISLER_APBUART is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_ST_ASC is not set
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=3Dy
# CONFIG_I2C is not set
# CONFIG_SPI is not set
# CONFIG_HSI is not set

#
# PPS support
#
# CONFIG_PPS is not set

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy
CONFIG_GPIO_DEVRES=3Dy
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_POWER_AVS is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
# CONFIG_WATCHDOG is not set
CONFIG_SSB_POSSIBLE=3Dy

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=3Dy

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RTSX_PCI is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
# CONFIG_REGULATOR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_VGA_ARB=3Dy
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_DRM is not set
# CONFIG_VGASTATE is not set
# CONFIG_VIDEO_OUTPUT_CONTROL is not set
# CONFIG_FB is not set
# CONFIG_EXYNOS_VIDEO is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=3Dy
# CONFIG_SOUND is not set

#
# HID support
#
# CONFIG_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
# CONFIG_USB_SUPPORT is not set
# CONFIG_UWB is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_RTC_LIB=3Dy
CONFIG_RTC_CLASS=3Dy
CONFIG_RTC_HCTOSYS=3Dy
CONFIG_RTC_SYSTOHC=3Dy
CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=3Dy
CONFIG_RTC_INTF_PROC=3Dy
CONFIG_RTC_INTF_DEV=3Dy
CONFIG_RTC_INTF_DEV_UIE_EMUL=3Dy
# CONFIG_RTC_DRV_TEST is not set

#
# SPI RTC drivers
#

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=3Dy
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
CONFIG_RTC_DRV_M48T59=3Dy
# CONFIG_RTC_DRV_MSM6242 is not set
CONFIG_RTC_DRV_BQ4802=3Dy
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_DS2404 is not set

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_SUN4V=3Dy
CONFIG_RTC_DRV_STARFIRE=3Dy
# CONFIG_RTC_DRV_SNVS is not set
# CONFIG_RTC_DRV_MOXART is not set

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set

#
# Virtio drivers
#
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_STAGING is not set

#
# Hardware Spinlock drivers
#
# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_STE_MODEM_RPROC is not set

#
# Rpmsg drivers
#
# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# Misc Linux/SPARC drivers
#
CONFIG_SUN_OPENPROMIO=3Dy
# CONFIG_OBP_FLASH is not set
# CONFIG_TADPOLE_TS102_UCTRL is not set
# CONFIG_BBC_I2C is not set
# CONFIG_ENVCTRL is not set
# CONFIG_DISPLAY7SEG is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=3Dy
CONFIG_EXT4_USE_FOR_EXT23=3Dy
CONFIG_EXT4_FS_POSIX_ACL=3Dy
CONFIG_EXT4_FS_SECURITY=3Dy
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=3Dy
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=3Dy
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_FILE_LOCKING=3Dy
CONFIG_FSNOTIFY=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
CONFIG_FANOTIFY=3Dy
# CONFIG_QUOTA is not set
# CONFIG_QUOTACTL is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set
CONFIG_GENERIC_ACL=3Dy

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_PROC_SYSCTL=3Dy
CONFIG_PROC_PAGE_MONITOR=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_TMPFS_XATTR=3Dy
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_CONFIGFS_FS is not set
# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
# CONFIG_NLS is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy

#
# printk and dmesg options
#
# CONFIG_PRINTK_TIME is not set
CONFIG_DEFAULT_MESSAGE_LOGLEVEL=3D4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=3Dy
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_ENABLE_WARN_DEPRECATED=3Dy
CONFIG_ENABLE_MUST_CHECK=3Dy
CONFIG_FRAME_WARN 48
# CONFIG_STRIP_ASM_SYMS is not set
CONFIG_READABLE_ASM=3Dy
# CONFIG_UNUSED_SYMBOLS is not set
CONFIG_DEBUG_FS=3Dy
CONFIG_HEADERS_CHECK=3Dy
CONFIG_DEBUG_SECTION_MISMATCH=3Dy
CONFIG_FRAME_POINTER=3Dy
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_DEBUG_KERNEL=3Dy

#
# Memory Debugging
#
CONFIG_DEBUG_PAGEALLOC=3Dy
CONFIG_WANT_PAGE_DEBUG_FLAGS=3Dy
CONFIG_PAGE_GUARD=3Dy
CONFIG_DEBUG_OBJECTS=3Dy
CONFIG_DEBUG_OBJECTS_SELFTEST=3Dy
CONFIG_DEBUG_OBJECTS_FREE=3Dy
CONFIG_DEBUG_OBJECTS_TIMERS=3Dy
CONFIG_DEBUG_OBJECTS_WORK=3Dy
CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy
CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=3Dy
CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=3D1
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
CONFIG_DEBUG_KMEMLEAK=3Dy
CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE@0
# CONFIG_DEBUG_KMEMLEAK_TEST is not set
# CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF is not set
CONFIG_DEBUG_STACK_USAGE=3Dy
CONFIG_DEBUG_VM=3Dy
CONFIG_DEBUG_VM_RB=3Dy
CONFIG_DEBUG_MEMORY_INIT=3Dy
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=3Dy
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
CONFIG_DETECT_HUNG_TASK=3Dy
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=3D0
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_TIMER_STATS is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=3Dy
CONFIG_DEBUG_PI_LIST=3Dy
CONFIG_RT_MUTEX_TESTER=3Dy
CONFIG_DEBUG_SPINLOCK=3Dy
CONFIG_DEBUG_MUTEXES=3Dy
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy
CONFIG_DEBUG_LOCK_ALLOC=3Dy
CONFIG_PROVE_LOCKING=3Dy
CONFIG_LOCKDEP=3Dy
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_LOCKDEP=3Dy
CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
CONFIG_DEBUG_LOCKING_API_SELFTESTS=3Dy
CONFIG_TRACE_IRQFLAGS=3Dy
CONFIG_STACKTRACE=3Dy
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_KOBJECT_RELEASE is not set
CONFIG_HAVE_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_WRITECOUNT=3Dy
CONFIG_DEBUG_LIST=3Dy
CONFIG_DEBUG_SG=3Dy
CONFIG_DEBUG_NOTIFIERS=3Dy
CONFIG_DEBUG_CREDENTIALS=3Dy

#
# RCU Debugging
#
CONFIG_PROVE_RCU=3Dy
# CONFIG_PROVE_RCU_REPEATEDLY is not set
CONFIG_SPARSE_RCU_POINTER=3Dy
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_TRACE is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_HAVE_FUNCTION_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_FP_TEST=3Dy
CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
CONFIG_HAVE_C_RECORDMCOUNT=3Dy
CONFIG_TRACING_SUPPORT=3Dy
# CONFIG_FTRACE is not set

#
# Runtime Testing
#
# CONFIG_LKDTM is not set
CONFIG_TEST_LIST_SORT=3Dy
CONFIG_BACKTRACE_SELF_TEST=3Dy
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
CONFIG_ATOMIC64_SELFTEST=3Dy
CONFIG_TEST_STRING_HELPERS=3Dy
CONFIG_TEST_KSTRTOX=3Dy
# CONFIG_BUILD_DOCSRC is not set
CONFIG_DMA_API_DEBUG=3Dy
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=3Dy
# CONFIG_KGDB is not set
CONFIG_DEBUG_DCFLUSH=3Dy

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_DEFAULT_SECURITY_DAC=3Dy
CONFIG_DEFAULT_SECURITY=3D""
CONFIG_CRYPTO=3Dy

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=3Dy
CONFIG_CRYPTO_ALGAPI2=3Dy
CONFIG_CRYPTO_HASH=3Dy
CONFIG_CRYPTO_HASH2=3Dy
# CONFIG_CRYPTO_MANAGER is not set
# CONFIG_CRYPTO_MANAGER2 is not set
# CONFIG_CRYPTO_USER is not set
# CONFIG_CRYPTO_GF128MUL is not set
# CONFIG_CRYPTO_NULL is not set
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set

#
# Block modes
#
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=3Dy
# CONFIG_CRYPTO_CRC32C_SPARC64 is not set
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRCT10DIF is not set
# CONFIG_CRYPTO_GHASH is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_MD5_SPARC64 is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
# CONFIG_CRYPTO_SHA1 is not set
# CONFIG_CRYPTO_SHA1_SPARC64 is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA256_SPARC64 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_SHA512_SPARC64 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=3Dy
# CONFIG_CRYPTO_AES_SPARC64 is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAMELLIA_SPARC64 is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_DES_SPARC64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_ZLIB is not set
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_HW is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_BITREVERSE=3Dy
CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
CONFIG_GENERIC_STRNLEN_USER=3Dy
CONFIG_GENERIC_NET_UTILS=3Dy
CONFIG_GENERIC_PCI_IOMAP=3Dy
CONFIG_GENERIC_IO=3Dy
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=3Dy
# CONFIG_CRC_T10DIF is not set
# CONFIG_CRC_ITU_T is not set
CONFIG_CRC32=3Dy
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=3Dy
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
# CONFIG_CRC8 is not set
# CONFIG_XZ_DEC is not set
# CONFIG_XZ_DEC_BCJ is not set
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT=3Dy
CONFIG_HAS_DMA=3Dy
CONFIG_DQL=3Dy
CONFIG_NLATTR=3Dy
CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=3Dy
# CONFIG_AVERAGE is not set
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set


--=20
Meelis Roos (mroos@linux.ee)

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Mon, 24 Nov 2014 10:17:03 +0000
Subject: journal related oops/hang with E250 (3.17.2)
Message-Id: <20141124101703.GA28222@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello,
with two different E250 and 3.17.2 I got an oops during fsck and the other =
hangs
during shutdown - see below. Both seems to be filesystem journal related.

Otherwise 3.17.2 is the first kernel on these UP machines which did
not hang under heavy io load since the debian lenny kernel - many thanks=20
for that progress !

Greetings
  Hermann

---------------------------------------------------------------------------=
----
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.30.0 2003/11/11 10:37'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.17.2 (hlauer@abacus) (gcc version 4.6.3 (Deb=
ian 4.6.3-14) ) #1 SMP Mon Nov 3 14:14:40 CET 2014
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: xxx
[    0.000000] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits =3D 40)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.000000] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
[    0.000000] PROM: Built device tree with 88030 bytes of memory.
[    0.000000] Top of RAM: 0x1fecc000, Total RAM: 0x1feb0000
[    0.000000] Memory hole size: 0MB
[    0.000000] Allocated 16384 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   DMA      empty
[    0.000000]   Normal   [mem 0x00000000-0x1fecbfff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x1fdfdfff]
[    0.000000]   node   0: [mem 0x1fe00000-0x1fe99fff]
[    0.000000]   node   0: [mem 0x1feaa000-0x1febffff]
[    0.000000]   node   0: [mem 0x1feca000-0x1fecbfff]
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] PERCPU: Embedded 7 pages/cpu @fffff8001f800000 s23040 r8192 =
d26112 u4194304
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 64857
[    0.000000] Kernel command line: root=3D/dev/md0 ro
[    0.000000] PID hash table entries: 2048 (order: 1, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 524288 byt=
es)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 262144 byte=
s)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 494296K/522944K available (4101K kernel code, 459K r=
wdata, 1272K rodata, 272K init, 858K bss, 28648K reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	CONFIG_RCU_FANOUT set to non-default value of 32
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS%6 to nr_cpu_ids=3D1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=
=3D1
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[   89.754720] clocksource: mult[360dd68] shift[24]
[   89.809450] clockevent: mult[4bc6a7f0] shift[32]
[   89.865359] Console: colour dummy device 80x25
[   89.917836] console [tty0] enabled
[   89.958394] bootconsole [earlyprom0] disabled
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.30.0 2003/11/11 10:37'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.17.2 (hlauer@abacus) (gcc version 4.6.3 (Deb=
ian 4.6.3-14) ) #1 SMP Mon Nov 3 14:14:40 CET 2014
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:b1:d6:65
[    0.000000] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits =3D 40)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.000000] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
[    0.000000] PROM: Built device tree with 88030 bytes of memory.
[    0.000000] Top of RAM: 0x1fecc000, Total RAM: 0x1feb0000
[    0.000000] Memory hole size: 0MB
[    0.000000] Allocated 16384 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   DMA      empty
[    0.000000]   Normal   [mem 0x00000000-0x1fecbfff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00000000-0x1fdfdfff]
[    0.000000]   node   0: [mem 0x1fe00000-0x1fe99fff]
[    0.000000]   node   0: [mem 0x1feaa000-0x1febffff]
[    0.000000]   node   0: [mem 0x1feca000-0x1fecbfff]
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] PERCPU: Embedded 7 pages/cpu @fffff8001f800000 s23040 r8192 =
d26112 u4194304
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 64857
[    0.000000] Kernel command line: root=3D/dev/md0 ro
[    0.000000] PID hash table entries: 2048 (order: 1, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 524288 byt=
es)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 262144 byte=
s)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 494296K/522944K available (4101K kernel code, 459K r=
wdata, 1272K rodata, 272K init, 858K bss, 28648K reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	CONFIG_RCU_FANOUT set to non-default value of 32
[    0.000000] 	RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] 	RCU restricting CPUs from NR_CPUS%6 to nr_cpu_ids=3D1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=
=3D1
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[   89.754720] clocksource: mult[360dd68] shift[24]
[   89.809450] clockevent: mult[4bc6a7f0] shift[32]
[   89.865359] Console: colour dummy device 80x25
[   89.917836] console [tty0] enabled
[   89.958394] bootconsole [earlyprom0] disabled
[   90.018572] allocated 2097152 bytes of page_cgroup
[   90.018609] please try 'cgroup_disable=3Dmemory' option if you don't wan=
t memory cgroups
[   90.098752] Calibrating delay using timer specific routine.. 595.24 Bogo=
MIPS (lpj=1190493)
[   90.098816] pid_max: default: 32768 minimum: 301
[   90.099127] Security Framework initialized
[   90.099205] AppArmor: AppArmor disabled by boot time parameter
[   90.099241] Yama: becoming mindful.
[   90.099400] Mount-cache hash table entries: 1024 (order: 0, 8192 bytes)
[   90.099450] Mountpoint-cache hash table entries: 1024 (order: 0, 8192 by=
tes)
[   90.101716] Initializing cgroup subsys memory
[   90.101826] Initializing cgroup subsys devices
[   90.101889] Initializing cgroup subsys freezer
[   90.101948] Initializing cgroup subsys net_cls
[   90.102018] Initializing cgroup subsys blkio
[   90.102077] Initializing cgroup subsys perf_event
[   90.106549] Brought up 1 CPUs
[   90.108002] devtmpfs: initialized
[   90.109218] Performance events: No support for PMU type 'ultra12'
[   90.111884] regulator-dummy: no parameters
[   90.120507] NET: Registered protocol family 16
[   90.141077] /pci@1f,4000: PCI IO[1fe02010000] MEM[1ff80000000]
[   90.141197] /pci@1f,4000: PSYCHO PCI Bus Module ver[4:0]
[   90.141257] PCI: Scanning PBM /pci@1f,4000
[   90.141655] psycho f006d1b0: PCI host bridge to bus 0000:00
[   90.141743] pci_bus 0000:00: root bus resource [io  0x1fe02010000-0x1fe0=
201ffff] (bus address [0x0000-0xffff])
[   90.141852] pci_bus 0000:00: root bus resource [mem 0x1ff80000000-0x1fff=
fffffff] (bus address [0x00000000-0x7fffffff])
[   90.141954] pci_bus 0000:00: root bus resource [bus 00]
[   90.144692] /pci@1f,2000: PCI IO[1fe02000000] MEM[1ff00000000]
[   90.144769] /pci@1f,2000: PSYCHO PCI Bus Module ver[4:0]
[   90.144824] PCI: Scanning PBM /pci@1f,2000
[   90.145131] psycho f006dfa4: PCI host bridge to bus 0001:80
[   90.145212] pci_bus 0001:80: root bus resource [io  0x1fe02000000-0x1fe0=
200ffff] (bus address [0x0000-0xffff])
[   90.145321] pci_bus 0001:80: root bus resource [mem 0x1ff00000000-0x1ff7=
fffffff] (bus address [0x00000000-0x7fffffff])
[   90.145424] pci_bus 0001:80: root bus resource [bus 80]
[   90.159965] vgaarb: loaded
[   90.162924] /pci@1f,4000/ebus@1/eeprom@14,0: Mostek regs at 0x1fff1000000
[   90.164049] AUXIO: Found device at /pci@1f,4000/ebus@1/auxio@14,726000
[   90.164649] Switched to clocksource tick
[   90.210119] NET: Registered protocol family 2
[   90.212509] TCP established hash table entries: 4096 (order: 2, 32768 by=
tes)
[   90.212799] TCP bind hash table entries: 4096 (order: 3, 65536 bytes)
[   90.213189] TCP: Hash tables configured (established 4096 bind 4096)
[   90.213651] TCP: reno registered
[   90.213717] UDP hash table entries: 256 (order: 0, 8192 bytes)
[   90.213830] UDP-Lite hash table entries: 256 (order: 0, 8192 bytes)
[   90.214439] NET: Registered protocol family 1
[   90.215193] Unpacking initramfs...
[   92.879766] Freeing initrd memory: 12280K (fffff80004400000 - fffff80004=
ffe000)
[   92.880522] power: Control reg at 1fff1724000
[   92.882939] futex hash table entries: 256 (order: 1, 16384 bytes)
[   92.883211] audit: initializing netlink subsys (disabled)
[   92.883470] audit: type 00 audit(2.880:1): initialized
[   92.885537] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[   92.887485] VFS: Disk quotas dquot_6.5.2
[   92.887673] Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[   92.888246] msgmni has been set to 989
[   92.891500] alg: No test for stdrng (krng)
[   92.891798] bounce: pool size: 64 pages
[   92.891972] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 252)
[   92.892457] io scheduler noop registered
[   92.892536] io scheduler deadline registered
[   92.892670] io scheduler cfq registered (default)
[   92.895632] /pci@1f,4000/ebus@1/su@14,3083f8: Keyboard port at 1fff13083=
f8, irq 9
[   92.896333] /pci@1f,4000/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8,=
 irq 10
[   92.897412] f0070074: ttyS0 at MMIO 0x1fff1400000 (irq =3D 7, base_baud =
=3D 115200) is a SAB82532 V3.2
[   92.897511] Console: ttyS0 (SAB82532)
[  100.401289] [sched_delayed] sched: RT throttling activated
[  100.401630] console [ttyS0] enabled
[  100.509013] f0070074: ttyS1 at MMIO 0x1fff1400040 (irq =3D 7, base_baud =
=3D 115200) is a SAB82532 V3.2
[  100.616444] f0071b18: ttyS2 at MMIO 0x1fff1200000 (irq =3D 8, base_baud =
=3D 115200) is a SAB82532 V3.2
[  100.723685] f0071b18: ttyS3 at MMIO 0x1fff1200040 (irq =3D 8, base_baud =
=3D 115200) is a SAB82532 V3.2
[  100.832697] mousedev: PS/2 mouse device common for all mice
[  100.902773] rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
[  100.982777] drop_monitor: Initializing network drop monitor service
[  101.057757] TCP: cubic registered
[  101.096798] NET: Registered protocol family 10
[  101.151706] mip6: Mobile IPv6
[  101.186287] NET: Registered protocol family 17
[  101.240498] registered taskstats version 1
[  101.289708] rtc-m48t59 rtc-m48t59.0: setting system clock to 2014-11-21 =
10:31:27 UTC (1416565887)=EF=BF=BDLoading, please wait...
[  101.535991] udevd[53]: starting version 175
[  101.899932] input: Sun Mouse as /devices/root/f006d1b0/f006f858/f0074e80=
/serio1/input/input1
[  102.411794] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@daveml=
oft.net)
[  102.626538] SCSI subsystem initialized
[  103.052135] eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20=
:b1:d6:65
[  103.142344] sym0: <875> rev 0x14 at pci 0000:00:03.0 irq 13
[  103.302874] sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
[  103.379277] sym0: SCSI BUS has been reset.
[  103.427432] scsi host0: sym-2.2.3
[  103.470658] sym1: <875> rev 0x14 at pci 0000:00:03.1 irq 14
[  103.623784] sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
[  103.700176] sym1: SCSI BUS has been reset.
[  103.748265] scsi host1: sym-2.2.3
[  106.392776] scsi 0:0:0:0: Direct-Access     SEAGATE  ST1181677LCV     00=
02 PQ: 0 ANSI: 3
[  106.488851] scsi target0:0:0: tagged command queuing enabled, command qu=
eue depth 16.
[  106.582580] scsi target0:0:0: Beginning Domain Validation
[  106.655667] scsi target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, off=
set 16)
[  106.746203] scsi target0:0:0: Domain Validation skipping write tests
[  106.821419] scsi target0:0:0: Ending Domain Validation
[  108.357220] scsi 0:0:6:0: CD-ROM            TOSHIBA  XM6201TASUN32XCD 11=
03 PQ: 0 ANSI: 2
[  108.453706] scsi target0:0:6: Beginning Domain Validation
[  108.519323] scsi target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset =
16)
[  108.602903] scsi target0:0:6: Domain Validation skipping write tests
[  108.678033] scsi target0:0:6: Ending Domain Validation
[  108.743100] scsi 0:0:8:0: Direct-Access     SEAGATE  ST1181677LCV     00=
02 PQ: 0 ANSI: 3
[  108.839862] scsi target0:0:8: tagged command queuing enabled, command qu=
eue depth 16.
[  108.934054] scsi target0:0:8: Beginning Domain Validation
[  109.006558] scsi target0:0:8: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, off=
set 16)
[  109.097181] scsi target0:0:8: Domain Validation skipping write tests
[  109.172361] scsi target0:0:8: Ending Domain Validation
[  111.695194] sr 0:0:6:0: [sr0] out of memory.
[  111.745373] cdrom: Uniform CD-ROM driver Revision: 3.20
[  111.858111] sd 0:0:0:0: [sda] 354600001 512-byte logical blocks: (181 GB=
/169 GiB)
[  111.948245] sd 0:0:8:0: [sdb] Spinning up disk...
[  112.009694] sd 0:0:0:0: Attached scsi generic sg0 type 0
[  112.073198] sr 0:0:6:0: Attached scsi generic sg1 type 5
[  112.136813] sd 0:0:8:0: Attached scsi generic sg2 type 0
[  112.199750] sd 0:0:0:0: [sda] Write Protect is off
[  112.305014] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled=
, supports DPO and FUA
[  112.437173]  sda: sda1 sda2 sda3 sda4 sda5
[  112.502120] sd 0:0:0:0: [sda] Attached SCSI disk
[  113.073641] ...................ready
[  131.815283] sd 0:0:8:0: [sdb] 354600001 512-byte logical blocks: (181 GB=
/169 GiB)
[  131.905597] sd 0:0:8:0: [sdb] Write Protect is off
[  131.963662] sd 0:0:8:0: [sdb] Write cache: disabled, read cache: enabled=
, supports DPO and FUA
[  132.094171]  sdb: sdb1 sdb2 sdb3 sdb4 sdb5
[  132.152320] sd 0:0:8:0: [sdb] Attached SCSI disk
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mountin[  132.809603] md: md1 stopped.
g ro[  132.847159] random: nonblocking pool is initialized
ot file[  132.913320] md: bind<sdb1>
 system ... Begin: Running /s[  132.975583] md: bind<sda1>
cripts/local-top ... Begin: Assembling all MD ar[  133.057565] md: raid1 pe=
rsonality registered for level 1
ra[  133.123495] md/raid1:md1: active with 2 out of 2 mirrors
[  133.187294] md1: detected capacity change from 0 to 98631680
ys ... mda[  133.264868]  md1: p1 p2 p3 p4 p5
[  133.303920] md1: p1 size 192780 extends beyond EOD, truncated
[  133.372660] md1: p2 start 192780 is beyond EOD, truncated
[  133.436683] md1: p3 size 354586680 extends beyond EOD, truncated
[  133.509312] md1: p4 start 62685630 is beyond EOD, truncated
[  133.575189] md1: p5 start 64645560 is beyond EOD, truncated
dm: /dev/md/1 has been started with 2 drives.
[  134.032504] md: md0 stopped.
[  134.090439] md: bind<sdb2>
[  134.161917] md: bind<sda2>
[  134.221979] md/raid1:md0: not clean -- starting background reconstruction
[  134.302380] md/raid1:md0: active with 2 out of 2 mirrors
[  134.366239] md0: detected capacity change from 0 to 31996248064
mdad[  134.447164]  md0: unknown partition table
m: /dev/md/0 has been started with 2 drives.
Success: assembled all arrays.
done.
done.
Begin: Running /scripts/local-premount ... done.
[  134.807813] EXT4-fs (md0): INFO: recovery required on readonly filesystem
[  134.888189] EXT4-fs (md0): write access will be enabled during recovery
[  138.718358] md: resync of RAID array md0
[  138.764310] md: minimum _guaranteed_  speed: 1000 KB/sec/disk.
[  138.834097] md: using maximum available idle IO bandwidth (but not more =
than 200000 KB/sec) for resync.
[  138.946585] md: using 256k window, over a total of 31246336k.
[  140.705656] EXT4-fs (md0): orphan cleanup on readonly fs
[  140.975130] EXT4-fs (md0): 48 orphan inodes deleted
[  141.032544] EXT4-fs (md0): recovery complete
[  141.116818] kernel BUG at fs/jbd2/journal.c:1967!
[  141.172220]               \|/ ____ \|/
[  141.172220]               "@'/ .. \`@"
[  141.172220]               /_| \__/ |_\
[  141.172220]                  \__U_/
[  141.348278] busybox(200): Kernel bad sw trap 5 [#1]
[  141.406513] CPU: 0 PID: 200 Comm: busybox Not tainted 3.17.2 #1
[  141.477313] task: fffff8001c5028a0 ti: fffff80004270000 task.ti: fffff80=
004270000
[  141.566905] TSTATE: 0000004411001603 TPC: 0000000010179888 TNPC: 0000000=
01017988c Y: 00000000    Not tainted
[  141.684661] TPC: <jbd2_journal_flush+0x11c/0x190 [jbd2]>
[  141.748081] g0: 0000000000a4226b g1: 0000000000969bb0 g2: 0000000000969b=
b0 g3: 0000000000969ba8
[  141.852272] g4: fffff8001c5028a0 g5: fffff8001ee02000 g6: fffff800042700=
00 g7: 0000000000000000
[  141.956396] o0: 0000000000000025 o1: 000000001017ca88 o2: 00000000000007=
af o3: fffff8000430e888
[  142.060537] o4: fffff80004eda000 o5: 000000001017ca88 sp: fffff800042730=
21 ret_pc: 0000000010179880
[  142.168907] RPC: <jbd2_journal_flush+0x114/0x190 [jbd2]>
[  142.232405] l0: fffff8001a093000 l1: 0000000000000000 l2: 00000000000000=
04 l3: 0000000000000006
[  142.336516] l4: 0000000000000004 l5: 0000000000955000 l6: 00000000000000=
00 l7: 000000000000000b
[  142.440658] i0: fffff8000430e800 i1: fffff8000430e824 i2: fffff8000430eb=
98 i3: fffff8000430e8e8
[  142.544798] i4: fffff8000430e824 i5: fffff8000430e8e8 i6: fffff800042730=
d1 i7: 00000000101bb440
[  142.649126] I7: <ext4_mark_recovery_complete.isra.237+0x4c/0xb0 [ext4]>
[  142.728054] Call Trace:
[  142.757315]  [00000000101bb440] ext4_mark_recovery_complete.isra.237+0x4=
c/0xb0 [ext4]
[  142.851080]  [00000000101c162c] ext4_fill_super+0x303c/0x33e8 [ext4]
[  142.926994]  [0000000000548580] mount_bdev+0x124/0x18c
[  142.988425]  [0000000000548fb0] mount_fs+0x60/0x17c
[  143.046755]  [000000000055fc38] vfs_kern_mount+0x48/0xe4
[  143.110269]  [0000000000562584] do_mount+0x8ac/0xa1c
[  143.169631]  [0000000000586c4c] compat_SyS_mount+0x1bc/0x1f4
[  143.237333]  [00000000004061b4] linux_sparc_syscall32+0x34/0x60
[  143.308132] Disabling lock debugging due to kernel taint
[  143.371764] Caller[00000000101bb440]: ext4_mark_recovery_complete.isra.2=
37+0x4c/0xb0 [ext4]
[  143.471765] Caller[00000000101c162c]: ext4_fill_super+0x303c/0x33e8 [ext=
4]
[  143.553926] Caller[0000000000548580]: mount_bdev+0x124/0x18c
[  143.621607] Caller[0000000000548fb0]: mount_fs+0x60/0x17c
[  143.686176] Caller[000000000055fc38]: vfs_kern_mount+0x48/0xe4
[  143.755952] Caller[0000000000562584]: do_mount+0x8ac/0xa1c
[  143.821567] Caller[0000000000586c4c]: compat_SyS_mount+0x1bc/0x1f4
[  143.895508] Caller[00000000004061b4]: linux_sparc_syscall32+0x34/0x60
[  143.972578] Caller[0000000000056024]: 0x56024
[  144.024623] Instruction DUMP: 90122288  7c0abaee  01000000 <91d02005> 11=
0405f2  921027af  0af07ffb  90122288  c45e2310=20
Killed
Begin: Running /scripts/local-bottom ... done.
done.
Begin: Running /scripts/init-bottom ... mount: mounting /dev on /root/dev f=
ailed: No such file or directory
done.
Target filesystem does[  144.365842] usbcore: registered new interface driv=
er usbfs
[  144.431565] usbcore: registered new interface driver hub
[  144.495257] usbcore: registered new device driver usb
n't[  144.559335] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
 have request[  144.650210] uhci_hcd: USB Universal Host Controller Interfa=
ce driver
ed /sbin/init[  144.740250] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI)=
 Driver
.
No init found. Tr[  144.834753] hidraw: raw HID events driver (C) Jiri Kosi=
na
y pa[  144.904049] usbcore: registered new interface driver usbhid
[  144.969860] usbhid: USB HID core driver
ssing init=3D bootarg.


BusyBox v1.20.2 (Debian 1:1.20.0-7) built-in shell (ash)
Enter 'help' for a list of built-in commands.

/bin/sh: can't access tty; job control turned off
(initramfs)

---------------------------------------------------------------------------=
----

[....] Deactivating swap...=1B[?25l=1B[?1c=1B7=1B[1G[=1B[32m ok =1B[39;49m=
=1B8=1B[?25h=1B[?0cdone.
[....] Unmounting local filesystems...=1B[?25l=1B[?1c=1B7=1B[1G[=1B[32m ok =
=1B[39;49m=1B8=1B[?25h=1B[?0cdone.
[1796287.045281] md1: detected capacity change from 98631680 to 0
[1796287.114303] md: md1 stopped.
[1796287.224331] md: unbind<sdb1>
[1796287.308350] md: export_rdev(sdb1)
[1796311.944309] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [mou=
nt:13152]
[1796312.032993] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl n=
fs lockd fscache sunrpc ext2 loop evdev flash uio_pdrv_genirq uio ext4 crc1=
6 jbd2 mbcache raid1 md_mod sg sd_mod crc_t10dif crct10dif_common sym53c8xx=
 scsi_transport_spi scsi_mod sunhme
[1796312.305820] CPU: 0 PID: 13152 Comm: mount Not tainted 3.17.2 #1
[1796312.378727] task: fffff8001c7416a0 ti: fffff8001c7d8000 task.ti: fffff=
8001c7d8000
[1796312.470398] TSTATE: 0000004411001601 TPC: 0000000010169d04 TNPC: 00000=
00010169d08 Y: 00000000    Not tainted
[1796312.590217] TPC: <jbd2_log_wait_commit+0xc0/0xd4 [jbd2]>
[1796312.655741] g0: 000000001016b768 g1: 0000000000000001 g2: 000000000000=
0001 g3: 0000000000000000
[1796312.761995] g4: fffff8001c7416a0 g5: fffff8001ee02000 g6: fffff8001c7d=
8000 g7: 0000000000000001
[1796312.868216] o0: fffff80004360824 o1: 0000000000163ecc o2: 000000001016=
7a58 o3: 0000000000000000
[1796312.974443] o4: 00000000009fe080 o5: 0000000000000000 sp: fffff8001c7d=
b041 ret_pc: 0000000010169c54
[1796313.084853] RPC: <jbd2_log_wait_commit+0x10/0xd4 [jbd2]>
[1796313.150416] l0: fffff800043608a0 l1: 0000004411001600 l2: 000000001016=
7a54 l3: 0000000000000400
[1796313.256665] l4: 0000000000000000 l5: 0000000000000001 l6: 000000000000=
0000 l7: 0000000000000008
[1796313.362890] i0: fffff80004360800 i1: 0000000000163ecc i2: fffff8001c7d=
b910 i3: fffff80004360888
[1796313.469113] i4: fffff80004360824 i5: fffff80004360824 i6: fffff8001c7d=
b121 i7: 0000000010167a8c
[1796313.575360] I7: <jbd2_log_do_checkpoint+0x188/0x450 [jbd2]>
[1796313.644037] Call Trace:
[1796313.675301]  [0000000010167a8c] jbd2_log_do_checkpoint+0x188/0x450 [jb=
d2]
[1796313.758633]  [000000001016b7e4] jbd2_journal_flush+0x78/0x190 [jbd2]
[1796313.836903]  [00000000101ad440] ext4_mark_recovery_complete.isra.237+0=
x4c/0xb0 [ext4]
[1796313.932645]  [00000000101afdc0] ext4_remount+0x2a8/0x664 [ext4]
[1796314.005437]  [0000000000548cb8] do_remount_sb+0x110/0x1ac
[1796314.072084]  [0000000000561fc4] do_mount+0x2ec/0xa1c
[1796314.133518]  [0000000000586c4c] compat_SyS_mount+0x1bc/0x1f4

--=20
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres=20
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de

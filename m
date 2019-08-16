From: Meelis Roos <mroos@linux.ee>
Date: Fri, 16 Aug 2019 13:15:49 +0000
Subject: sparc64: hang from BUG: Bad page state, on older CPU & compiler
Message-Id: <d2a51bfb-84e4-3ce7-ac48-7200b3a8d722@linux.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On suggestion of Anatoly Pugachev, I tried util-linux "make check" on some of my older Suns:
E250 with dual UlatraSparc II and Blade 100 with UltraSparc IIe. Both have old 32-bit
userspace from 2015 (inluding gcc 4.9.3) but new kernels from git (5.3-rc4 in both machines).

The util-linux hang was reproducible on both of them, therefor it is not
specific to newer CPU models and MMU-s, and not specific to newre gcc.
On single-CPU Blade 100, the machine became unusable. On dual-CPU E250, one CPU was stuck
and the other worked.

The test that was causing the problem was "fincore: count file contents in core".
The command line of the test was "/bin/bash /home/mroos/util-linux/tests/ts/fincore/count  --srcdir=/home/mroos/util-linux --builddir=/home/mroos/util-linux --parallel"
and the script created a subprocess dd that hangs in D state in both servers.

I have full dmesg from the dual CPU machine. After the hang, there are a couple more
"BUG: Bad page state in process lsblk" errors but seem to have not caused a hang.

Is there anything else I can provide - unstripped kernel image or something?

[    0.000124] PROMLIB: Sun IEEE Boot Prom 'OBP 3.30.0 2003/11/11 10:37'
[    0.000145] PROMLIB: Root node compatible: sun4u
[    0.000281] Linux version 5.3.0-rc4 (mroos@laimi) (gcc version 4.9.3 (Debian 4.9.3-2)) #85 SMP Mon Aug 12 11:35:07 EEST 2019
[    0.000478] printk: debug: ignoring loglevel setting.
[    0.325984] printk: bootconsole [earlyprom0] enabled
[    0.385316] ARCH: SUN4U
[    0.414603] Ethernet address: 08:00:20:b9:23:63
[    0.468663] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits = 40)
[    0.547775] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.622754] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.701890] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.777352] Remapping the kernel...
[    0.809262] done.
[    1.651424] OF stdout device is: /pci@1f,4000/ebus@1/se@14,400000:a
[    1.724633] PROM: Built device tree with 106772 bytes of memory.
[    1.796764] Top of RAM: 0x7feac000, Total RAM: 0x7fe9a000
[    1.861050] Memory hole size: 0MB
[    1.917710] Allocated 16384 bytes for kernel page tables.
[    1.980580] Zone ranges:
[    2.010695]   Normal   [mem 0x0000000000000000-0x000000007feabfff]
[    2.084630] Movable zone start for each node
[    2.135657] Early memory node ranges
[    2.178359]   node   0: [mem 0x0000000000000000-0x000000007fdfdfff]
[    2.253342]   node   0: [mem 0x000000007fe00000-0x000000007fe83fff]
[    2.328318]   node   0: [mem 0x000000007fe94000-0x000000007feabfff]
[    2.403300] Zeroed struct page in unavailable ranges: 9 pages
[    2.403314] Initmem setup node 0 [mem 0x0000000000000000-0x000000007feabfff]
[    2.556379] On node 0 totalpages: 261965
[    2.603240]   Normal zone: 2047 pages used for memmap
[    2.663638]   Normal zone: 0 pages reserved
[    2.713626]   Normal zone: 261965 pages, LIFO batch:31
[    2.860893] Booting Linux...
[    2.893579] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    2.970630] CPU CAPS: [vis]
[    3.039321] percpu: Embedded 10 pages/cpu s44288 r8192 d29440 u2097152
[    3.119822] pcpu-alloc: s44288 r8192 d29440 u2097152 alloc=1*4194304
[    3.194110] pcpu-alloc: [0] 0 1
[    3.243732] Built 1 zonelists, mobility grouping on.  Total pages: 259918
[    3.323250] Kernel command line: root=/dev/sda2 ro ignore_loglevel
[    3.409102] Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes, linear)
[    3.507804] Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes, linear)
[    3.598793] Sorting __ex_table...
[    3.641628] mem auto-init: stack:off, heap alloc:off, heap free:off
[    3.826687] Memory: 2069088K/2095720K available (4850K kernel code, 254K rwdata, 872K rodata, 248K init, 259K bss, 26632K reserved, 0K cma-reserved)
[    3.985116] SLUB: HWalign2, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    4.063319] rcu: Hierarchical RCU implementation.
[    4.118651] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    4.209332] NR_IRQS: 2048, nr_irqs: 2048, preallocated irqs: 1
[    4.279885] clocksource: tick: mask: 0xffffffffffffffff max_cycles: 0x4444444444, max_idle_ns: 440795205904 ns
[    4.398780] clocksource: mult[360dd68] shift[24]
[    4.453970] clockevent: mult[4bc6a7f0] shift[32]
[    4.509489] Console: colour dummy device 80x25
[    4.562339] printk: console [tty0] enabled
[    4.611235] printk: bootconsole [earlyprom0] disabled
[    4.821730] Calibrating delay using timer specific routine.. 593.15 BogoMIPS (lpj)65751)
[    4.821787] pid_max: default: 32768 minimum: 301
[    4.822315] Mount-cache hash table entries: 4096 (order: 2, 32768 bytes, linear)
[    4.822489] Mountpoint-cache hash table entries: 4096 (order: 2, 32768 bytes, linear)
[    4.826886] rcu: Hierarchical SRCU implementation.
[    4.828159] smp: Bringing up secondary CPUs ...
[    4.861805] CPU 1: synchronized TICK with master CPU (last diff -8 cycles, maxerr 539 cycles)
[    4.862224] smp: Brought up 1 node, 2 CPUs
[    4.863918] devtmpfs: initialized
[    4.871959] random: get_random_u32 called from bucket_table_alloc.isra.25+0x54/0x1a0 with crng_init=0
[    4.872392] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    4.872455] futex hash table entries: 512 (order: 2, 32768 bytes, linear)
[    4.873763] NET: Registered protocol family 16
[    4.905036] pci@1f,4000: PCI IO [io  0x1fe02010000-0x1fe0201ffff] offset 1fe02010000
[    4.905104] pci@1f,4000: PCI MEM [mem 0x1ff80000000-0x1ffffffffff] offset 1ff80000000
[    4.905178] pci@1f,4000: PSYCHO PCI Bus Module ver[4:0]
[    4.905237] PCI: Scanning PBM /pci@1f,4000
[    4.905623] psycho f006d1b0: PCI host bridge to bus 0000:00
[    4.905731] pci_bus 0000:00: root bus resource [io  0x1fe02010000-0x1fe0201ffff] (bus address [0x0000-0xffff])
[    4.905836] pci_bus 0000:00: root bus resource [mem 0x1ff80000000-0x1ffffffffff] (bus address [0x00000000-0x7fffffff])
[    4.905933] pci_bus 0000:00: root bus resource [bus 00]
[    4.906258] pci 0000:00:01.0: [108e:1000] type 00 class 0x068000
[    4.906827] pci 0000:00:01.1: [108e:1001] type 00 class 0x020000
[    4.906911] pci 0000:00:01.1: reg 0x10: [mem 0x1ff80008000-0x1ff8000f01f]
[    4.907507] pci 0000:00:03.0: [1000:000f] type 00 class 0x010000
[    4.907592] pci 0000:00:03.0: reg 0x10: [io  0x1fe02010400-0x1fe020104ff]
[    4.907669] pci 0000:00:03.0: reg 0x14: [mem 0x1ff80010000-0x1ff800100ff]
[    4.907741] pci 0000:00:03.0: reg 0x18: [mem 0x1ff80012000-0x1ff80012fff]
[    4.908262] pci 0000:00:03.1: [1000:000f] type 00 class 0x010000
[    4.908343] pci 0000:00:03.1: reg 0x10: [io  0x1fe02010800-0x1fe020108ff]
[    4.908418] pci 0000:00:03.1: reg 0x14: [mem 0x1ff80014000-0x1ff800140ff]
[    4.908489] pci 0000:00:03.1: reg 0x18: [mem 0x1ff80016000-0x1ff80016fff]
[    4.909060] pci 0000:00:05.0: [3d3d:0009] type 00 class 0x038000
[    4.909146] pci 0000:00:05.0: reg 0x10: [mem 0x1ff80020000-0x1ff8003ffff]
[    4.909218] pci 0000:00:05.0: reg 0x14: [mem 0x1ff80800000-0x1ff80ffffff]
[    4.909292] pci 0000:00:05.0: reg 0x18: [mem 0x1ff81000000-0x1ff817fffff]
[    4.909361] pci 0000:00:05.0: reg 0x30: [mem 0x1ff81800000-0x1ff8180ffff]
[    4.910562] pci@1f,2000: PCI IO [io  0x1fe02000000-0x1fe0200ffff] offset 1fe02000000
[    4.910640] pci@1f,2000: PCI MEM [mem 0x1ff00000000-0x1ff7fffffff] offset 1ff00000000
[    4.910711] pci@1f,2000: PSYCHO PCI Bus Module ver[4:0]
[    4.910767] PCI: Scanning PBM /pci@1f,2000
[    4.911063] psycho f006dfa4: PCI host bridge to bus 0001:80
[    4.911162] pci_bus 0001:80: root bus resource [io  0x1fe02000000-0x1fe0200ffff] (bus address [0x0000-0xffff])
[    4.911273] pci_bus 0001:80: root bus resource [mem 0x1ff00000000-0x1ff7fffffff] (bus address [0x00000000-0x7fffffff])
[    4.911376] pci_bus 0001:80: root bus resource [bus 80]
[    4.937118] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    4.937197] HugeTLB registered 8.00 MiB page size, pre-allocated 0 pages
[    4.937248] HugeTLB registered 256 MiB page size, pre-allocated 0 pages
[    4.937301] HugeTLB registered 2.00 GiB page size, pre-allocated 0 pages
[    4.948880] vgaarb: loaded
[    4.949699] SCSI subsystem initialized
[    4.954340] /pci@1f,4000/ebus@1/eeprom@14,0: Mostek regs at 0x1fff1000000
[    4.955819] AUXIO: Found device at /pci@1f,4000/ebus@1/auxio@14,726000
[    4.956302] clocksource: Switched to clocksource tick
[    4.988843] NET: Registered protocol family 2
[    4.990458] tcp_listen_portaddr_hash hash table entries: 1024 (order: 1, 16384 bytes, linear)
[    4.990648] TCP established hash table entries: 16384 (order: 4, 131072 bytes, linear)
[    4.991389] TCP bind hash table entries: 16384 (order: 5, 262144 bytes, linear)
[    4.992751] TCP: Hash tables configured (established 16384 bind 16384)
[    4.993484] UDP hash table entries: 1024 (order: 2, 32768 bytes, linear)
[    4.993732] UDP-Lite hash table entries: 1024 (order: 2, 32768 bytes, linear)
[    4.994288] NET: Registered protocol family 1
[    4.994519] PCI: CLS 0 bytes, default 64
[    4.994918] power: Control reg at 1fff1724000
[    4.998909] workingset: timestamp_bitsb max_order bucket_order=0
[    5.035459] /pci@1f,4000/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 9
[    5.035927] /pci@1f,4000/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 10
[    5.037189] f0070074: ttyS0 at MMIO 0x1fff1400000 (irq = 7, base_baud = 115200) is a SAB82532 V3.2
[    5.037272] Console: ttyS0 (SAB82532)
[   13.984086] printk: console [ttyS0] enabled
[   14.034425] f0070074: ttyS1 at MMIO 0x1fff1400040 (irq = 7, base_baud = 115200) is a SAB82532 V3.2
[   14.141881] f0071b18: ttyS2 at MMIO 0x1fff1200000 (irq = 8, base_baud = 115200) is a SAB82532 V3.2
[   14.248956] f0071b18: ttyS3 at MMIO 0x1fff1200040 (irq = 8, base_baud = 115200) is a SAB82532 V3.2
[   14.357114] sym53c8xx 0000:00:03.0: enabling device (0146 -> 0147)
[   14.431478] sym0: <875> rev 0x14 at pci 0000:00:03.0 irq 13
[   14.584619] sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
[   14.660907] sym0: SCSI BUS has been reset.
[   14.708971] scsi host0: sym-2.2.3
[   14.751774] sym53c8xx 0000:00:03.1: enabling device (0000 -> 0003)
[   14.826199] sym1: <875> rev 0x14 at pci 0000:00:03.1 irq 14
[   14.979168] sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
[   15.055437] sym1: SCSI BUS has been reset.
[   15.103566] scsi host1: sym-2.2.3
[   15.146934] mousedev: PS/2 mouse device common for all mice
[   15.214785] rtc-m48t59 rtc-m48t59.0: registered as rtc0
[   15.279222] NET: Registered protocol family 10
[   15.338642] Segment Routing with IPv6
[   15.381808] NET: Registered protocol family 17
[   15.437528] rtc-m48t59 rtc-m48t59.0: setting system clock to 2019-08-16T09:44:03 UTC (1565948643)
[   17.835494] scsi 0:0:0:0: Direct-Access     QUANTUM  ATLAS10K3_36_SCA 020W PQ: 0 ANSI: 3
[   17.931567] scsi target0:0:0: tagged command queuing enabled, command queue depth 16.
[   18.025412] scsi target0:0:0: Beginning Domain Validation
[   18.093513] scsi target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
[   18.181977] scsi target0:0:0: Domain Validation skipping write tests
[   18.257163] scsi target0:0:0: Ending Domain Validation
[   18.319401] scsi 0:0:0:0: Power-on or device reset occurred
[   19.568065] scsi 0:0:5:0: Sequential-Access HP       C1537A           L706 PQ: 0 ANSI: 2
[   19.664556] scsi target0:0:5: Beginning Domain Validation
[   19.745205] scsi target0:0:5: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 16)
[   19.841651] scsi target0:0:5: Domain Validation skipping write tests
[   19.916805] scsi target0:0:5: Ending Domain Validation
[   19.993601] scsi 0:0:6:0: CD-ROM            TOSHIBA  XM6201TASUN32XCD 1103 PQ: 0 ANSI: 2
[   20.089635] scsi target0:0:6: Beginning Domain Validation
[   20.155587] scsi target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 16)
[   20.239084] scsi target0:0:6: Domain Validation skipping write tests
[   20.314304] scsi target0:0:6: Ending Domain Validation
[   22.732951] sd 0:0:0:0: [sda] 71833096 512-byte logical blocks: (36.8 GB/34.3 GiB)
[   22.824288] sd 0:0:0:0: [sda] Write Protect is off
[   22.880727] sd 0:0:0:0: [sda] Mode Sense: e5 00 10 08
[   22.942423] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   23.055956]  sda: sda1 sda2 sda3 sda4
[   23.104919] sd 0:0:0:0: [sda] Attached SCSI disk
[   23.196937] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   23.287822] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
[   23.390210] devtmpfs: mounted
[   23.426005] This architecture does not have kernel memory protection.
[   23.502243] Run /sbin/init as init process
[   24.367186] random: fast init done
[   25.504486] random: udevd: uninitialized urandom read (16 bytes read)
[   25.582637] random: udevd: uninitialized urandom read (16 bytes read)
[   25.659091] random: udevd: uninitialized urandom read (16 bytes read)
[   26.364990] /pci@1f,4000/ebus@1/flashprom@10,0: OBP Flash, RD 1fff0000000[100000] WR 1fff0000000[100000]
[   26.411566] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[   26.482532] hme 0000:00:01.1: enabling device (0000 -> 0002)
[   26.620423] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
[   26.711962] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   26.718641] eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet
[   26.718653] 08:00:20:b9:23:63
[   26.885196] st 0:0:5:0: Attached scsi generic sg1 type 1
[   26.955625] st 0:0:5:0: Attached scsi tape st0
[   27.008052] st 0:0:5:0: st0: try direct i/o: yes (alignment 4 B)
[   27.081254] sr 0:0:6:0: Power-on or device reset occurred
[   27.146840] sr 0:0:6:0: Attached scsi generic sg2 type 5
[   27.147056] sr 0:0:6:0: [sr0] scsi-1 drive
[   27.258628] cdrom: Uniform CD-ROM driver Revision: 3.20
[   27.345230] sr 0:0:6:0: Attached scsi CD-ROM sr0
[   30.872895] Adding 1582392k swap on /dev/sda4.  Priority:-2 extents:1 across:1582392k
[   31.151920] EXT4-fs (sda2): re-mounted. Opts: (null)
[   31.718465] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[   33.195087] random: crng init done
[   33.234802] random: 1 urandom warning(s) missed due to ratelimiting
[   33.693877] loop: module loaded
[   34.015898] EXT4-fs (sda1): mounting ext2 file system using the ext4 subsystem
[   34.107019] EXT4-fs (sda1): mounted filesystem without journal. Opts: (null)
[   40.231650] eth0: Link is up using
[   40.231664] internal
[   40.272488] transceiver at
[   40.299564] 100Mb/s, Full Duplex.
[ 4480.589467] BUG: Bad page state in process ld  pfn:3d9d9
[ 4480.652097] page:0000060000f67640 refcount:-2 mapcount:0 mapping:0000000000000000 index:0x0
[ 4480.752039] flags: 0x0()
[ 4480.782234] raw: 0000000000000000 0000000000000100 0000000000000122 0000000000000000
[ 4480.874927] raw: 0000000000000000 0000000000000000 fffffffffffffffe fffff8007b3b2000
[ 4480.967598] page dumped because: nonzero _refcount
[ 4481.024856] Modules linked in: loop sr_mod cdrom sg sunhme st flash
[ 4481.099854] CPU: 1 PID: 2937 Comm: ld Not tainted 5.3.0-rc4 #85
[ 4481.170655] Call Trace:
[ 4481.199838]  [000000000054ac70] bad_page+0xb0/0x140
[ 4481.258143]  [000000000054beb0] free_pcppages_bulk+0x3d0/0x520
[ 4481.327920]  [000000000054d3a0] free_unref_page_list+0x100/0x160
[ 4481.399783]  [0000000000516a88] release_pages+0x2a8/0x380
[ 4481.464332]  [000000000053fd14] tlb_flush_mmu_free+0x54/0x80
[ 4481.532017]  [000000000054009c] tlb_finish_mmu+0x7c/0x140
[ 4481.596599]  [000000000053d7b8] exit_mmap+0xb8/0x180
[ 4481.655950]  [000000000045e6e0] mmput+0x40/0xe0
[ 4481.710101]  [0000000000464ae4] do_exit+0x1c4/0xa40
[ 4481.768415]  [00000000004653dc] do_group_exit+0x3c/0xe0
[ 4481.830899]  [0000000000465494] sys_exit_group+0x14/0x20
[ 4481.894432]  [00000000004061f4] linux_sparc_syscall32+0x34/0x60
[ 4481.965222] Disabling lock debugging due to kernel taint
[ 4482.700869] Unable to handle kernel NULL pointer dereference
[ 4482.767633] tsk->{mm,active_mm}->context = 0000000000000c33
[ 4482.834248] tsk->{mm,active_mm}->pgd = fffff8007ab64000
[ 4482.896730]               \|/ ____ \|/
                              "@'/ .. \`@"
                              /_| \__/ |_\
                                 \__U_/
[ 4483.072769] dd(3004): Oops [#1]
[ 4483.110220] CPU: 1 PID: 3004 Comm: dd Tainted: G    B             5.3.0-rc4 #85
[ 4483.197710] TSTATE: 0000008011e01604 TPC: 000000000054d7a0 TNPC: 000000000054d7a4 Y: 00000000    Tainted: G    B
[ 4483.332075] TPC: <get_page_from_freelist+0x1c0/0xca0>
[ 4483.392428] g0: 0000000000000000 g1: 0000060000f679c8 g2: 0000000000000122 g3: 0000000000000100
[ 4483.496582] g4: fffff8007a29e540 g5: fffff8007efea000 g6: fffff8007ab78000 g7: fffff8007fa0d290
[ 4483.600719] o0: 00000000009daa00 o1: 0000000000000000 o2: 0000000000003700 o3: 0000000000000000
[ 4483.704855] o4: 00000000009be800 o5: 0000000000000000 sp: fffff8007ab7ad41 ret_pc: 00000000004caf9c
[ 4483.813166] RPC: <smp_call_function_many+0x33c/0x3a0>
[ 4483.873546] l0: 00000000009db3c0 l1: fffff8007ab7b758 l2: 0000000000000201 l3: 00000000009daa00
[ 4483.977698] l4: 0000000000000010 l5: fffff8007fa0d280 l6: 0000000000000001 l7: 0000000000000000
[ 4484.081835] i0: fffff8007efea000 i1: 0000000000000008 i2: 0000000000000000 i3: 0000000000000010
[ 4484.185971] i4: 0000000000a23280 i5: 0000060000f679c0 i6: fffff8007ab7aea1 i7: 000000000054f4c4
[ 4484.290120] I7: <__alloc_pages_nodemask+0xc4/0x1c0>
[ 4484.348403] Call Trace:
[ 4484.377571]  [000000000054f4c4] __alloc_pages_nodemask+0xc4/0x1c0
[ 4484.450476]  [000000000054f5d8] __get_free_pages+0x18/0x40
[ 4484.516078]  [000000000053fda4] __tlb_remove_page_size+0x64/0xc0
[ 4484.587937]  [0000000000534ff8] unmap_page_range+0x5f8/0x880
[ 4484.655624]  [00000000005353e0] unmap_vmas+0x20/0x60
[ 4484.714986]  [000000000053d794] exit_mmap+0x94/0x180
[ 4484.774343]  [000000000045e6e0] mmput+0x40/0xe0
[ 4484.828495]  [0000000000464ae4] do_exit+0x1c4/0xa40
[ 4484.886807]  [00000000004653dc] do_group_exit+0x3c/0xe0
[ 4484.949292]  [0000000000465494] sys_exit_group+0x14/0x20
[ 4485.012822]  [00000000004061f4] linux_sparc_syscall32+0x34/0x60
[ 4485.083635] Caller[000000000054f4c4]: __alloc_pages_nodemask+0xc4/0x1c0
[ 4485.162777] Caller[000000000054f5d8]: __get_free_pages+0x18/0x40
[ 4485.234627] Caller[000000000053fda4]: __tlb_remove_page_size+0x64/0xc0
[ 4485.312733] Caller[0000000000534ff8]: unmap_page_range+0x5f8/0x880
[ 4485.386671] Caller[00000000005353e0]: unmap_vmas+0x20/0x60
[ 4485.452278] Caller[000000000053d794]: exit_mmap+0x94/0x180
[ 4485.517882] Caller[000000000045e6e0]: mmput+0x40/0xe0
[ 4485.578281] Caller[0000000000464ae4]: do_exit+0x1c4/0xa40
[ 4485.642848] Caller[00000000004653dc]: do_group_exit+0x3c/0xe0
[ 4485.711578] Caller[0000000000465494]: sys_exit_group+0x14/0x20
[ 4485.781351] Caller[00000000004061f4]: linux_sparc_syscall32+0x34/0x60
[ 4485.858406] Caller[00000000f7e3aa6c]: 0xf7e3aa6c
[ 4485.913585] Instruction DUMP:
[ 4485.913594]  c4586008
[ 4485.948991]  ba007ff8
[ 4485.977107]  c6584000
[ 4486.005224] <c470e008>
[ 4486.033340]  c6708000
[ 4486.061458]  84102100
[ 4486.089575]  c4704000
[ 4486.117692]  84102122
[ 4486.145808]  c4706008

[ 4486.219743] Fixing recursive fault but reboot is needed!
[ 4486.288030] BUG: Bad page state in process xz  pfn:3d9e7
[ 4486.350675] page:0000060000f679c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
[ 4486.449601] flags: 0x0()
[ 4486.479794] raw: 0000000000000000 0000000000000100 0000000000000122 0000000000000000
[ 4486.572490] raw: 0000000000000000 0000000000000000 ffffffff00000001 fffff8007b3ce000
[ 4486.665163] page dumped because: nonzero _refcount
[ 4486.722418] Modules linked in: loop sr_mod cdrom sg sunhme st flash
[ 4486.797414] CPU: 1 PID: 2631 Comm: xz Tainted: G    B D           5.3.0-rc4 #85
[ 4486.884887] Call Trace:
[ 4486.914051]  [000000000054ac70] bad_page+0xb0/0x140
[ 4486.972369]  [000000000054beb0] free_pcppages_bulk+0x3d0/0x520
[ 4487.042142]  [000000000054d3a0] free_unref_page_list+0x100/0x160
[ 4487.114005]  [0000000000516a88] release_pages+0x2a8/0x380
[ 4487.178554]  [000000000053fd14] tlb_flush_mmu_free+0x54/0x80
[ 4487.246245]  [000000000054009c] tlb_finish_mmu+0x7c/0x140
[ 4487.310816]  [000000000053d7b8] exit_mmap+0xb8/0x180
[ 4487.370172]  [000000000045e6e0] mmput+0x40/0xe0
[ 4487.424325]  [0000000000464ae4] do_exit+0x1c4/0xa40
[ 4487.482642]  [00000000004653dc] do_group_exit+0x3c/0xe0
[ 4487.545125]  [0000000000465494] sys_exit_group+0x14/0x20
[ 4487.608651]  [00000000004061f4] linux_sparc_syscall32+0x34/0x60
[ 4544.815855] BUG: Bad page state in process limits2  pfn:3d9e7
[ 4544.883710] page:0000060000f679c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
[ 4544.982613] flags: 0x0()
[ 4545.012808] raw: 0000000000000000 0000000000000100 0000000000000122 0000000000000000
[ 4545.105504] raw: 0000000000000000 0000000000000000 ffffffff00000001 fffff8007b3ce000
[ 4545.198173] page dumped because: nonzero _refcount
[ 4545.255431] Modules linked in: loop sr_mod cdrom sg sunhme st flash
[ 4545.330429] CPU: 1 PID: 5504 Comm: limits2 Tainted: G    B D           5.3.0-rc4 #85
[ 4545.423109] Call Trace:
[ 4545.452279]  [000000000054ac70] bad_page+0xb0/0x140
[ 4545.510593]  [000000000054e130] get_page_from_freelist+0xb50/0xca0
[ 4545.584527]  [000000000054f4c4] __alloc_pages_nodemask+0xc4/0x1c0
[ 4545.657421]  [000000000044ff10] pte_alloc_one+0x10/0x60
[ 4545.719906]  [0000000000534708] __pte_alloc+0x8/0x80
[ 4545.779262]  [0000000000537d38] __handle_mm_fault+0x7f8/0xc80
[ 4545.847993]  [00000000005325b0] __get_user_pages+0xf0/0x3e0
[ 4545.914639]  [0000000000532ba0] get_user_pages_remote+0x80/0x240
[ 4545.986494]  [000000000057cf10] copy_strings.isra.50+0x110/0x2a0
[ 4546.058343]  [000000000057d0c0] copy_strings_kernel+0x20/0x40
[ 4546.127075]  [000000000057d564] __do_execve_file.isra.58+0x484/0x620
[ 4546.203097]  [000000000057e688] compat_sys_execve+0x28/0x40
[ 4546.269755]  [00000000004061f4] linux_sparc_syscall32+0x34/0x60
[ 4596.235206] BUG: Bad page state in process lsblk  pfn:3d9d9
[ 4596.301017] page:0000060000f67640 refcount:-2 mapcount:0 mapping:0000000000000000 index:0x0
[ 4596.400958] flags: 0x0()
[ 4596.431153] raw: 0000000000000000 0000000000000100 0000000000000122 0000000000000000
[ 4596.523850] raw: 0000000000000000 0000000000000000 fffffffffffffffe fffff8007b3b2000
[ 4596.616519] page dumped because: nonzero _refcount
[ 4596.673777] Modules linked in: loop sr_mod cdrom sg sunhme st flash
[ 4596.748778] CPU: 0 PID: 9724 Comm: lsblk Tainted: G    B D           5.3.0-rc4 #85
[ 4596.839373] Call Trace:
[ 4596.868541]  [000000000054ac70] bad_page+0xb0/0x140
[ 4596.926858]  [000000000054daa0] get_page_from_freelist+0x4c0/0xca0
[ 4597.000792]  [000000000054f4c4] __alloc_pages_nodemask+0xc4/0x1c0
[ 4597.073684]  [0000000000562224] new_slab+0x364/0x420
[ 4597.133039]  [0000000000564820] ___slab_alloc.constprop.95+0x380/0x520
[ 4597.211144]  [0000000000564d60] kmem_cache_alloc+0x160/0x200
[ 4597.278839]  [00000000005368ec] __pmd_alloc+0xc/0x80
[ 4597.338195]  [0000000000537a58] __handle_mm_fault+0x518/0xc80
[ 4597.406926]  [00000000005325b0] __get_user_pages+0xf0/0x3e0
[ 4597.473572]  [0000000000532ba0] get_user_pages_remote+0x80/0x240
[ 4597.545427]  [000000000057cf10] copy_strings.isra.50+0x110/0x2a0
[ 4597.617277]  [000000000057d0c0] copy_strings_kernel+0x20/0x40
[ 4597.686006]  [000000000057d564] __do_execve_file.isra.58+0x484/0x620
[ 4597.762032]  [000000000057e688] compat_sys_execve+0x28/0x40
[ 4597.828688]  [00000000004061f4] linux_sparc_syscall32+0x34/0x60


-- 
Meelis Roos <mroos@linux.ee>

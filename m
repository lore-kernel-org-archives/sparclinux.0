From: Meelis Roos <mroos@linux.ee>
Date: Sun, 26 Aug 2018 07:48:44 +0000
Subject: new SBus related DMA warnings in 4.18+git
Message-Id: <alpine.LRH.2.21.1808260902280.22219@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org

Tried yesterdays git 4.18.0-12789-gaa5b105 on a Sun Ultra 1 with SBus 
and several SBus connected devicess give DMA mapping related warnings:

[    0.000272] PROMLIB: Sun IEEE Boot Prom 'OBP 3.35.0 2004/04/19 12:15'
[    0.000403] PROMLIB: Root node compatible: 
[    0.000861] Linux version 4.18.0-12789-gaa5b105 (mroos@melon) (gcc version 4.9.3 (Debian 4.9.3-2)) #181 Sat Aug 25 19:32:49 EEST 2018
[    0.271438] bootconsole [earlyprom0] enabled
[    0.322433] ARCH: SUN4U
[    0.351889] Ethernet address: 08:00:20:9f:6b:e4
[    0.405830] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits = 40)
[    0.484959] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.559966] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.641129] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.717545] Remapping the kernel... 
[    0.783535] done.
[    1.263372] OF stdout device is: /sbus@1f,0/zs@f,1100000:a
[    1.328169] PROM: Built device tree with 52656 bytes of memory.
[    1.399423] Top of RAM: 0x33f50000, Total RAM: 0x33f3e000
[    1.463595] Memory hole size: 0MB
[    1.515966] Allocated 16384 bytes for kernel page tables.
[    1.580408] Zone ranges:
[    1.609966]   Normal   [mem 0x0000000000000000-0x0000000033f4ffff]
[    1.683926] Movable zone start for each node
[    1.734974] Early memory node ranges
[    1.777700]   node   0: [mem 0x0000000000000000-0x0000000033efdfff]
[    1.852709]   node   0: [mem 0x0000000033f00000-0x0000000033f2bfff]
[    1.927716]   node   0: [mem 0x0000000033f3c000-0x0000000033f4ffff]
[    2.002904] Initmem setup node 0 [mem 0x0000000000000000-0x0000000033f4ffff]
[    2.087107] On node 0 totalpages: 106399
[    2.087126]   Normal zone: 832 pages used for memmap
[    2.087140]   Normal zone: 0 pages reserved
[    2.087160]   Normal zone: 106399 pages, LIFO batch:31
[    2.130356] Booting Linux...
[    2.163986] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    2.241064] CPU CAPS: [vis]
[    2.285004] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    2.285025] pcpu-alloc: [0] 0 
[    2.290171] Built 1 zonelists, mobility grouping on.  Total pages: 105567
[    2.370571] Kernel command line: root=/dev/sda2 ro scsi_mod.use_blk_mq=1
[    2.458819] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
[    2.547744] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
[    2.629240] Sorting __ex_table...
[    2.743001] Memory: 835208K/851192K available (4226K kernel code, 288K rwdata, 952K rodata, 168K init, 205K bss, 15984K reserved, 0K cma-reserved)
[    2.901478] NR_IRQS: 2048, nr_irqs: 2048, preallocated irqs: 1
[    2.970823] clocksource: tick: mask: 0xffffffffffffffff max_cycles: 0x20f9d3d150, max_idle_ns: 440795205852 ns
[    3.090230] clocksource: mult[6fe715b] shift[24]
[    3.145440] clockevent: mult[249a6daa] shift[32]
[    3.202180] Console: colour dummy device 80x25
[    3.254591] console [tty0] enabled
[    3.295176] bootconsole [earlyprom0] disabled
[    3.497488] Calibrating delay using timer specific routine.. 287.03 BogoMIPS (lpj35180)
[    3.497589] pid_max: default: 32768 minimum: 301
[    3.498727] Mount-cache hash table entries: 2048 (order: 1, 16384 bytes)
[    3.498859] Mountpoint-cache hash table entries: 2048 (order: 1, 16384 bytes)
[    3.505616] devtmpfs: initialized
[    3.514345] random: get_random_u32 called from bucket_table_alloc.isra.24+0x7c/0x1c0 with crng_init=0
[    3.515254] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    3.515355] futex hash table entries: 256 (order: -1, 6144 bytes)
[    3.516955] NET: Registered protocol family 16
[    3.536331] audit: initializing netlink subsys (disabled)
[    3.555514] SYSIO: UPA portID ffffffff, at 000001fe00000000
[    3.581737] audit: type 00 audit(0.230:1): state=initialized audit_enabled=0 res=1
[    3.616342] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    3.616438] HugeTLB registered 8.00 MiB page size, pre-allocated 0 pages
[    3.616505] HugeTLB registered 256 MiB page size, pre-allocated 0 pages
[    3.616574] HugeTLB registered 2.00 GiB page size, pre-allocated 0 pages
[    3.621134] fbcon: Taking over console
[    3.622385] SCSI subsystem initialized
[    3.626204] mostek f005a1dc: DMA mask not set
[    3.626352] /sbus@1f,0/eeprom@f,1200000: Mostek regs at 0x1fff1200000
[    3.627907] auxio f0059f50: DMA mask not set
[    3.628041] AUXIO: Found device at /sbus@1f,0/auxio@f,1900000
[    3.628539] clocksource: Switched to clocksource tick
[    3.704804] NET: Registered protocol family 2
[    3.707441] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 8192 bytes)
[    3.707643] TCP established hash table entries: 8192 (order: 3, 65536 bytes)
[    3.708174] TCP bind hash table entries: 8192 (order: 3, 65536 bytes)
[    3.708746] TCP: Hash tables configured (established 8192 bind 8192)
[    3.709486] UDP hash table entries: 512 (order: 1, 16384 bytes)
[    3.709700] UDP-Lite hash table entries: 512 (order: 1, 16384 bytes)
[    3.710618] NET: Registered protocol family 1
[    3.721015] workingset: timestamp_bitsb max_order bucket_order=0
[    3.744635] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    3.744788] io scheduler noop registered
[    3.744863] io scheduler deadline registered
[    3.745120] io scheduler cfq registered (default)
[    3.749312] zs f005a290: DMA mask not set
[    3.749817] f005a290: ttyS0 at MMIO 0x1fff1100000 (irq = 9, base_baud = 307200) is a zs
[    3.749930] Console: ttyS0 (SunZilog zs0)
[    9.203008] console [ttyS0] enabled
[    9.245538] f005a290: ttyS1 at MMIO 0x1fff1100004 (irq = 9, base_baud = 307200) is a zs
[    9.341897] zs f005b730: DMA mask not set
[    9.388980] f005b730: Keyboard at MMIO 0x1fff1000000 (irq = 9) is a zs
[    9.466630] f005b730: Mouse at MMIO 0x1fff1000004 (irq = 9) is a zs
[    9.542716] esp f0062a74: DMA mask not set
[    9.595718] ------------[ cut here ]------------
[    9.649150] WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 esp_sbus_probe+0x57c/0x700
[    9.756374] Modules linked in:
[    9.792814] CPU: 0 PID: 1 Comm: swapper Not tainted 4.18.0-12789-gaa5b105 #181
[    9.879291] Call Trace:
[    9.908449]  [00000000006ec8dc] esp_sbus_probe+0x57c/0x700
[    9.974112]  [00000000006c0b8c] platform_drv_probe+0x2c/0xa0
[   10.041817]  [00000000006be9dc] really_probe+0x19c/0x2e0
[   10.105367]  [00000000006becd0] driver_probe_device+0x50/0x100
[   10.175165]  [00000000006bee74] __driver_attach+0xf4/0x120
[   10.240789]  [00000000006bcb24] bus_for_each_dev+0x44/0x80
[   10.306420]  [00000000006bddf8] bus_add_driver+0x198/0x220
[   10.372062]  [00000000006bf7f0] driver_register+0x70/0x120
[   10.437694]  [0000000000427310] do_one_initcall+0x30/0x180
[   10.503340]  [0000000000964af8] kernel_init_freeable+0x134/0x1d0
[   10.575198]  [000000000081f6a4] kernel_init+0x4/0x100
[   10.635633]  [0000000000405f64] ret_from_fork+0x1c/0x2c
[   10.698108]  [0000000000000000]           (null)
[   10.753340] ---[ end trace 3332d1d0348bd1ad ]---
[   10.809253] esp f0062a74: esp0: regs[(____ptrval____):(____ptrval____)] irq[10]
[   10.896097] esp f0062a74: esp0: is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
[   14.039232] scsi host0: esp
[   14.072447] esp f00735ac: DMA mask not set
[   14.122675] scsi 0:0:0:0: Direct-Access     MAXTOR   ATLAS10K4_36SCA  DFV0 PQ: 0 ANSI: 3
[   14.217910] scsi target0:0:0: Beginning Domain Validation
[   14.284387] esp f00735ac: esp1: regs[(____ptrval____):(____ptrval____)] irq[14]
[   14.370147] esp f00735ac: esp1: is a FASHME, 40 MHz (ccf=0), SCSI ID 7
[   14.450462] scsi target0:0:0: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[   14.533386] scsi target0:0:0: Domain Validation skipping write tests
[   14.608015] scsi target0:0:0: Ending Domain Validation
[   14.669843] scsi 0:0:0:0: Power-on or device reset occurred
[   15.913404] scsi 0:0:6:0: CD-ROM            TOSHIBA  XM-5401TASUN4XCD 2565 PQ: 0 ANSI: 2
[   16.008606] scsi target0:0:6: Beginning Domain Validation
[   16.087230] scsi target0:0:6: FAST-5 SCSI 4.2 MB/s ST (236 ns, offset 15)
[   16.174368] scsi target0:0:6: Domain Validation skipping write tests
[   16.248596] scsi target0:0:6: Ending Domain Validation
[   17.479095] scsi host1: esp
[   17.516784] sd 0:0:0:0: [sda] 71833096 512-byte logical blocks: (36.8 GB/34.3 GiB)
[   17.609921] mousedev: PS/2 mouse device common for all mice
[   17.680502] sd 0:0:0:0: [sda] Write Protect is off
[   17.735982] sd 0:0:0:0: [sda] Mode Sense: ed 00 10 08
[   17.736678] rtc-m48t59 rtc-m48t59.0: registered as rtc0
[   17.800349] NET: Registered protocol family 17
[   17.851782] Key type dns_resolver registered
[   17.908257] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   18.012580] rtc-m48t59 rtc-m48t59.0: setting system clock to 2018-08-25 20:18:43 UTC (1535228323)
[   18.126394]  sda: sda1 sda2 sda3 sda4
[   18.179463] sd 0:0:0:0: [sda] Attached SCSI disk
[   18.680005] input: Sun Mouse as /devices/root/f0059940/f005b730/serio1/input/input1
[   21.223136] EXT4-fs (sda2): mounting ext3 file system using the ext4 subsystem
[   21.345645] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   21.435626] VFS: Mounted root (ext3 filesystem) readonly on device 8:2.
[   21.515923] random: fast init done
[   21.576895] devtmpfs: mounted
[   21.611680] This architecture does not have kernel memory protection.
[   21.687612] Run /sbin/init as init process
[   25.945971] systemd-udevd[476]: starting version 215
[   26.331472] random: udevd: uninitialized urandom read (16 bytes read)
[   26.553702] random: udevd: uninitialized urandom read (16 bytes read)
[   27.443371] flash f0059fe0: DMA mask not set
[   27.492744] /sbus@1f,0/flashprom@f,0: OBP Flash, RD 1fff0000000[80000] WR 1fff1380000[80000]
[   27.749840] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   27.838931] bpp f0069908: DMA mask not set
[   27.886682] parport0: sunbpp at 0x1ffec800000
[   27.972907] sr 0:0:6:0: Power-on or device reset occurred
[   28.041976] sunlance f006707c: DMA mask not set
[   28.094563] sunlance.c:v2.02 8/24/03 Miguel de Icaza (miguel@nuclecu.unam.mx)
[   28.179719] ------------[ cut here ]------------
[   28.234971] WARNING: CPU: 0 PID: 519 at ./include/linux/dma-mapping.h:516 sparc_lance_probe_one+0x37c/0x4c0 [sunlance]
[   28.363071] Modules linked in: sunlance(+) sr_mod(+) snd_pcm parport_sunbpp(+) cdrom parport sg(+) snd_timer snd flash(+) evdev soundcore
[   28.511044] CPU: 0 PID: 519 Comm: udevd Tainted: G        W         4.18.0-12789-gaa5b105 #181
[   28.614135] Call Trace:
[   28.643306]  [00000000100a1f7c] sparc_lance_probe_one+0x37c/0x4c0 [sunlance]
[   28.727713]  [00000000006c0b8c] platform_drv_probe+0x2c/0xa0
[   28.795403]  [00000000006be9dc] really_probe+0x19c/0x2e0
[   28.858966]  [00000000006becd0] driver_probe_device+0x50/0x100
[   28.928754]  [00000000006bee74] __driver_attach+0xf4/0x120
[   28.994381]  [00000000006bcb24] bus_for_each_dev+0x44/0x80
[   29.060007]  [00000000006bddf8] bus_add_driver+0x198/0x220
[   29.125642]  [00000000006bf7f0] driver_register+0x70/0x120
[   29.191279]  [0000000000427310] do_one_initcall+0x30/0x180
[   29.256917]  [00000000004ab0f0] do_init_module+0x4c/0x1bc
[   29.321504]  [00000000004aa408] load_module+0x1bc8/0x2020
[   29.386094]  [00000000004aa9d4] sys_finit_module+0x74/0xa0
[   29.451731]  [00000000004060b4] linux_sparc_syscall32+0x34/0x60
[   29.522544] ---[ end trace 3332d1d0348bd1af ]---
[   29.578176] SunLance: using auto-carrier-detection.
[   29.638121] eth0: LANCE 08:00:20:9f:6b:e4
[   29.688200] hme f006be34: DMA mask not set
[   29.735421] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
[   29.823899] ------------[ cut here ]------------
[   29.879121] WARNING: CPU: 0 PID: 523 at ./include/linux/dma-mapping.h:516 hme_sbus_probe+0x898/0x9c0 [sunhme]
[   29.997837] Modules linked in: sunhme(+) sunlance sr_mod(+) snd_pcm parport_sunbpp(+) cdrom parport sg(+) snd_timer snd flash(+) evdev soundcore
[   30.153104] CPU: 0 PID: 523 Comm: udevd Tainted: G        W         4.18.0-12789-gaa5b105 #181
[   30.256194] Call Trace:
[   30.285369]  [00000000100ac8b8] hme_sbus_probe+0x898/0x9c0 [sunhme]
[   30.360387]  [00000000006c0b8c] platform_drv_probe+0x2c/0xa0
[   30.428089]  [00000000006be9dc] really_probe+0x19c/0x2e0
[   30.491640]  [00000000006becd0] driver_probe_device+0x50/0x100
[   30.561442]  [00000000006bee74] __driver_attach+0xf4/0x120
[   30.627062]  [00000000006bcb24] bus_for_each_dev+0x44/0x80
[   30.692693]  [00000000006bddf8] bus_add_driver+0x198/0x220
[   30.758330]  [00000000006bf7f0] driver_register+0x70/0x120
[   30.823989]  [00000000100b2010] happy_meal_probe+0x10/0xc0 [sunhme]
[   30.898976]  [0000000000427310] do_one_initcall+0x30/0x180
[   30.964614]  [00000000004ab0f0] do_init_module+0x4c/0x1bc
[   31.029194]  [00000000004aa408] load_module+0x1bc8/0x2020
[   31.093786]  [00000000004aa9d4] sys_finit_module+0x74/0xa0
[   31.159423]  [00000000004060b4] linux_sparc_syscall32+0x34/0x60
[   31.230233] ---[ end trace 3332d1d0348bd1b0 ]---
[   31.287904] eth1: HAPPY MEAL (SBUS) 10/100baseT Ethernet 
[   31.287923] 08:00:20:9f:6b:e4
[   31.407985] qpti f00798c4: DMA mask not set
[   31.468397] sr 0:0:6:0: [sr0] scsi-1 drive
[   31.515534] cdrom: Uniform CD-ROM driver Revision: 3.20
[   31.604507] audio f0059e44: DMA mask not set
[   31.789408] qlogicpti0: IRQ 15 
[   31.789519] SCSI ID 7 
[   31.825285] ------------[ cut here ]------------
[   31.908745] WARNING: CPU: 0 PID: 525 at ./include/linux/dma-mapping.h:516 qpti_sbus_probe+0x450/0x1630 [qlogicpti]
[   32.032526] Modules linked in: snd_sun_cs4231(+) qlogicpti(+) sunhme sunlance sr_mod(+) snd_pcm parport_sunbpp(+) cdrom parport sg(+) snd_timer snd flash(+) evdev soundcore
[   32.216985] CPU: 0 PID: 525 Comm: udevd Tainted: G        W         4.18.0-12789-gaa5b105 #181
[   32.320052] Call Trace:
[   32.349211]  [00000000100b75f0] qpti_sbus_probe+0x450/0x1630 [qlogicpti]
[   32.429454]  [00000000006c0b8c] platform_drv_probe+0x2c/0xa0
[   32.497149]  [00000000006be9dc] really_probe+0x19c/0x2e0
[   32.560708]  [00000000006becd0] driver_probe_device+0x50/0x100
[   32.630527]  [00000000006bee74] __driver_attach+0xf4/0x120
[   32.696144]  [00000000006bcb24] bus_for_each_dev+0x44/0x80
[   32.761760]  [00000000006bddf8] bus_add_driver+0x198/0x220
[   32.827396]  [00000000006bf7f0] driver_register+0x70/0x120
[   32.893031]  [0000000000427310] do_one_initcall+0x30/0x180
[   32.958669]  [00000000004ab0f0] do_init_module+0x4c/0x1bc
[   33.023251]  [00000000004aa408] load_module+0x1bc8/0x2020
[   33.087843]  [00000000004aa9d4] sys_finit_module+0x74/0xa0
[   33.153481]  [00000000004060b4] linux_sparc_syscall32+0x34/0x60
[   33.224294] ---[ end trace 3332d1d0348bd1b1 ]---
[   33.282263] sr 0:0:6:0: Attached scsi generic sg1 type 5
[   33.499951] ------------[ cut here ]------------
[   33.553491] WARNING: CPU: 0 PID: 513 at ./include/linux/dma-mapping.h:516 snd_dma_alloc_pages+0x180/0x1a0 [snd_pcm]
[   33.678318] Modules linked in: snd_sun_cs4231(+) qlogicpti(+) sunhme sunlance sr_mod(+) snd_pcm parport_sunbpp(+) cdrom parport sg snd_timer snd flash(+) evdev soundcore
[   33.859660] CPU: 0 PID: 513 Comm: udevd Tainted: G        W         4.18.0-12789-gaa5b105 #181
[   33.962781] Call Trace:
[   33.991950]  [00000000100830c0] snd_dma_alloc_pages+0x180/0x1a0 [snd_pcm]
[   34.073225]  [0000000010082838] snd_pcm_lib_preallocate_pages1+0x118/0x1a0 [snd_pcm]
[   34.165966]  [0000000010082918] snd_pcm_lib_preallocate_pages_for_all+0x38/0x80 [snd_pcm]
[   34.263873]  [00000000100c1e38] cs4231_probe+0x638/0x7e0 [snd_sun_cs4231]
[   34.345074]  [00000000006c0b8c] platform_drv_probe+0x2c/0xa0
[   34.412771]  [00000000006be9dc] really_probe+0x19c/0x2e0
[   34.476319]  [00000000006becd0] driver_probe_device+0x50/0x100
[   34.546119]  [00000000006bee74] __driver_attach+0xf4/0x120
[   34.611747]  [00000000006bcb24] bus_for_each_dev+0x44/0x80
[   34.677373]  [00000000006bddf8] bus_add_driver+0x198/0x220
[   34.743010]  [00000000006bf7f0] driver_register+0x70/0x120
[   34.808643]  [0000000000427310] do_one_initcall+0x30/0x180
[   34.874288]  [00000000004ab0f0] do_init_module+0x4c/0x1bc
[   34.938866]  [00000000004aa408] load_module+0x1bc8/0x2020
[   35.003457]  [00000000004aa9d4] sys_finit_module+0x74/0xa0
[   35.069095]  [00000000004060b4] linux_sparc_syscall32+0x34/0x60
[   35.139904] ---[ end trace 3332d1d0348bd1b2 ]---
[   35.286257] sr 0:0:6:0: Attached scsi CD-ROM sr0
[   36.283976] sd 0:0:0:0: [sda] tag#4 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK
[   36.381331] sd 0:0:0:0: [sda] tag#4 CDB: ATA command pass through(16) 85 06 20 00 05 00 fe 00 00 00 00 00 00 40 ef 00
[   37.266190] sd 0:0:0:0: [sda] tag#2 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK
[   37.363525] sd 0:0:0:0: [sda] tag#2 CDB: ATA command pass through(16) 85 06 20 00 05 00 fe 00 00 00 00 00 00 40 ef 00
[   37.765963] sunlance f006707c rename2: renamed from eth0
[   37.831623] hme f006be34 eth0: renamed from eth1
[   38.320369] (Firmware v1.31.32)
[   38.320401] (FCode 1.21 95/05/18)
[   38.356199] 
               qlogicpti0: [Fast Wide, using single ended interface]
[   38.486325] scsi host2: PTI Qlogic,ISP SBUS SCSI irq 15 regs at (____ptrval____)
[   38.736044] sd 0:0:0:0: [sda] tag#1 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK
[   38.833349] sd 0:0:0:0: [sda] tag#1 CDB: ATA command pass through(16) 85 06 20 00 05 00 fe 00 00 00 00 00 00 40 ef 00
[   38.994170] systemd-udevd[519]: renamed network interface eth1 to eth0
[   39.100116] systemd-udevd[516]: renamed network interface eth0 to rename2
[   39.266082] sd 0:0:0:0: [sda] tag#1 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK
[   39.363408] sd 0:0:0:0: [sda] tag#1 CDB: ATA command pass through(16) 85 06 20 00 05 00 fe 00 00 00 00 00 00 40 ef 00
[   39.605965] sd 0:0:0:0: [sda] tag#1 FAILED Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK
[   39.703275] sd 0:0:0:0: [sda] tag#1 CDB: ATA command pass through(16) 85 06 20 00 05 00 fe 00 00 00 00 00 00 40 ef 00
[   39.916597] sunlance f006707c eth1: renamed from rename2
[   40.119269] systemd-udevd[516]: renamed network interface eth0 to eth1
[   41.033237] Adding 360440k swap on /dev/sda4.  Priority:-2 extents:1 across:360440k 
[   41.441029] EXT4-fs (sda2): re-mounted. Opts: (null)
[   42.110875] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[   47.809743] NET: Registered protocol family 10
[   47.868327] Segment Routing with IPv6
[   49.196386] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[   49.298784] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[   54.513618] random: dd: uninitialized urandom read (512 bytes read)
[   59.720440] eth0: Link is up using 
[   59.720459] internal 
[   59.760188] transceiver at 
[   59.787280] 100Mb/s, Full Duplex.
[   64.259942] random: crng init done

-- 
Meelis Roos (mroos@linux.ee)

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 27 Aug 2018 19:04:58 +0000
Subject: Re: new SBus related DMA warnings in 4.18+git
Message-Id: <alpine.LRH.2.21.1808272203270.28446@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.21.1808260902280.22219@math.ut.ee>
	<20180827154716.GA30492@lst.de>
In-Reply-To: <20180827154716.GA30492-jcswGhMUV9g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org

> On Sun, Aug 26, 2018 at 10:48:44AM +0300, Meelis Roos wrote:
> > Tried yesterdays git 4.18.0-12789-gaa5b105 on a Sun Ultra 1 with SBus 
> > and several SBus connected devicess give DMA mapping related warnings:
> 
> This should have been around since the warning was added.
> 
> The patch below should fix it:
> 
> ---
> >From 6294e0e330851ee06e66ab85b348f1d92d375d7a Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 27 Aug 2018 17:23:24 +0200
> Subject: driver core: initialize a default DMA mask for platform device

No, it does not fix it. Dmesg from another SBus machine that conmpiled 
it faster (Sun Ultra 2):

[    0.000112] PROMLIB: Sun IEEE Boot Prom 'OBP 3.25.0 1999/12/03 11:35'
[    0.000131] PROMLIB: Root node compatible: 
[    0.000250] Linux version 4.18.0-12952-g2923b27-dirty (mroos@u2) (gcc version 4.9.3 (Debian 4.9.3-2)) #239 SMP Mon Aug 27 21:42:14 EEST 2018
[    0.000448] debug: ignoring loglevel setting.
[    0.329860] bootconsole [earlyprom0] enabled
[    0.380881] ARCH: SUN4U
[    0.410167] Ethernet address: 08:00:20:89:2a:a0
[    0.464243] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits = 40)
[    0.543372] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.618366] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.697932] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.774140] Remapping the kernel... 
[    0.807146] done.
[    1.154827] OF stdout device is: /sbus@1f,0/zs@f,1100000:a
[    1.219566] PROM: Built device tree with 63364 bytes of memory.
[    1.290510] Top of RAM: 0x6ff2c000, Total RAM: 0x37f1a000
[    1.354970] Memory hole size: 896MB
[    1.406349] Allocated 16384 bytes for kernel page tables.
[    1.470133] Zone ranges:
[    1.500269]   Normal   [mem 0x0000000000000000-0x000000006ff2bfff]
[    1.574219] Movable zone start for each node
[    1.625258] Early memory node ranges
[    1.667967]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
[    1.742961]   node   0: [mem 0x0000000020000000-0x0000000027ffffff]
[    1.817956]   node   0: [mem 0x0000000040000000-0x000000004fffffff]
[    1.892948]   node   0: [mem 0x0000000060000000-0x000000006fefdfff]
[    1.967942]   node   0: [mem 0x000000006ff00000-0x000000006ff05fff]
[    2.042936]   node   0: [mem 0x000000006ff16000-0x000000006ff2bfff]
[    2.118044] Initmem setup node 0 [mem 0x0000000000000000-0x000000006ff2bfff]
[    2.202302] On node 0 totalpages: 114573
[    2.249169]   Normal zone: 896 pages used for memmap
[    2.308537]   Normal zone: 0 pages reserved
[    2.358535]   Normal zone: 114573 pages, LIFO batch:31
[    2.495241] Booting Linux...
[    2.528734] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    2.605799] CPU CAPS: [vis]
[    2.668258] percpu: Embedded 10 pages/cpu @(____ptrval____) s44928 r8192 d28800 u2097152
[    2.766410] pcpu-alloc: s44928 r8192 d28800 u2097152 alloc=1*4194304
[    2.841510] pcpu-alloc: [0] 0 1 
[    2.885668] Built 1 zonelists, mobility grouping on.  Total pages: 113677
[    2.965990] Kernel command line: root=/dev/sda2 ro ignore_loglevel
[    3.046466] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
[    3.134227] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
[    3.215649] Sorting __ex_table...
[    3.310465] Memory: 892040K/916584K available (4329K kernel code, 255K rwdata, 816K rodata, 232K init, 268K bss, 24544K reserved, 0K cma-reserved)
[    3.467295] SLUB: HWalign2, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    3.545872] rcu: Hierarchical RCU implementation.
[    3.601352] NR_IRQS: 2048, nr_irqs: 2048, preallocated irqs: 1
[    3.671504] clocksource: tick: mask: 0xffffffffffffffff max_cycles: 0x44439c2a93, max_idle_ns: 440795210626 ns
[    3.790815] clocksource: mult[360e5ba] shift[24]
[    3.846017] clockevent: mult[4bc5ed4a] shift[32]
[    3.901587] Console: colour dummy device 80x25
[    3.954414] console [tty0] enabled
[    3.994980] bootconsole [earlyprom0] disabled
[    4.197213] Calibrating delay using timer specific routine.. 593.26 BogoMIPS (lpj)66300)
[    4.197267] pid_max: default: 32768 minimum: 301
[    4.197757] Mount-cache hash table entries: 2048 (order: 1, 16384 bytes)
[    4.197861] Mountpoint-cache hash table entries: 2048 (order: 1, 16384 bytes)
[    4.201878] rcu: Hierarchical SRCU implementation.
[    4.203657] smp: Bringing up secondary CPUs ...
[    4.237851] CPU 1: synchronized TICK with master CPU (last diff -17 cycles, maxerr 539 cycles)
[    4.238252] smp: Brought up 1 node, 2 CPUs
[    4.239996] devtmpfs: initialized
[    4.245228] random: get_random_u32 called from bucket_table_alloc.isra.18+0x7c/0x1c0 with crng_init=0
[    4.245850] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    4.245913] futex hash table entries: 512 (order: 2, 32768 bytes)
[    4.247101] NET: Registered protocol family 16
[    4.261051] SYSIO: UPA portID ffffffff, at 000001fe00000000
[    4.297680] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    4.297744] HugeTLB registered 8.00 MiB page size, pre-allocated 0 pages
[    4.297779] HugeTLB registered 256 MiB page size, pre-allocated 0 pages
[    4.297816] HugeTLB registered 2.00 GiB page size, pre-allocated 0 pages
[    4.300832] fbcon: Taking over console
[    4.301679] SCSI subsystem initialized
[    4.304283] mostek f005b464: DMA mask not set
[    4.304365] /sbus@1f,0/eeprom@f,1200000: Mostek regs at 0x1fff1200000
[    4.305251] auxio f005b1d8: DMA mask not set
[    4.305332] AUXIO: Found device at /sbus@1f,0/auxio@f,1900000
[    4.305771] clocksource: Switched to clocksource tick
[    4.340181] NET: Registered protocol family 2
[    4.342138] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 8192 bytes)
[    4.342268] TCP established hash table entries: 8192 (order: 3, 65536 bytes)
[    4.342661] TCP bind hash table entries: 8192 (order: 4, 131072 bytes)
[    4.343354] TCP: Hash tables configured (established 8192 bind 8192)
[    4.343785] UDP hash table entries: 512 (order: 1, 16384 bytes)
[    4.343961] UDP-Lite hash table entries: 512 (order: 1, 16384 bytes)
[    4.344447] NET: Registered protocol family 1
[    4.349437] workingset: timestamp_bitsb max_order bucket_order=0
[    4.392958] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    4.393060] io scheduler noop registered
[    4.393099] io scheduler deadline registered
[    4.393471] io scheduler cfq registered (default)
[    4.394406] ffb f006635c: DMA mask not set
[    4.396369] Console: switching to colour frame buffer device 144x56
[    4.407269] /SUNW,ffb@1e,0: FFB at 000001fc00000000, type 8, DAC pnum[236c] rev[10] manuf_rev[4]
[    4.407893] cg6 f00930e0: DMA mask not set
[    4.408983] /sbus@1f,0/cgsix@1,0: CGsix [TGX sparc] at 0:1ff10000000
[    4.410748] zs f005b518: DMA mask not set
[    4.411208] f005b518: ttyS0 at MMIO 0x1fff1100000 (irq = 9, base_baud = 307200) is a zs
[    4.411375] Console: ttyS0 (SunZilog zs0)
[   11.168494] console [ttyS0] enabled
[   11.210705] f005b518: ttyS1 at MMIO 0x1fff1100004 (irq = 9, base_baud = 307200) is a zs
[   11.306714] zs f005c9b8: DMA mask not set
[   11.354326] f005c9b8: Keyboard at MMIO 0x1fff1000000 (irq = 9) is a zs
[   11.432125] f005c9b8: Mouse at MMIO 0x1fff1000004 (irq = 9) is a zs
[   11.508108] esp f006c230: DMA mask not set
[   11.557107] ------------[ cut here ]------------
[   11.611290] WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 esp_sbus_probe+0x57c/0x700
[   11.718646] Modules linked in:
[   11.754977] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.18.0-12952-g2923b27-dirty #239
[   11.849770] Call Trace:
[   11.878854]  [0000000000457af0] __warn+0xb0/0xe0
[   11.934092]  [000000000071d47c] esp_sbus_probe+0x57c/0x700
[   11.999738]  [00000000006f07cc] platform_drv_probe+0x2c/0xa0
[   12.067422]  [00000000006ee9fc] really_probe+0x19c/0x2e0
[   12.130953]  [00000000006eef10] driver_probe_device+0x50/0x100
[   12.200750]  [00000000006ef0b4] __driver_attach+0xf4/0x120
[   12.266361]  [00000000006ecbc4] bus_for_each_dev+0x44/0x80
[   12.331980]  [00000000006edc18] bus_add_driver+0x198/0x220
[   12.397605]  [00000000006efb10] driver_register+0x70/0x120
[   12.463229]  [0000000000427310] do_one_initcall+0x30/0x180
[   12.528857]  [0000000000954b2c] kernel_init_freeable+0x148/0x1e4
[   12.600737]  [0000000000838124] kernel_init+0x4/0x120
[   12.661120]  [0000000000406064] ret_from_fork+0x1c/0x2c
[   12.723604]  [0000000000000000]           (null)
[   12.782988] ---[ end trace 0d4c52020aafc2d4 ]---
[   12.841032] esp f006c230: esp0: regs[(____ptrval____):(____ptrval____)] irq[10]
[   12.930780] esp f006c230: esp0: is a FASHME, 40 MHz (ccf=0), SCSI ID 7
[   16.097212] scsi host0: esp
[   16.135602] scsi 0:0:0:0: Direct-Access     FUJITSU  MAP3367N SUN36G  0401 PQ: 0 ANSI: 4
[   16.235036] scsi target0:0:0: Beginning Domain Validation
[   16.307457] scsi target0:0:0: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 15)
[   16.399928] scsi target0:0:0: Domain Validation skipping write tests
[   16.478336] scsi target0:0:0: Ending Domain Validation
[   17.721196] scsi 0:0:6:0: CD-ROM            NEC      CD-ROM DRIVE:463 1.05 PQ: 0 ANSI: 2
[   17.820629] scsi target0:0:6: Beginning Domain Validation
[   17.891527] scsi target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[   17.979824] scsi target0:0:6: Domain Validation skipping write tests
[   18.058282] scsi target0:0:6: Ending Domain Validation
[   20.000261] sd 0:0:0:0: Power-on or device reset occurred
[   20.067471] mousedev: PS/2 mouse device common for all mice
[   20.138372] rtc-m48t59 rtc-m48t59.0: registered as rtc0
[   20.204324] NET: Registered protocol family 17
[   20.255650] sd 0:0:0:0: [sda] 71132959 512-byte logical blocks: (36.4 GB/33.9 GiB)
[   20.259821] Key type dns_resolver registered
[   20.407848] rtc-m48t59 rtc-m48t59.0: setting system clock to 2018-08-27 18:49:51 UTC (1535395791)
[   20.516793] sd 0:0:0:0: [sda] Write Protect is off
[   20.576704] sd 0:0:0:0: [sda] Mode Sense: b3 00 00 08
[   20.641255] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[   20.769811]  sda: sda1 sda2 sda3 sda4
[   20.823985] sd 0:0:0:0: [sda] Attached SCSI disk
[   21.218313] input: Sun Mouse as /devices/root/f005abc8/f005c9b8/serio1/input/input1
[   21.325293] random: fast init done
[   21.396507] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   21.490805] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
[   21.596389] devtmpfs: mounted
[   21.635446] This architecture does not have kernel memory protection.
[   21.715165] Run /sbin/init as init process
[   24.104249] random: udevd: uninitialized urandom read (16 bytes read)
[   24.188187] random: udevd: uninitialized urandom read (16 bytes read)
[   24.269361] random: udevd: uninitialized urandom read (16 bytes read)
[   24.838696] flash f005b268: DMA mask not set
[   24.892363] /sbus@1f,0/flashprom@f,0: OBP Flash, RD 1fff0000000[80000] WR 1fff1380000[80000]
[   25.029284] hme f007280c: DMA mask not set
[   25.082398] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
[   25.173398] ------------[ cut here ]------------
[   25.231068] WARNING: CPU: 0 PID: 594 at ./include/linux/dma-mapping.h:516 happy_meal_sbus_probe_one+0x7a8/0x8c0 [sunhme]
[   25.363817] Modules linked in: sunhme(+) soundcore flash
[   25.429833] CPU: 0 PID: 594 Comm: udevd Tainted: G        W         4.18.0-12952-g2923b27-dirty #239
[   25.541685] Call Trace:
[   25.573303]  [0000000000457af0] __warn+0xb0/0xe0
[   25.631011]  [0000000010012828] happy_meal_sbus_probe_one+0x7a8/0x8c0 [sunhme]
[   25.720023]  [00000000006f07cc] platform_drv_probe+0x2c/0xa0
[   25.790310]  [00000000006ee9fc] really_probe+0x19c/0x2e0
[   25.856351]  [00000000006eef10] driver_probe_device+0x50/0x100
[   25.928639]  [00000000006ef0b4] __driver_attach+0xf4/0x120
[   25.996762]  [00000000006ecbc4] bus_for_each_dev+0x44/0x80
[   26.064887]  [00000000006edc18] bus_add_driver+0x198/0x220
[   26.133128]  [00000000006efb10] driver_register+0x70/0x120
[   26.201344]  [0000000010018010] happy_meal_probe+0x10/0xc0 [sunhme]
[   26.278959]  [0000000000427310] do_one_initcall+0x30/0x180
[   26.347181]  [00000000004cb4e8] do_init_module+0x4c/0x1c4
[   26.414307]  [00000000004ca428] load_module+0x11c8/0x1260
[   26.481388]  [00000000004ca634] sys_finit_module+0x74/0xa0
[   26.549474]  [00000000004061b4] linux_sparc_syscall32+0x34/0x60
[   26.622824] ---[ end trace 0d4c52020aafc2d6 ]---
[   26.682802] eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 
[   26.682813] 08:00:20:89:2a:a0
[   26.787983] hme f007a418: DMA mask not set
[   26.847151] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   26.910437] eth1: Quattro HME slot 0 (SBUS) 10/100baseT Ethernet 
[   26.913242] 08:00:20:cc:93:40
[   27.028194] hme f00803cc: DMA mask not set
[   27.082052] eth2: Quattro HME slot 1 (SBUS) 10/100baseT Ethernet 
[   27.082063] 08:00:20:cc:93:41
[   27.190917] bpp f007a25c: DMA mask not set
[   27.195172] hme f00862a8: DMA mask not set
[   27.293628] parport0: sunbpp at 0x1ffec800000
[   27.300035] eth3: Quattro HME slot 2 (SBUS) 10/100baseT Ethernet 
[   27.352282] 08:00:20:cc:93:42
[   27.465580] hme f008c9c4: DMA mask not set
[   27.520730] eth4: Quattro HME slot 3 (SBUS) 10/100baseT Ethernet 
[   27.520740] 08:00:20:cc:93:43
[   27.642120] scsi 0:0:6:0: Attached scsi generic sg1 type 5
[   27.711314] sr 0:0:6:0: Power-on or device reset occurred
[   27.784509] sr 0:0:6:0: [sr0] scsi-1 drive
[   27.837306] cdrom: Uniform CD-ROM driver Revision: 3.20
[   27.914630] audio f005b0cc: DMA mask not set
[   27.980828] sr 0:0:6:0: Attached scsi CD-ROM sr0
[   28.158845] ------------[ cut here ]------------
[   28.216326] WARNING: CPU: 1 PID: 580 at ./include/linux/dma-mapping.h:516 snd_dma_alloc_pages+0x180/0x1a0 [snd_pcm]
[   28.343408] Modules linked in: snd_sun_cs4231(+) sr_mod cdrom parport_sunbpp snd_pcm evdev parport snd_timer sg snd sunhme soundcore flash
[   28.494661] CPU: 1 PID: 580 Comm: udevd Tainted: G        W         4.18.0-12952-g2923b27-dirty #239
[   28.606119] Call Trace:
[   28.637303]  [0000000000457af0] __warn+0xb0/0xe0
[   28.694687]  [00000000100a91a0] snd_dma_alloc_pages+0x180/0x1a0 [snd_pcm]
[   28.778220]  [00000000100a8918] snd_pcm_lib_preallocate_pages1+0x118/0x1a0 [snd_pcm]
[   28.873222]  [00000000100a89d8] snd_pcm_lib_preallocate_pages_for_all+0x38/0x80 [snd_pcm]
[   28.973388]  [00000000100dbf18] cs4231_probe+0x678/0x820 [snd_sun_cs4231]
[   29.056744]  [00000000006f07cc] platform_drv_probe+0x2c/0xa0
[   29.126586]  [00000000006ee9fc] really_probe+0x19c/0x2e0
[   29.192167]  [00000000006eef10] driver_probe_device+0x50/0x100
[   29.263973]  [00000000006ef0b4] __driver_attach+0xf4/0x120
[   29.331480]  [00000000006ecbc4] bus_for_each_dev+0x44/0x80
[   29.398927]  [00000000006edc18] bus_add_driver+0x198/0x220
[   29.466364]  [00000000006efb10] driver_register+0x70/0x120
[   29.533766]  [0000000000427310] do_one_initcall+0x30/0x180
[   29.601227]  [00000000004cb4e8] do_init_module+0x4c/0x1c4
[   29.667536]  [00000000004ca428] load_module+0x11c8/0x1260
[   29.733883]  [00000000004ca634] sys_finit_module+0x74/0xa0
[   29.801342] ---[ end trace 0d4c52020aafc2d7 ]---
[   31.012131] random: crng init done
[   31.054663] random: 1 urandom warning(s) missed due to ratelimiting
[   31.441800] Adding 722912k swap on /dev/sda4.  Priority:-2 extents:1 across:722912k 
[   31.720740] EXT4-fs (sda2): re-mounted. Opts: (null)
[   32.176380] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[   34.126095] loop: module loaded
[   34.679947] EXT4-fs (sda1): mounting ext2 file system using the ext4 subsystem
[   34.788477] EXT4-fs (sda1): mounted filesystem without journal. Opts: (null)
[   37.302565] NET: Registered protocol family 10
[   37.362653] Segment Routing with IPv6
[   41.620058] eth0: Link is up using 
[   41.620074] internal 
[   41.663868] transceiver at 
[   41.692882] 100Mb/s, Full Duplex.

-- 
Meelis Roos (mroos@linux.ee)

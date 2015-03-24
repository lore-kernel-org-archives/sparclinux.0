From: Meelis Roos <mroos@linux.ee>
Date: Tue, 24 Mar 2015 08:44:52 +0000
Subject: Ultra1 warning in 4.0.0-rc4-00048-gc586165
Message-Id: <alpine.LRH.2.11.1503241040040.9652@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Just started to compile todays git with memmove fixes on many sparcs and 
got the following warning on Ultra 1 during git or make:

[435962.279707] BUG: Bad rss-counter state mm:fffff800322b72e0 idx:0 val:7
[435962.357276] BUG: non-zero nr_ptes on freeing mm: 1

This is the first time I remember having seen this. After boot into 
4.0.0-rc4-00048-gc586165 I performed only debian upgrade and that was 
fine. No load since then.

Full dmesg:

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.35.0 2004/04/19 12:15'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 4.0.0-rc4-00048-gc586165 (mroos@melon) (gcc version 4.9.2 (Debian 4.9.2-10) ) #68 Wed Mar 18 23:32:55 EET 2015
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:9f:6b:e4
[    0.000000] MM: PAGE_OFFSET is 0xfffff80000000000 (max_phys_bits = 40)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000060000000000]
[    0.000000] MM: VMEMMAP [0x0000060000000000 --> 0x00000c0000000000]
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /sbus@1f,0/zs@f,1100000:a
[    0.000000] PROM: Built device tree with 52336 bytes of memory.
[    0.000000] Top of RAM: 0x33f50000, Total RAM: 0x33f3e000
[    0.000000] Memory hole size: 0MB
[    0.000000] Allocated 16384 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000000000000-0x0000000033f4ffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000033efdfff]
[    0.000000]   node   0: [mem 0x0000000033f00000-0x0000000033f2bfff]
[    0.000000]   node   0: [mem 0x0000000033f3c000-0x0000000033f4ffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x0000000033f4ffff]
[    0.000000] On node 0 totalpages: 106399
[    0.000000]   Normal zone: 832 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 106399 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
[    0.000000] CPU CAPS: [vis]
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 105567
[    0.000000] Kernel command line: root=/dev/sda2 ro scsi_mod.use_blk_mq=1
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 835968K/851192K available (3508K kernel code, 232K rwdata, 856K rodata, 152K init, 399K bss, 15224K reserved, 0K cma-reserved)
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[   56.943784] clocksource: mult[6fe6a98] shift[24]
[   56.998540] clockevent: mult[249a9110] shift[32]
[   57.054566] Console: colour dummy device 80x25
[   57.106957] console [tty0] enabled
[   57.147540] bootconsole [earlyprom0] disabled
[   57.349810] Calibrating delay using timer specific routine.. 286.85 BogoMIPS (lpj34273)
[   57.349906] pid_max: default: 32768 minimum: 301
[   57.350626] Mount-cache hash table entries: 2048 (order: 1, 16384 bytes)
[   57.350715] Mountpoint-cache hash table entries: 2048 (order: 1, 16384 bytes)
[   57.353820] Initializing cgroup subsys blkio
[   57.353931] Initializing cgroup subsys net_cls
[   57.358492] devtmpfs: initialized
[   57.372548] NET: Registered protocol family 16
[   57.393363] SYSIO: UPA portID ffffffff, at 000001fe00000000
[   57.458504] SCSI subsystem initialized
[   57.462843] /sbus@1f,0/eeprom@f,1200000: Mostek regs at 0x1fff1200000
[   57.464701] AUXIO: Found device at /sbus@1f,0/auxio@f,1900000
[   57.465026] Switched to clocksource tick
[   57.540921] NET: Registered protocol family 2
[   57.544039] TCP established hash table entries: 8192 (order: 3, 65536 bytes)
[   57.544565] TCP bind hash table entries: 8192 (order: 3, 65536 bytes)
[   57.545115] TCP: Hash tables configured (established 8192 bind 8192)
[   57.545686] TCP: reno registered
[   57.545770] UDP hash table entries: 512 (order: 1, 16384 bytes)
[   57.545955] UDP-Lite hash table entries: 512 (order: 1, 16384 bytes)
[   57.546884] NET: Registered protocol family 1
[   57.553608] futex hash table entries: 256 (order: -1, 6144 bytes)
[   57.553930] audit: initializing netlink subsys (disabled)
[   57.554298] audit: type 00 audit(0.370:1): initialized
[   57.558452] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[   57.565919] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[   57.566125] io scheduler noop registered
[   57.566246] io scheduler deadline registered
[   57.566517] io scheduler cfq registered (default)
[   57.570001] f005a290: ttyS0 at MMIO 0x1fff1100000 (irq = 9, base_baud = 307200) is a zs
[   57.570186] Console: ttyS0 (SunZilog zs0)
[   62.263936] console [ttyS0] enabled
[   62.308210] f005a290: ttyS1 at MMIO 0x1fff1100004 (irq = 9, base_baud = 307200) is a zs
[   62.404104] f005b730: Keyboard at MMIO 0x1fff1000000 (irq = 9) is a zs
[   62.480413] f005b730: Mouse at MMIO 0x1fff1000004 (irq = 9) is a zs
[   62.560901] esp f0062a74: esp0: regs[1ffe8800000:1ffe8400000] irq[10]
[   62.636210] esp f0062a74: esp0: is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
[   65.725797] scsi host0: esp
[   65.761256] scsi 0:0:0:0: Direct-Access     MAXTOR   ATLAS10K4_36SCA  DFV0 PQ: 0 ANSI: 3
[   65.856479] scsi target0:0:0: Beginning Domain Validation
[   65.922840] esp f00735ac: esp1: regs[1ff08810000:1ff08800000] irq[14]
[   65.998111] esp f00735ac: esp1: is a FASHME, 40 MHz (ccf=0), SCSI ID 7
[   66.078317] scsi target0:0:0: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
[   66.161287] scsi target0:0:0: Domain Validation skipping write tests
[   66.235935] scsi target0:0:0: Ending Domain Validation
[   67.475014] scsi 0:0:6:0: CD-ROM            TOSHIBA  XM-5401TASUN4XCD 2565 PQ: 0 ANSI: 2
[   67.570259] scsi target0:0:6: Beginning Domain Validation
[   67.648795] scsi target0:0:6: FAST-5 SCSI 4.2 MB/s ST (236 ns, offset 15)
[   67.735942] scsi target0:0:6: Domain Validation skipping write tests
[   67.810155] scsi target0:0:6: Ending Domain Validation
[   69.085904] scsi host1: esp
[   69.123165] sd 0:0:0:0: [sda] 71833096 512-byte logical blocks: (36.7 GB/34.2 GiB)
[   69.215628] mousedev: PS/2 mouse device common for all mice
[   69.285689] rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
[   69.366109] TCP: cubic registered
[   69.403873] NET: Registered protocol family 17
[   69.457181] Key type dns_resolver registered
[   69.511375] sd 0:0:0:0: [sda] Write Protect is off
[   69.566937] sd 0:0:0:0: [sda] Mode Sense: ed 00 10 08
[   69.569089] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   69.674549] rtc-m48t59 rtc-m48t59.0: setting system clock to 2015-03-19 07:33:06 UTC (1426750386)
[   69.794636]  sda: sda1 sda2 sda3 sda4
[   69.847126] sd 0:0:0:0: [sda] Attached SCSI disk
[   70.276859] input: Sun Mouse as /devices/root/f0059940/f005b730/serio1/input/input1
[   72.831332] EXT4-fs (sda2): mounting ext3 file system using the ext4 subsystem
[   72.953697] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   73.043765] VFS: Mounted root (ext3 filesystem) readonly on device 8:2.
[   73.162036] devtmpfs: mounted
[   76.838997] systemd-udevd[430]: starting version 215
[   77.184809] random: udevd urandom read with 50 bits of entropy available
[   78.252814] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   78.330173] sr 0:0:6:0: [sr0] scsi-1 drive
[   78.377338] cdrom: Uniform CD-ROM driver Revision: 3.20
[   78.736436] sr 0:0:6:0: Attached scsi generic sg1 type 5
[   78.965701] sr 0:0:6:0: Attached scsi CD-ROM sr0
[   82.416022] Adding 360440k swap on /dev/sda4.  Priority:-1 extents:1 across:360440k 
[   82.788875] EXT4-fs (sda2): re-mounted. Opts: (null)
[   83.457973] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[   86.898222] NET: Registered protocol family 10
[   87.140412] sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
[   87.230806] eth0: HAPPY MEAL (SBUS) 10/100baseT Ethernet 08:00:20:9f:6b:e4
[   87.477278] sunlance.c:v2.02 8/24/03 Miguel de Icaza (miguel@nuclecu.unam.mx)
[   87.561510] SunLance: using auto-carrier-detection.
[   87.622235] eth1: LANCE 08:00:20:9f:6b:e4
[   87.839352] qlogicpti0: IRQ 15 SCSI ID 7 (Firmware v1.31.32)(FCode 1.21 95/05/18)
qlogicpti0: [Fast Wide, using single ended interface]
[   88.369234] scsi host2: PTI Qlogic,ISP SBUS SCSI irq 15 regs at 000001ff10010000
[   88.492073] scsi 2:0:0:0: Medium Changer    ADIC     FastStor 2       G12r PQ: 0 ANSI: 2
[   89.617884] scsi 2:0:5:0: Sequential-Access HP       Ultrium 2-SCSI   F53A PQ: 0 ANSI: 3
[   92.030924] scsi 2:0:0:0: Attached scsi generic sg2 type 8
[   92.114193] SCSI Media Changer driver v0.25 
[   92.176225] scsi 2:0:5:0: Attached scsi generic sg3 type 1
[   92.293939] st: Version 20101219, fixed bufsize 32768, s/g segs 256
[   92.466422] parport0: sunbpp at 0x1ffec800000
[   92.519371] ch 2:0:0:0: [ch0] type #1 (mt): 0x56+1 [medium transport]
[   92.594714] ch 2:0:0:0: [ch0] type #2 (st): 0x1+8 [storage]
[   92.661329] ch 2:0:0:0: [ch0] type #3 (ie): 0x0+0 [import/export]
[   92.734245] ch 2:0:0:0: [ch0] type #4 (dt): 0x52+1 [data transfer]
[   93.181096] ch 2:0:0:0: [ch0] dt 0x52: 
[   93.225180] ch 2:0:0:0: [ch0] ID 5, LUN 0, 
[   93.275135] ch 2:0:0:0: [ch0] name: HP       Ultrium 2-SCSI   F53A
[   93.349101] ch 2:0:0:0: [ch0] INITIALIZE ELEMENT STATUS, may take some time ...
[   94.323186] EXT4-fs (sda1): mounting ext3 file system using the ext4 subsystem
[   94.425735] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[   95.960982] random: nonblocking pool is initialized
[  115.858170] ch 2:0:0:0: [ch0] ... finished
[  115.905318] ch 2:0:0:0: Attached scsi changer ch0
[  115.985269] st 2:0:5:0: Attached scsi tape st0
[  116.036625] st 2:0:5:0: st0: try direct i/o: yes (alignment 4 B)
[  116.174279] osst :I: Tape driver with OnStream support version 0.99.4
osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
[  121.268097] eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
[435962.279707] BUG: Bad rss-counter state mm:fffff800322b72e0 idx:0 val:7
[435962.357276] BUG: non-zero nr_ptes on freeing mm: 1

-- 
Meelis Roos (mroos@linux.ee)

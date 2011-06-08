From: Meelis Roos <mroos@linux.ee>
Date: Wed, 08 Jun 2011 12:02:36 +0000
Subject: RTC problem on Netra X1?
Message-Id: <alpine.SOC.1.00.1106081454240.8911@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I noticed the clock was wrong on my Netra T1 (running 3.0.0-rc2 and 
not having ntp and ntpdate installed). Installing ntp, ntpdate and 
updating the clock with ntpdate worked. But reboot did not set the 
correct time and hwclock also fails:

# hwclock --systohc
Timed out waiting for time change.

Dmesg finds both OF RTC and PC RTC but later complains
"No RTC device found, ALARM timers will not wake from suspend"

Same hwclock error happens on Fire V100 that is quite similar to Netra 
X1. The same RTC-s are found there. Howevere, the V100 has its clock 
correct - it has been running NTP for a long time.

Kernel config has selected all possible RTC-s for sparc64 so I probably 
have not made a mistake there.

Full dmesg from X1:

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.0.9 2001/05/17 21:52'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 3.0.0-rc2 (mroos@deegu) (gcc version 4.4.6 (Debian 4.4.6-3) ) #154 Tue Jun 7 17:04:37 EEST 2011
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:0c:06:cd
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1f,0/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 46351 bytes of memory.
[    0.000000] Top of RAM: 0x6fec8000, Total RAM: 0x3fe36000
[    0.000000] Memory hole size: 768MB
[    0.000000] [0000010000000000-fffff80000400000] page_structs1072 node=0 entry=0/8192
[    0.000000] [0000010000000000-fffff80000800000] page_structs1072 node=0 entry=1/8192
[    0.000000] [0000010000800000-fffff80000c00000] page_structs1072 node=0 entry=2/8192
[    0.000000] [0000010000800000-fffff80001000000] page_structs1072 node=0 entry=3/8192
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x00037f64
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[7] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00008000
[    0.000000]     0: 0x00010000 -> 0x00018000
[    0.000000]     0: 0x00020000 -> 0x00028000
[    0.000000]     0: 0x00030000 -> 0x000377ff
[    0.000000]     0: 0x00037800 -> 0x00037f00
[    0.000000]     0: 0x00037f40 -> 0x00037f58
[    0.000000]     0: 0x00037f60 -> 0x00037f64
[    0.000000] On node 0 totalpages: 130843
[    0.000000]   Normal zone: 1791 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 129052 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129052
[    0.000000] Kernel command line: root=/dev/sda2 ro debug ignore_logelevl
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
[    0.000000] Memory: 1023616k available (3016k kernel code, 1384k data, 152k init) [fffff80000000000,000000006fec8000]
[    0.000000] SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] NR_IRQS:255
[    0.000000] clocksource: mult[b400012e] shift[24]
[    0.000000] clockevent: mult[16c16bf] shift[32]
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled, bootconsole disabled
[   51.943122] calibrate_delay_direct() timer_rate_maxU651 timer_rate_minU529 pre_start(8517182 pre_end(8572772
[   51.973136] calibrate_delay_direct() timer_rate_maxU646 timer_rate_minU524 pre_start(8683947 pre_end(8739532
[   52.003153] calibrate_delay_direct() timer_rate_maxU645 timer_rate_minU524 pre_start(8850708 pre_end(8906293
[   52.033170] calibrate_delay_direct() timer_rate_maxU645 timer_rate_minU524 pre_start(9017471 pre_end(9073055
[   52.063187] calibrate_delay_direct() timer_rate_maxU644 timer_rate_minU524 pre_start(9184234 pre_end(9239818
[   52.063219] Calibrating delay using timer specific routine.. 11.12 BogoMIPS (lpjU646)
[   52.063253] pid_max: default: 32768 minimum: 301
[   52.063462] Security Framework initialized
[   52.063560] Mount-cache hash table entries: 512
[   52.066429] kworker/u:0 used greatest stack depth: 13096 bytes left
[   52.067255] NET: Registered protocol family 16
[   52.071735] kworker/u:0 used greatest stack depth: 12240 bytes left
[   52.091278] /pci@1f,0: PCI IO[1fe02000000] MEM[1ff00000000]
[   52.091349] /pci@1f,0: SABRE PCI Bus Module ver[0:0]
[   52.091372] PCI: Scanning PBM /pci@1f,0
[   52.092290] pci 0000:00:03.0: quirk: [io  0x1fe02002000-0x1fe0200203f] claimed by ali7101 ACPI
[   52.092334] pci 0000:00:03.0: quirk: [io  0x1fe02004000-0x1fe0200401f] claimed by ali7101 SMB
[   52.092491] pci 0000:00:0c.0: PME# supported from D3hot D3cold
[   52.092538] pci 0000:00:0c.0: PME# disabled
[   52.092651] pci 0000:00:05.0: PME# supported from D3hot D3cold
[   52.092694] pci 0000:00:05.0: PME# disabled
[   52.113426] kworker/u:0 used greatest stack depth: 11288 bytes left
[   52.115203] bio: create slab <bio-0> at 0
[   52.116569] vgaarb: loaded
[   52.117876] SCSI subsystem initialized
[   52.118978] libata version 3.00 loaded.
[   52.120899] /pci@1f,0/isa@7/rtc@0,70: RTC regs at 0x1fe02000070
[   52.123073] Switching to clocksource hbtick
[   52.123385] Switched to NOHz mode on CPU #0
[   52.133705] kworker/u:0 used greatest stack depth: 11232 bytes left
[   52.152699] NET: Registered protocol family 2
[   52.152962] IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
[   52.153829] TCP established hash table entries: 32768 (order: 6, 524288 bytes)
[   52.156430] TCP bind hash table entries: 32768 (order: 5, 262144 bytes)
[   52.157855] TCP: Hash tables configured (established 32768 bind 32768)
[   52.157925] TCP reno registered
[   52.157990] UDP hash table entries: 512 (order: 1, 16384 bytes)
[   52.158126] UDP-Lite hash table entries: 512 (order: 1, 16384 bytes)
[   52.158741] NET: Registered protocol family 1
[   52.158848] pci 0000:00:07.0: Activating ISA DMA hang workarounds
[   52.158931] PCI: CLS 0 bytes, default 64
[   52.159184] power: Control reg at 1fe02002000
[   52.210168] VFS: Disk quotas dquot_6.5.2
[   52.210788] Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[   52.216821] msgmni has been set to 1999
[   52.219009] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[   52.219089] io scheduler noop registered
[   52.219730] io scheduler cfq registered (default)
[   52.220793] f0076704: ttyS0 at MMIO 0x1fe020003f8 (irq = 7) is a 16550A
[   52.220852] Console: ttyS0 (SU)
[   59.250378] console [ttyS0] enabled
[   59.296965] f00783f0: ttyS1 at MMIO 0x1fe020002e8 (irq = 7) is a 16550A
[   59.385652] PCI: Enabling device: (0000:00:0d.0), cmd 5
[   59.457916] scsi0 : pata_ali
[   59.496840] scsi1 : pata_ali
[   59.535385] ata1: PATA max UDMA/66 cmd 0x1fe02010200 ctl 0x1fe02010218 bmdma 0x1fe02010220 irq 12
[   59.652120] ata2: PATA max UDMA/66 cmd 0x1fe02010210 ctl 0x1fe02010208 bmdma 0x1fe02010228 irq 12
[   59.769693] Linux Tulip driver version 1.1.15-NAPI (Feb 27, 2007)
[   59.852588] tulip0: Old style EEPROM with no media selection information
[   59.940996] tulip0:  MII transceiver #1 config 1000 status 782d advertising 01e1
[   60.041794] net eth0: Davicom DM9102/DM9102A rev 49 at MMIO 0x1ff00000000, EEPROM not present, 00:03:ba:0c:06:cd, IRQ 9
[   60.186504] tulip1: Old style EEPROM with no media selection information
[   60.274837] tulip1:  MII transceiver #1 config 1000 status 7809 advertising 01e1
[   60.375502] ata1.00: ATA-7: SAMSUNG SP1213N, TL100-30, max UDMA/100
[   60.457888] ata1.00: 234493056 sectors, multi 16: LBA48 
[   60.528351] net eth1: Davicom DM9102/DM9102A rev 49 at MMIO 0x1ff00002000, EEPROM not present, 00:03:ba:0c:06:ce, IRQ 10
[   60.671989] ata1.00: configured for UDMA/66
[   60.727570] scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG SP1213N  TL10 PQ: 0 ANSI: 5
[   60.834351] console [netcon0] enabled
[   60.882436] netconsole: network logging started
[   60.942549] mousedev: PS/2 mouse device common for all mice
[   61.017565] sd 0:0:0:0: [sda] 234493056 512-byte logical blocks: (120 GB/111 GiB)
[   61.117922] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[   61.201486] rtc0: no alarms, 114 bytes nvram
[   61.258435] sd 0:0:0:0: [sda] Write Protect is off
[   61.321362] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   61.401335] TCP cubic registered
[   61.443773] NET: Registered protocol family 17
[   61.502158] Registering the dns_resolver key type
[   61.565217] No RTC device found, ALARM timers will not wake from suspend
[   61.651062] registered taskstats version 1
[   61.707542] rtc_cmos rtc_cmos: setting system clock to 2011-06-08 09:02:24 UTC (1307523744)
[   61.818021] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   61.945512]  sda: sda1 sda2 sda3 sda4 sda5
[   62.002440] sd 0:0:0:0: [sda] Attached SCSI disk
[   62.090933] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   62.191752] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
[   62.753673] modprobe used greatest stack depth: 9912 bytes left
[   63.075376] startpar used greatest stack depth: 9344 bytes left
[   63.729774] mv used greatest stack depth: 32 bytes left
[   64.666246] alim7101_wdt: Steve Hill <steve@navaho.co.uk>.
[   64.738558] alim7101_wdt: Detected old alim7101 revision 'a1d'.  If this is a cobalt board, set the 'use_gpio' module parameter.
[   64.932126] usbcore: registered new interface driver usbfs
[   65.004519] usbcore: registered new interface driver hub
[   65.086412] usbcore: registered new device driver usb
[   65.645605] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   65.726855] ohci_hcd: block sizes: ed 80 td 96
[   65.785299] PCI: Enabling device: (0000:00:0a.0), cmd 2
[   65.854011] ohci_hcd 0000:00:0a.0: OHCI Host Controller
[   65.922735] drivers/usb/core/inode.c: creating file 'devices'
[   65.998213] drivers/usb/core/inode.c: creating file '001'
[   66.069176] ohci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 1
[   66.166536] ohci_hcd 0000:00:0a.0: created debug files
[   66.234122] ohci_hcd 0000:00:0a.0: irq 11, io mem 0x1ff01000000
[   66.313215] alim7101_wdt: Steve Hill <steve@navaho.co.uk>.
[   66.385405] alim7101_wdt: Detected old alim7101 revision 'a1d'.  If this is a cobalt board, set the 'use_gpio' module parameter.
[   66.547624] ohci_hcd 0000:00:0a.0: enabling initreset quirk
[   66.624697] ohci_hcd 0000:00:0a.0: OHCI controller state
[   66.694566] ohci_hcd 0000:00:0a.0: OHCI 1.0, NO legacy support registers
[   66.782715] ohci_hcd 0000:00:0a.0: control 0x083 HCFS=operational CBSR=3
[   66.870811] ohci_hcd 0000:00:0a.0: cmdstatus 0x00000 SOC=0
[   66.942927] ohci_hcd 0000:00:0a.0: intrstatus 0x00000044 RHSC SF
[   67.021895] ohci_hcd 0000:00:0a.0: intrenable 0x8000000a MIE RD WDH
[   67.104288] ohci_hcd 0000:00:0a.0: hcca frame #01e4
[   67.168398] ohci_hcd 0000:00:0a.0: roothub.a 02000202 POTPGT=2 NPS NDP=2(2)
[   67.259947] ohci_hcd 0000:00:0a.0: roothub.b 00000000 PPCM 00 DR 00
[   67.346908] ohci_hcd 0000:00:0a.0: roothub.status 00008000 DRWE
[   67.424737] ohci_hcd 0000:00:0a.0: roothub.portstatus [0] 0x00000100 PPS
[   67.512856] ohci_hcd 0000:00:0a.0: roothub.portstatus [1] 0x00000100 PPS
[   67.601039] usb usb1: default language 0x0409
[   67.658242] usb usb1: udev 1, busnum 1, minor = 0
[   67.720041] usb usb1: New USB device found, idVendor6b, idProduct 01
[   67.809293] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   67.904281] usb usb1: Product: OHCI Host Controller
[   67.968373] usb usb1: Manufacturer: Linux 3.0.0-rc2 ohci_hcd
[   68.042765] usb usb1: SerialNumber: 0000:00:0a.0
[   68.103815] usb usb1: usb_probe_device
[   68.153029] usb usb1: configuration #1 chosen from 1 choice
[   68.226310] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[   68.301937] hub 1-0:1.0: usb_probe_interface
[   68.358020] hub 1-0:1.0: usb_probe_interface - got id
[   68.424413] hub 1-0:1.0: USB hub found
[   68.473691] hub 1-0:1.0: 2 ports detected
[   68.526346] hub 1-0:1.0: standalone hub
[   68.576738] hub 1-0:1.0: no power switching (usb 1.0)
[   68.643146] hub 1-0:1.0: global over-current protection
[   68.711824] hub 1-0:1.0: power on to power good time: 4ms
[   68.782801] hub 1-0:1.0: local power source is good
[   68.846900] hub 1-0:1.0: no over-current condition exists
[   68.917869] hub 1-0:1.0: trying to enable port power on non-switchable hub
[   69.008434] drivers/usb/core/inode.c: creating file '001'
[   69.103610] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[   71.761298] Adding 2996112k swap on /dev/sda4.  Priority:-1 extents:1 across:2996112k 
[   71.897202] EXT4-fs (sda2): re-mounted. Opts: (null)
[   72.320747] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[   74.211431] loop: module loaded
[   75.997999] EXT3-fs: barriers not enabled
[   76.058469] kjournald starting.  Commit interval 5 seconds
[   76.130879] EXT3-fs (sda1): using internal journal
[   76.193847] EXT3-fs (sda1): mounted filesystem with writeback data mode
[   76.443301] EXT4-fs (sda5): mounted filesystem with ordered data mode. Opts: (null)
[   77.552629] startpar used greatest stack depth: 8 bytes left
[   79.349340] NET: Registered protocol family 10
[   89.803155] eth0: no IPv6 routers present

-- 
Meelis Roos (mroos@linux.ee)

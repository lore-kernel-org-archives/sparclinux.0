From: =?ISO-8859-1?Q?S=E9bastien_Bernard?= <sbernard@nerim.net>
Date: Tue, 05 Jun 2012 13:52:11 +0000
Subject: Kernel panic on V240 while compiling kernel 3.4.
Message-Id: <4FCE0F0B.7010903@nerim.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060105090707090907030302"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------060105090707090907030302
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
I got today two kernel panic in a row on a 2xV240 with 4go RAM.
Twice the same. This machine is completely headless.
I joined the dmesg log.
Here's the extract :
[ 3844.604607] ERROR(0): Cheetah error trap taken afsr[0010100000000000] 
afar[0000000040000000] TL1(0)
[ 3844.604624] ERROR(0): TPC[407bd0] TNPC[407bd4] O7[448c84] 
TSTATE[411e01602]
[ 3844.604631] ERROR(0): TPC<copy_tsb+0x30/0x80>
[ 3844.604652] ERROR(0): M_SYND(0),  E_SYND(0), Privileged
[ 3844.604661] ERROR(0): Highest priority error (0000100000000000) 
"Unmapped error from system bus"
[ 3844.604671] ERROR(0): D-cache idx[0] tag[0000000000000000] 
utag[0000000000000000] stag[0000000000000000]
[ 3844.604681] ERROR(0): D-cache data0[0000000000000000] 
data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
[ 3844.604692] ERROR(0): I-cache idx[0] tag[0000000000000000] 
utag[0000000000000000] stag[0000000000000000] u[0000000000000000] 
l[0000000000000000]
[ 3844.604703] ERROR(0): I-cache INSN0[0000000000000000] 
INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
[ 3844.604714] ERROR(0): I-cache INSN4[0000000000000000] 
INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
[ 3844.604723] ERROR(0): E-cache idx[40000000] tag[000000001e040efd]
[ 3844.604731] ERROR(0): E-cache data0[00000000000001c0] 
data1[80000003385a0fb2] data2[00000000000001c0] data3[8000000334834fb2]
[ 3844.604743] Kernel panic - not syncing: Irrecoverable deferred error 
trap.
[ 3844.604747]
[ 3844.714568] Call Trace:
[ 3844.746602]  [0000000000428e28] cheetah_deferred_handler+0x32c/0x364
[ 3844.830097]  [0000000000405e50] c_deferred+0x18/0x24
[ 3844.895282]  [0000000000407bd0] copy_tsb+0x30/0x80
[ 3844.958196]  [0000000000793ef8] do_sparc64_fault+0x5a8/0x798
[ 3845.032533]  [00000000004079c8] sparc64_realfault_common+0x10/0x20
[ 3845.113759] Press Stop-A (L1-A) to return to the boot prom

I'll tell if the 3.4 has the same problem or not.



--------------060105090707090907030302
Content-Type: text/plain; charset=UTF-8;
 name="kernel.panic.v240.050602012"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="kernel.panic.v240.050602012"

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.22.33 2007/06/18 12:45'
[    0.000000] PROMLIB: Root node compatible:
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.2.0-2-sparc64-smp (Debian 3.2.19-1) (debian-kernel@lists.debian.org) (gcc version 4.6.3 (Debian 4.6.3-5) ) #1 SMP Sat Jun 2 02:13:51 UTC 2012
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:83:a3:0d
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1e,600000/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 80248 bytes of memory.
[    0.000000] Top of RAM: 0x103feee000, Total RAM: 0xffea2000
[    0.000000] Memory hole size: 62464MB
[    0.000000] [0000010000000000-fffff80000400000] page_structs=131072 node=0 entry=0/8192
[    0.000000] [0000010000000000-fffff80000800000] page_structs=131072 node=0 entry=1/8192
[    0.000000] [0000010004000000-fffff80000c00000] page_structs=131072 node=0 entry=16/8192
[    0.000000] [0000010004000000-fffff80001000000] page_structs=131072 node=0 entry=17/8192
[    0.000000] [0000010006000000-fffff80001400000] page_structs=131072 node=0 entry=24/8192
[    0.000000] [0000010006000000-fffff80001800000] page_structs=131072 node=0 entry=25/8192
[    0.000000] [0000010020000000-fffff80001c00000] page_structs=131072 node=0 entry=128/8192
[    0.000000] [0000010020000000-fffff80002000000] page_structs=131072 node=0 entry=129/8192
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x0081ff77
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[8] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00020000
[    0.000000]     0: 0x00100000 -> 0x00120000
[    0.000000]     0: 0x00180000 -> 0x001a0000
[    0.000000]     0: 0x00800000 -> 0x0081f7ff
[    0.000000]     0: 0x0081f800 -> 0x0081ff45
[    0.000000]     0: 0x0081ff48 -> 0x0081ff50
[    0.000000]     0: 0x0081ff70 -> 0x0081ff74
[    0.000000]     0: 0x0081ff76 -> 0x0081ff77
[    0.000000] On node 0 totalpages: 524113
[    0.000000]   Normal zone: 66559 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 457554 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,ultra3,mul32,div32]
[    0.000000] CPU CAPS: [v8plus,vis,vis2]
[    0.000000] PERCPU: Embedded 6 pages/cpu @fffff80002400000 s20096 r8192 d20864 u2097152
[    0.000000] pcpu-alloc: s20096 r8192 d20864 u2097152 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 0 1
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 457554
[    0.000000] Kernel command line: BOOT_IMAGE=/vmlinuz-3.2.0-2-sparc64-smp root=/dev/mapper/raptor-root ro quiet
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
[    0.000000] Memory: 4136120k available (3656k kernel code, 1568k data, 232k init) [fffff80000000000,000000103feee000]
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  CONFIG_RCU_FANOUT set to non-default value of 32
[    0.000000]  RCU dyntick-idle grace-period acceleration is enabled.
[    0.000000] NR_IRQS:255
[    0.000000] clocksource: mult[53555555] shift[24]
[    0.000000] clockevent: mult[3126e98] shift[32]
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled, bootconsole disabled
[   39.876653] Calibrating delay using timer specific routine.. 24.00 BogoMIPS (lpj=48008)
[   39.876665] pid_max: default: 32768 minimum: 301
[   39.876804] Security Framework initialized
[   39.876822] AppArmor: AppArmor disabled by boot time parameter
[   39.876880] Mount-cache hash table entries: 512
[   39.877415] Initializing cgroup subsys cpuacct
[   39.877444] Initializing cgroup subsys memory
[   39.877481] Initializing cgroup subsys devices
[   39.877488] Initializing cgroup subsys freezer
[   39.877494] Initializing cgroup subsys net_cls
[   39.877500] Initializing cgroup subsys blkio
[   39.877524] Initializing cgroup subsys perf_event
[   39.877714] Performance events: Supported PMU type is 'ultra3i'
[   39.879296] CPU 0: synchronized TICK with master CPU (last diff 0 cycles, maxerr 6 cycles)
[   39.879343] Brought up 2 CPUs
[   39.879358] Testing NMI watchdog ... OK.
[   39.960160] devtmpfs: initialized
[   39.960783] print_constraints: dummy:
[   39.960976] NET: Registered protocol family 16
[   39.964518] /pci@1f,700000: TOMATILLO PCI Bus Module ver[4:0]
[   39.964529] /pci@1f,700000: PCI IO[7f601000000] MEM[7f700000000]
[   39.966520] PCI: Scanning PBM /pci@1f,700000
[   39.966700] pci 0000:00:02.0: PME# supported from D3hot
[   39.966710] pci 0000:00:02.0: PME# disabled
[   39.966793] pci 0000:00:02.1: PME# supported from D3hot
[   39.966801] pci 0000:00:02.1: PME# disabled
[   39.967075] /pci@1e,600000: TOMATILLO PCI Bus Module ver[4:0]
[   39.967085] /pci@1e,600000: PCI IO[7fe01000000] MEM[7ff00000000]
[   39.969095] PCI: Scanning PBM /pci@1e,600000
[   39.969318] pci 0001:00:06.0: quirk: [io  0x7fe01000800-0x7fe0100083f] claimed by ali7101 ACPI
[   39.969330] pci 0001:00:06.0: quirk: [io  0x7fe01000600-0x7fe0100061f] claimed by ali7101 SMB
[   39.969398] pci 0001:00:0a.0: PME# supported from D3cold
[   39.969407] pci 0001:00:0a.0: PME# disabled
[   39.969900] /pci@1c,600000: TOMATILLO PCI Bus Module ver[4:0]
[   39.969911] /pci@1c,600000: PCI IO[7ce01000000] MEM[7cf00000000]
[   39.971897] PCI: Scanning PBM /pci@1c,600000
[   39.972052] pci 0002:00:02.0: supports D1 D2
[   39.972127] pci 0002:00:02.1: supports D1 D2
[   39.972432] /pci@1d,700000: TOMATILLO PCI Bus Module ver[4:0]
[   39.972442] /pci@1d,700000: PCI IO[7c601000000] MEM[7c700000000]
[   39.974463] PCI: Scanning PBM /pci@1d,700000
[   39.974655] pci 0003:00:02.0: PME# supported from D3hot
[   39.974665] pci 0003:00:02.0: PME# disabled
[   39.974762] pci 0003:00:02.1: PME# supported from D3hot
[   39.974770] pci 0003:00:02.1: PME# disabled
[   39.977137] bio: create slab <bio-0> at 0
[   39.977534] vgaarb: loaded
[   39.978071] /pci@1e,600000/isa@7/rtc@0,70: RTC regs at 0x7fe01000070
[   39.978653] Switching to clocksource stick
[   39.987750] NET: Registered protocol family 2
[   39.987989] IP route cache hash table entries: 131072 (order: 7, 1048576 bytes)
[   39.990713] TCP established hash table entries: 524288 (order: 10, 8388608 bytes)
[   40.008104] TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
[   40.011359] TCP: Hash tables configured (established 524288 bind 65536)
[   40.011367] TCP reno registered
[   40.011381] UDP hash table entries: 2048 (order: 3, 65536 bytes)
[   40.011601] UDP-Lite hash table entries: 2048 (order: 3, 65536 bytes)
[   40.012141] NET: Registered protocol family 1
[   40.012197] pci 0001:00:07.0: Activating ISA DMA hang workarounds
[   40.012223] PCI: Enabling device: (0001:00:0a.0), cmd 2
[   40.066733] PCI: CLS 64 bytes, default 64
[   40.066896] Unpacking initramfs...
[   40.569105] Freeing initrd memory: 11035k freed
[   40.570008] power: Control reg at 7fe01000800
[   40.570319] chmc: UltraSPARC-IIIi memory controller at /memory-controller@0,0
[   40.570343] chmc: UltraSPARC-IIIi memory controller at /memory-controller@1,0
[   40.570701] audit: initializing netlink socket (disabled)
[   40.570733] type=2000 audit(0.768:1): initialized
[   40.684458] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[   40.685106] VFS: Disk quotas dquot_6.5.2
[   40.685256] Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[   40.685473] msgmni has been set to 8099
[   40.685961] alg: No test for stdrng (krng)
[   40.686046] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[   40.686056] io scheduler noop registered
[   40.686062] io scheduler deadline registered
[   40.686097] io scheduler cfq registered (default)
[   40.687120] f00a7730: ttyS0 at MMIO 0x7fe010003f8 (irq = 15) is a 16550A
[   40.687130] Console: ttyS0 (SU)
[   40.687219] console [ttyS0] enabled
[   40.687367] f00a92b0: ttyS1 at MMIO 0x7fe010002e8 (irq = 15) is a 16550A
[   40.687723] [drm] Initialized drm 1.1.0 20060810
[   40.688982] mousedev: PS/2 mouse device common for all mice
[   40.689552] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[   40.689580] rtc0: no alarms, 114 bytes nvram
[   40.690260] TCP cubic registered
[   40.690365] NET: Registered protocol family 10
[   40.691688] Mobile IPv6
[   40.691697] NET: Registered protocol family 17
[   40.691710] Registering the dns_resolver key type
[   40.691796] registered taskstats version 1
[   40.692170] rtc_cmos rtc_cmos: setting system clock to 2012-06-05 07:58:09 UTC (1338883089)
[   40.692205] Initializing network drop monitor service
[   40.731706] udevd[48]: starting version 175
[   40.894043] tg3.c:v3.121 (November 2, 2011)
[   40.894064] PCI: Enabling device: (0000:00:02.0), cmd 2
[   40.936282] SCSI subsystem initialized
[   40.950617] libata version 3.00 loaded.
[   40.951263] PCI: Enabling device: (0001:00:0d.0), cmd 5
[   40.951899] scsi0 : pata_ali
[   40.952128] scsi1 : pata_ali
[   40.952215] ata1: PATA max UDMA/100 cmd 0x7fe01000900 ctl 0x7fe01000918 bmdma 0x7fe01000920 irq 18
[   40.952225] ata2: PATA max UDMA/100 cmd 0x7fe01000910 ctl 0x7fe01000908 bmdma 0x7fe01000928 irq 18
[   40.982790] usbcore: registered new interface driver usbfs
[   40.982862] usbcore: registered new interface driver hub
[   40.983000] usbcore: registered new device driver usb
[   41.071055] tg3 0000:00:02.0: (unregistered net_device): Cannot get nvram lock, tg3_nvram_init failed
[   41.273100] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   41.273764] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   41.273826] ohci_hcd 0001:00:0a.0: OHCI Host Controller
[   41.273913] ohci_hcd 0001:00:0a.0: new USB bus registered, assigned bus number 1
[   41.273985] ohci_hcd 0001:00:0a.0: irq 17, io mem 0x7ff01000000
[   41.330754] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[   41.330766] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[   41.330774] usb usb1: Product: OHCI Host Controller
[   41.330780] usb usb1: Manufacturer: Linux 3.2.0-2-sparc64-smp ohci_hcd
[   41.330787] usb usb1: SerialNumber: 0001:00:0a.0
[   41.331288] hub 1-0:1.0: USB hub found
[   41.331316] hub 1-0:1.0: 2 ports detected
[   41.408958] tg3 0000:00:02.0: eth0: Tigon3 [partno(none) rev 2003] (PCI:66MHz:64-bit) MAC address 00:03:ba:83:a3:0d
[   41.408973] tg3 0000:00:02.0: eth0: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   41.408984] tg3 0000:00:02.0: eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   41.408993] tg3 0000:00:02.0: eth0: dma_rwctrl[763f0000] dma_mask[32-bit]
[   41.409041] PCI: Enabling device: (0000:00:02.1), cmd 2
[   41.579641] tg3 0000:00:02.1: (unregistered net_device): Cannot get nvram lock, tg3_nvram_init failed
[   41.921342] tg3 0000:00:02.1: eth1: Tigon3 [partno(none) rev 2003] (PCI:66MHz:64-bit) MAC address 00:03:ba:83:a3:0e
[   41.921360] tg3 0000:00:02.1: eth1: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   41.921371] tg3 0000:00:02.1: eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   41.921381] tg3 0000:00:02.1: eth1: dma_rwctrl[763f0000] dma_mask[32-bit]
[   41.921449] PCI: Enabling device: (0003:00:02.0), cmd 2
[   41.926593] PCI: Enabling device: (0002:00:02.0), cmd 147
[   41.927209] sym0: <1010-66> rev 0x1 at pci 0002:00:02.0 irq 24
[   41.931816] sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
[   41.972829] sym0: SCSI BUS has been reset.

[   41.976062] sym1: No NVRAM, ID 7, Fast-80, LVD, parity checking
[   42.016427] sym1: SCSI BUS has been reset.
[   42.016447] scsi3 : sym-2.2.3
[   42.095966] tg3 0003:00:02.0: (unregistered net_device): Cannot get nvram lock, tg3_nvram_init failed
[   42.434145] tg3 0003:00:02.0: eth2: Tigon3 [partno(none) rev 2003] (PCI:66MHz:64-bit) MAC address 00:03:ba:83:a3:0f
[   42.434158] tg3 0003:00:02.0: eth2: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   42.434169] tg3 0003:00:02.0: eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   42.434179] tg3 0003:00:02.0: eth2: dma_rwctrl[763f0000] dma_mask[32-bit]
[   42.434237] PCI: Enabling device: (0003:00:02.1), cmd 2
[   42.607688] tg3 0003:00:02.1: (unregistered net_device): Cannot get nvram lock, tg3_nvram_init failed
[   42.946059] tg3 0003:00:02.1: eth3: Tigon3 [partno(none) rev 2003] (PCI:66MHz:64-bit) MAC address 00:03:ba:83:a3:10
[   42.946072] tg3 0003:00:02.1: eth3: attached PHY is 5704 (10/100/1000Base-T Ethernet) (WireSpeed[1], EEE[0])
[   42.946084] tg3 0003:00:02.1: eth3: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
[   42.946093] tg3 0003:00:02.1: eth3: dma_rwctrl[763f0000] dma_mask[32-bit]
[   42.995354] scsi: waiting for bus probes to complete ...
[   44.983774] scsi 2:0:0:0: Direct-Access     SEAGATE  ST336607LSUN36G  0507 PQ: 0 ANSI: 3
[   44.983799] scsi target2:0:0: tagged command queuing enabled, command queue depth 16.
[   44.983821] scsi target2:0:0: Beginning Domain Validation
[   44.988707] scsi target2:0:0: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
[   44.994542] scsi target2:0:0: Ending Domain Validation
[   44.995905] scsi 2:0:1:0: Direct-Access     SEAGATE  ST336607LSUN36G  0507 PQ: 0 ANSI: 3
[   44.995917] scsi target2:0:1: tagged command queuing enabled, command queue depth 16.
[   44.995932] scsi target2:0:1: Beginning Domain Validation
[   45.000772] scsi target2:0:1: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
[   45.006588] scsi target2:0:1: Ending Domain Validation
[   45.007932] scsi 2:0:2:0: Direct-Access     SEAGATE  ST336607LSUN36G  0507 PQ: 0 ANSI: 3
[   45.007944] scsi target2:0:2: tagged command queuing enabled, command queue depth 16.
[   45.007960] scsi target2:0:2: Beginning Domain Validation
[   45.012812] scsi target2:0:2: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
[   45.018660] scsi target2:0:2: Ending Domain Validation
[   45.020002] scsi 2:0:3:0: Direct-Access     SEAGATE  ST336607LSUN36G  0507 PQ: 0 ANSI: 3
[   45.020014] scsi target2:0:3: tagged command queuing enabled, command queue depth 16.
[   45.020030] scsi target2:0:3: Beginning Domain Validation
[   45.024896] scsi target2:0:3: FAST-80 WIDE SCSI 160.0 MB/s DT (12.5 ns, offset 31)
[   45.030753] scsi target2:0:3: Ending Domain Validation
[   48.280757] sd 2:0:0:0: [sda] 71132959 512-byte logical blocks: (36.4 GB/33.9 GiB)
[   48.282379] sd 2:0:0:0: [sda] Write Protect is off
[   48.282392] sd 2:0:0:0: [sda] Mode Sense: db 00 10 08
[   48.284615] sd 2:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   48.288287] sd 2:0:1:0: [sdb] 71132959 512-byte logical blocks: (36.4 GB/33.9 GiB)
[   48.289097] sd 2:0:2:0: [sdc] 71132959 512-byte logical blocks: (36.4 GB/33.9 GiB)
[   48.289154] sd 2:0:3:0: [sdd] 71132959 512-byte logical blocks: (36.4 GB/33.9 GiB)
[   48.289904] sd 2:0:1:0: [sdb] Write Protect is off
[   48.289916] sd 2:0:1:0: [sdb] Mode Sense: db 00 10 08
[   48.290753] sd 2:0:2:0: [sdc] Write Protect is off
[   48.290762] sd 2:0:2:0: [sdc] Mode Sense: db 00 10 08
[   48.290801] sd 2:0:3:0: [sdd] Write Protect is off
[   48.290809] sd 2:0:3:0: [sdd] Mode Sense: db 00 10 08
[   48.292329] sd 2:0:1:0: [sdb] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   48.292972] sd 2:0:2:0: [sdc] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   48.293115] sd 2:0:3:0: [sdd] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   48.302384]  sda: sda1 sda2 sda3
[   48.307453] sd 2:0:0:0: [sda] Attached SCSI disk
[   48.307557]  sdb: sdb3
[   48.310731]  sdd: sdd3
[   48.310849]  sdc: sdc1 sdc2 sdc3
[   48.315723] sd 2:0:1:0: [sdb] Attached SCSI disk
[   48.315920] sd 2:0:3:0: [sdd] Attached SCSI disk
[   48.317000] sd 2:0:2:0: [sdc] Attached SCSI disk
[   49.511023] device-mapper: uevent: version 1.0.3
[   49.512020] device-mapper: ioctl: 4.22.0-ioctl (2011-10-19) initialised: dm-devel@redhat.com
[   50.022523] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
[   50.943894] udevd[316]: starting version 175
[   52.705859] EXT4-fs (dm-0): re-mounted. Opts: (null)
[   52.810398] EXT4-fs (dm-0): re-mounted. Opts: errors=remount-ro
[   52.875180] loop: module loaded
[   53.475928] Adding 3592184k swap on /dev/mapper/raptor-swap_1.  Priority:-1 extents:1 across:3592184k 
[   53.878226] EXT4-fs (dm-10): mounted filesystem with ordered data mode. Opts: (null)
[   53.898425] EXT4-fs (dm-9): mounted filesystem with ordered data mode. Opts: (null)
[   53.932915] EXT4-fs (dm-7): mounted filesystem with ordered data mode. Opts: (null)
[   53.974964] EXT4-fs (dm-8): mounted filesystem with ordered data mode. Opts: (null)
[   56.282944] tg3 0000:00:02.0: eth0: No firmware running
[   56.492089] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   57.002854] RPC: Registered named UNIX socket transport module.
[   57.002866] RPC: Registered udp transport module.
[   57.002872] RPC: Registered tcp transport module.
[   57.002877] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   57.040644] FS-Cache: Loaded
[   57.079556] FS-Cache: Netfs 'nfs' registered for caching
[   57.094524] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   58.067531] tg3 0000:00:02.0: eth0: Link is up at 100 Mbps, full duplex
[   58.067546] tg3 0000:00:02.0: eth0: Flow control is on for TX and on for RX
[   58.071382] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[  956.866068] sched: RT throttling activated
[  958.551117] tg3 0000:00:02.0: BAR 0: set to [mem 0x7f700200000-0x7f7003fffff] (PCI address [0x200000-0x3fffff])
[  958.551137] tg3 0000:00:02.0: BAR 2: set to [mem 0x7f700110000-0x7f70011ffff] (PCI address [0x110000-0x11ffff])
[  960.208248] ADDRCONF(NETDEV_UP): eth0: link is not ready
[  961.847451] tg3 0000:00:02.0: eth0: Link is up at 100 Mbps, full duplex
[  961.847466] tg3 0000:00:02.0: eth0: Flow control is on for TX and on for RX
[  961.851679] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[ 1011.122903] tg3 0000:00:02.0: BAR 0: set to [mem 0x7f700200000-0x7f7003fffff] (PCI address [0x200000-0x3fffff])
[ 1011.122921] tg3 0000:00:02.0: BAR 2: set to [mem 0x7f700110000-0x7f70011ffff] (PCI address [0x110000-0x11ffff])
[ 1012.779480] ADDRCONF(NETDEV_UP): eth0: link is not ready
[ 1014.334251] tg3 0000:00:02.0: eth0: Link is up at 100 Mbps, full duplex
[ 1014.334267] tg3 0000:00:02.0: eth0: Flow control is on for TX and on for RX
[ 1014.338039] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[ 3844.604607] ERROR(0): Cheetah error trap taken afsr[0010100000000000] afar[0000000040000000] TL1(0)
[ 3844.604624] ERROR(0): TPC[407bd0] TNPC[407bd4] O7[448c84] TSTATE[411e01602]
[ 3844.604631] ERROR(0): TPC<copy_tsb+0x30/0x80>
[ 3844.604652] ERROR(0): M_SYND(0),  E_SYND(0), Privileged
[ 3844.604661] ERROR(0): Highest priority error (0000100000000000) "Unmapped error from system bus"
[ 3844.604671] ERROR(0): D-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000]
[ 3844.604681] ERROR(0): D-cache data0[0000000000000000] data1[0000000000000000] data2[0000000000000000] data3[0000000000000000]
[ 3844.604692] ERROR(0): I-cache idx[0] tag[0000000000000000] utag[0000000000000000] stag[0000000000000000] u[0000000000000000] l[0000000000000000]
[ 3844.604703] ERROR(0): I-cache INSN0[0000000000000000] INSN1[0000000000000000] INSN2[0000000000000000] INSN3[0000000000000000]
[ 3844.604714] ERROR(0): I-cache INSN4[0000000000000000] INSN5[0000000000000000] INSN6[0000000000000000] INSN7[0000000000000000]
[ 3844.604723] ERROR(0): E-cache idx[40000000] tag[000000001e040efd]
[ 3844.604731] ERROR(0): E-cache data0[00000000000001c0] data1[80000003385a0fb2] data2[00000000000001c0] data3[8000000334834fb2]
[ 3844.604743] Kernel panic - not syncing: Irrecoverable deferred error trap.
[ 3844.604747] 
[ 3844.714568] Call Trace:
[ 3844.746602]  [0000000000428e28] cheetah_deferred_handler+0x32c/0x364
[ 3844.830097]  [0000000000405e50] c_deferred+0x18/0x24
[ 3844.895282]  [0000000000407bd0] copy_tsb+0x30/0x80
[ 3844.958196]  [0000000000793ef8] do_sparc64_fault+0x5a8/0x798
[ 3845.032533]  [00000000004079c8] sparc64_realfault_common+0x10/0x20
[ 3845.113759] Press Stop-A (L1-A) to return to the boot prom

--------------060105090707090907030302--

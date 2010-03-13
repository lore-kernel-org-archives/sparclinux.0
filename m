From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sat, 13 Mar 2010 17:57:28 +0000
Subject: Re: XVR-500 additional pci ids
Message-Id: <1268503048.1775.66.camel@deblnxsrv254.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-407WByKAgX0oUaVNngkX"
List-Id: <sparclinux.vger.kernel.org>
References: <201002251955.23519.dennis@ausil.us>
In-Reply-To: <201002251955.23519.dennis@ausil.us>
To: sparclinux@vger.kernel.org


--=-407WByKAgX0oUaVNngkX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2010-03-12 at 00:08 -0800, David Miller wrote:
> From: Frans van Berckel <fberckel@xs4all.nl>
> Date: Fri, 12 Mar 2010 08:54:39 +0100
> 
> >> sparc64: Add very basic XVR-1000 framebuffer driver.
> > 
> > Oh that sound rely nice, wanne say thank you! Gonna test this XVR 1000
> > patch later on and will report the results.
> 
> I look forward to it :-)

It boot's! 

[    0.000000] OF stdout device
is: /upa@8,480000/SUNW,gfb@0,0:r1440x900x60

Next the screen is switching into blue letters, it scrolls on and on, as
expected. At the end it prints a blinking cursor. It freezes the cursor.
But the system goes on and is still accessible with ssh.

Attaching the dmesg ...

--=-407WByKAgX0oUaVNngkX
Content-Disposition: attachment; filename="dmesg-sun4u-xvr-1000-build.txt"
Content-Type: text/plain; name="dmesg-sun4u-xvr-1000-build.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.5.21 2003/02/24 17:23'
[    0.000000] PROMLIB: Root node compatible: 
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Linux version 2.6.34-rc1-kernelbuilder-next-20100309+ (root@deblnxsrv251) (gcc version 4.4.3 (Ubuntu 4.4.3-3ubuntu1) ) #1 SMP Sat Mar 13 13:22:22 CET 2010
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:5b:86:cb
[    0.000000] Kernel: Using 2 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /upa@8,480000/SUNW,gfb@0,0:r1440x900x60
[    0.000000] PROM: Built device tree with 67248 bytes of memory.
[    0.000000] Top of RAM: 0x7fe8c000, Total RAM: 0x7fd6e000
[    0.000000] Memory hole size: 1MB
[    0.000000] [0000010000000000-fffff80000c00000] page_structs=131072 node=0 entry=0/0
[    0.000000] [0000010000000000-fffff80001000000] page_structs=131072 node=0 entry=1/0
[    0.000000] [0000010000800000-fffff80001400000] page_structs=131072 node=0 entry=2/0
[    0.000000] [0000010000800000-fffff80001800000] page_structs=131072 node=0 entry=3/0
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x0003ff46
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[6] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x0003f7ff
[    0.000000]     0: 0x0003f800 -> 0x0003fe3e
[    0.000000]     0: 0x0003fec0 -> 0x0003fec8
[    0.000000]     0: 0x0003feca -> 0x0003fed2
[    0.000000]     0: 0x0003fed4 -> 0x0003ff2f
[    0.000000]     0: 0x0003ff37 -> 0x0003ff46
[    0.000000] On node 0 totalpages: 261815
[    0.000000]   Normal zone: 2047 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 259768 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] PERCPU: Embedded 7 pages/cpu @fffff80001c00000 s25472 r8192 d23680 u4194304
[    0.000000] pcpu-alloc: s25472 r8192 d23680 u4194304 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 259768
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=/dev/sda5 ro
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Memory: 2061640k available (4400k kernel code, 1960k data, 352k init) [fffff80000000000,000000007fe8c000]
[    0.000000] SLUB: Genslabs=15, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=16
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:255
[    0.000000] clocksource: mult[c8000000] shift[24]
[    0.000000] clockevent: mult[147ae14] shift[32]
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled, bootconsole disabled
[   64.907919] Calibrating delay using timer specific routine.. 10.00 BogoMIPS (lpj=20019)
[   64.908048] Security Framework initialized
[   64.908085] SELinux:  Disabled at boot.
[   64.908453] Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)
[   64.915461] Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)
[   64.918881] Mount-cache hash table entries: 512
[   64.919420] Initializing cgroup subsys ns
[   64.919442] Initializing cgroup subsys devices
[   64.919458] Initializing cgroup subsys freezer
[   64.919471] Initializing cgroup subsys net_cls
[   64.919525] ftrace: allocating 14094 entries in 28 pages
[   64.926441] Brought up 1 CPUs
[   64.926880] devtmpfs: initialized
[   64.927444] regulator: core version 0.5
[   64.927579] NET: Registered protocol family 16
[   64.930787] Testing NMI watchdog ... OK.
[   65.010805] Performance events: Supported PMU type is 'ultra3+'
[   65.011370] /pci@8,700000: SCHIZO PCI Bus Module ver[7:0]
[   65.011391] /pci@8,700000: PCI IO[7ffef000000] MEM[7fe00000000]
[   65.015463] PCI: Scanning PBM /pci@8,700000
[   65.015984] pci 0000:00:06.0: supports D1 D2
[   65.016047] pci 0000:00:06.1: supports D1 D2
[   65.016677] /pci@8,600000: SCHIZO PCI Bus Module ver[7:0]
[   65.016697] /pci@8,600000: PCI IO[7ffed000000] MEM[7fd00000000]
[   65.020731] PCI: Scanning PBM /pci@8,600000
[   65.022520] bio: create slab <bio-0> at 0
[   65.022885] vgaarb: loaded
[   65.023425] NetLabel: Initializing
[   65.023442] NetLabel:  domain hash size = 128
[   65.023457] NetLabel:  protocols = UNLABELED CIPSOv4
[   65.023516] NetLabel:  unlabeled traffic allowed by default
[   65.023697] /pci@8,700000/ebus@5/rtc@1,300070: RTC regs at 0x7fe7e300070
[   65.024096] Switching to clocksource stick
[   65.030246] NET: Registered protocol family 2
[   65.030515] IP route cache hash table entries: 65536 (order: 6, 524288 bytes)
[   65.032508] TCP established hash table entries: 262144 (order: 9, 4194304 bytes)
[   65.046063] TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
[   65.049467] TCP: Hash tables configured (established 262144 bind 65536)
[   65.049490] TCP reno registered
[   65.049523] UDP hash table entries: 1024 (order: 2, 32768 bytes)
[   65.049676] UDP-Lite hash table entries: 1024 (order: 2, 32768 bytes)
[   65.050062] NET: Registered protocol family 1
[   65.050163] PCI: CLS 64 bytes, default 64
[   65.050335] Trying to unpack rootfs image as initramfs...
[   65.471748] Freeing initrd memory: 8315k freed
[   65.472988] audit: initializing netlink socket (disabled)
[   65.473040] type=2000 audit(0.648:1): initialized
[   65.545468] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[   65.550558] VFS: Disk quotas dquot_6.5.2
[   65.550745] Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[   65.552121] fuse init (API version 7.13)
[   65.552415] msgmni has been set to 4042
[   65.553300] alg: No test for stdrng (krng)
[   65.553356] io scheduler noop registered
[   65.553376] io scheduler deadline registered
[   65.553617] io scheduler cfq registered (default)
[   65.554199] gfb: Found device at /upa@8,480000/SUNW,gfb@0,0
[   65.594553] Console: switching to colour frame buffer device 160x64
[   65.638376] [drm] Initialized drm 1.1.0 20060810
[   65.638985] f0086c30: ttyS0 at MMIO 0x7fe7e400000 (irq = 12) is a SAB82532 V3.2
[   65.639403] f0086c30: ttyS1 at MMIO 0x7fe7e400040 (irq = 12) is a SAB82532 V3.2
[   65.642905] brd: module loaded
[   65.644599] loop: module loaded
[   65.644860] Fixed MDIO Bus: probed
[   65.645141] sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
[   65.646337] PHY ID: 18074c1, addr: 0
[   65.647187] eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:ba:5b:86:cb
[   65.647518] eth0: Found Generic MII PHY
[   65.647743] tun: Universal TUN/TAP device driver, 1.6
[   65.647983] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   65.648654] mice: PS/2 mouse device common for all mice
[   65.649181] input: Sparc BBC Speaker as /devices/root/f006c678/f007e070/f0084030/input/input0
[   65.649955] rtc_cmos rtc_cmos: rtc core: registered rtc_cmos as rtc0
[   65.650272] rtc0: no alarms, 114 bytes nvram
[   65.651404] TCP cubic registered
[   65.651568] NET: Registered protocol family 17
[   65.652070] registered taskstats version 1
[   65.652538] rtc_cmos rtc_cmos: setting system clock to 2010-03-13 17:24:24 UTC (1268501064)
[   65.691746] udev: starting version 151
[   65.937621] SCSI subsystem initialized
[   66.019562] usbcore: registered new interface driver usbfs
[   66.019868] usbcore: registered new interface driver hub
[   66.152338] PCI: Enabling device: (0000:00:06.0), cmd 147
[   66.153490] sym0: <875> rev 0x37 at pci 0000:00:06.0 irq 16
[   66.240731] sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
[   66.248099] sym0: SCSI BUS has been reset.
[   66.248313] scsi0 : sym-2.2.3
[   66.270752] QLogic Fibre Channel HBA Driver: 8.03.02-k1
[   66.271044] PCI: Enabling device: (0001:00:04.0), cmd 3
[   66.271063] qla2xxx 0001:00:04.0: Found an ISP2200, irq 20, iobase 0x000007fd00100000
[   66.283977] usbcore: registered new device driver usb
[   66.290351] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   66.299077] qla2xxx 0001:00:04.0: Configuring PCI space...
[   66.307746] qla2xxx 0001:00:04.0: Configure NVRAM parameters...
[   66.410602] qla2xxx 0001:00:04.0: Inconsistent NVRAM detected: checksum=0x0 id=
[   66.410946] qla2xxx 0001:00:04.0: Falling back to functioning (yet invalid -- WWPN) defaults.
[   66.428638] qla2xxx 0001:00:04.0: Verifying loaded RISC code...
[   66.438341] PCI: Enabling device: (0000:00:06.1), cmd 147
[   66.439509] sym1: <875> rev 0x37 at pci 0000:00:06.1 irq 17
[   66.535783] sym1: No NVRAM, ID 7, Fast-20, SE, parity checking
[   66.552491] sym1: SCSI BUS has been reset.
[   66.562233] scsi2 : sym-2.2.3
[   66.572617] qla2xxx 0001:00:04.0: firmware: requesting ql2200_fw.bin
[   66.645274] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[14]  MMIO=[7fe00120000-7fe001207ff]  Max Packet=[2048]  IR/IT contexts=[4/4]
[   66.661466] ohci_hcd 0000:00:05.3: OHCI Host Controller
[   66.672576] ohci_hcd 0000:00:05.3: new USB bus registered, assigned bus number 1
[   66.683961] ohci_hcd 0000:00:05.3: irq 15, io mem 0x7fe01000000
[   66.752577] hub 1-0:1.0: USB hub found
[   66.764120] hub 1-0:1.0: 4 ports detected
[   67.100227] usb 1-1: new low speed USB device using ohci_hcd and address 2
[   67.312017] input: HID 0430:0100 as /devices/root/f006c678/pci0000:00/0000:00:05.3/usb1/1-1/1-1:1.0/input/input1
[   67.324761] generic-usb 0003:0430:0100.0001: input,hidraw0: USB HID v1.10 Mouse [HID 0430:0100] on usb-0000:00:05.3-1/input0
[   67.337848] usbcore: registered new interface driver usbhid
[   67.351039] usbhid: USB HID core driver
[   67.420228] usb 1-2: new low speed USB device using ohci_hcd and address 3
[   67.594671] input: HID 0430:0005 as /devices/root/f006c678/pci0000:00/0000:00:05.3/usb1/1-2/1-2:1.0/input/input2
[   67.609055] generic-usb 0003:0430:0005.0002: input,hidraw1: USB HID v1.00 Keyboard [HID 0430:0005] on usb-0000:00:05.3-2/input0
[   67.932445] ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0003bafffe5b86cb]
[   68.044422] eth0: Link is up at 100 Mbps, full-duplex.
[   71.001376] scsi 0:0:6:0: CD-ROM            TOSHIBA  DVD-ROM SD-M1401 1007 PQ: 0 ANSI: 2
[   71.015994] scsi target0:0:6: Beginning Domain Validation
[   71.032295] scsi target0:0:6: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 16)
[   71.048224] scsi target0:0:6: Domain Validation skipping write tests
[   71.062989] scsi target0:0:6: Ending Domain Validation
[   73.457807] sr0: scsi3-mmc drive: 40x/40x cd/rw xa/form2 cdda tray
[   73.472601] Uniform CD-ROM driver Revision: 3.20
[   73.487495] sr 0:0:6:0: Attached scsi CD-ROM sr0
[   73.501968] sr 0:0:6:0: Attached scsi generic sg0 type 5
[   77.420288] qla2xxx 0001:00:04.0: Allocated (252 KB) for firmware dump...
[   77.560226] qla2xxx 0001:00:04.0: LIP reset occurred (f8e8).
[   77.575035] scsi1 : qla2xxx
[   77.590390] qla2xxx 0001:00:04.0: 
[   77.590394]  QLogic Fibre Channel HBA Driver: 8.03.02-k1
[   77.590398]   QLogic QLA22xx - 
[   77.590400]   ISP2200: PCI (66 MHz) @ 0001:00:04.0 hdma-, host#=1, fw=2.02.08 TP
[   77.647535] qla2xxx 0001:00:04.0: LIP occurred (f8e8).
[   77.662023] qla2xxx 0001:00:04.0: LOOP UP detected (1 Gbps).
[   78.581442] scsi 1:0:0:0: Direct-Access     SEAGATE  ST336605FSUN36G  0638 PQ: 0 ANSI: 3
[   78.596840] scsi 1:0:0:0: Attached scsi generic sg1 type 0
[   78.635907] sd 1:0:0:0: [sda] 71132959 512-byte logical blocks: (36.4 GB/33.9 GiB)
[   78.653014] sd 1:0:0:0: [sda] Write Protect is off
[   78.667483] sd 1:0:0:0: [sda] Mode Sense: db 00 10 08
[   78.671866] sd 1:0:0:0: [sda] Write cache: disabled, read cache: enabled, supports DPO and FUA
[   78.696847]  sda: sda1 sda2 sda3 sda4 sda5 sda6
[   78.732469] sd 1:0:0:0: [sda] Attached SCSI disk
[   79.450624] kjournald starting.  Commit interval 5 seconds
[   79.465589] EXT3-fs (sda5): mounted filesystem with ordered data mode
[   83.596381] Adding 891592k swap on /dev/sda4.  Priority:-1 extents:1 across:891592k 
[   83.678536] udev: starting version 151
[   83.875017] EXT3-fs (sda5): using internal journal
[   84.549903] kjournald starting.  Commit interval 5 seconds
[   84.561101] EXT3-fs (sda6): using internal journal
[   84.561121] EXT3-fs (sda6): mounted filesystem with ordered data mode
[   84.569637] eth0: Link is up at 100 Mbps, full-duplex.
[   84.569648] eth0: Pause is disabled
[   84.671821] plymouthd[170]: segfault at 0 ip 00000000f7e3f790 (rpc 00000000f7bd5eb0) sp 00000000ffa213e0 error 30001 in libc-2.11.1.so[f7db0000+168000]
[   85.209528] NET: Registered protocol family 10
[   85.210677] lo: Disabled Privacy Extensions
[   85.527599] RPC: Registered udp transport module.
[   85.527610] RPC: Registered tcp transport module.
[   85.527617] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   85.937900] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   86.475976] svc: failed to register lockdv1 RPC service (errno 47).
[   86.478863] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
[   86.487283] NFSD: starting 90-second grace period
[   95.916219] eth0: no IPv6 routers present

--=-407WByKAgX0oUaVNngkX--


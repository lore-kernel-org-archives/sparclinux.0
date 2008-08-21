From: Meelis Roos <mroos@ut.ee>
Date: Thu, 21 Aug 2008 20:04:21 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.SOC.4.64.0808212301270.2109@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> > > In addition, you should take a look at ohci_rhsc_enable() in
> > > ohci-hub.c.  That's the place where RHSC interrupts get re-enabled, so
> > > make sure it isn't getting called by mistake.
> >=20
> > It seems to be always called from usb_enable_root_hub_irq:
>=20
> That's how it's supposed to be called.  The question remains whether it
> always gets called between invocations of ohci_irq().  The log you
> posted seemed to indicate that it wasn't.
>=20
> Incidentally, this patch might very well affect your problem:
>=20
> 	http://marc.info/?l=3Dlinux-usb&m=121926736707452&w=3D2
>=20
> It may not apply exactly as-is to 2.6.27-rc4 because it was made=20
> against a development tree, but you should be able to adjust it easily=20
> enough.

Applied some chunks by hand and tried it. Still loops.

Note that there is the following line in logs between looping:
ps used greatest stack depth: 0 bytes left

Does this mean that the looping used up all the stack??

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.0.18 2002/05/23 18:22'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 2.6.27-rc3-00661-g82d63fc-dirty (mroos@janku) =
(gcc version 4.3.1 (Debian 4.3.1-8) ) #40 Thu Aug 21 21:48:07 EEST 2008
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:11:b3:71
[    0.000000] Kernel: Using 4 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1f,0/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 46357 bytes of memory.
[    0.000000] Top of RAM: 0x6fec6000, Total RAM: 0x3fe42000
[    0.000000] Memory hole size: 768MB
[    0.000000] [0000000200000000-fffff80000400000] page_structs=131072 node=
=3D0 entry=3D0/0
[    0.000000] [0000000200000000-fffff80000800000] page_structs=131072 node=
=3D0 entry=3D1/0
[    0.000000] [0000000200700000-fffff80000c00000] page_structs=131072 node=
=3D0 entry=3D2/0
[    0.000000] [0000000200700000-fffff80001000000] page_structs=131072 node=
=3D0 entry=3D3/0
[    0.000000] Allocated 1056768 bytes for kernel page tables.
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x00037f63
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[7] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00008000
[    0.000000]     0: 0x00010000 -> 0x00018000
[    0.000000]     0: 0x00020000 -> 0x00028000
[    0.000000]     0: 0x00030000 -> 0x000377ff
[    0.000000]     0: 0x00037800 -> 0x00037f00
[    0.000000]     0: 0x00037f40 -> 0x00037f5f
[    0.000000]     0: 0x00037f60 -> 0x00037f63
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 129282
[    0.000000] Kernel command line: ro root=3D/dev/sda2
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[b40001] shift[16]
[    0.000000] clockevent: mult[16c16bf] shift[32]
[   55.589766] Console: colour dummy device 80x25
[   55.642729] console handover: boot [earlyprom0] -> real [tty0]
[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.0.18 2002/05/23 18:22'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 2.6.27-rc3-00661-g82d63fc-dirty (mroos@janku) =
(gcc version 4.3.1 (Debian 4.3.1-8) ) #40 Thu Aug 21 21:48:07 EEST 2008
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:11:b3:71
[    0.000000] Kernel: Using 4 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1f,0/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 46357 bytes of memory.
[    0.000000] Top of RAM: 0x6fec6000, Total RAM: 0x3fe42000
[    0.000000] Memory hole size: 768MB
[    0.000000] [0000000200000000-fffff80000400000] page_structs=131072 node=
=3D0 entry=3D0/0
[    0.000000] [0000000200000000-fffff80000800000] page_structs=131072 node=
=3D0 entry=3D1/0
[    0.000000] [0000000200700000-fffff80000c00000] page_structs=131072 node=
=3D0 entry=3D2/0
[    0.000000] [0000000200700000-fffff80001000000] page_structs=131072 node=
=3D0 entry=3D3/0
[    0.000000] Allocated 1056768 bytes for kernel page tables.
[    0.000000] Zone PFN ranges:
[    0.000000]   Normal   0x00000000 -> 0x00037f63
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[7] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00008000
[    0.000000]     0: 0x00010000 -> 0x00018000
[    0.000000]     0: 0x00020000 -> 0x00028000
[    0.000000]     0: 0x00030000 -> 0x000377ff
[    0.000000]     0: 0x00037800 -> 0x00037f00
[    0.000000]     0: 0x00037f40 -> 0x00037f5f
[    0.000000]     0: 0x00037f60 -> 0x00037f63
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 129282
[    0.000000] Kernel command line: ro root=3D/dev/sda2
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[b40001] shift[16]
[    0.000000] clockevent: mult[16c16bf] shift[32]
[   55.589766] Console: colour dummy device 80x25
[   55.642729] console handover: boot [earlyprom0] -> real [tty0]
[   55.712284] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc.,=
 Ingo Molnar
[   55.712345] ... MAX_LOCKDEP_SUBCLASSES:    8
[   55.712379] ... MAX_LOCK_DEPTH:          48
[   55.712411] ... MAX_LOCKDEP_KEYS:        8191
[   55.712445] ... CLASSHASH_SIZE:           4096
[   55.712478] ... MAX_LOCKDEP_ENTRIES:     8192
[   55.712512] ... MAX_LOCKDEP_CHAINS:      16384
[   55.712547] ... CHAINHASH_SIZE:          8192
[   55.712581]  memory used by lock dependency info: 4095 kB
[   55.712621]  per task-struct memory footprint: 2688 bytes
[   55.718040] Dentry cache hash table entries: 131072 (order: 7, 1048576 b=
ytes)
[   55.726459] Inode-cache hash table entries: 65536 (order: 6, 524288 byte=
s)
[   55.824361] Memory: 1013304k available (2728k kernel code, 1272k data, 1=
44k init) [fffff80000000000,000000006fec6000]
[   55.824818] SLUB: Genslabs=13, HWalign2, Order=3D0-3, MinObjects=3D0, CP=
Us=3D1, Nodes=3D1
[   55.973397] Calibrating delay using timer specific routine.. 11.18 BogoM=
IPS (lpjU936)
[   55.974652] Mount-cache hash table entries: 512
[   55.988851] khelper used greatest stack depth: 11056 bytes left
[   55.991251] net_namespace: 1592 bytes
[   55.994410] NET: Registered protocol family 16
[   56.029591] khelper used greatest stack depth: 10480 bytes left
[   56.101268] PCI: Probing for controllers.
[   56.104592] /pci@1f,0: SABRE PCI Bus Module
[   56.104723] /pci@1f,0: PCI IO[1fe02000000] MEM[1ff00000000]
[   56.105008] PCI: Scanning PBM /pci@1f,0
[   56.107960] pci 0000:00:03.0: quirk: region 2000-203f claimed by ali7101=
 ACPI
[   56.108059] pci 0000:00:03.0: quirk: region 4000-401f claimed by ali7101=
 SMB
[   56.108593] pci 0000:00:0c.0: PME# supported from D3hot D3cold
[   56.108681] pci 0000:00:0c.0: PME# disabled
[   56.109175] pci 0000:00:05.0: PME# supported from D3hot D3cold
[   56.109261] pci 0000:00:05.0: PME# disabled
[   56.123675] ebus: No EBus's found.
[   56.124564] power: Control reg at 1fe02002000
[   56.165924] SCSI subsystem initialized
[   56.199601] /pci@1f,0/isa@7/rtc@0,70: Clock regs at 000001fe02000070
[   56.207246] tracer: 643 pages allocated for 65536 entries of 80 bytes
[   56.207325]    actual entries 65586
[   56.232842] NET: Registered protocol family 2
[   56.796075] IP route cache hash table entries: 8192 (order: 3, 65536 byt=
es)
[   56.802455] TCP established hash table entries: 32768 (order: 6, 524288 =
bytes)
[   56.805687] TCP bind hash table entries: 32768 (order: 8, 2097152 bytes)
[   56.832822] TCP: Hash tables configured (established 32768 bind 32768)
[   56.833094] TCP reno registered
[   56.856684] NET: Registered protocol family 1
[   56.857947] Mini RTC Driver
[   56.865006] khelper used greatest stack depth: 9272 bytes left
[   56.890803] Initializing RT-Tester: OK
[   56.906893] Kprobe smoke test started
[   57.005107] Kprobe smoke test passed successfully
[   57.286287] VFS: Disk quotas dquot_6.5.1
[   57.290183] Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[   57.313282] msgmni has been set to 1980
[   57.323802] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 254)
[   57.324002] io scheduler noop registered
[   57.324064] io scheduler anticipatory registered
[   57.324124] io scheduler deadline registered
[   57.330194] io scheduler cfq registered (default)
[   57.330330] pci 0000:00:07.0: Activating ISA DMA hang workarounds
[   57.469225] f0076e0c: ttyS0 at MMIO 0x1fe020003f8 (irq =3D 7) is a 16550A
[   57.469366] Console: ttyS0 (SU)
[   57.469442] console [ttyS0] enabled
[   64.076734] f0078af8: ttyS1 at MMIO 0x1fe020002e8 (irq =3D 7) is a 16550A
[   64.208447] loop: module loaded
[   64.249894] console [netcon0] enabled
[   64.300197] netconsole: network logging started
[   64.361559] Driver 'sd' needs updating - please use bus_type methods
[   64.451257] scsi0 : pata_ali
[   64.500760] scsi1 : pata_ali
[   64.543334] ata1: PATA max UDMA/66 cmd 0x1fe02010200 ctl 0x1fe02010218 b=
mdma 0x1fe02010220 irq 12
[   64.660174] ata2: PATA max UDMA/66 cmd 0x1fe02010210 ctl 0x1fe02010208 b=
mdma 0x1fe02010228 irq 12
[   65.325499] ata2.00: ATA-6: ST3120026A, 3.06, max UDMA/100
[   65.397637] ata2.00: 234441648 sectors, multi 0: LBA48=20
[   65.466371] ata2.01: ATAPI: CD-224E, 1.7A, max UDMA/33
[   65.533968] ata2.01: WARNING: ATAPI DMA disabled for reliablity issues. =
 It can be enabled
[   65.642760] ata2.01: WARNING: via pata_ali.atapi_dma modparam or corresp=
onding sysfs node.
[   65.785379] ata2.00: configured for UDMA/66
[   65.875121] ata2.01: configured for UDMA/33
[   65.932914] scsi 1:0:0:0: Direct-Access     ATA      ST3120026A       3.=
06 PQ: 0 ANSI: 5
[   66.047466] sd 1:0:0:0: [sda] 234441648 512-byte hardware sectors (12003=
4 MB)
[   66.141889] sd 1:0:0:0: [sda] Write Protect is off
[   66.206142] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   66.327530] sd 1:0:0:0: [sda] 234441648 512-byte hardware sectors (12003=
4 MB)
[   66.422091] sd 1:0:0:0: [sda] Write Protect is off
[   66.486045] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA
[   66.605242]  sda: sda1 sda2 sda3 sda4 sda5
[   66.682367] sd 1:0:0:0: [sda] Attached SCSI disk
[   66.750574] scsi 1:0:1:0: CD-ROM            TEAC     CD-224E          1.=
7A PQ: 0 ANSI: 5
[   66.869895] mice: PS/2 mouse device common for all mice
[   66.952256] TCP cubic registered
[   66.994767] NET: Registered protocol family 17
[   67.059502] registered taskstats version 1
[   67.145972] kjournald starting.  Commit interval 5 seconds
[   67.218780] EXT3-fs: mounted filesystem with ordered data mode.
[   67.297056] VFS: Mounted root (ext3 filesystem) readonly.
Mount failed for selinuxfs on /selinux:  No such file or directory
INIT: version 2.86 booting
[   68.340896] stty used greatest stack depth: 7168 bytes left
[   68.677473] sed used greatest stack depth: 6848 bytes left
[   69.253393] mount used greatest stack depth: 6064 bytes left
[   70.221733] create_static_n used greatest stack depth: 256 bytes left
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...[   72.439968] Linux Tulip driver=
 version 1.1.15-NAPI (Feb 27, 2007)
[   72.523626] tulip0: Old style EEPROM with no media selection information.
[   72.613371] tulip0:  MII transceiver #1 config 1000 status 782d advertis=
ing 01e1.
[   72.722125] eth0: Davicom DM9102/DM9102A rev 49 at MMIO 0x1ff00000000, E=
EPROM not present, 00:03:ba:11:b3:71, IRQ 9.
[   72.864058] tulip1: Old style EEPROM with no media selection information.
[   72.953602] tulip1:  MII transceiver #1 config 1000 status 7809 advertis=
ing 01e1.
[   73.062471] eth1: Davicom DM9102/DM9102A rev 49 at MMIO 0x1ff00002000, E=
EPROM not present, 00:03:ba:11:b3:72, IRQ 10.
[   73.451136] usbcore: registered new interface driver usbfs
[   73.524544] usbcore: registered new interface driver hub
done.
Waiting for /dev to be fully populated...[   74.268703] usbcore: registered=
 new device driver usb
[   74.366367] Driver 'sr' needs updating - please use bus_type methods
[   74.737994] ohci_hcd 0000:00:0a.0: OHCI Host Controller
[   74.809630] ohci_hcd 0000:00:0a.0: new USB bus registered, assigned bus =
number 1
[   74.907802] ohci_hcd 0000:00:0a.0: irq 11, io mem 0x1ff01000000
[   75.013765] sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
[   75.095509] Uniform CD-ROM driver Revision: 3.20
[   76.035738] sd 1:0:0:0: Attached scsi generic sg0 type 0
[   76.106582] sr 1:0:1:0: Attached scsi generic sg1 type 5
[   76.233804] ohci_irq intrstatus: 64
[   76.279627] ohci_irq intrenable: 0
[   76.324285] usb_hcd_poll_rh_status start
[   76.383030] usb usb1: configuration #1 chosen from 1 choice
[   76.457504] hub 1-0:1.0: USB hub found
[   76.507420] hub 1-0:1.0: 2 ports detected
[   76.670111] usb usb1: New USB device found, idVendor=1D6b, idProduct=0001
[   76.759790] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[   76.854840] usb usb1: Product: OHCI Host Controller
[   76.919011] usb usb1: Manufacturer: Linux 2.6.27-rc3-00661-g82d63fc-dirt=
y ohci_hcd
[   77.018583] usb usb1: SerialNumber: 0000:00:0a.0
[   77.079395] usb_hcd_poll_rh_status start
[   77.130979] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   77.232839] usb_hcd_poll_rh_status before hub_status_data
[   77.303881] ohci_hub_status_data before spin_lock_irqsave
[   77.374851] ohci_hub_status_data after spin_lock_irqsave
[   77.444679] ohci_hub_status_data return
[   77.495062] usb_hcd_poll_rh_status after hub_status_data
[   77.734791] usb_hcd_poll_rh_status start
[   77.786476] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   77.888373] usb_hcd_poll_rh_status before hub_status_data
[   77.959314] ohci_hub_status_data before spin_lock_irqsave
[   78.030299] ohci_hub_status_data after spin_lock_irqsave
[   78.100117] ohci_hub_status_data return
[   78.150496] usb_hcd_poll_rh_status after hub_status_data
[   78.234796] usb_hcd_poll_rh_status start
[   78.286474] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   78.388371] usb_hcd_poll_rh_status before hub_status_data
[   78.459313] ohci_hub_status_data before spin_lock_irqsave
[   78.530283] ohci_hub_status_data after spin_lock_irqsave
[   78.600110] ohci_hub_status_data return
[   78.650495] usb_hcd_poll_rh_status after hub_status_data
[   78.734794] usb_hcd_poll_rh_status start
[   78.786463] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   78.888366] usb_hcd_poll_rh_status before hub_status_data
[   78.959307] ohci_hub_status_data before spin_lock_irqsave
[   79.030282] ohci_hub_status_data after spin_lock_irqsave
[   79.100108] ohci_hub_status_data return
[   79.150489] usb_hcd_poll_rh_status after hub_status_data
[   79.234822] usb_hcd_poll_rh_status start
[   79.286447] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   79.388365] usb_hcd_poll_rh_status before hub_status_data
[   79.459304] ohci_hub_status_data before spin_lock_irqsave
[   79.530277] ohci_hub_status_data after spin_lock_irqsave
[   79.600103] ohci_hub_status_data return
[   79.650484] usb_hcd_poll_rh_status after hub_status_data
[   79.734784] usb_hcd_poll_rh_status start
[   79.786463] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   79.888361] usb_hcd_poll_rh_status before hub_status_data
[   79.959303] ohci_hub_status_data before spin_lock_irqsave
[   80.030274] ohci_hub_status_data after spin_lock_irqsave
[   80.100104] ohci_hub_status_data return
[   80.150482] usb_hcd_poll_rh_status after hub_status_data
[   80.234818] usb_hcd_poll_rh_status start
[   80.286461] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   80.388364] usb_hcd_poll_rh_status before hub_status_data
[   80.459304] ohci_hub_status_data before spin_lock_irqsave
[   80.530274] ohci_hub_status_data after spin_lock_irqsave
[   80.600102] ohci_hub_status_data return
[   80.650484] usb_hcd_poll_rh_status after hub_status_data
[   80.734784] usb_hcd_poll_rh_status start
[   80.786459] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   80.888360] usb_hcd_poll_rh_status before hub_status_data
[   80.959298] ohci_hub_status_data before spin_lock_irqsave
[   81.030270] ohci_hub_status_data after spin_lock_irqsave
[   81.100098] ohci_hub_status_data return
[   81.150481] usb_hcd_poll_rh_status after hub_status_data
[   81.234793] usb_hcd_poll_rh_status start
[   81.286466] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   81.388359] usb_hcd_poll_rh_status before hub_status_data
[   81.459297] ohci_hub_status_data before spin_lock_irqsave
[   81.530271] ohci_hub_status_data after spin_lock_irqsave
[   81.600099] ohci_hub_status_data return
[   81.650477] usb_hcd_poll_rh_status after hub_status_data
[   81.734792] usb_hcd_poll_rh_status start
[   81.786456] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   81.888356] usb_hcd_poll_rh_status before hub_status_data
[   81.959298] ohci_hub_status_data before spin_lock_irqsave
[   82.030269] ohci_hub_status_data after spin_lock_irqsave
[   82.100097] ohci_hub_status_data return
[   82.150477] usb_hcd_poll_rh_status after hub_status_data
[   82.234787] usb_hcd_poll_rh_status start
[   82.286453] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   82.388354] usb_hcd_poll_rh_status before hub_status_data
[   82.459296] ohci_hub_status_data before spin_lock_irqsave
[   82.530265] ohci_hub_status_data after spin_lock_irqsave
[   82.600093] ohci_hub_status_data return
[   82.650478] usb_hcd_poll_rh_status after hub_status_data
[   82.734787] usb_hcd_poll_rh_status start
[   82.786441] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   82.888347] usb_hcd_poll_rh_status before hub_status_data
[   82.959294] ohci_hub_status_data before spin_lock_irqsave
[   83.030259] ohci_hub_status_data after spin_lock_irqsave
[   83.100091] ohci_hub_status_data return
[   83.150473] usb_hcd_poll_rh_status after hub_status_data
[   83.234787] usb_hcd_poll_rh_status start
[   83.286449] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   83.388351] usb_hcd_poll_rh_status before hub_status_data
[   83.459290] ohci_hub_status_data before spin_lock_irqsave
[   83.530260] ohci_hub_status_data after spin_lock_irqsave
[   83.600089] ohci_hub_status_data return
[   83.650469] usb_hcd_poll_rh_status after hub_status_data
[   83.734823] usb_hcd_poll_rh_status start
[   83.786445] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   83.888344] usb_hcd_poll_rh_status before hub_status_data
[   83.959285] ohci_hub_status_data before spin_lock_irqsave
[   84.030257] ohci_hub_status_data after spin_lock_irqsave
[   84.100085] ohci_hub_status_data return
[   84.150470] usb_hcd_poll_rh_status after hub_status_data
[   84.234798] usb_hcd_poll_rh_status start
[   84.286447] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   84.388344] usb_hcd_poll_rh_status before hub_status_data
[   84.459289] ohci_hub_status_data before spin_lock_irqsave
[   84.530257] ohci_hub_status_data after spin_lock_irqsave
[   84.600088] ohci_hub_status_data return
[   84.650469] usb_hcd_poll_rh_status after hub_status_data
[   84.734795] usb_hcd_poll_rh_status start
[   84.786442] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   84.888345] usb_hcd_poll_rh_status before hub_status_data
[   84.959287] ohci_hub_status_data before spin_lock_irqsave
[   85.030257] ohci_hub_status_data after spin_lock_irqsave
[   85.100085] ohci_hub_status_data return
[   85.150464] usb_hcd_poll_rh_status after hub_status_data
[   85.234797] usb_hcd_poll_rh_status start
[   85.286442] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   85.388340] usb_hcd_poll_rh_status before hub_status_data
[   85.459280] ohci_hub_status_data before spin_lock_irqsave
[   85.530254] ohci_hub_status_data after spin_lock_irqsave
[   85.600081] ohci_hub_status_data return
[   85.650462] usb_hcd_poll_rh_status after hub_status_data
[   85.734803] usb_hcd_poll_rh_status start
[   85.786437] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   85.888339] usb_hcd_poll_rh_status before hub_status_data
[   85.959279] ohci_hub_status_data before spin_lock_irqsave
[   86.030247] ohci_hub_status_data after spin_lock_irqsave
[   86.100079] ohci_hub_status_data return
[   86.150460] usb_hcd_poll_rh_status after hub_status_data
[   86.234795] usb_hcd_poll_rh_status start
[   86.286434] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   86.388335] usb_hcd_poll_rh_status before hub_status_data
[   86.459277] ohci_hub_status_data before spin_lock_irqsave
[   86.530248] ohci_hub_status_data after spin_lock_irqsave
[   86.600077] ohci_hub_status_data return
[   86.650459] usb_hcd_poll_rh_status after hub_status_data
[   86.734793] usb_hcd_poll_rh_status start
[   86.786434] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   86.888332] usb_hcd_poll_rh_status before hub_status_data
[   86.959274] ohci_hub_status_data before spin_lock_irqsave
[   87.030243] ohci_hub_status_data after spin_lock_irqsave
[   87.100074] ohci_hub_status_data return
[   87.150455] usb_hcd_poll_rh_status after hub_status_data
[   87.234815] usb_hcd_poll_rh_status start
[   87.286433] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   87.388331] usb_hcd_poll_rh_status before hub_status_data
[   87.459272] ohci_hub_status_data before spin_lock_irqsave
[   87.530242] ohci_hub_status_data after spin_lock_irqsave
[   87.600071] ohci_hub_status_data return
[   87.650452] usb_hcd_poll_rh_status after hub_status_data
[   87.734797] usb_hcd_poll_rh_status start
[   87.786431] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   87.888334] usb_hcd_poll_rh_status before hub_status_data
[   87.959272] ohci_hub_status_data before spin_lock_irqsave
[   88.030242] ohci_hub_status_data after spin_lock_irqsave
[   88.100068] ohci_hub_status_data return
[   88.150452] usb_hcd_poll_rh_status after hub_status_data
[   88.234805] usb_hcd_poll_rh_status start
[   88.286412] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   88.388328] usb_hcd_poll_rh_status before hub_status_data
[   88.459269] ohci_hub_status_data before spin_lock_irqsave
[   88.530238] ohci_hub_status_data after spin_lock_irqsave
[   88.600066] ohci_hub_status_data return
[   88.650450] usb_hcd_poll_rh_status after hub_status_data
[   88.734782] usb_hcd_poll_rh_status start
[   88.786413] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   88.888325] usb_hcd_poll_rh_status before hub_status_data
[   88.959263] ohci_hub_status_data before spin_lock_irqsave
[   89.030237] ohci_hub_status_data after spin_lock_irqsave
[   89.100064] ohci_hub_status_data return
[   89.150448] usb_hcd_poll_rh_status after hub_status_data
[   89.234800] usb_hcd_poll_rh_status start
[   89.286427] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   89.388326] usb_hcd_poll_rh_status before hub_status_data
[   89.459266] ohci_hub_status_data before spin_lock_irqsave
[   89.530236] ohci_hub_status_data after spin_lock_irqsave
[   89.600067] ohci_hub_status_data return
[   89.650448] usb_hcd_poll_rh_status after hub_status_data
[   89.734789] usb_hcd_poll_rh_status start
[   89.786425] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   89.888319] usb_hcd_poll_rh_status before hub_status_data
[   89.959264] ohci_hub_status_data before spin_lock_irqsave
[   90.030232] ohci_hub_status_data after spin_lock_irqsave
[   90.100061] ohci_hub_status_data return
[   90.150444] usb_hcd_poll_rh_status after hub_status_data
[   90.234805] usb_hcd_poll_rh_status start
[   90.286424] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   90.388319] usb_hcd_poll_rh_status before hub_status_data
[   90.459262] ohci_hub_status_data before spin_lock_irqsave
[   90.530231] ohci_hub_status_data after spin_lock_irqsave
[   90.600060] ohci_hub_status_data return
[   90.650441] usb_hcd_poll_rh_status after hub_status_data
[   90.734790] usb_hcd_poll_rh_status start
[   90.786418] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   90.888319] usb_hcd_poll_rh_status before hub_status_data
[   90.959258] ohci_hub_status_data before spin_lock_irqsave
[   91.030229] ohci_hub_status_data after spin_lock_irqsave
[   91.100056] ohci_hub_status_data return
[   91.150438] usb_hcd_poll_rh_status after hub_status_data
[   91.234864] usb_hcd_poll_rh_status start
[   91.286519] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   91.388417] usb_hcd_poll_rh_status before hub_status_data
[   91.459360] ohci_hub_status_data before spin_lock_irqsave
[   91.530330] ohci_hub_status_data after spin_lock_irqsave
[   91.600158] ohci_hub_status_data return
[   91.650541] usb_hcd_poll_rh_status after hub_status_data
[   91.734792] usb_hcd_poll_rh_status start
[   91.786415] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   91.888309] usb_hcd_poll_rh_status before hub_status_data
[   91.959253] ohci_hub_status_data before spin_lock_irqsave
[   92.030223] ohci_hub_status_data after spin_lock_irqsave
[   92.100051] ohci_hub_status_data return
[   92.150432] usb_hcd_poll_rh_status after hub_status_data
[   92.234775] usb_hcd_poll_rh_status start
[   92.286409] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   92.388312] usb_hcd_poll_rh_status before hub_status_data
[   92.459253] ohci_hub_status_data before spin_lock_irqsave
[   92.530220] ohci_hub_status_data after spin_lock_irqsave
[   92.600052] ohci_hub_status_data return
[   92.650434] usb_hcd_poll_rh_status after hub_status_data
[   92.734809] usb_hcd_poll_rh_status start
[   92.786404] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   92.888309] usb_hcd_poll_rh_status before hub_status_data
[   92.959248] ohci_hub_status_data before spin_lock_irqsave
[   93.030222] ohci_hub_status_data after spin_lock_irqsave
[   93.100049] ohci_hub_status_data return
[   93.150432] usb_hcd_poll_rh_status after hub_status_data
[   93.234846] usb_hcd_poll_rh_status start
[   93.286510] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   93.388411] usb_hcd_poll_rh_status before hub_status_data
[   93.459350] ohci_hub_status_data before spin_lock_irqsave
[   93.530324] ohci_hub_status_data after spin_lock_irqsave
[   93.600148] ohci_hub_status_data return
[   93.650533] usb_hcd_poll_rh_status after hub_status_data
[   93.734781] usb_hcd_poll_rh_status start
[   93.786404] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   93.888305] usb_hcd_poll_rh_status before hub_status_data
[   93.959246] ohci_hub_status_data before spin_lock_irqsave
[   94.030215] ohci_hub_status_data after spin_lock_irqsave
[   94.100045] ohci_hub_status_data return
[   94.150426] usb_hcd_poll_rh_status after hub_status_data
[   94.234797] usb_hcd_poll_rh_status start
[   94.286399] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   94.388303] usb_hcd_poll_rh_status before hub_status_data
[   94.459244] ohci_hub_status_data before spin_lock_irqsave
[   94.530214] ohci_hub_status_data after spin_lock_irqsave
[   94.600045] ohci_hub_status_data return
[   94.650424] usb_hcd_poll_rh_status after hub_status_data
[   94.734819] usb_hcd_poll_rh_status start
[   94.786402] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   94.888302] usb_hcd_poll_rh_status before hub_status_data
[   94.959240] ohci_hub_status_data before spin_lock_irqsave
[   95.030212] ohci_hub_status_data after spin_lock_irqsave
[   95.100041] ohci_hub_status_data return
[   95.150423] usb_hcd_poll_rh_status after hub_status_data
[   95.234809] usb_hcd_poll_rh_status start
[   95.286399] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   95.388301] usb_hcd_poll_rh_status before hub_status_data
[   95.459237] ohci_hub_status_data before spin_lock_irqsave
[   95.530208] ohci_hub_status_data after spin_lock_irqsave
[   95.600036] ohci_hub_status_data return
[   95.650420] usb_hcd_poll_rh_status after hub_status_data
[   95.734788] usb_hcd_poll_rh_status start
[   95.786392] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   95.888296] usb_hcd_poll_rh_status before hub_status_data
[   95.959236] ohci_hub_status_data before spin_lock_irqsave
[   96.030210] ohci_hub_status_data after spin_lock_irqsave
[   96.100036] ohci_hub_status_data return
[   96.150416] usb_hcd_poll_rh_status after hub_status_data
[   96.234808] usb_hcd_poll_rh_status start
[   96.286370] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   96.388293] usb_hcd_poll_rh_status before hub_status_data
[   96.459236] ohci_hub_status_data before spin_lock_irqsave
[   96.530205] ohci_hub_status_data after spin_lock_irqsave
[   96.600033] ohci_hub_status_data return
[   96.650414] usb_hcd_poll_rh_status after hub_status_data
[   96.734797] usb_hcd_poll_rh_status start
[   96.786386] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   96.888290] usb_hcd_poll_rh_status before hub_status_data
[   96.959232] ohci_hub_status_data before spin_lock_irqsave
[   97.030202] ohci_hub_status_data after spin_lock_irqsave
[   97.100031] ohci_hub_status_data return
[   97.150414] usb_hcd_poll_rh_status after hub_status_data
[   97.234804] usb_hcd_poll_rh_status start
[   97.286391] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   97.388295] usb_hcd_poll_rh_status before hub_status_data
[   97.459232] ohci_hub_status_data before spin_lock_irqsave
[   97.530205] ohci_hub_status_data after spin_lock_irqsave
[   97.600032] ohci_hub_status_data return
[   97.650413] usb_hcd_poll_rh_status after hub_status_data
[   97.734788] usb_hcd_poll_rh_status start
[   97.786389] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   97.888288] usb_hcd_poll_rh_status before hub_status_data
[   97.959229] ohci_hub_status_data before spin_lock_irqsave
[   98.030202] ohci_hub_status_data after spin_lock_irqsave
[   98.100027] ohci_hub_status_data return
[   98.150410] usb_hcd_poll_rh_status after hub_status_data
[   98.234968] usb_hcd_poll_rh_status start
[   98.286596] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   98.388492] usb_hcd_poll_rh_status before hub_status_data
[   98.459435] ohci_hub_status_data before spin_lock_irqsave
[   98.530403] ohci_hub_status_data after spin_lock_irqsave
[   98.600232] ohci_hub_status_data return
[   98.650617] usb_hcd_poll_rh_status after hub_status_data
[   98.734795] usb_hcd_poll_rh_status start
[   98.786384] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   98.888283] usb_hcd_poll_rh_status before hub_status_data
[   98.959226] ohci_hub_status_data before spin_lock_irqsave
[   99.030197] ohci_hub_status_data after spin_lock_irqsave
[   99.100024] ohci_hub_status_data return
[   99.150404] usb_hcd_poll_rh_status after hub_status_data
[   99.234795] usb_hcd_poll_rh_status start
[   99.286383] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   99.388283] usb_hcd_poll_rh_status before hub_status_data
[   99.459224] ohci_hub_status_data before spin_lock_irqsave
[   99.530194] ohci_hub_status_data after spin_lock_irqsave
[   99.600021] ohci_hub_status_data return
[   99.650403] usb_hcd_poll_rh_status after hub_status_data
[   99.734786] usb_hcd_poll_rh_status start
[   99.786382] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[   99.888279] usb_hcd_poll_rh_status before hub_status_data
[   99.959219] ohci_hub_status_data before spin_lock_irqsave
[  100.030190] ohci_hub_status_data after spin_lock_irqsave
[  100.100018] ohci_hub_status_data return
[  100.150402] usb_hcd_poll_rh_status after hub_status_data
[  100.234795] usb_hcd_poll_rh_status start
[  100.286379] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  100.388277] usb_hcd_poll_rh_status before hub_status_data
[  100.459219] ohci_hub_status_data before spin_lock_irqsave
[  100.530188] ohci_hub_status_data after spin_lock_irqsave
[  100.600018] ohci_hub_status_data return
[  100.650399] usb_hcd_poll_rh_status after hub_status_data
[  100.734786] usb_hcd_poll_rh_status start
[  100.786374] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  100.888274] usb_hcd_poll_rh_status before hub_status_data
[  100.959217] ohci_hub_status_data before spin_lock_irqsave
[  101.030188] ohci_hub_status_data after spin_lock_irqsave
[  101.100017] ohci_hub_status_data return
[  101.150400] usb_hcd_poll_rh_status after hub_status_data
[  101.234791] usb_hcd_poll_rh_status start
[  101.286374] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  101.388275] usb_hcd_poll_rh_status before hub_status_data
[  101.459219] ohci_hub_status_data before spin_lock_irqsave
[  101.530189] ohci_hub_status_data after spin_lock_irqsave
[  101.600017] ohci_hub_status_data return
[  101.650400] usb_hcd_poll_rh_status after hub_status_data
[  101.734791] usb_hcd_poll_rh_status start
[  101.786375] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  101.888267] usb_hcd_poll_rh_status before hub_status_data
[  101.959213] ohci_hub_status_data before spin_lock_irqsave
[  102.030182] ohci_hub_status_data after spin_lock_irqsave
[  102.100013] ohci_hub_status_data return
[  102.150392] usb_hcd_poll_rh_status after hub_status_data
[  102.234784] usb_hcd_poll_rh_status start
[  102.286368] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  102.388269] usb_hcd_poll_rh_status before hub_status_data
[  102.459208] ohci_hub_status_data before spin_lock_irqsave
[  102.530180] ohci_hub_status_data after spin_lock_irqsave
[  102.600007] ohci_hub_status_data return
[  102.650390] usb_hcd_poll_rh_status after hub_status_data
[  102.734787] usb_hcd_poll_rh_status start
[  102.786363] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  102.888267] usb_hcd_poll_rh_status before hub_status_data
[  102.959209] ohci_hub_status_data before spin_lock_irqsave
[  103.030178] ohci_hub_status_data after spin_lock_irqsave
[  103.100305] ohci_hub_status_data return
[  103.150710] usb_hcd_poll_rh_status after hub_status_data
[  103.234804] usb_hcd_poll_rh_status start
[  103.286467] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  103.388370] usb_hcd_poll_rh_status before hub_status_data
[  103.459308] ohci_hub_status_data before spin_lock_irqsave
[  103.530279] ohci_hub_status_data after spin_lock_irqsave
[  103.600106] ohci_hub_status_data return
[  103.650491] usb_hcd_poll_rh_status after hub_status_data
[  103.734806] usb_hcd_poll_rh_status start
[  103.786470] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  103.888366] usb_hcd_poll_rh_status before hub_status_data
[  103.959308] ohci_hub_status_data before spin_lock_irqsave
[  104.030278] ohci_hub_status_data after spin_lock_irqsave
[  104.100105] ohci_hub_status_data return
[  104.150490] usb_hcd_poll_rh_status after hub_status_data
[  104.234825] usb_hcd_poll_rh_status start
[  104.286466] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  104.388362] usb_hcd_poll_rh_status before hub_status_data
[  104.459307] ohci_hub_status_data before spin_lock_irqsave
[  104.530275] ohci_hub_status_data after spin_lock_irqsave
[  104.600106] ohci_hub_status_data return
[  104.650487] usb_hcd_poll_rh_status after hub_status_data
[  104.734791] usb_hcd_poll_rh_status start
[  104.786461] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  104.888361] usb_hcd_poll_rh_status before hub_status_data
[  104.959304] ohci_hub_status_data before spin_lock_irqsave
[  105.030274] ohci_hub_status_data after spin_lock_irqsave
[  105.100105] ohci_hub_status_data return
[  105.150486] usb_hcd_poll_rh_status after hub_status_data
[  105.234792] usb_hcd_poll_rh_status start
[  105.286462] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  105.388360] usb_hcd_poll_rh_status before hub_status_data
[  105.459304] ohci_hub_status_data before spin_lock_irqsave
[  105.530273] ohci_hub_status_data after spin_lock_irqsave
[  105.600102] ohci_hub_status_data return
[  105.650485] usb_hcd_poll_rh_status after hub_status_data
[  105.734807] usb_hcd_poll_rh_status start
[  105.786457] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  105.888358] usb_hcd_poll_rh_status before hub_status_data
[  105.959298] ohci_hub_status_data before spin_lock_irqsave
[  106.030271] ohci_hub_status_data after spin_lock_irqsave
[  106.100098] ohci_hub_status_data return
[  106.150479] usb_hcd_poll_rh_status after hub_status_data
[  106.234848] usb_hcd_poll_rh_status start
[  106.286457] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  106.388359] usb_hcd_poll_rh_status before hub_status_data
[  106.459298] ohci_hub_status_data before spin_lock_irqsave
[  106.530267] ohci_hub_status_data after spin_lock_irqsave
[  106.600095] ohci_hub_status_data return
[  106.650479] usb_hcd_poll_rh_status after hub_status_data
[  106.734825] usb_hcd_poll_rh_status start
[  106.786449] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  106.888353] usb_hcd_poll_rh_status before hub_status_data
[  106.959295] ohci_hub_status_data before spin_lock_irqsave
[  107.030266] ohci_hub_status_data after spin_lock_irqsave
[  107.100092] ohci_hub_status_data return
[  107.150475] usb_hcd_poll_rh_status after hub_status_data
[  107.234781] usb_hcd_poll_rh_status start
[  107.286447] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  107.388348] usb_hcd_poll_rh_status before hub_status_data
[  107.459293] ohci_hub_status_data before spin_lock_irqsave
[  107.530263] ohci_hub_status_data after spin_lock_irqsave
[  107.600091] ohci_hub_status_data return
[  107.650473] usb_hcd_poll_rh_status after hub_status_data
[  107.734788] usb_hcd_poll_rh_status start
[  107.786446] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  107.888351] usb_hcd_poll_rh_status before hub_status_data
[  107.959289] ohci_hub_status_data before spin_lock_irqsave
[  108.030261] ohci_hub_status_data after spin_lock_irqsave
[  108.100089] ohci_hub_status_data return
[  108.150472] usb_hcd_poll_rh_status after hub_status_data
[  108.234795] usb_hcd_poll_rh_status start
[  108.286534] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  108.388458] usb_hcd_poll_rh_status before hub_status_data
[  108.459395] ohci_hub_status_data before spin_lock_irqsave
[  108.530365] ohci_hub_status_data after spin_lock_irqsave
[  108.600192] ohci_hub_status_data return
[  108.650574] usb_hcd_poll_rh_status after hub_status_data
[  108.734788] usb_hcd_poll_rh_status start
[  108.786417] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  108.888341] usb_hcd_poll_rh_status before hub_status_data
[  108.959284] ohci_hub_status_data before spin_lock_irqsave
[  109.030258] ohci_hub_status_data after spin_lock_irqsave
[  109.100086] ohci_hub_status_data return
[  109.150467] usb_hcd_poll_rh_status after hub_status_data
[  109.234792] usb_hcd_poll_rh_status start
[  109.286448] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  109.388343] usb_hcd_poll_rh_status before hub_status_data
[  109.459286] ohci_hub_status_data before spin_lock_irqsave
[  109.530257] ohci_hub_status_data after spin_lock_irqsave
[  109.600085] ohci_hub_status_data return
[  109.650465] usb_hcd_poll_rh_status after hub_status_data
[  109.734797] usb_hcd_poll_rh_status start
[  109.786443] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  109.888341] usb_hcd_poll_rh_status before hub_status_data
[  109.959285] ohci_hub_status_data before spin_lock_irqsave
[  110.030255] ohci_hub_status_data after spin_lock_irqsave
[  110.100080] ohci_hub_status_data return
[  110.150462] usb_hcd_poll_rh_status after hub_status_data
[  110.234851] usb_hcd_poll_rh_status start
[  110.286441] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  110.388339] usb_hcd_poll_rh_status before hub_status_data
[  110.459278] ohci_hub_status_data before spin_lock_irqsave
[  110.530249] ohci_hub_status_data after spin_lock_irqsave
[  110.600080] ohci_hub_status_data return
[  110.650460] usb_hcd_poll_rh_status after hub_status_data
[  110.734793] usb_hcd_poll_rh_status start
[  110.786436] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  110.888334] usb_hcd_poll_rh_status before hub_status_data
[  110.959277] ohci_hub_status_data before spin_lock_irqsave
[  111.030249] ohci_hub_status_data after spin_lock_irqsave
[  111.100076] ohci_hub_status_data return
[  111.150459] usb_hcd_poll_rh_status after hub_status_data
[  111.234790] usb_hcd_poll_rh_status start
[  111.286433] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  111.388337] usb_hcd_poll_rh_status before hub_status_data
[  111.459276] ohci_hub_status_data before spin_lock_irqsave
[  111.530246] ohci_hub_status_data after spin_lock_irqsave
[  111.600073] ohci_hub_status_data return
[  111.650458] usb_hcd_poll_rh_status after hub_status_data
[  111.734797] usb_hcd_poll_rh_status start
[  111.786432] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  111.888334] usb_hcd_poll_rh_status before hub_status_data
[  111.959274] ohci_hub_status_data before spin_lock_irqsave
[  112.030243] ohci_hub_status_data after spin_lock_irqsave
[  112.100072] ohci_hub_status_data return
[  112.150455] usb_hcd_poll_rh_status after hub_status_data
[  112.234847] usb_hcd_poll_rh_status start
[  112.286433] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  112.388331] usb_hcd_poll_rh_status before hub_status_data
[  112.459274] ohci_hub_status_data before spin_lock_irqsave
[  112.530241] ohci_hub_status_data after spin_lock_irqsave
[  112.600070] ohci_hub_status_data return
[  112.650451] usb_hcd_poll_rh_status after hub_status_data
[  112.734790] usb_hcd_poll_rh_status start
[  112.786430] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  112.888330] usb_hcd_poll_rh_status before hub_status_data
[  112.959271] ohci_hub_status_data before spin_lock_irqsave
[  113.030241] ohci_hub_status_data after spin_lock_irqsave
[  113.100069] ohci_hub_status_data return
[  113.150451] usb_hcd_poll_rh_status after hub_status_data
[  113.234796] usb_hcd_poll_rh_status start
[  113.286427] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  113.388331] usb_hcd_poll_rh_status before hub_status_data
[  113.459269] ohci_hub_status_data before spin_lock_irqsave
[  113.530238] ohci_hub_status_data after spin_lock_irqsave
[  113.600066] ohci_hub_status_data return
[  113.650450] usb_hcd_poll_rh_status after hub_status_data
[  113.734810] usb_hcd_poll_rh_status start
[  113.786423] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  113.888324] usb_hcd_poll_rh_status before hub_status_data
[  113.959266] ohci_hub_status_data before spin_lock_irqsave
[  114.030235] ohci_hub_status_data after spin_lock_irqsave
[  114.100066] ohci_hub_status_data return
[  114.150445] usb_hcd_poll_rh_status after hub_status_data
[  114.234786] usb_hcd_poll_rh_status start
[  114.286420] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  114.388321] usb_hcd_poll_rh_status before hub_status_data
[  114.459264] ohci_hub_status_data before spin_lock_irqsave
[  114.530234] ohci_hub_status_data after spin_lock_irqsave
[  114.600061] ohci_hub_status_data return
[  114.650442] usb_hcd_poll_rh_status after hub_status_data
[  114.734797] usb_hcd_poll_rh_status start
[  114.786422] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  114.888318] usb_hcd_poll_rh_status before hub_status_data
[  114.959259] ohci_hub_status_data before spin_lock_irqsave
[  115.030232] ohci_hub_status_data after spin_lock_irqsave
[  115.100059] ohci_hub_status_data return
[  115.150444] usb_hcd_poll_rh_status after hub_status_data
[  115.234794] usb_hcd_poll_rh_status start
[  115.286425] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  115.388317] usb_hcd_poll_rh_status before hub_status_data
[  115.459260] ohci_hub_status_data before spin_lock_irqsave
[  115.530229] ohci_hub_status_data after spin_lock_irqsave
[  115.600057] ohci_hub_status_data return
[  115.650441] usb_hcd_poll_rh_status after hub_status_data
[  115.734789] usb_hcd_poll_rh_status start
[  115.786420] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  115.888315] usb_hcd_poll_rh_status before hub_status_data
[  115.959256] ohci_hub_status_data before spin_lock_irqsave
[  116.030226] ohci_hub_status_data after spin_lock_irqsave
[  116.100054] ohci_hub_status_data return
[  116.150437] usb_hcd_poll_rh_status after hub_status_data
[  116.234796] usb_hcd_poll_rh_status start
[  116.286418] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  116.388317] usb_hcd_poll_rh_status before hub_status_data
[  116.459256] ohci_hub_status_data before spin_lock_irqsave
[  116.530226] ohci_hub_status_data after spin_lock_irqsave
[  116.600057] ohci_hub_status_data return
[  116.650436] usb_hcd_poll_rh_status after hub_status_data
[  116.734787] usb_hcd_poll_rh_status start
[  116.786412] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  116.888311] usb_hcd_poll_rh_status before hub_status_data
[  116.959253] ohci_hub_status_data before spin_lock_irqsave
[  117.030224] ohci_hub_status_data after spin_lock_irqsave
[  117.100052] ohci_hub_status_data return
[  117.150431] usb_hcd_poll_rh_status after hub_status_data
[  117.234796] usb_hcd_poll_rh_status start
[  117.286415] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  117.388308] usb_hcd_poll_rh_status before hub_status_data
[  117.459251] ohci_hub_status_data before spin_lock_irqsave
[  117.530223] ohci_hub_status_data after spin_lock_irqsave
[  117.600053] ohci_hub_status_data return
[  117.650432] usb_hcd_poll_rh_status after hub_status_data
[  117.734813] usb_hcd_poll_rh_status start
[  117.786411] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  117.888307] usb_hcd_poll_rh_status before hub_status_data
[  117.959247] ohci_hub_status_data before spin_lock_irqsave
[  118.030218] ohci_hub_status_data after spin_lock_irqsave
[  118.100047] ohci_hub_status_data return
[  118.150430] usb_hcd_poll_rh_status after hub_status_data
[  118.234806] usb_hcd_poll_rh_status start
[  118.286409] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  118.388307] usb_hcd_poll_rh_status before hub_status_data
[  118.459246] ohci_hub_status_data before spin_lock_irqsave
[  118.530219] ohci_hub_status_data after spin_lock_irqsave
[  118.600046] ohci_hub_status_data return
[  118.650430] usb_hcd_poll_rh_status after hub_status_data
[  118.734786] usb_hcd_poll_rh_status start
[  118.786401] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  118.888302] usb_hcd_poll_rh_status before hub_status_data
[  118.959244] ohci_hub_status_data before spin_lock_irqsave
[  119.030216] ohci_hub_status_data after spin_lock_irqsave
[  119.100043] ohci_hub_status_data return
[  119.150425] usb_hcd_poll_rh_status after hub_status_data
[  119.234802] usb_hcd_poll_rh_status start
[  119.286403] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  119.388301] usb_hcd_poll_rh_status before hub_status_data
[  119.459242] ohci_hub_status_data before spin_lock_irqsave
[  119.530210] ohci_hub_status_data after spin_lock_irqsave
[  119.600041] ohci_hub_status_data return
[  119.650424] usb_hcd_poll_rh_status after hub_status_data
[  119.734794] usb_hcd_poll_rh_status start
[  119.786401] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  119.888296] usb_hcd_poll_rh_status before hub_status_data
[  119.959241] ohci_hub_status_data before spin_lock_irqsave
[  120.030213] ohci_hub_status_data after spin_lock_irqsave
[  120.100039] ohci_hub_status_data return
[  120.150422] usb_hcd_poll_rh_status after hub_status_data
[  120.234835] usb_hcd_poll_rh_status start
[  120.286492] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  120.388399] usb_hcd_poll_rh_status before hub_status_data
[  120.459342] ohci_hub_status_data before spin_lock_irqsave
[  120.530314] ohci_hub_status_data after spin_lock_irqsave
[  120.600139] ohci_hub_status_data return
[  120.650522] usb_hcd_poll_rh_status after hub_status_data
[  120.734792] usb_hcd_poll_rh_status start
[  120.786400] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  120.888295] usb_hcd_poll_rh_status before hub_status_data
[  120.959236] ohci_hub_status_data before spin_lock_irqsave
[  121.030208] ohci_hub_status_data after spin_lock_irqsave
[  121.100033] ohci_hub_status_data return
[  121.150416] usb_hcd_poll_rh_status after hub_status_data
[  121.234796] usb_hcd_poll_rh_status start
[  121.286397] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  121.388293] usb_hcd_poll_rh_status before hub_status_data
[  121.459237] ohci_hub_status_data before spin_lock_irqsave
[  121.530204] ohci_hub_status_data after spin_lock_irqsave
[  121.600032] ohci_hub_status_data return
[  121.650414] usb_hcd_poll_rh_status after hub_status_data
[  121.734798] usb_hcd_poll_rh_status start
[  121.786394] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  121.888289] usb_hcd_poll_rh_status before hub_status_data
[  121.959232] ohci_hub_status_data before spin_lock_irqsave
[  122.030203] ohci_hub_status_data after spin_lock_irqsave
[  122.100032] ohci_hub_status_data return
[  122.150415] usb_hcd_poll_rh_status after hub_status_data
[  122.234793] usb_hcd_poll_rh_status start
[  122.286389] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  122.388288] usb_hcd_poll_rh_status before hub_status_data
[  122.459230] ohci_hub_status_data before spin_lock_irqsave
[  122.530201] ohci_hub_status_data after spin_lock_irqsave
[  122.600030] ohci_hub_status_data return
[  122.650412] usb_hcd_poll_rh_status after hub_status_data
[  122.734798] usb_hcd_poll_rh_status start
[  122.786386] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  122.888286] usb_hcd_poll_rh_status before hub_status_data
[  122.959227] ohci_hub_status_data before spin_lock_irqsave
[  123.030198] ohci_hub_status_data after spin_lock_irqsave
[  123.100026] ohci_hub_status_data return
[  123.150409] usb_hcd_poll_rh_status after hub_status_data
[  123.234817] usb_hcd_poll_rh_status start
[  123.286478] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  123.388388] usb_hcd_poll_rh_status before hub_status_data
[  123.459330] ohci_hub_status_data before spin_lock_irqsave
[  123.530301] ohci_hub_status_data after spin_lock_irqsave
[  123.600130] ohci_hub_status_data return
[  123.650511] usb_hcd_poll_rh_status after hub_status_data
[  123.734792] usb_hcd_poll_rh_status start
[  123.786385] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  123.888282] usb_hcd_poll_rh_status before hub_status_data
[  123.959223] ohci_hub_status_data before spin_lock_irqsave
[  124.030194] ohci_hub_status_data after spin_lock_irqsave
[  124.100024] ohci_hub_status_data return
[  124.150406] usb_hcd_poll_rh_status after hub_status_data
[  124.234799] usb_hcd_poll_rh_status start
[  124.286383] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  124.388281] usb_hcd_poll_rh_status before hub_status_data
[  124.459223] ohci_hub_status_data before spin_lock_irqsave
[  124.530194] ohci_hub_status_data after spin_lock_irqsave
[  124.600022] ohci_hub_status_data return
[  124.650401] usb_hcd_poll_rh_status after hub_status_data
[  124.734786] usb_hcd_poll_rh_status start
[  124.786373] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  124.888280] usb_hcd_poll_rh_status before hub_status_data
[  124.959218] ohci_hub_status_data before spin_lock_irqsave
[  125.030188] ohci_hub_status_data after spin_lock_irqsave
[  125.100017] ohci_hub_status_data return
[  125.150401] usb_hcd_poll_rh_status after hub_status_data
[  125.234845] usb_hcd_poll_rh_status start
[  125.286475] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  125.388379] usb_hcd_poll_rh_status before hub_status_data
[  125.459322] ohci_hub_status_data before spin_lock_irqsave
[  125.530291] ohci_hub_status_data after spin_lock_irqsave
[  125.600119] ohci_hub_status_data return
[  125.650501] usb_hcd_poll_rh_status after hub_status_data
[  125.734789] usb_hcd_poll_rh_status start
[  125.786362] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  125.888272] usb_hcd_poll_rh_status before hub_status_data
[  125.959214] ohci_hub_status_data before spin_lock_irqsave
[  126.030186] ohci_hub_status_data after spin_lock_irqsave
[  126.100012] ohci_hub_status_data return
[  126.150395] usb_hcd_poll_rh_status after hub_status_data
[  126.234788] usb_hcd_poll_rh_status start
[  126.286368] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  126.388274] usb_hcd_poll_rh_status before hub_status_data
[  126.459213] ohci_hub_status_data before spin_lock_irqsave
[  126.530182] ohci_hub_status_data after spin_lock_irqsave
[  126.600011] ohci_hub_status_data return
[  126.650392] usb_hcd_poll_rh_status after hub_status_data
[  126.734793] usb_hcd_poll_rh_status start
[  126.786371] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  126.888269] usb_hcd_poll_rh_status before hub_status_data
[  126.959213] ohci_hub_status_data before spin_lock_irqsave
[  127.030181] ohci_hub_status_data after spin_lock_irqsave
[  127.100010] ohci_hub_status_data return
[  127.150392] usb_hcd_poll_rh_status after hub_status_data
[  127.234792] usb_hcd_poll_rh_status start
[  127.286465] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  127.388371] usb_hcd_poll_rh_status before hub_status_data
[  127.459311] ohci_hub_status_data before spin_lock_irqsave
[  127.530281] ohci_hub_status_data after spin_lock_irqsave
[  127.600110] ohci_hub_status_data return
[  127.650496] usb_hcd_poll_rh_status after hub_status_data
[  127.734797] usb_hcd_poll_rh_status start
[  127.786469] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  127.888372] usb_hcd_poll_rh_status before hub_status_data
[  127.959312] ohci_hub_status_data before spin_lock_irqsave
[  128.030283] ohci_hub_status_data after spin_lock_irqsave
[  128.100110] ohci_hub_status_data return
[  128.150490] usb_hcd_poll_rh_status after hub_status_data
[  128.234823] usb_hcd_poll_rh_status start
[  128.286471] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  128.388366] usb_hcd_poll_rh_status before hub_status_data
[  128.459310] ohci_hub_status_data before spin_lock_irqsave
[  128.530278] ohci_hub_status_data after spin_lock_irqsave
[  128.600112] ohci_hub_status_data return
[  128.650492] usb_hcd_poll_rh_status after hub_status_data
[  128.734793] usb_hcd_poll_rh_status start
[  128.786465] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  128.888364] usb_hcd_poll_rh_status before hub_status_data
[  128.959306] ohci_hub_status_data before spin_lock_irqsave
[  129.030275] ohci_hub_status_data after spin_lock_irqsave
[  129.100105] ohci_hub_status_data return
[  129.150488] usb_hcd_poll_rh_status after hub_status_data
[  129.234795] usb_hcd_poll_rh_status start
[  129.286471] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  129.388365] usb_hcd_poll_rh_status before hub_status_data
[  129.459307] ohci_hub_status_data before spin_lock_irqsave
[  129.530274] ohci_hub_status_data after spin_lock_irqsave
[  129.600106] ohci_hub_status_data return
[  129.650488] usb_hcd_poll_rh_status after hub_status_data
[  129.734801] usb_hcd_poll_rh_status start
[  129.786456] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  129.888358] usb_hcd_poll_rh_status before hub_status_data
[  129.959303] ohci_hub_status_data before spin_lock_irqsave
[  130.030272] ohci_hub_status_data after spin_lock_irqsave
[  130.100101] ohci_hub_status_data return
[  130.150480] usb_hcd_poll_rh_status after hub_status_data
[  130.234845] usb_hcd_poll_rh_status start
[  130.286458] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  130.388358] usb_hcd_poll_rh_status before hub_status_data
[  130.459297] ohci_hub_status_data before spin_lock_irqsave
[  130.530269] ohci_hub_status_data after spin_lock_irqsave
[  130.600097] ohci_hub_status_data return
[  130.650481] usb_hcd_poll_rh_status after hub_status_data
[  130.734791] usb_hcd_poll_rh_status start
[  130.786531] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  130.888358] usb_hcd_poll_rh_status before hub_status_data
[  130.959295] ohci_hub_status_data before spin_lock_irqsave
[  131.030266] ohci_hub_status_data after spin_lock_irqsave
[  131.100095] ohci_hub_status_data return
[  131.150478] usb_hcd_poll_rh_status after hub_status_data
[  131.234790] usb_hcd_poll_rh_status start
[  131.286457] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  131.388356] usb_hcd_poll_rh_status before hub_status_data
[  131.459295] ohci_hub_status_data before spin_lock_irqsave
[  131.530266] ohci_hub_status_data after spin_lock_irqsave
[  131.600095] ohci_hub_status_data return
[  131.650478] usb_hcd_poll_rh_status after hub_status_data
[  131.734783] usb_hcd_poll_rh_status start
[  131.786451] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  131.888353] usb_hcd_poll_rh_status before hub_status_data
[  131.959294] ohci_hub_status_data before spin_lock_irqsave
[  132.030266] ohci_hub_status_data after spin_lock_irqsave
[  132.100093] ohci_hub_status_data return
[  132.150476] usb_hcd_poll_rh_status after hub_status_data
[  132.234873] usb_hcd_poll_rh_status start
[  132.286455] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  132.388352] usb_hcd_poll_rh_status before hub_status_data
[  132.459292] ohci_hub_status_data before spin_lock_irqsave
[  132.530264] ohci_hub_status_data after spin_lock_irqsave
[  132.600093] ohci_hub_status_data return
[  132.650473] usb_hcd_poll_rh_status after hub_status_data
[  132.734799] usb_hcd_poll_rh_status start
[  132.786453] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  132.888348] usb_hcd_poll_rh_status before hub_status_data
[  132.959290] ohci_hub_status_data before spin_lock_irqsave
[  133.030261] ohci_hub_status_data after spin_lock_irqsave
[  133.100088] ohci_hub_status_data return
[  133.150473] usb_hcd_poll_rh_status after hub_status_data
[  133.234809] usb_hcd_poll_rh_status start
[  133.286450] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  133.388350] usb_hcd_poll_rh_status before hub_status_data
[  133.459288] ohci_hub_status_data before spin_lock_irqsave
[  133.530258] ohci_hub_status_data after spin_lock_irqsave
[  133.600088] ohci_hub_status_data return
[  133.650471] usb_hcd_poll_rh_status after hub_status_data
[  133.734796] usb_hcd_poll_rh_status start
[  133.786445] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  133.888346] usb_hcd_poll_rh_status before hub_status_data
[  133.959285] ohci_hub_status_data before spin_lock_irqsave
[  134.030253] ohci_hub_status_data after spin_lock_irqsave
[  134.100086] ohci_hub_status_data return
[  134.150467] usb_hcd_poll_rh_status after hub_status_data
[  134.234793] usb_hcd_poll_rh_status start
[  134.286447] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  134.388341] usb_hcd_poll_rh_status before hub_status_data
[  134.459283] ohci_hub_status_data before spin_lock_irqsave
[  134.530254] ohci_hub_status_data after spin_lock_irqsave
[  134.600083] ohci_hub_status_data return
[  134.650462] usb_hcd_poll_rh_status after hub_status_data
[  134.734830] usb_hcd_poll_rh_status start
[  134.786441] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  134.888341] usb_hcd_poll_rh_status before hub_status_data
[  134.959278] ohci_hub_status_data before spin_lock_irqsave
[  135.030251] ohci_hub_status_data after spin_lock_irqsave
[  135.100079] ohci_hub_status_data return
[  135.150462] usb_hcd_poll_rh_status after hub_status_data
[  135.234777] usb_hcd_poll_rh_status start
[  135.286433] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  135.388339] usb_hcd_poll_rh_status before hub_status_data
[  135.459281] ohci_hub_status_data before spin_lock_irqsave
[  135.530248] ohci_hub_status_data after spin_lock_irqsave
[  135.600078] ohci_hub_status_data return
[  135.650461] usb_hcd_poll_rh_status after hub_status_data
[  135.734787] usb_hcd_poll_rh_status start
[  135.786435] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  135.888335] usb_hcd_poll_rh_status before hub_status_data
[  135.959279] ohci_hub_status_data before spin_lock_irqsave
[  136.030249] ohci_hub_status_data after spin_lock_irqsave
[  136.100078] ohci_hub_status_data return
[  136.150460] usb_hcd_poll_rh_status after hub_status_data
[  136.234795] usb_hcd_poll_rh_status start
[  136.286436] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  136.388367] usb_hcd_poll_rh_status before hub_status_data
[  136.459383] ohci_hub_status_data before spin_lock_irqsave
[  136.530355] ohci_hub_status_data after spin_lock_irqsave
[  136.600181] ohci_hub_status_data return
[  136.650564] usb_hcd_poll_rh_status after hub_status_data
[  136.734796] usb_hcd_poll_rh_status start
[  136.786426] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  136.888331] usb_hcd_poll_rh_status before hub_status_data
[  136.959274] ohci_hub_status_data before spin_lock_irqsave
[  137.030242] ohci_hub_status_data after spin_lock_irqsave
[  137.100070] ohci_hub_status_data return
[  137.150454] usb_hcd_poll_rh_status after hub_status_data
[  137.234792] usb_hcd_poll_rh_status start
[  137.286430] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  137.388333] usb_hcd_poll_rh_status before hub_status_data
[  137.459271] ohci_hub_status_data before spin_lock_irqsave
[  137.530243] ohci_hub_status_data after spin_lock_irqsave
[  137.600069] ohci_hub_status_data return
[  137.650451] usb_hcd_poll_rh_status after hub_status_data
[  137.734796] usb_hcd_poll_rh_status start
[  137.786428] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  137.888326] usb_hcd_poll_rh_status before hub_status_data
[  137.959270] ohci_hub_status_data before spin_lock_irqsave
[  138.030242] ohci_hub_status_data after spin_lock_irqsave
[  138.100069] ohci_hub_status_data return
[  138.150448] usb_hcd_poll_rh_status after hub_status_data
[  138.234796] usb_hcd_poll_rh_status start
[  138.286425] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  138.388324] usb_hcd_poll_rh_status before hub_status_data
[  138.459269] ohci_hub_status_data before spin_lock_irqsave
[  138.530239] ohci_hub_status_data after spin_lock_irqsave
[  138.600068] ohci_hub_status_data return
[  138.650446] usb_hcd_poll_rh_status after hub_status_data
[  138.734805] usb_hcd_poll_rh_status start
[  138.786433] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  138.888322] usb_hcd_poll_rh_status before hub_status_data
[  138.959267] ohci_hub_status_data before spin_lock_irqsave
[  139.030237] ohci_hub_status_data after spin_lock_irqsave
[  139.100066] ohci_hub_status_data return
[  139.150447] usb_hcd_poll_rh_status after hub_status_data
[  139.234808] usb_hcd_poll_rh_status start
[  139.286426] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  139.388325] usb_hcd_poll_rh_status before hub_status_data
[  139.459262] ohci_hub_status_data before spin_lock_irqsave
[  139.530235] ohci_hub_status_data after spin_lock_irqsave
[  139.600062] ohci_hub_status_data return
[  139.650444] usb_hcd_poll_rh_status after hub_status_data
[  139.734794] usb_hcd_poll_rh_status start
[  139.786420] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  139.888320] usb_hcd_poll_rh_status before hub_status_data
[  139.959261] ohci_hub_status_data before spin_lock_irqsave
[  140.030231] ohci_hub_status_data after spin_lock_irqsave
[  140.100059] ohci_hub_status_data return
[  140.150442] usb_hcd_poll_rh_status after hub_status_data
[  140.234780] usb_hcd_poll_rh_status start
[  140.286416] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  140.388317] usb_hcd_poll_rh_status before hub_status_data
[  140.459258] ohci_hub_status_data before spin_lock_irqsave
[  140.530230] ohci_hub_status_data after spin_lock_irqsave
[  140.600059] ohci_hub_status_data return
[  140.650439] usb_hcd_poll_rh_status after hub_status_data
[  140.734796] usb_hcd_poll_rh_status start
[  140.786417] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  140.888316] usb_hcd_poll_rh_status before hub_status_data
[  140.959260] ohci_hub_status_data before spin_lock_irqsave
[  141.030230] ohci_hub_status_data after spin_lock_irqsave
[  141.100056] ohci_hub_status_data return
[  141.150440] usb_hcd_poll_rh_status after hub_status_data
[  141.234802] usb_hcd_poll_rh_status start
[  141.286416] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  141.388318] usb_hcd_poll_rh_status before hub_status_data
[  141.459255] ohci_hub_status_data before spin_lock_irqsave
[  141.530225] ohci_hub_status_data after spin_lock_irqsave
[  141.600052] ohci_hub_status_data return
[  141.650438] usb_hcd_poll_rh_status after hub_status_data
[  141.734801] usb_hcd_poll_rh_status start
[  141.786412] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  141.888309] usb_hcd_poll_rh_status before hub_status_data
[  141.959253] ohci_hub_status_data before spin_lock_irqsave
[  142.030224] ohci_hub_status_data after spin_lock_irqsave
[  142.100053] ohci_hub_status_data return
[  142.150434] usb_hcd_poll_rh_status after hub_status_data
[  142.234801] usb_hcd_poll_rh_status start
[  142.286410] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  142.388309] usb_hcd_poll_rh_status before hub_status_data
[  142.459249] ohci_hub_status_data before spin_lock_irqsave
[  142.530219] ohci_hub_status_data after spin_lock_irqsave
[  142.600046] ohci_hub_status_data return
[  142.650430] usb_hcd_poll_rh_status after hub_status_data
[  142.734798] usb_hcd_poll_rh_status start
[  142.786402] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  142.888305] usb_hcd_poll_rh_status before hub_status_data
[  142.959246] ohci_hub_status_data before spin_lock_irqsave
[  143.030219] ohci_hub_status_data after spin_lock_irqsave
[  143.100045] ohci_hub_status_data return
[  143.150428] usb_hcd_poll_rh_status after hub_status_data
[  143.234796] usb_hcd_poll_rh_status start
[  143.286404] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  143.388305] usb_hcd_poll_rh_status before hub_status_data
[  143.459247] ohci_hub_status_data before spin_lock_irqsave
[  143.530217] ohci_hub_status_data after spin_lock_irqsave
[  143.600044] ohci_hub_status_data return
[  143.650428] usb_hcd_poll_rh_status after hub_status_data
[  143.734841] usb_hcd_poll_rh_status start
[  143.786506] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  143.888407] usb_hcd_poll_rh_status before hub_status_data
[  143.959347] ohci_hub_status_data before spin_lock_irqsave
[  144.030316] ohci_hub_status_data after spin_lock_irqsave
[  144.100144] ohci_hub_status_data return
[  144.150529] usb_hcd_poll_rh_status after hub_status_data
[  144.234824] usb_hcd_poll_rh_status start
[  144.286402] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  144.388301] usb_hcd_poll_rh_status before hub_status_data
[  144.459243] ohci_hub_status_data before spin_lock_irqsave
[  144.530212] ohci_hub_status_data after spin_lock_irqsave
[  144.600041] ohci_hub_status_data return
[  144.650420] usb_hcd_poll_rh_status after hub_status_data
[  144.734848] usb_hcd_poll_rh_status start
[  144.786503] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  144.888402] usb_hcd_poll_rh_status before hub_status_data
[  144.959340] ohci_hub_status_data before spin_lock_irqsave
[  145.030311] ohci_hub_status_data after spin_lock_irqsave
[  145.100142] ohci_hub_status_data return
[  145.150522] usb_hcd_poll_rh_status after hub_status_data
[  145.234793] usb_hcd_poll_rh_status start
[  145.286393] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  145.388296] usb_hcd_poll_rh_status before hub_status_data
[  145.459241] ohci_hub_status_data before spin_lock_irqsave
[  145.530209] ohci_hub_status_data after spin_lock_irqsave
[  145.600040] ohci_hub_status_data return
[  145.650419] usb_hcd_poll_rh_status after hub_status_data
[  145.734821] usb_hcd_poll_rh_status start
[  145.786498] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  145.888396] usb_hcd_poll_rh_status before hub_status_data
[  145.959342] ohci_hub_status_data before spin_lock_irqsave
[  146.030310] ohci_hub_status_data after spin_lock_irqsave
[  146.100141] ohci_hub_status_data return
[  146.150522] usb_hcd_poll_rh_status after hub_status_data
[  146.234800] usb_hcd_poll_rh_status start
[  146.286396] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  146.388294] usb_hcd_poll_rh_status before hub_status_data
[  146.459235] ohci_hub_status_data before spin_lock_irqsave
[  146.530206] ohci_hub_status_data after spin_lock_irqsave
[  146.600032] ohci_hub_status_data return
[  146.650414] usb_hcd_poll_rh_status after hub_status_data
[  146.734795] usb_hcd_poll_rh_status start
[  146.786389] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  146.888292] usb_hcd_poll_rh_status before hub_status_data
[  146.959233] ohci_hub_status_data before spin_lock_irqsave
[  147.030203] ohci_hub_status_data after spin_lock_irqsave
[  147.100030] ohci_hub_status_data return
[  147.150412] usb_hcd_poll_rh_status after hub_status_data
[  147.234803] usb_hcd_poll_rh_status start
[  147.286389] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  147.388286] usb_hcd_poll_rh_status before hub_status_data
[  147.459231] ohci_hub_status_data before spin_lock_irqsave
[  147.530201] ohci_hub_status_data after spin_lock_irqsave
[  147.600029] ohci_hub_status_data return
[  147.650409] usb_hcd_poll_rh_status after hub_status_data
[  147.734797] usb_hcd_poll_rh_status start
[  147.786389] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  147.888288] usb_hcd_poll_rh_status before hub_status_data
[  147.959228] ohci_hub_status_data before spin_lock_irqsave
[  148.030200] ohci_hub_status_data after spin_lock_irqsave
[  148.100027] ohci_hub_status_data return
[  148.150407] usb_hcd_poll_rh_status after hub_status_data
[  148.234821] usb_hcd_poll_rh_status start
[  148.286488] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  148.388390] usb_hcd_poll_rh_status before hub_status_data
[  148.459331] ohci_hub_status_data before spin_lock_irqsave
[  148.530299] ohci_hub_status_data after spin_lock_irqsave
[  148.600126] ohci_hub_status_data return
[  148.650511] usb_hcd_poll_rh_status after hub_status_data
[  148.734854] usb_hcd_poll_rh_status start
[  148.786482] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  148.888385] usb_hcd_poll_rh_status before hub_status_data
[  148.959328] ohci_hub_status_data before spin_lock_irqsave
[  149.030299] ohci_hub_status_data after spin_lock_irqsave
[  149.100125] ohci_hub_status_data return
[  149.150507] usb_hcd_poll_rh_status after hub_status_data
[  149.234790] usb_hcd_poll_rh_status start
[  149.286382] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  149.388277] usb_hcd_poll_rh_status before hub_status_data
[  149.459221] ohci_hub_status_data before spin_lock_irqsave
[  149.530188] ohci_hub_status_data after spin_lock_irqsave
[  149.600017] ohci_hub_status_data return
[  149.650400] usb_hcd_poll_rh_status after hub_status_data
[  149.734789] usb_hcd_poll_rh_status start
[  149.786372] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  149.888278] usb_hcd_poll_rh_status before hub_status_data
[  149.959219] ohci_hub_status_data before spin_lock_irqsave
[  150.030188] ohci_hub_status_data after spin_lock_irqsave
[  150.100020] ohci_hub_status_data return
[  150.150401] usb_hcd_poll_rh_status after hub_status_data
[  150.234793] usb_hcd_poll_rh_status start
[  150.286375] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  150.388274] usb_hcd_poll_rh_status before hub_status_data
[  150.459217] ohci_hub_status_data before spin_lock_irqsave
[  150.530187] ohci_hub_status_data after spin_lock_irqsave
[  150.600014] ohci_hub_status_data return
[  150.650396] usb_hcd_poll_rh_status after hub_status_data
[  150.734805] usb_hcd_poll_rh_status start
[  150.786471] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  150.888375] usb_hcd_poll_rh_status before hub_status_data
[  150.959318] ohci_hub_status_data before spin_lock_irqsave
[  151.030287] ohci_hub_status_data after spin_lock_irqsave
[  151.100117] ohci_hub_status_data return
[  151.150497] usb_hcd_poll_rh_status after hub_status_data
[  151.234798] usb_hcd_poll_rh_status start
[  151.286479] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  151.388376] usb_hcd_poll_rh_status before hub_status_data
[  151.459318] ohci_hub_status_data before spin_lock_irqsave
[  151.530286] ohci_hub_status_data after spin_lock_irqsave
[  151.600113] ohci_hub_status_data return
[  151.650498] usb_hcd_poll_rh_status after hub_status_data
[  151.734801] usb_hcd_poll_rh_status start
[  151.786473] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  151.888373] usb_hcd_poll_rh_status before hub_status_data
[  151.959314] ohci_hub_status_data before spin_lock_irqsave
[  152.030286] ohci_hub_status_data after spin_lock_irqsave
[  152.100114] ohci_hub_status_data return
[  152.150495] usb_hcd_poll_rh_status after hub_status_data
[  152.234837] usb_hcd_poll_rh_status start
[  152.286477] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  152.388370] usb_hcd_poll_rh_status before hub_status_data
[  152.459311] ohci_hub_status_data before spin_lock_irqsave
[  152.530284] ohci_hub_status_data after spin_lock_irqsave
[  152.600112] ohci_hub_status_data return
[  152.650492] usb_hcd_poll_rh_status after hub_status_data
[  152.734797] usb_hcd_poll_rh_status start
[  152.786473] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  152.888368] usb_hcd_poll_rh_status before hub_status_data
[  152.959312] ohci_hub_status_data before spin_lock_irqsave
[  153.030279] ohci_hub_status_data after spin_lock_irqsave
[  153.100109] ohci_hub_status_data return
[  153.150491] usb_hcd_poll_rh_status after hub_status_data
[  153.234843] usb_hcd_poll_rh_status start
[  153.286465] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  153.388367] usb_hcd_poll_rh_status before hub_status_data
[  153.459309] ohci_hub_status_data before spin_lock_irqsave
[  153.530278] ohci_hub_status_data after spin_lock_irqsave
[  153.600108] ohci_hub_status_data return
[  153.650490] usb_hcd_poll_rh_status after hub_status_data
[  153.734846] usb_hcd_poll_rh_status start
[  153.786467] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  153.888364] usb_hcd_poll_rh_status before hub_status_data
[  153.959305] ohci_hub_status_data before spin_lock_irqsave
[  154.030276] ohci_hub_status_data after spin_lock_irqsave
[  154.100100] ohci_hub_status_data return
[  154.150484] usb_hcd_poll_rh_status after hub_status_data
[  154.234796] usb_hcd_poll_rh_status start
[  154.286467] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  154.388362] usb_hcd_poll_rh_status before hub_status_data
[  154.459303] ohci_hub_status_data before spin_lock_irqsave
[  154.530276] ohci_hub_status_data after spin_lock_irqsave
[  154.600102] ohci_hub_status_data return
[  154.650483] usb_hcd_poll_rh_status after hub_status_data
[  154.734797] usb_hcd_poll_rh_status start
[  154.786463] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  154.888360] usb_hcd_poll_rh_status before hub_status_data
[  154.959301] ohci_hub_status_data before spin_lock_irqsave
[  155.030271] ohci_hub_status_data after spin_lock_irqsave
[  155.100100] ohci_hub_status_data return
[  155.150482] usb_hcd_poll_rh_status after hub_status_data
[  155.234793] usb_hcd_poll_rh_status start
[  155.286459] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  155.388358] usb_hcd_poll_rh_status before hub_status_data
[  155.459298] ohci_hub_status_data before spin_lock_irqsave
[  155.530269] ohci_hub_status_data after spin_lock_irqsave
[  155.600099] ohci_hub_status_data return
[  155.650481] usb_hcd_poll_rh_status after hub_status_data
[  155.734783] usb_hcd_poll_rh_status start
[  155.786451] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  155.888359] usb_hcd_poll_rh_status before hub_status_data
[  155.959297] ohci_hub_status_data before spin_lock_irqsave
[  156.030269] ohci_hub_status_data after spin_lock_irqsave
[  156.100096] ohci_hub_status_data return
[  156.150475] usb_hcd_poll_rh_status after hub_status_data
[  156.229921] ps used greatest stack depth: 0 bytes left
[  156.297594] usb_hcd_poll_rh_status start
[  156.349161] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  156.451010] usb_hcd_poll_rh_status before hub_status_data
[  156.521952] ohci_hub_status_data before spin_lock_irqsave
[  156.592920] ohci_hub_status_data after spin_lock_irqsave
[  156.662750] ohci_hub_status_data return
[  156.713133] usb_hcd_poll_rh_status after hub_status_data
[  156.984799] usb_hcd_poll_rh_status start
[  157.036454] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  157.138350] usb_hcd_poll_rh_status before hub_status_data
[  157.209292] ohci_hub_status_data before spin_lock_irqsave
[  157.280262] ohci_hub_status_data after spin_lock_irqsave
[  157.350091] ohci_hub_status_data return
[  157.400472] usb_hcd_poll_rh_status after hub_status_data
[  157.484788] usb_hcd_poll_rh_status start
[  157.536448] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  157.638345] usb_hcd_poll_rh_status before hub_status_data
[  157.709291] ohci_hub_status_data before spin_lock_irqsave
[  157.780260] ohci_hub_status_data after spin_lock_irqsave
[  157.850088] ohci_hub_status_data return
[  157.900489] usb_hcd_poll_rh_status after hub_status_data
[  157.984802] usb_hcd_poll_rh_status start
[  158.036424] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  158.138344] usb_hcd_poll_rh_status before hub_status_data
[  158.209288] ohci_hub_status_data before spin_lock_irqsave
[  158.280258] ohci_hub_status_data after spin_lock_irqsave
[  158.350088] ohci_hub_status_data return
[  158.400468] usb_hcd_poll_rh_status after hub_status_data
[  158.484817] usb_hcd_poll_rh_status start
[  158.536437] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  158.638342] usb_hcd_poll_rh_status before hub_status_data
[  158.709288] ohci_hub_status_data before spin_lock_irqsave
[  158.780256] ohci_hub_status_data after spin_lock_irqsave
[  158.850084] ohci_hub_status_data return
[  158.900467] usb_hcd_poll_rh_status after hub_status_data
[  158.984801] usb_hcd_poll_rh_status start
[  159.036442] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  159.138340] usb_hcd_poll_rh_status before hub_status_data
[  159.209284] ohci_hub_status_data before spin_lock_irqsave
[  159.280258] ohci_hub_status_data after spin_lock_irqsave
[  159.350083] ohci_hub_status_data return
[  159.400467] usb_hcd_poll_rh_status after hub_status_data
[  159.484798] usb_hcd_poll_rh_status start
[  159.536444] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  159.638339] usb_hcd_poll_rh_status before hub_status_data
[  159.709285] ohci_hub_status_data before spin_lock_irqsave
[  159.780254] ohci_hub_status_data after spin_lock_irqsave
[  159.850081] ohci_hub_status_data return
[  159.900463] usb_hcd_poll_rh_status after hub_status_data
[  159.984796] usb_hcd_poll_rh_status start
[  160.036434] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  160.138340] usb_hcd_poll_rh_status before hub_status_data
[  160.209280] ohci_hub_status_data before spin_lock_irqsave
[  160.280250] ohci_hub_status_data after spin_lock_irqsave
[  160.350078] ohci_hub_status_data return
[  160.400460] usb_hcd_poll_rh_status after hub_status_data
[  160.484849] usb_hcd_poll_rh_status start
[  160.536440] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  160.638332] usb_hcd_poll_rh_status before hub_status_data
[  160.709280] ohci_hub_status_data before spin_lock_irqsave
[  160.780250] ohci_hub_status_data after spin_lock_irqsave
[  160.850077] ohci_hub_status_data return
[  160.900459] usb_hcd_poll_rh_status after hub_status_data
[  160.984798] usb_hcd_poll_rh_status start
[  161.036433] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  161.138334] usb_hcd_poll_rh_status before hub_status_data
[  161.209278] ohci_hub_status_data before spin_lock_irqsave
[  161.280245] ohci_hub_status_data after spin_lock_irqsave
[  161.350073] ohci_hub_status_data return
[  161.400453] usb_hcd_poll_rh_status after hub_status_data
[  161.484793] usb_hcd_poll_rh_status start
[  161.536428] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  161.638331] usb_hcd_poll_rh_status before hub_status_data
[  161.709276] ohci_hub_status_data before spin_lock_irqsave
[  161.780243] ohci_hub_status_data after spin_lock_irqsave
[  161.850073] ohci_hub_status_data return
[  161.900454] usb_hcd_poll_rh_status after hub_status_data
[  161.984907] usb_hcd_poll_rh_status start
[  162.036535] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  162.138436] usb_hcd_poll_rh_status before hub_status_data
[  162.209375] ohci_hub_status_data before spin_lock_irqsave
[  162.280344] ohci_hub_status_data after spin_lock_irqsave
[  162.350173] ohci_hub_status_data return
[  162.400555] usb_hcd_poll_rh_status after hub_status_data
[  162.484788] usb_hcd_poll_rh_status start
[  162.536420] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  162.638326] usb_hcd_poll_rh_status before hub_status_data
[  162.709269] ohci_hub_status_data before spin_lock_irqsave
[  162.780236] ohci_hub_status_data after spin_lock_irqsave
[  162.850068] ohci_hub_status_data return
[  162.900450] usb_hcd_poll_rh_status after hub_status_data
[  162.984801] usb_hcd_poll_rh_status start
[  163.036424] usb_hcd_poll_rh_status: uses_new_polling=3D1, status_urb=FFf=
ff8006e1778c0=20
[  163.138324] usb_hcd_pol

--=20
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/

From: Meelis Roos <mroos@ut.ee>
Date: Sat, 23 Aug 2008 06:48:30 +0000
Subject: Re: soft lockup in 2.6.26-rc1+git, on Fire V100 - USB again
Message-Id: <Pine.SOC.4.64.0808230946390.2459@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0805051908190.17592@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Meelis, in keeping with David's suggestion about posting the PCI 
> writes, you ought to apply this patch along with the previous one.
> I doubt it will make any difference, but it's worth doing anyway.

Now got it to boot with 9600 again, with both your patches applied (and 
your earlier patch too) and it works (have not tried anything isn USB 
port yet, the machine is remote):

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.0.18 2002/05/23 18:22'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 2.6.27-rc3-00661-g82d63fc-dirty (mroos@janku) (gcc version 4.3.1 (Debian 4.3.1-8) ) #40 Thu Aug 21 21:48:07 EEST 2008
[    0.000000] console [earlyprom0] enabled
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 00:03:ba:11:b3:71
[    0.000000] Kernel: Using 4 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /pci@1f,0/isa@7/serial@0,3f8
[    0.000000] PROM: Built device tree with 46357 bytes of memory.
[    0.000000] Top of RAM: 0x6fec6000, Total RAM: 0x3fe42000
[    0.000000] Memory hole size: 768MB
[    0.000000] [0000000200000000-fffff80000400000] page_structs1072 node=0 entry=0/0
[    0.000000] [0000000200000000-fffff80000800000] page_structs1072 node=0 entry=1/0
[    0.000000] [0000000200700000-fffff80000c00000] page_structs1072 node=0 entry=2/0
[    0.000000] [0000000200700000-fffff80001000000] page_structs1072 node=0 entry=3/0
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
[    0.000000] On node 0 totalpages: 130849
[    0.000000]   Normal zone: 129282 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129282
[    0.000000] Kernel command line: ro root=/dev/sda2 debug
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[    0.000000] clocksource: mult[b40001] shift[16]
[    0.000000] clockevent: mult[16c16bf] shift[32]
[  154.634562] Console: colour dummy device 80x25
[  154.687523] console handover: boot [earlyprom0] -> real [tty0]
[  154.757079] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[  154.757140] ... MAX_LOCKDEP_SUBCLASSES:    8
[  154.757172] ... MAX_LOCK_DEPTH:          48
[  154.757204] ... MAX_LOCKDEP_KEYS:        8191
[  154.757237] ... CLASSHASH_SIZE:           4096
[  154.757270] ... MAX_LOCKDEP_ENTRIES:     8192
[  154.757303] ... MAX_LOCKDEP_CHAINS:      16384
[  154.757336] ... CHAINHASH_SIZE:          8192
[  154.757369]  memory used by lock dependency info: 4095 kB
[  154.757407]  per task-struct memory footprint: 2688 bytes
[  154.762823] Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
[  154.771231] Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
[  154.868656] Memory: 1013304k available (2728k kernel code, 1272k data, 144k init) [fffff80000000000,000000006fec6000]
[  154.869108] SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[  155.018202] Calibrating delay using timer specific routine.. 11.18 BogoMIPS (lpjU936)
[  155.019469] Mount-cache hash table entries: 512
[  155.033693] khelper used greatest stack depth: 11056 bytes left
[  155.036086] net_namespace: 1592 bytes
[  155.039281] NET: Registered protocol family 16
[  155.074468] khelper used greatest stack depth: 10480 bytes left
[  155.146206] PCI: Probing for controllers.
[  155.149525] /pci@1f,0: SABRE PCI Bus Module
[  155.149661] /pci@1f,0: PCI IO[1fe02000000] MEM[1ff00000000]
[  155.149948] PCI: Scanning PBM /pci@1f,0
[  155.152891] pci 0000:00:03.0: quirk: region 2000-203f claimed by ali7101 ACPI
[  155.152992] pci 0000:00:03.0: quirk: region 4000-401f claimed by ali7101 SMB
[  155.153522] pci 0000:00:0c.0: PME# supported from D3hot D3cold
[  155.153611] pci 0000:00:0c.0: PME# disabled
[  155.154105] pci 0000:00:05.0: PME# supported from D3hot D3cold
[  155.154191] pci 0000:00:05.0: PME# disabled
[  155.168616] ebus: No EBus's found.
[  155.169500] power: Control reg at 1fe02002000
[  155.211363] SCSI subsystem initialized
[  155.212496] libata version 3.00 loaded.
[  155.244559] /pci@1f,0/isa@7/rtc@0,70: Clock regs at 000001fe02000070
[  155.249705] Switched to high resolution mode on CPU 0
[  155.252275] tracer: 643 pages allocated for 65536 entries of 80 bytes
[  155.252345]    actual entries 65586
[  155.277902] NET: Registered protocol family 2
[  155.840994] IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
[  155.847375] TCP established hash table entries: 32768 (order: 6, 524288 bytes)
[  155.850608] TCP bind hash table entries: 32768 (order: 8, 2097152 bytes)
[  155.877312] TCP: Hash tables configured (established 32768 bind 32768)
[  155.877583] TCP reno registered
[  155.901595] NET: Registered protocol family 1
[  155.902862] Mini RTC Driver
[  155.909910] khelper used greatest stack depth: 9688 bytes left
[  155.935692] Initializing RT-Tester: OK
[  155.952225] Kprobe smoke test started
[  156.050016] Kprobe smoke test passed successfully
[  156.331246] VFS: Disk quotas dquot_6.5.1
[  156.335153] Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[  156.358279] msgmni has been set to 1980
[  156.368835] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
[  156.369028] io scheduler noop registered
[  156.369090] io scheduler anticipatory registered
[  156.369150] io scheduler deadline registered
[  156.375220] io scheduler cfq registered (default)
[  156.375357] pci 0000:00:07.0: Activating ISA DMA hang workarounds
[  156.514198] f0076e0c: ttyS0 at MMIO 0x1fe020003f8 (irq = 7) is a 16550A
[  156.514339] Console: ttyS0 (SU)
[  156.514415] console [ttyS0] enabled
[  163.364703] f0078af8: ttyS1 at MMIO 0x1fe020002e8 (irq = 7) is a 16550A
[  163.495497] loop: module loaded
[  163.538055] console [netcon0] enabled
[  163.586258] netconsole: network logging started
[  163.647571] Driver 'sd' needs updating - please use bus_type methods
[  163.735346] PCI: Enabling device: (0000:00:0d.0), cmd 5
[  163.808013] scsi0 : pata_ali
[  163.857870] scsi1 : pata_ali
[  163.900354] ata1: PATA max UDMA/66 cmd 0x1fe02010200 ctl 0x1fe02010218 bmdma 0x1fe02010220 irq 12
[  164.017187] ata2: PATA max UDMA/66 cmd 0x1fe02010210 ctl 0x1fe02010208 bmdma 0x1fe02010228 irq 12
[  164.680400] ata2.00: ATA-6: ST3120026A, 3.06, max UDMA/100
[  164.752594] ata2.00: 234441648 sectors, multi 0: LBA48 
[  164.821318] ata2.01: ATAPI: CD-224E, 1.7A, max UDMA/33
[  164.888924] ata2.01: WARNING: ATAPI DMA disabled for reliablity issues.  It can be enabled
[  164.997716] ata2.01: WARNING: via pata_ali.atapi_dma modparam or corresponding sysfs node.
[  165.140299] ata2.00: configured for UDMA/66
[  165.230029] ata2.01: configured for UDMA/33
[  165.287742] scsi 1:0:0:0: Direct-Access     ATA      ST3120026A       3.06 PQ: 0 ANSI: 5
[  165.402307] sd 1:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
[  165.496635] sd 1:0:0:0: [sda] Write Protect is off
[  165.559976] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  165.627343] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  165.748654] sd 1:0:0:0: [sda] 234441648 512-byte hardware sectors (120034 MB)
[  165.843240] sd 1:0:0:0: [sda] Write Protect is off
[  165.906261] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[  165.973545] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[  166.092787]  sda: sda1 sda2 sda3 sda4 sda5
[  166.172435] sd 1:0:0:0: [sda] Attached SCSI disk
[  166.241201] scsi 1:0:1:0: CD-ROM            TEAC     CD-224E          1.7A PQ: 0 ANSI: 5
[  166.360175] mice: PS/2 mouse device common for all mice
[  166.442024] TCP cubic registered
[  166.485226] NET: Registered protocol family 17
[  166.549887] registered taskstats version 1
[  166.619241] kjournald starting.  Commit interval 5 seconds
[  166.692431] EXT3-fs: mounted filesystem with ordered data mode.
[  166.770789] VFS: Mounted root (ext3 filesystem) readonly.
[  167.805865] stty used greatest stack depth: 7168 bytes left
[  168.142414] sed used greatest stack depth: 6848 bytes left
[  168.693328] mount used greatest stack depth: 6064 bytes left
[  169.661118] create_static_n used greatest stack depth: 256 bytes left
[  171.841544] Linux Tulip driver version 1.1.15-NAPI (Feb 27, 2007)
[  171.925190] tulip0: Old style EEPROM with no media selection information.
[  172.014873] tulip0:  MII transceiver #1 config 1000 status 782d advertising 01e1.
[  172.123721] eth0: Davicom DM9102/DM9102A rev 49 at MMIO 0x1ff00000000, EEPROM not present, 00:03:ba:11:b3:71, IRQ 9.
[  172.265684] tulip1: Old style EEPROM with no media selection information.
[  172.355226] tulip1:  MII transceiver #1 config 1000 status 7809 advertising 01e1.
[  172.464025] eth1: Davicom DM9102/DM9102A rev 49 at MMIO 0x1ff00002000, EEPROM not present, 00:03:ba:11:b3:72, IRQ 10.
[  172.863457] usbcore: registered new interface driver usbfs
[  172.936794] usbcore: registered new interface driver hub
[  173.661727] usbcore: registered new device driver usb
[  173.761407] Driver 'sr' needs updating - please use bus_type methods
[  173.883760] sr0: scsi3-mmc drive: 24x/24x cd/rw xa/form2 cdda tray
[  173.965408] Uniform CD-ROM driver Revision: 3.20
[  174.029943] sr 1:0:1:0: Attached scsi CD-ROM sr0
[  174.135769] ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
[  174.234294] ohci_hcd: block sizes: ed 80 td 96
[  174.293431] PCI: Enabling device: (0000:00:0a.0), cmd 2
[  174.362217] ohci_hcd 0000:00:0a.0: OHCI Host Controller
[  174.433054] drivers/usb/core/inode.c: creating file 'devices'
[  174.508936] drivers/usb/core/inode.c: creating file '001'
[  174.580180] ohci_hcd 0000:00:0a.0: new USB bus registered, assigned bus number 1
[  174.678013] ohci_hcd 0000:00:0a.0: created debug files
[  174.745836] ohci_hcd 0000:00:0a.0: irq 11, io mem 0x1ff01000000
[  175.323718] sd 1:0:0:0: Attached scsi generic sg0 type 0
[  175.394562] sr 1:0:1:0: Attached scsi generic sg1 type 5
[  175.976922] ohci_hcd 0000:00:0a.0: irq status 40 enable 8000004a
[  176.060570] ohci_hcd 0000:00:0a.0: OHCI controller state
[  176.130500] ohci_hcd 0000:00:0a.0: OHCI 1.0, NO legacy support registers
[  176.218711] ohci_hcd 0000:00:0a.0: control 0x083 HCFS=operational CBSR=3
[  176.306817] ohci_hcd 0000:00:0a.0: cmdstatus 0x00000 SOC=0
[  176.378923] ohci_hcd 0000:00:0a.0: intrstatus 0x00000044 RHSC SF
[  176.457894] ohci_hcd 0000:00:0a.0: intrenable 0x8000000a MIE RD WDH
[  176.540289] ohci_hcd 0000:00:0a.0: hcca frame #0234
[  176.604397] ohci_hcd 0000:00:0a.0: roothub.a 02000202 POTPGT=2 NPS NDP=2(2)
[  176.695943] ohci_hcd 0000:00:0a.0: roothub.b 00000000 PPCM 00 DR 00
[  176.782916] ohci_hcd 0000:00:0a.0: roothub.status 00008000 DRWE
[  176.860740] ohci_hcd 0000:00:0a.0: roothub.portstatus [0] 0x00000100 PPS
[  176.948853] ohci_hcd 0000:00:0a.0: roothub.portstatus [1] 0x00000100 PPS
[  177.037790] usb usb1: default language 0x0409
[  177.096711] usb usb1: uevent
[  177.134860] usb usb1: usb_probe_device
[  177.184105] usb usb1: configuration #1 chosen from 1 choice
[  177.257511] usb usb1: adding 1-0:1.0 (config #1, interface 0)
[  177.333563] usb 1-0:1.0: uevent
[  177.375306] hub 1-0:1.0: usb_probe_interface
[  177.431508] hub 1-0:1.0: usb_probe_interface - got id
[  177.497889] hub 1-0:1.0: USB hub found
[  177.547487] hub 1-0:1.0: 2 ports detected
[  177.600278] hub 1-0:1.0: standalone hub
[  177.650728] hub 1-0:1.0: no power switching (usb 1.0)
[  177.717129] hub 1-0:1.0: global over-current protection
[  177.785818] hub 1-0:1.0: power on to power good time: 4ms
[  177.857123] hub 1-0:1.0: local power source is good
[  177.921318] hub 1-0:1.0: no over-current condition exists
[  177.992287] hub 1-0:1.0: trying to enable port power on non-switchable hub
[  178.299867] drivers/usb/core/inode.c: creating file '001'
[  178.372334] usb usb1: New USB device found, idVendor6b, idProduct 01
[  178.461654] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[  178.556720] usb usb1: Product: OHCI Host Controller
[  178.620908] usb usb1: Manufacturer: Linux 2.6.27-rc3-00661-g82d63fc-dirty ohci_hcd
[  178.720478] usb usb1: SerialNumber: 0000:00:0a.0
[  178.782540] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  179.030025] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  179.280279] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  179.532264] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  179.798787] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  180.050417] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  180.288167] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  180.534724] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  180.840060] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  181.177408] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  181.442548] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  181.670547] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  181.751735] ps used greatest stack depth: 0 bytes left
[  182.001211] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  182.073579] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  182.339232] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  182.530751] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  182.780046] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  183.030299] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  183.319918] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  183.576230] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  183.892728] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  184.043455] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  184.283084] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  184.530155] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  184.779955] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  185.029943] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  185.279972] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  185.529862] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  185.779774] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  186.029772] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  186.280097] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  186.540676] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  186.780031] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  186.925030] Adding 3012168k swap on /dev/sda4.  Priority:-1 extents:1 across:3012168k
[  187.030643] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  187.280270] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  187.530101] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  187.780844] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  187.975129] EXT3 FS on sda2, internal journal
[  188.059310] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  188.280971] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  188.530880] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  188.790286] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  189.029815] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  189.279783] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  189.530160] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  189.779888] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  190.030257] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  190.280199] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  190.530206] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  190.780411] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  191.054421] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  191.279938] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  191.534711] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  191.779932] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  192.029878] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  192.282709] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  192.530202] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  192.779824] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  193.091939] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  193.280583] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  193.578307] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  193.782191] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  194.029928] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  194.279944] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  194.529855] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  194.779934] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  194.876544] fuse init (API version 7.9)
[  195.031453] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  195.280177] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  195.491734] kjournald starting.  Commit interval 5 seconds
[  195.564275] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  195.637509] EXT3 FS on sda1, internal journal
[  195.694992] EXT3-fs: mounted filesystem with ordered data mode.
[  195.780464] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  195.870603] kjournald starting.  Commit interval 5 seconds
[  195.944061] EXT3 FS on sda5, internal journal
[  196.001513] EXT3-fs: mounted filesystem with ordered data mode.
[  196.079734] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  196.279864] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  196.531141] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  196.779942] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  197.029902] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  197.281017] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  197.529901] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  197.780277] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  198.030009] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  198.279979] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  198.530233] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  198.780028] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  199.030157] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  199.280764] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  199.529945] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  199.779935] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  200.029977] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  200.280801] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  200.529947] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  200.780259] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  201.029996] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  201.280961] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  201.530226] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  201.780094] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  202.030195] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  202.280137] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  202.529855] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  202.780171] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  203.029924] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  203.279987] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  203.529927] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  203.780271] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  204.033038] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  204.281353] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  204.532349] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  204.781986] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  205.030104] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  205.279987] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  205.529976] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  205.783939] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  206.034946] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  206.280207] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  206.531559] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  206.780062] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  207.034841] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  207.280455] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  207.532557] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  207.781461] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  208.033992] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  208.433891] NET: Registered protocol family 10
[  208.515754] lo: Disabled Privacy Extensions
[  208.633975] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  208.833568] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  209.030462] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  209.283780] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  209.532865] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  209.792965] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  210.034477] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  210.284428] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  210.533742] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  210.780750] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  211.032553] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  211.287762] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  211.529942] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  211.782651] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  212.029930] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  212.284974] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  212.529968] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  212.779957] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  213.030333] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  213.291453] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  213.530126] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  213.780065] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  214.030291] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  214.280277] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  214.529881] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  214.779907] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  215.029900] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  215.279930] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  215.529901] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  215.779872] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  216.029874] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  216.280041] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  216.530336] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  216.781064] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  217.029923] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  217.279965] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  217.530158] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  217.780381] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  218.032576] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  218.281527] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  218.530106] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  218.780088] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  219.029877] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  219.109727] eth0: no IPv6 routers present
[  219.280179] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  219.529863] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  219.779842] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  220.029836] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  220.279915] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  220.529842] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  220.779851] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  221.029828] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  221.279865] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  221.529838] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  221.779842] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  222.029827] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  222.279844] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  222.529833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  222.779831] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  223.029822] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  223.279865] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  223.529832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  223.779831] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  224.029837] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  224.279920] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  224.529825] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  224.779837] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  225.029832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  225.279832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  225.529831] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  225.779829] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  226.029828] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  226.279927] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  226.529844] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  226.779849] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  227.029834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  227.279873] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  227.529842] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  227.779834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  228.029830] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  228.279909] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  228.529832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  228.779819] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  229.029828] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  229.279827] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  229.529824] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  229.779833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  230.029837] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  230.279845] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  230.529838] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  230.779830] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  231.029835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  231.279868] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  231.529836] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  231.779844] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  232.029847] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  232.279922] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  232.529835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  232.779832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  233.029825] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  233.279827] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  233.529834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  233.779832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  234.029845] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  234.279838] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  234.529826] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  234.779833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  235.029830] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  235.279862] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  235.529838] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  235.779837] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  236.029829] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  236.279909] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  236.529827] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  236.779835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  237.029842] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  237.279852] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  237.529839] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  237.779807] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  238.029835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  238.279834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  238.529830] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  238.779845] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  239.029844] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  239.279878] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  239.529827] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  239.779831] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  240.029833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  240.279907] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  240.529836] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  240.779833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  241.029827] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  241.279833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  241.529830] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  241.779829] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  242.029830] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  242.279843] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  242.529853] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  242.779846] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  243.029831] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  243.279867] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  243.529834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  243.779833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  244.029853] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  244.279932] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  244.529828] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  244.779835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  245.029830] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  245.279844] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  245.529829] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  245.779834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  246.029831] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  246.279834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  246.529841] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  246.779834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  247.029830] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  247.279963] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  247.529851] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  247.779854] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  248.029832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  248.279934] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  248.529835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  248.779836] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  249.029851] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  249.279849] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  249.529832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  249.779847] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  250.029836] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  250.279831] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  250.529833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  250.779830] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  251.029832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  251.279853] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  251.529832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  251.779833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  252.029828] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  252.279902] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  252.529837] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  252.779846] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  253.029836] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  253.279837] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  253.529838] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  253.779838] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  254.029846] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  254.279857] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  254.529830] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  254.779835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  255.029833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  255.279861] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  255.529833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  255.779835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  256.029831] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  256.279905] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  256.529818] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  256.779833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  257.029826] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  257.279839] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  257.529832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  257.779833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  258.029852] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  258.279855] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  258.529838] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  258.779831] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  259.029822] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  259.279876] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  259.529826] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  259.779832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  260.029841] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  260.279925] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  260.529835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  260.779836] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  261.029839] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  261.279839] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  261.529830] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  261.779836] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  262.029831] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  262.279834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  262.529834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  262.779833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  263.029832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  263.279877] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  263.529827] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  263.779841] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  264.029825] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  264.279929] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  264.529827] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  264.779845] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  265.029834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  265.279835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  265.529835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  265.779834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  266.029836] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  266.279833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  266.529835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  266.779833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  267.029831] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  267.279858] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  267.529832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  267.779808] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  268.029837] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  268.279999] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  268.529843] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  268.779852] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  269.029825] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  269.279837] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  269.529828] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  269.779837] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  270.029834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  270.279839] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  270.529832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  270.779838] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  271.029836] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  271.279854] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  271.529829] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  271.779835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  272.029844] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  272.279902] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  272.529837] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  272.779836] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  273.029833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  273.279830] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  273.529839] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  273.779845] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  274.029843] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  274.279852] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  274.529829] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  274.779838] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  275.029834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  275.279874] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  275.529835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  275.779841] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  276.029839] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  276.280390] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  276.529846] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  276.779842] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  277.029830] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  277.279845] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  277.529846] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  277.779834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  278.029836] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  278.279837] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  278.529834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  278.779833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  279.029850] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  279.279888] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  279.529836] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  279.779835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  280.029841] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  280.280180] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  280.529839] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  280.779836] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  281.029833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  281.279840] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  281.529834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  281.779832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  282.029833] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  282.279834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  282.529834] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  282.779838] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  283.029814] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  283.279877] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  283.529840] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  283.779842] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  284.029827] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  284.279912] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  284.529835] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  284.779848] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  285.029837] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  285.279832] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  285.529837] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  285.779837] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  286.030277] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  286.279865] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  286.529846] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  286.779843] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  287.029822] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  287.279727] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  287.529574] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  287.779450] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  288.029230] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  288.279266] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  288.529070] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  288.778898] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  289.028801] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  289.278802] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  289.528561] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  289.778410] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  290.028318] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  290.278173] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  290.527990] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  290.777852] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  291.027818] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  291.277702] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  291.527494] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  291.777374] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  292.027310] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  292.277224] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  292.527060] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  292.776870] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  293.026807] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  293.276682] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  293.526488] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  293.776364] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  294.026270] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  294.276187] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  294.526032] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  294.775931] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  295.025813] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  295.275713] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  295.525524] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  295.775425] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  296.025294] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  296.275251] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  296.525046] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  296.774921] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  297.024795] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  297.274668] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  297.524540] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  297.774310] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  298.024302] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  298.274172] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  298.524040] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  298.773876] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  299.023756] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  299.273695] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  299.523521] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  299.773375] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  300.023262] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  300.273252] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  300.523042] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  300.772920] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  301.022788] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  301.272664] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  301.522536] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  301.772413] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  302.022287] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  302.272171] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  302.522040] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  302.771915] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  303.021790] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  303.271689] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  303.521536] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  303.771415] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  304.021266] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  304.271250] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  304.521021] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  304.770918] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  305.020789] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  305.270671] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  305.520558] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  305.770422] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  306.020289] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  306.270165] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  306.520039] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  306.769917] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  307.019789] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  307.269707] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  307.519540] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  307.769414] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  308.019291] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  308.269236] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  308.519039] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  308.768914] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  309.018768] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  309.268690] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  309.518521] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  309.768408] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  310.018293] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  310.268234] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  310.518047] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  310.767935] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  311.017795] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  311.267669] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  311.517542] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  311.767419] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  312.017294] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  312.267214] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  312.517045] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  312.766920] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  313.016789] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  313.266671] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  313.516545] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  313.766415] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  314.016257] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  314.266172] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  314.516026] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  314.765917] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  315.015792] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  315.265690] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  315.515544] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  315.765427] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  316.015305] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  316.265241] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  316.515052] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  316.764923] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  317.014796] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  317.264667] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  317.514554] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  317.764387] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  318.014292] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  318.264171] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  318.514043] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  318.763885] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  319.013772] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  319.263685] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  319.513527] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  319.763394] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  320.013213] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  320.263247] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  320.513049] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  320.762921] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  321.012800] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  321.262690] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  321.512548] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  321.762423] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  322.012296] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  322.262168] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  322.512051] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  322.761924] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  323.011793] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  323.261709] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  323.511467] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  323.761426] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  324.011280] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  324.261255] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  324.511028] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  324.760927] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  325.010794] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  325.260672] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  325.510524] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  325.760423] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  326.010295] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  326.260177] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  326.510062] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  326.759929] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  327.009797] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  327.259709] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  327.509545] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  327.759318] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  328.009302] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  328.259252] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  328.509047] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  328.758924] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  329.008761] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  329.258675] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  329.508525] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  329.758425] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  330.008300] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  330.258133] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  330.508050] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  330.757923] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  331.007795] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  331.257747] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  331.507557] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  331.757441] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  332.007302] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  332.257225] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  332.507052] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  332.756923] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  333.006795] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  333.256671] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  333.506547] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  333.756427] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  334.006277] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  334.256187] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  334.506029] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  334.755929] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  335.005801] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  335.255698] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  335.505560] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  335.755430] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  336.005299] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  336.255246] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  336.505048] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  336.754931] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  337.004815] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  337.254642] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  337.504563] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  337.754402] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  338.004302] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  338.254177] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  338.504053] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  338.753898] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  339.003786] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  339.253731] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  339.503533] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  339.753402] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  340.003260] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  340.253251] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  340.503049] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  340.752929] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  341.002801] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  341.252678] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  341.502552] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  341.752426] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  342.002306] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  342.252194] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  342.502056] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  342.751931] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  343.001800] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  343.251710] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  343.501549] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  343.751367] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  344.001267] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  344.251302] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  344.501011] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  344.750857] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  345.000754] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  345.250683] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  345.500571] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  345.750436] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  346.000305] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  346.250181] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  346.500050] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  346.749872] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  347.016793] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  347.249675] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  347.501821] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  347.749351] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  347.999241] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  348.249206] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  348.498997] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  348.748940] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  348.998784] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  349.248648] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  349.498468] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  349.748354] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  349.998259] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  350.248165] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  350.498064] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  350.747896] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  350.997799] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  351.247705] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  351.497504] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  351.749230] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  351.997283] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  352.247346] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  352.497075] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  352.746939] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  352.996808] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  353.246662] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  353.504685] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  353.746363] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  353.996269] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  354.246105] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  354.495986] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  354.745867] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  354.995811] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  355.245722] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  355.495558] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  355.745437] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  355.995315] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  356.245254] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  356.495058] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  356.744932] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  356.994808] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  357.244777] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  357.494558] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  357.744337] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  357.994318] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  358.244108] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  358.494020] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  358.743914] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  358.993794] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  359.243738] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  359.493537] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  359.743412] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  359.993314] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  360.243262] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  360.493058] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  360.742932] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  360.992806] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  361.242689] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  361.492482] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  361.742351] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  361.992236] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  362.242109] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  362.492059] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  362.741947] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  362.991824] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  363.241702] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  363.491556] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  363.741418] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  363.991259] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  364.241172] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  364.490981] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  364.740942] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  364.990815] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  365.240638] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  365.490495] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  365.740353] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  365.990245] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  366.240144] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  366.490003] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  366.739873] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  366.989741] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  367.239716] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
[  367.489562] hub 1-0:1.0: state 7 ports 2 chg 0000 evt 0000
...

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/

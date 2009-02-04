From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Wed, 04 Feb 2009 14:36:12 +0000
Subject: NMI appears to be stuck (0->0)
Message-Id: <20090204143612.GA13284@orion>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David

Is it known problem?
It is Ultra10.

Testing NMI watchdog ...
WARNING: CPU#0: NMI appears to be stuck (0->0)!

dmesg:

PROMLIB: Sun IEEE Boot Prom 'OBP 3.25.3 2000/06/29 14:12'
PROMLIB: Root node compatible: 
Linux version 2.6.29-rc3-next-20090204 (alexb@sparky) (gcc version 4.3.1 (Gentoo 4.3.1 p1.0) ) #16 PREEMPT Wed Feb 4 15:59:44 MSK 2009
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 08:00:20:ff:e6:ff
Kernel: Using 3 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@1f,0/pci@1,1/SUNW,m64B@2
PROM: Built device tree with 41922 bytes of memory.
Top of RAM: 0x3ff46000, Total RAM: 0x3ff36000
Memory hole size: 0MB
[0000000200000000-fffff80001000000] page_structs1072 node=0 entry=0/0
[0000000200000000-fffff80001400000] page_structs1072 node=0 entry=1/0
Allocated 1056768 bytes for kernel page tables.
Zone PFN ranges:
  Normal   0x00000000 -> 0x0001ffa3
Movable zone start PFN for each node
early_node_map[3] active PFN ranges
    0: 0x00000000 -> 0x0001ff7f
    0: 0x0001ff80 -> 0x0001ff98
    0: 0x0001ff9f -> 0x0001ffa3
On node 0 totalpages: 130971
  Normal zone: 1024 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 129947 pages, LIFO batch:15
Booting Linux...
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129947
Kernel command line: root=/dev/sda2
Preemptible RCU implementation.
NR_IRQS:255
PID hash table entries: 4096 (order: 12, 32768 bytes)
clocksource: mult[245d1] shift[16]
clockevent: mult[70a3d70a] shift[32]
Console: colour dummy device 80x25
console handover: boot [earlyprom0] -> real [tty0]
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:  8
... MAX_LOCK_DEPTH:          48
... MAX_LOCKDEP_KEYS:        8191
... CLASSHASH_SIZE:          4096
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 3839 kB
 per task-struct memory footprint: 1920 bytes
------------------------
| Locking API testsuite:
----------------------------------------------------------------------------
                                 | spin |wlock |rlock |mutex | wsem | rsem |
  --------------------------------------------------------------------------
                     A-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 A-B-B-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
             A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
         A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                    double unlock:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                  initialize held:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
                 bad unlock order:  ok  |  ok  |  ok  |  ok  |  ok  |  ok  |
  --------------------------------------------------------------------------
              recursive read-lock:             |  ok  |             |  ok  |
           recursive read-lock #2:             |  ok  |             |  ok  |
            mixed read-write-lock:             |  ok  |             |  ok  |
            mixed write-read-lock:             |  ok  |             |  ok  |
  --------------------------------------------------------------------------
     hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
     hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
     soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
       sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
         hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
         soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
    hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
    soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
      hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
      soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
      hard-irq read-recursion/123:  ok  |
      soft-irq read-recursion/123:  ok  |
      hard-irq read-recursion/132:  ok  |
      soft-irq read-recursion/132:  ok  |
      hard-irq read-recursion/213:  ok  |
      soft-irq read-recursion/213:  ok  |
      hard-irq read-recursion/231:  ok  |
      soft-irq read-recursion/231:  ok  |
      hard-irq read-recursion/312:  ok  |
      soft-irq read-recursion/312:  ok  |
      hard-irq read-recursion/321:  ok  |
      soft-irq read-recursion/321:  ok  |
-------------------------------------------------------
Good, all 218 testcases passed! |
---------------------------------
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Memory: 1024992k available (2960k kernel code, 1344k data, 136k init) [fffff80000000000,000000003ff46000]
Calibrating delay using timer specific routine.. 884.23 BogoMIPS (lpjD21151)
Mount-cache hash table entries: 512
device: 'platform': device_add
bus: 'platform': registered
Registering sysdev class 'cpu'
net_namespace: 664 bytes
NET: Registered protocol family 16
bus: 'of': registered
device: 'root': device_add
bus: 'of': add device root
device: 'f002ca6c': device_add
bus: 'of': add device f002ca6c
device: 'f0033bf0': device_add
bus: 'of': add device f0033bf0
device: 'f003692c': device_add
bus: 'of': add device f003692c
device: 'f0037008': device_add
bus: 'of': add device f0037008
device: 'f0041d40': device_add
bus: 'of': add device f0041d40
device: 'f005af9c': device_add
bus: 'of': add device f005af9c
device: 'f0068d08': device_add
bus: 'of': add device f0068d08
device: 'f002cadc': device_add
bus: 'of': add device f002cadc
device: 'f002cb48': device_add
bus: 'of': add device f002cb48
device: 'f002cbd8': device_add
bus: 'of': add device f002cbd8
device: 'f002cc80': device_add
bus: 'of': add device f002cc80
device: 'f002ccf0': device_add
bus: 'of': add device f002ccf0
device: 'f004c7a8': device_add
bus: 'of': add device f004c7a8
device: 'f004cd88': device_add
bus: 'of': add device f004cd88
device: 'f005f2f8': device_add
bus: 'of': add device f005f2f8
device: 'f005faec': device_add
bus: 'of': add device f005faec
device: 'f0060e3c': device_add
bus: 'of': add device f0060e3c
device: 'f0061378': device_add
bus: 'of': add device f0061378
device: 'f0061438': device_add
bus: 'of': add device f0061438
device: 'f0061508': device_add
bus: 'of': add device f0061508
device: 'f006159c': device_add
bus: 'of': add device f006159c
device: 'f0062ecc': device_add
bus: 'of': add device f0062ecc
device: 'f006472c': device_add
bus: 'of': add device f006472c
device: 'f0064848': device_add
bus: 'of': add device f0064848
device: 'f0064948': device_add
bus: 'of': add device f0064948
device: 'f0066438': device_add
bus: 'of': add device f0066438
device: 'f0066520': device_add
bus: 'of': add device f0066520
device: 'f00665dc': device_add
bus: 'of': add device f00665dc
device: 'f006d788': device_add
bus: 'of': add device f006d788
device: 'f0075790': device_add
bus: 'of': add device f0075790
device: 'f007db60': device_add
bus: 'of': add device f007db60
device: 'f0080400': device_add
bus: 'of': add device f0080400
device: 'f0080aac': device_add
bus: 'of': add device f0080aac
device: 'f00600d4': device_add
bus: 'of': add device f00600d4
device: 'f006cd8c': device_add
bus: 'of': add device f006cd8c
device class 'bdi': registering
device class 'pci_bus': registering
bus: 'pci': registered
device class 'tty': registering
device class 'vtconsole': registering
device: 'vtcon0': device_add
Testing NMI watchdog ... 
WARNING: CPU#0: NMI appears to be stuck (0->0)!
Please report this to bugzilla.kernel.org,
and attach the output of the 'dmesg' command.
Registering sys device of class 'cpu'
Registering sys device 'cpu0'
bus: 'of': add driver fhc
bus: 'of': add driver clock_board
bus: 'of': add driver psycho
bus: 'of': add driver sabre
bus: 'of': driver_probe_device: matched device f005f2f8 with driver sabre
bus: 'of': really_probe: probing driver sabre with device f005f2f8
/pci@1f,0: PCI IO[1fe02000000] MEM[1ff00000000]
/pci@1f,0: SABRE PCI Bus Module ver[0:0]
PCI: Scanning PBM /pci@1f,0
device: 'pci0000:00': device_add
device: '0000:00': device_add
pci 0000:01:03.0: enabling bus mastering
device: '0000:00:01.1': device_add
bus: 'pci': add device 0000:00:01.1
device: '0000:00:01.0': device_add
bus: 'pci': add device 0000:00:01.0
device: '0000:01:01.0': device_add
bus: 'pci': add device 0000:01:01.0
device: '0000:01:01.1': device_add
bus: 'pci': add device 0000:01:01.1
device: '0000:01:02.0': device_add
bus: 'pci': add device 0000:01:02.0
device: '0000:01:03.0': device_add
bus: 'pci': add device 0000:01:03.0
device: '0000:01': device_add
device: '0000:02': device_add
driver: 'f005f2f8': driver_bound: bound to device 'sabre'
bus: 'of': really_probe: bound device f005f2f8 to driver sabre
bus: 'of': add driver schizo
bus: 'of': add driver pci_sun4v
bus: 'of': add driver fire
device: 'default': device_add
bio: create slab <bio-0> at 0
device class 'block': registering
device class 'graphics': registering
device class 'misc': registering
device class 'scsi_host': registering
bus: 'scsi': registered
device class 'scsi_device': registering
SCSI subsystem initialized
libata version 3.00 loaded.
bus: 'serio': registered
device class 'input': registering
device class 'rtc': registering
device class 'net': registering
device: 'lo': device_add
bus: 'of': add driver rtc
bus: 'of': add driver mostek
bus: 'of': driver_probe_device: matched device f0066438 with driver mostek
bus: 'of': really_probe: probing driver mostek with device f0066438
/pci@1f,0/pci@1,1/ebus@1/eeprom@14,0: Mostek regs at 0x1fff1000000
Registering platform device 'rtc-m48t59.0'. Parent at platform
device: 'rtc-m48t59.0': device_add
bus: 'platform': add device rtc-m48t59.0
driver: 'f0066438': driver_bound: bound to device 'mostek'
bus: 'of': really_probe: bound device f0066438 to driver mostek
bus: 'of': add driver bq4802
bus: 'of': add driver auxio
bus: 'of': driver_probe_device: matched device f0061378 with driver auxio
bus: 'of': really_probe: probing driver auxio with device f0061378
AUXIO: Found device at /pci@1f,0/pci@1,1/ebus@1/auxio@14,726000
driver: 'f0061378': driver_bound: bound to device 'auxio'
bus: 'of': really_probe: bound device f0061378 to driver auxio
device class 'mem': registering
device: 'mem': device_add
device: 'kmem': device_add
Switched to NOHz mode on CPU #0
device: 'null': device_add
device: 'port': device_add
device: 'zero': device_add
device: 'full': device_add
device: 'random': device_add
device: 'urandom': device_add
device: 'kmsg': device_add
device class 'firmware': registering
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
TCP established hash table entries: 32768 (order: 6, 524288 bytes)
TCP bind hash table entries: 32768 (order: 7, 1835008 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
NET: Registered protocol family 1
bus: 'of': add driver power
bus: 'of': driver_probe_device: matched device f0061438 with driver power
bus: 'of': really_probe: probing driver power with device f0061438
power: Control reg at 1fff1724000
driver: 'f0061438': driver_bound: bound to device 'power'
bus: 'of': really_probe: bound device f0061438 to driver power
device: 'mdesc': device_add
Registering sysdev class 'timekeeping'
Registering sys device of class 'timekeeping'
Registering sys device 'timekeeping0'
Registering sysdev class 'clocksource'
Registering sys device of class 'clocksource'
Registering sys device 'clocksource0'
Kprobe smoke test started
Kprobe smoke test passed successfully
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
msgmni has been set to 2003
io scheduler noop registered
io scheduler cfq registered (default)
pci 0000:00:01.1: calling quirk_cardbus_legacy+0x0/0x40
pci 0000:00:01.1: calling quirk_usb_early_handoff+0x0/0x440
pci 0000:00:01.0: calling quirk_cardbus_legacy+0x0/0x40
pci 0000:00:01.0: calling quirk_usb_early_handoff+0x0/0x440
pci 0000:01:01.0: calling quirk_cardbus_legacy+0x0/0x40
pci 0000:01:01.0: calling quirk_usb_early_handoff+0x0/0x440
pci 0000:01:01.1: calling quirk_cardbus_legacy+0x0/0x40
pci 0000:01:01.1: calling quirk_usb_early_handoff+0x0/0x440
pci 0000:01:02.0: calling quirk_cardbus_legacy+0x0/0x40
pci 0000:01:02.0: calling quirk_usb_early_handoff+0x0/0x440
pci 0000:01:03.0: calling quirk_cardbus_legacy+0x0/0x40
pci 0000:01:03.0: calling quirk_usb_early_handoff+0x0/0x440
device: 'fbcon': device_add
bus: 'pci': add driver atyfb
bus: 'pci': driver_probe_device: matched device 0000:01:02.0 with driver atyfb
bus: 'pci': really_probe: probing driver atyfb with device 0000:01:02.0
atyfb: 3D RAGE PRO (Mach64 GP, PQFP, PCI) [0x4750 rev 0x7c]
atyfb: 4M SGRAM (1:1), 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK, 100 MHz XCLK
device: 'fb0': device_add
fbcon: ATY Mach64 (fb0) is primary device
device: 'vtcon1': device_add
Console: switching to colour frame buffer device 144x56
atyfb: fb0: ATY Mach64 frame buffer device on PCI
driver: '0000:01:02.0': driver_bound: bound to device 'atyfb'
bus: 'pci': really_probe: bound device 0000:01:02.0 to driver atyfb
bus: 'of': add driver ffb
device: 'tty': device_add
device: 'console': device_add
device: 'tty0': device_add
device class 'vc': registering
device: 'vcs': device_add
device: 'vcsa': device_add
device: 'tty1': device_add
device: 'tty2': device_add
device: 'tty3': device_add
device: 'tty4': device_add
device: 'tty5': device_add
device: 'tty6': device_add
device: 'tty7': device_add
device: 'tty8': device_add
device: 'tty9': device_add
device: 'tty10': device_add
device: 'tty11': device_add
device: 'tty12': device_add
device: 'tty13': device_add
device: 'tty14': device_add
device: 'tty15': device_add
device: 'tty16': device_add
device: 'tty17': device_add
device: 'tty18': device_add
device: 'tty19': device_add
device: 'tty20': device_add
device: 'tty21': device_add
device: 'tty22': device_add
device: 'tty23': device_add
device: 'tty24': device_add
device: 'tty25': device_add
device: 'tty26': device_add
device: 'tty27': device_add
device: 'tty28': device_add
device: 'tty29': device_add
device: 'tty30': device_add
device: 'tty31': device_add
device: 'tty32': device_add
device: 'tty33': device_add
device: 'tty34': device_add
device: 'tty35': device_add
device: 'tty36': device_add
device: 'tty37': device_add
device: 'tty38': device_add
device: 'tty39': device_add
device: 'tty40': device_add
device: 'tty41': device_add
device: 'tty42': device_add
device: 'tty43': device_add
device: 'tty44': device_add
device: 'tty45': device_add
device: 'tty46': device_add
device: 'tty47': device_add
device: 'tty48': device_add
device: 'tty49': device_add
device: 'tty50': device_add
device: 'tty51': device_add
device: 'tty52': device_add
device: 'tty53': device_add
device: 'tty54': device_add
device: 'tty55': device_add
device: 'tty56': device_add
device: 'tty57': device_add
device: 'tty58': device_add
device: 'tty59': device_add
device: 'tty60': device_add
device: 'tty61': device_add
device: 'tty62': device_add
device: 'tty63': device_add
device: 'ptmx': device_add
bus: 'of': add driver su
bus: 'of': driver_probe_device: matched device f0062ecc with driver su
bus: 'of': really_probe: probing driver su with device f0062ecc
/pci@1f,0/pci@1,1/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 6
driver: 'f0062ecc': driver_bound: bound to device 'su'
bus: 'of': really_probe: bound device f0062ecc to driver su
bus: 'of': driver_probe_device: matched device f006472c with driver su
bus: 'of': really_probe: probing driver su with device f006472c
/pci@1f,0/pci@1,1/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 7
driver: 'f006472c': driver_bound: bound to device 'su'
bus: 'of': really_probe: bound device f006472c to driver su
device: 'serio0': device_add
bus: 'serio': add device serio0
bus: 'of': add driver hme
device: 'serio1': device_add
bus: 'serio': add device serio1
bus: 'pci': add driver hme
bus: 'pci': driver_probe_device: matched device 0000:01:01.1 with driver hme
bus: 'pci': really_probe: probing driver hme with device 0000:01:01.1
PCI: Enabling device: (0000:01:01.1), cmd 2
hme 0000:01:01.1: enabling bus mastering
sunhme.c:v3.10 August 26, 2008 David S. Miller (davem@davemloft.net)
device: 'eth0': device_add
eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:ff:e6:ff
driver: '0000:01:01.1': driver_bound: bound to device 'hme'
bus: 'pci': really_probe: bound device 0000:01:01.1 to driver hme
console [netcon0] enabled
netconsole: network logging started
device class 'scsi_disk': registering
Driver 'sd' needs updating - please use bus_type methods
bus: 'scsi': add driver sd
Driver 'sr' needs updating - please use bus_type methods
bus: 'scsi': add driver sr
device class 'scsi_generic': registering
bus: 'pci': add driver pata_cmd64x
bus: 'pci': driver_probe_device: matched device 0000:01:03.0 with driver pata_cmd64x
bus: 'pci': really_probe: probing driver pata_cmd64x with device 0000:01:03.0
scsi0 : pata_cmd64x
device: 'host0': device_add
device: 'host0': device_add
scsi1 : pata_cmd64x
device: 'host1': device_add
device: 'host1': device_add
ata1: PATA max MWDMA2 cmd 0x1fe02c00000 ctl 0x1fe02c00008 bmdma 0x1fe02c00020 irq 14
ata2: PATA max MWDMA2 cmd 0x1fe02c00010 ctl 0x1fe02c00018 bmdma 0x1fe02c00028 irq 14
pata_cmd64x: active 10 recovery 10 setup 3.
pata_cmd64x: active 10 recovery 10 setup 3.
ata1.00: ATA-4: ST320420A, 3.21, max UDMA/66
ata1.00: 39851760 sectors, multi 0: LBA 
pata_cmd64x: active 3 recovery 1 setup 1.
pata_cmd64x: active 3 recovery 1 setup 1.
ata1.00: configured for MWDMA2
scsi 0:0:0:0: Direct-Access     ATA      ST320420A        3.21 PQ: 0 ANSI: 5
device: 'target0:0:0': device_add
device: '0:0:0:0': device_add
bus: 'scsi': add device 0:0:0:0
bus: 'scsi': driver_probe_device: matched device 0:0:0:0 with driver sd
bus: 'scsi': really_probe: probing driver sd with device 0:0:0:0
device: '0:0:0:0': device_add
sd 0:0:0:0: [sda] 39851760 512-byte hardware sectors: (20.4 GB/19.0 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
device: 'sda': device_add
sd 0:0:0:0: [sda] 39851760 512-byte hardware sectors: (20.4 GB/19.0 GiB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda: sda1 sda2
device: 'sda1': device_add
device: 'sda2': device_add
device: '8:0': device_add
sd 0:0:0:0: [sda] Attached SCSI disk
driver: '0:0:0:0': driver_bound: bound to device 'sd'
bus: 'scsi': really_probe: bound device 0:0:0:0 to driver sd
device: '0:0:0:0': device_add
device: 'sg0': device_add
sd 0:0:0:0: Attached scsi generic sg0 type 0
pata_cmd64x: active 10 recovery 10 setup 3.
pata_cmd64x: active 10 recovery 10 setup 3.
ata2.00: ATAPI: CRD-8483B, 1.01, max UDMA/33
pata_cmd64x: active 3 recovery 1 setup 1.
pata_cmd64x: active 3 recovery 1 setup 1.
ata2.00: configured for MWDMA2
scsi 1:0:0:0: CD-ROM            LG       CD-ROM CRD-8483B 1.01 PQ: 0 ANSI: 5
device: 'target1:0:0': device_add
device: '1:0:0:0': device_add
bus: 'scsi': add device 1:0:0:0
bus: 'scsi': driver_probe_device: matched device 1:0:0:0 with driver sd
bus: 'scsi': really_probe: probing driver sd with device 1:0:0:0
bus: 'scsi': driver_probe_device: matched device 1:0:0:0 with driver sr
bus: 'scsi': really_probe: probing driver sr with device 1:0:0:0
sr0: scsi3-mmc drive: 0x/48x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
device: 'sr0': device_add
device: '11:0': device_add
sr 1:0:0:0: Attached scsi CD-ROM sr0
driver: '1:0:0:0': driver_bound: bound to device 'sr'
bus: 'scsi': really_probe: bound device 1:0:0:0 to driver sr
device: '1:0:0:0': device_add
device: 'sg1': device_add
sr 1:0:0:0: Attached scsi generic sg1 type 5
driver: '0000:01:03.0': driver_bound: bound to device 'pata_cmd64x'
bus: 'pci': really_probe: bound device 0000:01:03.0 to driver pata_cmd64x
device: 'openprom': device_add
device: 'mice': device_add
device: 'psaux': device_add
mice: PS/2 mouse device common for all mice
bus: 'serio': add driver sunkbd
bus: 'platform': add driver rtc_cmos
bus: 'serio': driver_probe_device: matched device serio0 with driver sunkbd
bus: 'serio': really_probe: probing driver sunkbd with device serio0
bus: 'platform': remove driver rtc_cmos
driver: 'rtc_cmos': driver_release
bus: 'platform': add driver rtc-m48t59
bus: 'platform': driver_probe_device: matched device rtc-m48t59.0 with driver rtc-m48t59
bus: 'platform': really_probe: probing driver rtc-m48t59 with device rtc-m48t59.0
device: 'rtc0': device_add
rtc-m48t59 rtc-m48t59.0: rtc core: registered m48t59 as rtc0
driver: 'rtc-m48t59.0': driver_bound: bound to device 'rtc-m48t59'
bus: 'platform': really_probe: bound device rtc-m48t59.0 to driver rtc-m48t59
bus: 'platform': add driver rtc-bq4802
bus: 'platform': add driver rtc-sun4v
bus: 'platform': remove driver rtc-sun4v
driver: 'rtc-sun4v': driver_release
bus: 'platform': add driver rtc-starfire
bus: 'platform': remove driver rtc-starfire
driver: 'rtc-starfire': driver_release
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
device: 'cpu_dma_latency': device_add
device: 'network_latency': device_add
device: 'network_throughput': device_add
rtc-m48t59 rtc-m48t59.0: setting system clock to 2009-02-04 17:06:13 UTC (1233767173)
driver_probe_done: probe_count = 1
driver_probe_done: probe_count = 1
driver_probe_done: probe_count = 1
driver_probe_done: probe_count = 1
driver_probe_done: probe_count = 1
driver_probe_done: probe_count = 1
device: 'input0': device_add
input: Sun Type 5 keyboard as /class/input/input0
driver_probe_done: probe_count = 1
driver_probe_done: probe_count = 1
device: 'event0': device_add
driver: 'serio0': driver_bound: bound to device 'sunkbd'
bus: 'serio': really_probe: bound device serio0 to driver sunkbd
driver_probe_done: probe_count = 0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly on device 8:2.
device: 'vcs1': device_add
device: 'vcsa1': device_add
device: 'vcs1': device_unregister
device: 'vcs1': device_create_release
device: 'vcsa1': device_unregister
device: 'vcsa1': device_create_release
device: 'vcs1': device_add
device: 'vcsa1': device_add
device: 'vcs1': device_unregister
device: 'vcs1': device_create_release
device: 'vcsa1': device_unregister
device: 'vcsa1': device_create_release
device: 'vcs1': device_add
device: 'vcsa1': device_add
device: 'vcs1': device_unregister
device: 'vcs1': device_create_release
device: 'vcsa1': device_unregister
device: 'vcsa1': device_create_release
device: 'vcs1': device_add
device: 'vcsa1': device_add
device: 'vcs1': device_unregister
device: 'vcs1': device_create_release
device: 'vcsa1': device_unregister
device: 'vcsa1': device_create_release
device: 'vcs1': device_add
device: 'vcsa1': device_add
device: 'vcs1': device_unregister
device: 'vcs1': device_create_release
device: 'vcsa1': device_unregister
device: 'vcsa1': device_create_release
device: 'vcs1': device_add
device: 'vcsa1': device_add
device: 'vcs1': device_unregister
device: 'vcs1': device_create_release
device: 'vcsa1': device_unregister
device: 'vcsa1': device_create_release
device: 'vcs1': device_add
device: 'vcsa1': device_add
EXT3 FS on sda2, internal journal
device: 'vcs2': device_add
device: 'vcsa2': device_add
device: 'vcs2': device_unregister
device: 'vcs2': device_create_release
device: 'vcsa2': device_unregister
device: 'vcsa2': device_create_release
device: 'vcs3': device_add
device: 'vcsa3': device_add
device: 'vcs3': device_unregister
device: 'vcs3': device_create_release
device: 'vcsa3': device_unregister
device: 'vcsa3': device_create_release
device: 'vcs4': device_add
device: 'vcsa4': device_add
device: 'vcs4': device_unregister
device: 'vcs4': device_create_release
device: 'vcsa4': device_unregister
device: 'vcsa4': device_create_release
device: 'vcs5': device_add
device: 'vcsa5': device_add
device: 'vcs5': device_unregister
device: 'vcs5': device_create_release
device: 'vcsa5': device_unregister
device: 'vcsa5': device_create_release
device: 'vcs6': device_add
device: 'vcsa6': device_add
device: 'vcs6': device_unregister
device: 'vcs6': device_create_release
device: 'vcsa6': device_unregister
device: 'vcsa6': device_create_release
device: 'vcs7': device_add
device: 'vcsa7': device_add
device: 'vcs7': device_unregister
device: 'vcs7': device_create_release
device: 'vcsa7': device_unregister
device: 'vcsa7': device_create_release
device: 'vcs8': device_add
device: 'vcsa8': device_add
device: 'vcs8': device_unregister
device: 'vcs8': device_create_release
device: 'vcsa8': device_unregister
device: 'vcsa8': device_create_release
device: 'vcs9': device_add
device: 'vcsa9': device_add
device: 'vcs9': device_unregister
device: 'vcs9': device_create_release
device: 'vcsa9': device_unregister
device: 'vcsa9': device_create_release
device: 'vcs10': device_add
device: 'vcsa10': device_add
device: 'vcs10': device_unregister
device: 'vcs10': device_create_release
device: 'vcsa10': device_unregister
device: 'vcsa10': device_create_release
device: 'vcs11': device_add
device: 'vcsa11': device_add
device: 'vcs11': device_unregister
device: 'vcs11': device_create_release
device: 'vcsa11': device_unregister
device: 'vcsa11': device_create_release
device: 'vcs12': device_add
device: 'vcsa12': device_add
device: 'vcs12': device_unregister
device: 'vcs12': device_create_release
device: 'vcsa12': device_unregister
device: 'vcsa12': device_create_release
device: 'vcs2': device_add
device: 'vcsa2': device_add
device: 'vcs2': device_unregister
device: 'vcs2': device_create_release
device: 'vcsa2': device_unregister
device: 'vcsa2': device_create_release
device: 'vcs3': device_add
device: 'vcsa3': device_add
device: 'vcs3': device_unregister
device: 'vcs3': device_create_release
device: 'vcsa3': device_unregister
device: 'vcsa3': device_create_release
device: 'vcs4': device_add
device: 'vcsa4': device_add
device: 'vcs4': device_unregister
device: 'vcs4': device_create_release
device: 'vcsa4': device_unregister
device: 'vcsa4': device_create_release
device: 'vcs5': device_add
device: 'vcsa5': device_add
device: 'vcs5': device_unregister
device: 'vcs5': device_create_release
device: 'vcsa5': device_unregister
device: 'vcsa5': device_create_release
device: 'vcs6': device_add
device: 'vcsa6': device_add
device: 'vcs6': device_unregister
device: 'vcs6': device_create_release
device: 'vcsa6': device_unregister
device: 'vcsa6': device_create_release
device: 'vcs7': device_add
device: 'vcsa7': device_add
device: 'vcs7': device_unregister
device: 'vcs7': device_create_release
device: 'vcsa7': device_unregister
device: 'vcsa7': device_create_release
device: 'vcs8': device_add
device: 'vcsa8': device_add
device: 'vcs8': device_unregister
device: 'vcs8': device_create_release
device: 'vcsa8': device_unregister
device: 'vcsa8': device_create_release
device: 'vcs9': device_add
device: 'vcsa9': device_add
device: 'vcs9': device_unregister
device: 'vcs9': device_create_release
device: 'vcsa9': device_unregister
device: 'vcsa9': device_create_release
device: 'vcs10': device_add
device: 'vcsa10': device_add
device: 'vcs10': device_unregister
device: 'vcs10': device_create_release
device: 'vcsa10': device_unregister
device: 'vcsa10': device_create_release
device: 'vcs11': device_add
device: 'vcsa11': device_add
device: 'vcs11': device_unregister
device: 'vcs11': device_create_release
device: 'vcsa11': device_unregister
device: 'vcsa11': device_create_release
device: 'vcs12': device_add
device: 'vcsa12': device_add
device: 'vcs12': device_unregister
device: 'vcs12': device_create_release
device: 'vcsa12': device_unregister
device: 'vcsa12': device_create_release
device: 'vcs2': device_add
device: 'vcsa2': device_add
device: 'vcs2': device_unregister
device: 'vcs2': device_create_release
device: 'vcsa2': device_unregister
device: 'vcsa2': device_create_release
device: 'vcs3': device_add
device: 'vcsa3': device_add
device: 'vcs3': device_unregister
device: 'vcs3': device_create_release
device: 'vcsa3': device_unregister
device: 'vcsa3': device_create_release
device: 'vcs4': device_add
device: 'vcsa4': device_add
device: 'vcs4': device_unregister
device: 'vcs4': device_create_release
device: 'vcsa4': device_unregister
device: 'vcsa4': device_create_release
device: 'vcs5': device_add
device: 'vcsa5': device_add
device: 'vcs5': device_unregister
device: 'vcs5': device_create_release
device: 'vcsa5': device_unregister
device: 'vcsa5': device_create_release
device: 'vcs6': device_add
device: 'vcsa6': device_add
device: 'vcs6': device_unregister
device: 'vcs6': device_create_release
device: 'vcsa6': device_unregister
device: 'vcsa6': device_create_release
device: 'vcs7': device_add
device: 'vcsa7': device_add
device: 'vcs7': device_unregister
device: 'vcs7': device_create_release
device: 'vcsa7': device_unregister
device: 'vcsa7': device_create_release
device: 'vcs8': device_add
device: 'vcsa8': device_add
device: 'vcs8': device_unregister
device: 'vcs8': device_create_release
device: 'vcsa8': device_unregister
device: 'vcsa8': device_create_release
device: 'vcs9': device_add
device: 'vcsa9': device_add
device: 'vcs9': device_unregister
device: 'vcs9': device_create_release
device: 'vcsa9': device_unregister
device: 'vcsa9': device_create_release
device: 'vcs10': device_add
device: 'vcsa10': device_add
device: 'vcs10': device_unregister
device: 'vcs10': device_create_release
device: 'vcsa10': device_unregister
device: 'vcsa10': device_create_release
device: 'vcs11': device_add
device: 'vcsa11': device_add
device: 'vcs11': device_unregister
device: 'vcs11': device_create_release
device: 'vcsa11': device_unregister
device: 'vcsa11': device_create_release
device: 'vcs12': device_add
device: 'vcsa12': device_add
device: 'vcs12': device_unregister
device: 'vcs12': device_create_release
device: 'vcsa12': device_unregister
device: 'vcsa12': device_create_release
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.
Adding 258032k swap on /dev/sda1.  Priority:-1 extents:1 across:258032k 
device: 'vcs1': device_unregister
device: 'vcs1': device_create_release
device: 'vcsa1': device_unregister
device: 'vcsa1': device_create_release
device: 'vcs1': device_add
device: 'vcsa1': device_add
device: 'vcs1': device_unregister
device: 'vcs1': device_create_release
device: 'vcsa1': device_unregister
device: 'vcsa1': device_create_release
device: 'vcs1': device_add
device: 'vcsa1': device_add
device: 'vcs1': device_unregister
device: 'vcs1': device_create_release
device: 'vcsa1': device_unregister
device: 'vcsa1': device_create_release
device: 'vcs1': device_add
device: 'vcsa1': device_add
device: 'vcs1': device_unregister
device: 'vcs1': device_create_release
device: 'vcsa1': device_unregister
device: 'vcsa1': device_create_release
device: 'vcs1': device_add
device: 'vcsa1': device_add
device: 'vcs1': device_unregister
device: 'vcs1': device_create_release
device: 'vcsa1': device_unregister
device: 'vcsa1': device_create_release
device: 'vcs1': device_add
device: 'vcsa1': device_add
device: 'vcs1': device_unregister
device: 'vcs1': device_create_release
device: 'vcsa1': device_unregister
device: 'vcsa1': device_create_release
device: 'vcs1': device_add
device: 'vcsa1': device_add
device: 'vcs5': device_add
device: 'vcsa5': device_add
device: 'vcs4': device_add
device: 'vcsa4': device_add
device: 'vcs3': device_add
device: 'vcsa3': device_add
device: 'vcs6': device_add
device: 'vcsa6': device_add
device: 'vcs2': device_add
device: 'vcsa2': device_add

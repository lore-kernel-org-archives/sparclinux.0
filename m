From: Nick Schmalenberger <nick@schmalenberger.us>
Date: Sat, 12 Apr 2008 09:32:42 +0000
Subject: disks on Ultra/1 not detected with esp_scsi on 2.6.24
Message-Id: <20080412093242.GP3535@bayworld.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="VV4b6MQE+OnNyhkM"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I just tried to install debian using the netboot installer with the
2.6.24 kernel and it doesn't detect my disks, which were detected with
the esp driver in 2.6.18. The system is an Ultra/1 with 1 18GB disk.
lsmod shows this:
 # lsmod
 Module                  Size  Used by
 sd_mod                 30104  0 
 esp_scsi               26384  0 
 scsi_transport_spi     28416  1 esp_scsi
 scsi_mod              173824  3 sd_mod,esp_scsi,scsi_transport_spi
 ide_generic             1536  0 [permanent]
 sunlance               17232  0 
and dmesg has this:
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
registered taskstats version 1
sunlance.c:v2.02 8/24/03 Miguel de Icaza (miguel@nuclecu.unam.mx)
eth0: LANCE 08:00:20:8c:ca:c1
SCSI subsystem initialized
Driver 'sd' needs updating - please use bus_type methods

Full dmesg, hardware summary, and syslog are attached, thanks for all help!


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

PROMLIB: Sun IEEE Boot Prom 'OBP 3.35.0 2004/04/19 12:16'
PROMLIB: Root node compatible: 
Linux version 2.6.24-1-sparc64 (Debian 2.6.24-5) (waldi@debian.org) (gcc version 4.1.3 20080308 (prerelease) (Debian 4.1.2-21)) #1 Thu Mar 27 16:28:01 UTC 2008
ARCH: SUN4U
Ethernet address: 08:00:20:8c:ca:c1
[0000000200000000-fffff80000800000] page_structs=262144 node=0 entry=0/0
[0000000200000000-fffff80000c00000] page_structs=262144 node=0 entry=1/0
[0000000200000000-fffff80001000000] page_structs=262144 node=0 entry=2/0
[0000000200000000-fffff80001400000] page_structs=262144 node=0 entry=3/0
OF stdout device is: /sbus@1f,0/zs@f,1100000:a
PROM: Built device tree with 34477 bytes of memory.
On node 0 totalpages: 32217
  Normal zone: 335 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 31882 pages, LIFO batch:7
  Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 31882
Kernel command line: 
PID hash table entries: 1024 (order: 10, 8192 bytes)
clocksource: mult[5fcfc] shift[16]
clockevent: mult[2ac025bd] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled
Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 4, 131072 bytes)
Memory: 237104k available (2496k kernel code, 904k data, 160k init) [fffff80000000000,0000000017f4c000]
Calibrating delay using timer specific routine.. 334.77 BogoMIPS (lpj=669543)
Security Framework initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
net_namespace: 120 bytes
NET: Registered protocol family 16
PCI: Probing for controllers.
SYSIO: UPA portID 1f, at 000001fe00000000
sbus0: Clock 25.0 MHz
dma0: Revision 2 
dma1: Revision 2 
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
AUXIO: Found device at /sbus@1f,0/auxio@f,1900000
/sbus@1f,0/eeprom@f,1200000: Clock regs at 000001fff1200000
Time: tick clocksource has been installed.
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 16384 bytes)
TCP established hash table entries: 8192 (order: 4, 131072 bytes)
TCP bind hash table entries: 8192 (order: 3, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 3225k freed
Mini RTC Driver
audit: initializing netlink socket (disabled)
audit(1207984106.040:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Console: switching to colour frame buffer device 144x56
/sbus@1f,0/cgsix@0,0: CGsix [GX 68020] at 0:1ff00000000
[drm] Initialized drm 1.1.0 20060810
f005a290: ttyS0 at MMIO 0x1fff1100000 (irq = 9) is a zs
Console: ttyS0 (SunZilog zs0)
console [ttyS0] enabled
f005a290: ttyS1 at MMIO 0x1fff1100004 (irq = 9) is a zs
f005b730: Keyboard at MMIO 0x1fff1000000 (irq = 9) is a zs
f005b730: Mouse at MMIO 0x1fff1000004 (irq = 9) is a zs
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: module loaded
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
mice: PS/2 mouse device common for all mice
input: Sun Mouse as /class/input/input0
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
registered taskstats version 1
sunlance.c:v2.02 8/24/03 Miguel de Icaza (miguel@nuclecu.unam.mx)
eth0: LANCE 08:00:20:8c:ca:c1
SCSI subsystem initialized
Driver 'sd' needs updating - please use bus_type methods

--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=hardware-summary

umame -a: Linux dors 2.6.24-1-sparc64 #1 Thu Mar 27 16:28:01 UTC 2008 sparc64 unknown
lsmod: Module                  Size  Used by
lsmod: sd_mod                 30104  0 
lsmod: esp_scsi               26384  0 
lsmod: scsi_transport_spi     28416  1 esp_scsi
lsmod: scsi_mod              173824  3 sd_mod,esp_scsi,scsi_transport_spi
lsmod: ide_generic             1536  0 [permanent]
lsmod: sunlance               17232  0 
df: Filesystem           1k-blocks      Used Available Use% Mounted on
df: tmpfs                   120416         8    120408   0% /dev
df: tmpfs                   120416         8    120408   0% /dev
free:               total         used         free       shared      buffers
free:   Mem:       240832        35800       205032            0            0
free:  Swap:            0            0            0
free: Total:       240832        35800       205032
cardctl status: /usr/bin/report-hw: line 48: pccardctl: not found
cardctl ident: /usr/bin/report-hw: line 49: pccardctl: not found
cardctl status: /usr/bin/report-hw: line 50: cardctl: not found
cardctl ident: /usr/bin/report-hw: line 51: cardctl: not found
/proc/cpuinfo: cpu		: TI UltraSparc I   (SpitFire)
/proc/cpuinfo: fpu		: UltraSparc I integrated FPU
/proc/cpuinfo: prom		: OBP 3.35.0 2004/04/19 12:16
/proc/cpuinfo: type		: sun4u
/proc/cpuinfo: ncpus probed	: 1
/proc/cpuinfo: ncpus active	: 1
/proc/cpuinfo: D$ parity tl1	: 0
/proc/cpuinfo: I$ parity tl1	: 0
/proc/cpuinfo: Cpu0ClkTck	: 0000000009f42205
/proc/cpuinfo: MMU Type	: Spitfire
/proc/ioports: 1ffe8400000-1ffe840000f : dma
/proc/ioports: 1ffe8400010-1ffe840002f : dma
/proc/ioports: 1ffe8c00000-1ffe8c00003 : LANCE
/proc/ioports: 1fff1400002-1fff1400005 : floppy
/proc/ioports: 1fff1400007-1fff1400007 : floppy DIR
/proc/iomem: 1ff00200000-1ff0020000f : cgsix dac
/proc/iomem: 1ff00300000-1ff00300003 : cgsix fhc
/proc/iomem: 1ff00301000-1ff003019ff : cgsix thc
/proc/iomem: 1ff00700000-1ff00700fff : cgsix fbc
/proc/iomem: 1ff00701000-1ff0070100b : cgsix tec
/proc/iomem: 1ff00800000-1ff008fdfff : cgsix ram
/proc/iomem: 1fff1000000-1fff1000007 : zs
/proc/iomem: 1fff1100000-1fff1100007 : zs
/proc/iomem: 1fff1200000-1fff1201fff : clock
/proc/iomem: 1fff1900000-1fff1900000 : auxio
/proc/interrupts:            CPU0       
/proc/interrupts:   0:    2117326     <NULL>  timer
/proc/interrupts:   1:          0      sun4u  SYSIO_UE
/proc/interrupts:   2:          0      sun4u  SYSIO_CE
/proc/interrupts:   3:          0      sun4u  SYSIO_SBERR
/proc/interrupts:   8:          2      sun4u  floppy
/proc/interrupts:   9:     305551      sun4u  zs
/proc/interrupts:  11:       9667      sun4u  LANCE
/proc/meminfo: MemTotal:       240832 kB
/proc/meminfo: MemFree:        205032 kB
/proc/meminfo: Buffers:             0 kB
/proc/meminfo: Cached:          25816 kB
/proc/meminfo: SwapCached:          0 kB
/proc/meminfo: Active:           8576 kB
/proc/meminfo: Inactive:        19696 kB
/proc/meminfo: SwapTotal:           0 kB
/proc/meminfo: SwapFree:            0 kB
/proc/meminfo: Dirty:               0 kB
/proc/meminfo: Writeback:           0 kB
/proc/meminfo: AnonPages:        2496 kB
/proc/meminfo: Mapped:           2216 kB
/proc/meminfo: Slab:             4200 kB
/proc/meminfo: SReclaimable:     1744 kB
/proc/meminfo: SUnreclaim:       2456 kB
/proc/meminfo: PageTables:        400 kB
/proc/meminfo: NFS_Unstable:        0 kB
/proc/meminfo: Bounce:              0 kB
/proc/meminfo: CommitLimit:    120416 kB
/proc/meminfo: Committed_AS:     6720 kB
/proc/meminfo: VmallocTotal:  4194304 kB
/proc/meminfo: VmallocUsed:         0 kB
/proc/meminfo: VmallocChunk:  4194304 kB
/proc/meminfo: HugePages_Total:     0
/proc/meminfo: HugePages_Free:      0
/proc/meminfo: HugePages_Rsvd:      0
/proc/meminfo: HugePages_Surp:      0
/proc/meminfo: Hugepagesize:     4096 kB
/proc/bus/input/devices: I: Bus=0013 Vendor=0002 Product=0001 Version=0100
/proc/bus/input/devices: N: Name="Sun Mouse"
/proc/bus/input/devices: P: Phys=zs/serio1/input0
/proc/bus/input/devices: S: Sysfs=/class/input/input0
/proc/bus/input/devices: U: Uniq=
/proc/bus/input/devices: H: Handlers=mouse0 
/proc/bus/input/devices: B: EV=7
/proc/bus/input/devices: B: KEY=70000 0 0 0 0
/proc/bus/input/devices: B: REL=3
/proc/bus/input/devices: 
dmidecode: /usr/bin/report-hw: line 65: dmidecode: not found

--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=syslog

Apr 12 07:08:33 syslogd started: BusyBox v1.9.2
Apr 12 07:08:33 kernel: klogd started: BusyBox v1.9.2 (2008-03-26 12:11:19 UTC)
Apr 12 07:08:33 kernel: PROMLIB: Sun IEEE Boot Prom 'OBP 3.35.0 2004/04/19 12:16'
Apr 12 07:08:33 kernel: PROMLIB: Root node compatible: 
Apr 12 07:08:33 kernel: Linux version 2.6.24-1-sparc64 (Debian 2.6.24-5) (waldi@debian.org) (gcc version 4.1.3 20080308 (prerelease) (Debian 4.1.2-21)) #1 Thu Mar 27 16:28:01 UTC 2008
Apr 12 07:08:33 kernel: ARCH: SUN4U
Apr 12 07:08:33 kernel: Ethernet address: 08:00:20:8c:ca:c1
Apr 12 07:08:33 kernel: [0000000200000000-fffff80000800000] page_structs=262144 node=0 entry=0/0
Apr 12 07:08:33 kernel: [0000000200000000-fffff80000c00000] page_structs=262144 node=0 entry=1/0
Apr 12 07:08:33 kernel: [0000000200000000-fffff80001000000] page_structs=262144 node=0 entry=2/0
Apr 12 07:08:33 kernel: [0000000200000000-fffff80001400000] page_structs=262144 node=0 entry=3/0
Apr 12 07:08:33 kernel: OF stdout device is: /sbus@1f,0/zs@f,1100000:a
Apr 12 07:08:33 kernel: PROM: Built device tree with 34477 bytes of memory.
Apr 12 07:08:33 kernel: On node 0 totalpages: 32217
Apr 12 07:08:33 kernel:   Normal zone: 335 pages used for memmap
Apr 12 07:08:33 kernel:   Normal zone: 0 pages reserved
Apr 12 07:08:33 kernel:   Normal zone: 31882 pages, LIFO batch:7
Apr 12 07:08:33 kernel:   Movable zone: 0 pages used for memmap
Apr 12 07:08:33 kernel: Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 31882
Apr 12 07:08:33 kernel: Kernel command line: 
Apr 12 07:08:33 kernel: PID hash table entries: 1024 (order: 10, 8192 bytes)
Apr 12 07:08:33 kernel: clocksource: mult[5fcfc] shift[16]
Apr 12 07:08:33 kernel: clockevent: mult[2ac025bd] shift[32]
Apr 12 07:08:33 kernel: Console: colour dummy device 80x25
Apr 12 07:08:33 kernel: console [tty0] enabled
Apr 12 07:08:33 kernel: Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
Apr 12 07:08:33 kernel: Inode-cache hash table entries: 16384 (order: 4, 131072 bytes)
Apr 12 07:08:33 kernel: Memory: 237104k available (2496k kernel code, 904k data, 160k init) [fffff80000000000,0000000017f4c000]
Apr 12 07:08:33 kernel: Calibrating delay using timer specific routine.. 334.77 BogoMIPS (lpj=669543)
Apr 12 07:08:33 kernel: Security Framework initialized
Apr 12 07:08:33 kernel: SELinux:  Disabled at boot.
Apr 12 07:08:33 kernel: Capability LSM initialized
Apr 12 07:08:33 kernel: Mount-cache hash table entries: 512
Apr 12 07:08:33 kernel: Initializing cgroup subsys ns
Apr 12 07:08:33 kernel: Initializing cgroup subsys cpuacct
Apr 12 07:08:33 kernel: net_namespace: 120 bytes
Apr 12 07:08:33 kernel: NET: Registered protocol family 16
Apr 12 07:08:33 kernel: PCI: Probing for controllers.
Apr 12 07:08:33 kernel: SYSIO: UPA portID 1f, at 000001fe00000000
Apr 12 07:08:33 kernel: sbus0: Clock 25.0 MHz
Apr 12 07:08:33 kernel: dma0: Revision 2 
Apr 12 07:08:33 kernel: dma1: Revision 2 
Apr 12 07:08:33 kernel: usbcore: registered new interface driver usbfs
Apr 12 07:08:33 kernel: usbcore: registered new interface driver hub
Apr 12 07:08:33 kernel: usbcore: registered new device driver usb
Apr 12 07:08:33 kernel: AUXIO: Found device at /sbus@1f,0/auxio@f,1900000
Apr 12 07:08:33 kernel: /sbus@1f,0/eeprom@f,1200000: Clock regs at 000001fff1200000
Apr 12 07:08:33 kernel: Time: tick clocksource has been installed.
Apr 12 07:08:33 kernel: NET: Registered protocol family 2
Apr 12 07:08:33 kernel: IP route cache hash table entries: 2048 (order: 1, 16384 bytes)
Apr 12 07:08:33 kernel: TCP established hash table entries: 8192 (order: 4, 131072 bytes)
Apr 12 07:08:33 kernel: TCP bind hash table entries: 8192 (order: 3, 65536 bytes)
Apr 12 07:08:33 kernel: TCP: Hash tables configured (established 8192 bind 8192)
Apr 12 07:08:33 kernel: TCP reno registered
Apr 12 07:08:33 kernel: checking if image is initramfs... it is
Apr 12 07:08:33 kernel: Freeing initrd memory: 3225k freed
Apr 12 07:08:33 kernel: Mini RTC Driver
Apr 12 07:08:33 kernel: audit: initializing netlink socket (disabled)
Apr 12 07:08:33 kernel: audit(1207984106.040:1): initialized
Apr 12 07:08:33 kernel: Total HugeTLB memory allocated, 0
Apr 12 07:08:33 kernel: VFS: Disk quotas dquot_6.5.1
Apr 12 07:08:33 kernel: Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
Apr 12 07:08:33 kernel: io scheduler noop registered
Apr 12 07:08:33 kernel: io scheduler anticipatory registered
Apr 12 07:08:33 kernel: io scheduler deadline registered
Apr 12 07:08:33 kernel: io scheduler cfq registered (default)
Apr 12 07:08:33 kernel: Console: switching to colour frame buffer device 144x56
Apr 12 07:08:33 kernel: /sbus@1f,0/cgsix@0,0: CGsix [GX 68020] at 0:1ff00000000
Apr 12 07:08:33 kernel: [drm] Initialized drm 1.1.0 20060810
Apr 12 07:08:33 kernel: f005a290: ttyS0 at MMIO 0x1fff1100000 (irq = 9) is a zs
Apr 12 07:08:33 kernel: Console: ttyS0 (SunZilog zs0)
Apr 12 07:08:33 kernel: console [ttyS0] enabled
Apr 12 07:08:33 kernel: f005a290: ttyS1 at MMIO 0x1fff1100004 (irq = 9) is a zs
Apr 12 07:08:33 kernel: f005b730: Keyboard at MMIO 0x1fff1000000 (irq = 9) is a zs
Apr 12 07:08:33 kernel: f005b730: Mouse at MMIO 0x1fff1000004 (irq = 9) is a zs
Apr 12 07:08:33 kernel: Floppy drive(s): fd0 is 1.44M
Apr 12 07:08:33 kernel: FDC 0 is a post-1991 82077
Apr 12 07:08:33 kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Apr 12 07:08:33 kernel: loop: module loaded
Apr 12 07:08:33 kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Apr 12 07:08:33 kernel: ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=xx
Apr 12 07:08:33 kernel: mice: PS/2 mouse device common for all mice
Apr 12 07:08:33 kernel: input: Sun Mouse as /class/input/input0
Apr 12 07:08:33 kernel: usbcore: registered new interface driver usbhid
Apr 12 07:08:33 kernel: drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Apr 12 07:08:33 kernel: TCP bic registered
Apr 12 07:08:33 kernel: NET: Registered protocol family 1
Apr 12 07:08:33 kernel: NET: Registered protocol family 17
Apr 12 07:08:33 kernel: registered taskstats version 1
Apr 12 07:08:41 init: init: starting pid 575, tty '': '/bin/cttyhack'
Apr 12 07:08:41 init: init: starting pid 577, tty '/dev/tty4': '/usr/bin/tail'
Apr 12 07:08:45 debconf: Setting debconf/language to en
Apr 12 07:08:45 main-menu[598]: DEBUG: resolver (libc6): package doesn't exist (ignored)
Apr 12 07:08:45 main-menu[598]: INFO: Menu item 'localechooser' selected
Apr 12 07:08:45 debconf: Setting debconf/language to C
Apr 12 07:10:08 main-menu[598]: INFO: Menu item 'localechooser' succeeded but requested to be left unconfigured.
Apr 12 07:10:08 main-menu[598]: INFO: Modifying debconf priority limit from 'high' to 'medium'
Apr 12 07:10:08 debconf: Setting debconf/priority to medium
Apr 12 07:10:08 main-menu[598]: DEBUG: resolver (libc6): package doesn't exist (ignored)
Apr 12 07:10:17 main-menu[598]: INFO: Falling back to the package description for auto-install
Apr 12 07:10:17 main-menu[598]: INFO: Falling back to the package description for ai-choosers
Apr 12 07:10:17 main-menu[598]: INFO: Menu item 'cdebconf-priority' selected
Apr 12 07:10:29 debconf: Setting debconf/priority to low
Apr 12 07:10:29 main-menu[598]: INFO: Priority changed externally, setting main-menu default to 'low' (low)
Apr 12 07:10:29 main-menu[598]: DEBUG: resolver (libc6): package doesn't exist (ignored)
Apr 12 07:10:38 main-menu[598]: INFO: Menu item 'localechooser' selected
Apr 12 07:10:38 debconf: Setting debconf/language to C
Apr 12 07:10:44 localechooser: info: Language = 'en'
Apr 12 07:10:44 localechooser: info: line=en;0;US;en_US.UTF-8;;kbd=lat0-sun16(utf8)
Apr 12 07:10:44 localechooser: info: Set debian-installer/language = 'en'
Apr 12 07:10:44 localechooser: info: Set debian-installer/locale = 'en_US.UTF-8'
Apr 12 07:10:44 localechooser: info: Set debian-installer/fallbacklocale = 'en_US.UTF-8'
Apr 12 07:10:44 localechooser: info: Set debian-installer/country = 'US'
Apr 12 07:10:44 localechooser: info: Set debian-installer/consoledisplay = 'kbd=lat0-sun16(utf8)'
Apr 12 07:10:44 debconf: Setting debconf/language to en
Apr 12 07:10:44 localechooser: info: Set debconf/language = 'en'
Apr 12 07:10:44 debconf: Setting debconf/language to en
Apr 12 07:11:11 localechooser: info: Set debian-installer/country = 'US'
Apr 12 07:11:11 localechooser: info: Set debian-installer/locale = 'en_US.UTF-8'
Apr 12 07:11:28 main-menu[598]: DEBUG: resolver (libc6): package doesn't exist (ignored)
Apr 12 07:11:35 main-menu[598]: INFO: Menu item 'kbd-chooser' selected
Apr 12 07:11:35 main-menu[598]: INFO: Falling back to the package description for console-keymaps-at
Apr 12 07:11:35 main-menu[598]: INFO: Falling back to the package description for console-keymaps-at
Apr 12 07:11:35 kbd-chooser[804]: DEBUG: Mounting usbdevfs to look for kbd
Apr 12 07:11:35 kbd-chooser[804]: DEBUG: Failed to open /proc/bus/usb/devices: 2
Apr 12 07:11:35 kbd-chooser[804]: DEBUG: Adding generic entry for AT keymaps
Apr 12 07:11:35 kbd-chooser[804]: INFO: keyboard type at: present: false 
Apr 12 07:11:35 kbd-chooser[804]: INFO: keyboard type at: present: false 
Apr 12 07:11:35 kbd-chooser[804]: INFO: keyboard type at: present: unknown  
Apr 12 07:11:35 kbd-chooser[804]: INFO: Setting debian-installer/serial-console to true
Apr 12 07:11:35 kbd-chooser[804]: INFO: Setting debian-installer/uml-console to false
Apr 12 07:11:41 kbd-chooser[804]: INFO: kbd-chooser: arch no-keyboard selected
Apr 12 07:11:41 kbd-chooser[804]: INFO: kbd-chooser: not setting keymap
Apr 12 07:11:41 main-menu[598]: DEBUG: resolver (libc6): package doesn't exist (ignored)
Apr 12 07:11:47 main-menu[598]: INFO: Menu item 'ethdetect' selected
Apr 12 07:11:48 net/hw-detect.hotplug: Detected hotpluggable network interface lo
Apr 12 07:11:55 hw-detect: Detected module 'sunlance' for '"LANCE" 10Mbit Ethernet'
Apr 12 07:11:55 kernel: sunlance.c:v2.02 8/24/03 Miguel de Icaza (miguel@nuclecu.unam.mx)
Apr 12 07:11:55 kernel: eth0: LANCE 08:00:20:8c:ca:c1
Apr 12 07:11:55 hw-detect: insmod /lib/modules/2.6.24-1-sparc64/kernel/drivers/net/sunlance.ko 
Apr 12 07:11:55 net/hw-detect.hotplug: Detected hotpluggable network interface eth0
Apr 12 07:11:55 apt-install: Queueing package udev for later installation
Apr 12 07:11:55 apt-install: Queueing package usbutils for later installation
Apr 12 07:11:57 apt-install: Queueing package libc6-sparcv9 for later installation
Apr 12 07:11:58 hw-detect: Missing modules 'esp (ESP SCSI), usb-storage (USB storage)
Apr 12 07:11:58 net/hw-detect.hotplug: Detected hotpluggable network interface eth0
Apr 12 07:11:58 net/hw-detect.hotplug: Detected hotpluggable network interface lo
Apr 12 07:11:59 main-menu[598]: DEBUG: resolver (libc6): package doesn't exist (ignored)
Apr 12 07:12:06 main-menu[598]: INFO: Menu item 'netcfg' selected
Apr 12 07:12:13 dhclient: Internet Systems Consortium DHCP Client V3.1.0
Apr 12 07:12:13 dhclient: Copyright 2004-2007 Internet Systems Consortium.
Apr 12 07:12:13 dhclient: All rights reserved.
Apr 12 07:12:13 dhclient: For info, please visit http://www.isc.org/sw/dhcp/
Apr 12 07:12:13 dhclient: 
Apr 12 07:12:14 dhclient: Listening on LPF/eth0/08:00:20:8c:ca:c1
Apr 12 07:12:14 dhclient: Sending on   LPF/eth0/08:00:20:8c:ca:c1
Apr 12 07:12:14 dhclient: Sending on   Socket/fallback
Apr 12 07:12:18 dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 3
Apr 12 07:12:18 dhclient: DHCPOFFER from 192.168.3.1
Apr 12 07:12:18 dhclient: DHCPREQUEST on eth0 to 255.255.255.255 port 67
Apr 12 07:12:18 dhclient: DHCPACK from 192.168.3.1
Apr 12 07:12:18 dhclient: bound to 192.168.3.18 -- renewal in 21461 seconds.
Apr 12 07:12:20 netcfg[2072]: INFO: DHCP hostname: "dors"
Apr 12 07:15:56 netcfg[2072]: INFO: Detected eth0 as a hotpluggable device
Apr 12 07:15:56 main-menu[598]: (process:2071): Internet Systems Consortium DHCP Client V3.1.0
Apr 12 07:15:56 main-menu[598]: (process:2071): 
Apr 12 07:15:56 main-menu[598]: (process:2071): Copyright 2004-2007 Internet Systems Consortium.
Apr 12 07:15:56 main-menu[598]: (process:2071): 
Apr 12 07:15:56 main-menu[598]: (process:2071): All rights reserved.
Apr 12 07:15:56 main-menu[598]: (process:2071): 
Apr 12 07:15:56 main-menu[598]: (process:2071): For info, please visit http://www.isc.org/sw/dhcp/
Apr 12 07:15:56 main-menu[598]: (process:2071): 
Apr 12 07:15:56 main-menu[598]: (process:2071): 
Apr 12 07:15:56 main-menu[598]: (process:2071): Listening on LPF/eth0/08:00:20:8c:ca:c1
Apr 12 07:15:56 main-menu[598]: (process:2071): Sending on   LPF/eth0/08:00:20:8c:ca:c1
Apr 12 07:15:56 main-menu[598]: (process:2071): Sending on   Socket/fallback
Apr 12 07:15:56 main-menu[598]: (process:2071): DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 3
Apr 12 07:15:56 main-menu[598]: (process:2071): DHCPOFFER from 192.168.3.1
Apr 12 07:15:56 main-menu[598]: (process:2071): DHCPREQUEST on eth0 to 255.255.255.255 port 67
Apr 12 07:15:56 main-menu[598]: (process:2071): DHCPACK from 192.168.3.1
Apr 12 07:15:56 main-menu[598]: (process:2071): bound to 192.168.3.18 -- renewal in 21461 seconds.
Apr 12 07:15:56 main-menu[598]: DEBUG: resolver (libc6): package doesn't exist (ignored)
Apr 12 07:16:03 main-menu[598]: INFO: Falling back to the package description for auto-install
Apr 12 07:16:03 main-menu[598]: INFO: Falling back to the package description for ai-choosers
Apr 12 07:16:03 main-menu[598]: INFO: Menu item 'choose-mirror' selected
Apr 12 07:16:03 anna-install: Queueing udeb apt-mirror-setup for later installation
Apr 12 07:29:15 choose-mirror[2131]: DEBUG: command: wget -q http://mirrors.kernel.org/debian//dists/lenny/Release -O - | grep ^Suite: | cut -d' ' -f 2
Apr 12 07:53:30 choose-mirror[2131]: DEBUG: command: wget -q http://mirrors.kernel.org/debian//dists/testing/Release -O - | grep ^Codename: | cut -d' ' -f 2
Apr 12 07:53:47 choose-mirror[2131]: INFO: codename set to: lenny
Apr 12 07:53:47 choose-mirror[2131]: DEBUG: command: wget -q http://mirrors.kernel.org/debian//dists/testing/main/binary-sparc/Release -O - | grep Architecture
Apr 12 07:54:10 anna-install: Queueing udeb lenny-support for later installation
Apr 12 07:54:10 main-menu[598]: DEBUG: resolver (libc6): package doesn't exist (ignored)
Apr 12 07:57:52 main-menu[598]: INFO: Falling back to the package description for auto-install
Apr 12 07:57:52 main-menu[598]: INFO: Falling back to the package description for ai-choosers
Apr 12 07:57:52 main-menu[598]: INFO: Menu item 'download-installer' selected
Apr 12 07:58:30 net-retriever: gpgv: 
Apr 12 07:58:30 net-retriever: Signature made Fri Apr 11 21:00:57 2008 UTC using DSA key ID 6070D3A1
Apr 12 07:58:30 net-retriever: gpgv: 
Apr 12 07:58:30 net-retriever: Good signature from "Debian Archive Automatic Signing Key (4.0/etch) <ftpmaster@debian.org>"
Apr 12 07:58:30 net-retriever: 
Apr 12 07:59:15 anna[2178]: DEBUG: install hw-detect, enhances installed packages hw-detect
Apr 12 07:59:15 anna[2178]: DEBUG: install apt-mirror-setup, queued by anna-install
Apr 12 07:59:15 anna[2178]: DEBUG: install apt-setup-udeb, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for ata-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: install base-installer, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install bootstrap-base, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install cdebconf-udeb, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for cdrom-checker, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for cdrom-core-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: install cdrom-core-modules-2.6.24-1-sparc64-di, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for cdrom-detect, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: install clock-setup, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for console-setup-udeb, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for crypto-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: ask for debian-edu-install-udeb, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for debian-edu-profile-udeb, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for di-utils-exit-installer, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: install di-utils-mapdevfs, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for disk-detect, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for eject-udeb, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for ext3-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: install ext3-modules-2.6.24-1-sparc64-di, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for fat-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: ask for fdisk-udeb, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for file-preseed, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: install finish-install, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for ide-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: install ide-modules-2.6.24-1-sparc64-di, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for ipv6-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: ask for iso-scan, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for jfs-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: install jfs-modules-2.6.24-1-sparc64-di, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install kickseed-common, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install libpcre3-udeb, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for live-installer, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for load-cdrom, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for load-floppy, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for load-iso, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for loop-aes-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: ask for lowmem, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for ltsp-client-builder, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for lvmcfg, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for md-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: ask for mdcfg, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: install mkreiserfs-udeb, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for multipath-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: ask for netcfg-static, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for network-console, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: install nobootloader, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for openssh-client-udeb, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: install partman-auto, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install partman-auto-raid, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install partman-base, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install partman-basicfilesystems, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install partman-ext3, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install partman-jfs, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install partman-md, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install partman-reiserfs, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install partman-target, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install partman-xfs, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for pata-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: install pata-modules-2.6.24-1-sparc64-di, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install pkgsel, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for plip-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: ask for ppp-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: ask for ppp-udeb, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for reiserfs-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: install reiserfs-modules-2.6.24-1-sparc64-di, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for rescue-mode, is menu item
Apr 12 07:59:15 anna[2178]: DEBUG: ask for sata-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: install sata-modules-2.6.24-1-sparc64-di, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for scsi-common-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: install scsi-common-modules-2.6.24-1-sparc64-di, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for scsi-core-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: install scsi-core-modules-2.6.24-1-sparc64-di, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for scsi-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: install scsi-modules-2.6.24-1-sparc64-di, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install silo-installer, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for squashfs-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: install tzsetup-udeb, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: install user-setup-udeb, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for xfs-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 07:59:15 anna[2178]: DEBUG: install xfs-modules-2.6.24-1-sparc64-di, priority >= standard
Apr 12 07:59:15 anna[2178]: DEBUG: ask for zlib-modules-2.6.24-1-sparc64-di, matches kernel
Apr 12 08:24:08 anna[2178]: wget: cannot connect to remote host (204.152.191.39): Connection timed out
Apr 12 08:24:08 anna[2178]: WARNING **: package retrieval failed
Apr 12 08:50:57 main-menu[598]: INFO: Falling back to the package description for auto-install
Apr 12 08:50:57 main-menu[598]: INFO: Falling back to the package description for ai-choosers
Apr 12 08:50:57 main-menu[598]: INFO: Menu item 'clock-setup' selected
Apr 12 08:51:22 clock-setup: Sat Apr 12 08:51:22 UTC 2008 rdate: adjust local clock by -11.601451 seconds
Apr 12 08:52:04 main-menu[598]: INFO: Falling back to the package description for auto-install
Apr 12 08:52:04 main-menu[598]: INFO: Falling back to the package description for ai-choosers
Apr 12 08:52:04 main-menu[598]: INFO: Menu item 'di-utils-shell' selected
Apr 12 08:58:41 kernel: SCSI subsystem initialized
Apr 12 09:00:58 main-menu[598]: INFO: Falling back to the package description for auto-install
Apr 12 09:00:58 main-menu[598]: INFO: Falling back to the package description for ai-choosers
Apr 12 09:00:58 main-menu[598]: INFO: Menu item 'save-logs' selected
Apr 12 09:11:26 main-menu[598]: INFO: Falling back to the package description for auto-install
Apr 12 09:11:26 main-menu[598]: INFO: Falling back to the package description for ai-choosers
Apr 12 09:11:26 main-menu[598]: INFO: Menu item 'di-utils-shell' selected
Apr 12 09:12:04 kernel: Driver 'sd' needs updating - please use bus_type methods
Apr 12 09:29:17 main-menu[598]: INFO: Falling back to the package description for auto-install
Apr 12 09:29:17 main-menu[598]: INFO: Falling back to the package description for ai-choosers
Apr 12 09:29:17 main-menu[598]: INFO: Menu item 'save-logs' selected

--VV4b6MQE+OnNyhkM--

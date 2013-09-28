From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Sat, 28 Sep 2013 04:07:11 +0000
Subject: Re: [PATCH 0/3] Fully support 47-bit physical addresses.
Message-Id: <524655EF.20104@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20130926.165242.1048533011152185981.davem@redhat.com>
In-Reply-To: <20130926.165242.1048533011152185981.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On 09/26/2013 01:52 PM, David Miller wrote:
> Ok, this patch set builds on top of the variable PAGE_OFFSET
> patches.
>
> First we move to 8MB huge pages.  The chips don't really have
> 8MB page support, but we fabricate such a thing using 4MB
> PTEs.
>
> Next we move to 64-bit pmd_t and pgd_t entries, which is the
> most trivial of the changes here.
>
> Finally, we encode huge PMDs using the plain PTE encoding of
> huge pages.   All of the ugly huge PMD --> PTE translation
> code disappears, and the TLB miss path is smaller and faster.
>
> I just got this stuff fully working so caveat emptor :-)
>
> Signed-off-by: David S. Miller<davem@davemloft.net>
Hi,

This is on a t4-1, machine becomes unusable with hundreds of
"WARNING: CPU: 0 PID: 441 at mm/mmap.c:2729 exit_mmap+0x14c/0x160()"

Thanks,
-Guru

Allocated 64 Megs of memory at 0x40000000 for kernel
Loaded kernel version 3.12.0
Loading initial ramdisk (31621536 bytes at 0x24800000 phys, 0x40C00000=20
virt)...
|
PROMLIB: Sun IEEE Boot Prom 'OBP 4.34.1 2012/08/01 12:19'
PROMLIB: Root node compatible: sun4v
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 3.12.0-16.mainline.sparc64 (root@xxx) (gcc version 4.4.7=20
20120313 (Red Hat 4.4.7-3) (GCC) ) #1 SMP Fri Sep 27 22:08:03 EDT 2013
bootconsole [earlyprom0] enabled
ARCH: SUN4V
Ethernet address: 00:21:28:e8:e9:da
PAGE_OFFSET is 0xffff800000000000 (max_phys_bits =3D 47)
Kernel: Using 5 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /virtual-devices@100/console@1
PROM: Built device tree with 166802 bytes of memory.
MDESC: Size is 60208 bytes.
PLATFORM: banner-name [SPARC T4-1]
PLATFORM: name [ORCL,SPARC-T4-1]
PLATFORM: hostid [85e8e9da]
PLATFORM: serial# [00e8e9da]
PLATFORM: stick-frequency [3b8f5850]
PLATFORM: mac-address [2128e8e9da]
PLATFORM: watchdog-resolution [1000 ms]
PLATFORM: watchdog-max-timeout [31536000000 ms]
PLATFORM: max-cpus [64]
Top of RAM: 0x7ffaf2000, Total RAM: 0x7df664000
Memory hole size: 516MB
Zone ranges:
   Normal   [mem 0x20400000-0x7ffaf1fff]
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x20400000-0x7ffa43fff]
   node   0: [mem 0x7ffa54000-0x7ffa67fff]
   node   0: [mem 0x7ffae6000-0x7ffaf1fff]
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3]
CPU CAPS: [hpc,ima,pause,cbcond,aes,des,kasumi,camellia]
CPU CAPS: [md5,sha1,sha256,sha512,mpmul,montmul,montsqr,crc32c]
PERCPU: Embedded 7 pages/cpu @ffff8007ef000000 s23296 r8192 d25856 u65536
SUN4V: Mondo queue sizes [cpu(8192) dev(16384) r(8192) nr(256)]
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 4095291
Policy zone: Normal
Kernel command line: root=3D/dev/mapper/VolGroup-lv_root ro rd_NO_LUKS=20
LANG=3Den_US.UTF-8 rd_NO_MD rd_LVM_LV=3DVolGroup/lv_swap=20
SYSFONT=3Dlatarcyrheb-sun16 rd_LVM_LV=3DVolGroup/lv_root KEYBOARDTYPE=3Dpc =

KEYTABLE=3Dus rd_NO_DM
PID hash table entries: 4096 (order: 2, 32768 bytes)
Sorting __ex_table...
Memory: 32704360K/33020304K available (5333K kernel code, 708K rwdata,=20
2216K rodata, 488K init, 7896K bss, 315944K reserved)
Hierarchical RCU implementation.
NR_IRQS:255
clocksource: mult[801898] shift[23]
clockevent: mult[ffced917] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
PROMLIB: Sun IEEE Boot Prom 'OBP 4.34.1 2012/08/01 12:19'
PROMLIB: Root node compatible: sun4v
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 3.12.0-16.mainline.sparc64 (root@xxx) (gcc version 4.4.7=20
20120313 (Red Hat 4.4.7-3) (GCC) ) #1 SMP Fri Sep 27 22:08:03 EDT 2013
bootconsole [earlyprom0] enabled
ARCH: SUN4V
Ethernet address: 00:21:28:e8:e9:da
PAGE_OFFSET is 0xffff800000000000 (max_phys_bits =3D 47)
Kernel: Using 5 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /virtual-devices@100/console@1
PROM: Built device tree with 166802 bytes of memory.
MDESC: Size is 60208 bytes.
PLATFORM: banner-name [SPARC T4-1]
PLATFORM: name [ORCL,SPARC-T4-1]
PLATFORM: hostid [85e8e9da]
PLATFORM: serial# [00e8e9da]
PLATFORM: stick-frequency [3b8f5850]
PLATFORM: mac-address [2128e8e9da]
PLATFORM: watchdog-resolution [1000 ms]
PLATFORM: watchdog-max-timeout [31536000000 ms]
PLATFORM: max-cpus [64]
Top of RAM: 0x7ffaf2000, Total RAM: 0x7df664000
Memory hole size: 516MB
Zone ranges:
   Normal   [mem 0x20400000-0x7ffaf1fff]
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x20400000-0x7ffa43fff]
   node   0: [mem 0x7ffa54000-0x7ffa67fff]
   node   0: [mem 0x7ffae6000-0x7ffaf1fff]
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,vis3]
CPU CAPS: [hpc,ima,pause,cbcond,aes,des,kasumi,camellia]
CPU CAPS: [md5,sha1,sha256,sha512,mpmul,montmul,montsqr,crc32c]
PERCPU: Embedded 7 pages/cpu @ffff8007ef000000 s23296 r8192 d25856 u65536
SUN4V: Mondo queue sizes [cpu(8192) dev(16384) r(8192) nr(256)]
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 4095291
Policy zone: Normal
Kernel command line: root=3D/dev/mapper/VolGroup-lv_root ro rd_NO_LUKS=20
LANG=3Den_US.UTF-8 rd_NO_MD rd_LVM_LV=3DVolGroup/lv_swap=20
SYSFONT=3Dlatarcyrheb-sun16 rd_LVM_LV=3DVolGroup/lv_root KEYBOARDTYPE=3Dpc =

KEYTABLE=3Dus rd_NO_DM
PID hash table entries: 4096 (order: 2, 32768 bytes)
Sorting __ex_table...
Memory: 32704360K/33020304K available (5333K kernel code, 708K rwdata,=20
2216K rodata, 488K init, 7896K bss, 315944K reserved)
Hierarchical RCU implementation.
NR_IRQS:255
clocksource: mult[801898] shift[23]
clockevent: mult[ffced917] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
allocated 67108864 bytes of page_cgroup
please try 'cgroup_disable=3Dmemory' option if you don't want memory cgroups
Calibrating delay using timer specific routine.. 2000.25 BogoMIPS=20
(lpj@00514)
pid_max: default: 65536 minimum: 512
Security Framework initialized
SELinux:  Initializing.
Dentry cache hash table entries: 4194304 (order: 12, 33554432 bytes)
Inode-cache hash table entries: 2097152 (order: 11, 16777216 bytes)
Mount-cache hash table entries: 512
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
Initializing cgroup subsys blkio
Initializing cgroup subsys perf_event
Initializing cgroup subsys hugetlb
ftrace: allocating 19188 entries in 38 pages
Performance events: Supported PMU type is 'niagara4'
Brought up 64 CPUs
Testing NMI watchdog ... OK.
devtmpfs: initialized
ldc.c:v1.1 (July 22, 2008)
regulator-dummy: no parameters
NET: Registered protocol family 16
VIO: Adding device channel-devices
VIO: Adding device vldc-port-0-0
VIO: Adding device vldc-port-0-1
VIO: Adding device vldc-port-0-2
VIO: Adding device vldc-port-1-0
VIO: Adding device vldc-port-2-0
VIO: Adding device vldc-port-3-0
VIO: Adding device vldc-port-3-1
VIO: Adding device vldc-port-3-2
VIO: Adding device vldc-port-3-3
VIO: Adding device vldc-port-3-4
VIO: Adding device vldc-port-3-6
VIO: Adding device vlds-port-0-0
VIO: Adding device ds-0
VIO: Adding device ds-1
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
Missing cpus node, bailing out
pci_sun4v: Registered hvapi major[1] minor[0]
/pci@400: SUN4V PCI Bus Module
/pci@400: On NUMA node -1
/pci@400: PCI IO[85100000000] MEM[84000000000]
/pci@400: Unable to request IOMMU resource.
/pci@400: Imported 3 TSB entries from OBP
/pci@400: MSI Queue first[0] num[56] count[512] devino[0x6]
/pci@400: MSI first[0] num[512] mask[0x3ff] width[32]
/pci@400: MSI addr32[0x7f800000:0x800000]=20
addr64[0xe00000003f800000:0x800000]
/pci@400: MSI queues at RA [00000007e6600000]
PCI: Scanning PBM /pci@400
pci_sun4v f028c7bc: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io 0x85100000000-0x8510fffffff] (bus=20
address [0x0000-0xfffffff])
pci_bus 0000:00: root bus resource [mem 0x84000000000-0x8407f7fffff]=20
(bus address [0x00000000-0x7f7fffff])
pci_bus 0000:00: root bus resource [bus 00-12]
bio: create slab <bio-0> at 0
vgaarb: device added: PCI:0000:0a:00.0,decodes=3Dio+mem,owns=3Dnone,locks=
=3Dnone
vgaarb: loaded
vgaarb: bridge control possible 0000:0a:00.0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NetLabel: Initializing
NetLabel:  domain hash size =3D 128
NetLabel:  protocols =3D UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
SUN4V: Reboot data supported (maj=3D1,min=3D0).
ds.c:v1.0 (Jul 11, 2007)
Switched to clocksource stick
NET: Registered protocol family 2
TCP established hash table entries: 262144 (order: 9, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP: reno registered
UDP hash table entries: 16384 (order: 6, 524288 bytes)
UDP-Lite hash table entries: 16384 (order: 6, 524288 bytes)
NET: Registered protocol family 1
ds-1: Registered pri service.
ds-1: Registered var-config-backup service.
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 30880K (ffff800024800000 - ffff800026628000)
Initialise module verification
audit: initializing netlink socket (disabled)
type 00 audit(2.219:1): initialized
HugeTLB registered 8 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
msgmni has been set to 32768
alg: No test for stdrng (krng)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered (default)
io scheduler cfq registered
f0286a24: ttyS0 at I/O 0x0 (irq =3D 1, base_baud =3D 115200) is a SUN4V HCO=
NS
console [ttyHV0] enabled
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
n2rng.c:v0.2 (July 27, 2011)
n2rng f02866c8: Registered RNG HVAPI major 2 minor 0
n2rng f02866c8: Found multi-unit-capable RNG, units: 1
n2rng f02866c8: Selftest passed on unit 0
n2rng f02866c8: RNG ready
brd: module loaded
loop: module loaded
libphy: Fixed MDIO Bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-pci 0000:12:00.2: EHCI Host Controller
ehci-pci 0000:12:00.2: new USB bus registered, assigned bus number 1
ehci-pci 0000:12:00.2: irq 7, io mem 0x84001604000
ehci-pci 0000:12:00.2: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1D6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 3.12.0-16.mainline.sparc64 ehci_hcd
usb usb1: SerialNumber: 0000:12:00.2
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-pci 0000:12:00.0: OHCI PCI host controller
ohci-pci 0000:12:00.0: new USB bus registered, assigned bus number 2
ohci-pci 0000:12:00.0: irq 4, io mem 0x84001600000
usb usb2: New USB device found, idVendor=1D6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb2: Product: OHCI PCI host controller
usb usb2: Manufacturer: Linux 3.12.0-16.mainline.sparc64 ohci_hcd
usb usb2: SerialNumber: 0000:12:00.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci-pci 0000:12:00.1: OHCI PCI host controller
ohci-pci 0000:12:00.1: new USB bus registered, assigned bus number 3
ohci-pci 0000:12:00.1: irq 5, io mem 0x84001602000
usb usb3: New USB device found, idVendor=1D6b, idProduct=0001
usb usb3: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb3: Product: OHCI PCI host controller
usb usb3: Manufacturer: Linux 3.12.0-16.mainline.sparc64 ohci_hcd
usb usb3: SerialNumber: 0000:12:00.1
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
uhci_hcd: USB Universal Host Controller Interface driver
mousedev: PS/2 mouse device common for all mice
rtc-sun4v rtc-sun4v: rtc core: registered sun4v as rtc0
hidraw: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
zram: Created 1 device(s) ...
drop_monitor: Initializing network drop monitor service
TCP: cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 17
Key type dns_resolver registered
Loading module verification certificates
X.509: Cert 078c059778dca5d31f31c361ea7f72f469478688 is not yet valid
MODSIGN: Problem loading in-kernel X.509 certificate (-131)
registered taskstats version 1
usb 1-2: new high-speed USB device number 2 using ehci-pci
IMA: No TPM chip found, activating TPM-bypass!
rtc-sun4v rtc-sun4v: setting system clock to 2013-09-28 02:44:47 UTC=20
(1380336287)
------------[ cut here ]------------
WARNING: CPU: 25 PID: 377 at mm/mmap.c:2729 exit_mmap+0x14c/0x160()
Modules linked in:
CPU: 25 PID: 377 Comm: init Not tainted 3.12.0-16.mainline.sparc64 #1
Call Trace:
  [0000000000466b5c] warn_slowpath_common+0x5c/0x80
  [0000000000466b9c] warn_slowpath_null+0x1c/0x40
  [000000000055a18c] exit_mmap+0x14c/0x160
  [0000000000465014] mmput+0x54/0xe0
  [0000000000594ea0] exec_mmap+0x180/0x220
  [0000000000594ffc] flush_old_exec+0xbc/0x140
  [00000000005e46cc] load_elf_binary+0x24c/0xac0
usb 1-2: New USB device found, idVendor=04b4, idProducte60
usb 1-2: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
  [0000000000594468] search_binary_handler+0xe8/0x2c0
  [0000000000594670] exec_binprm+0x30/0x140
  [0000000000595f8c] do_execve_common+0x36c/0x440
  [000000000059610c] do_execve+0x2c/0x40
  [000000000059614c] SyS_execve+0x2c/0x60
  [00000000004061d4] linux_sparc_syscall+0x34/0x44
---[ end trace 178c5f2c2644bf92 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 377 at mm/mmap.c:2729 exit_mmap+0x14c/0x160()
Modules linked in:usb 1-4: new high-speed USB device number 3 using ehci-pci

CPU: 0 PID: 377 Comm: mknod Tainted: G        W=20
3.12.0-16.mainline.sparc64 #1
Call Trace:
  [0000000000466b5c] warn_slowpath_common+0x5c/0x80
  [0000000000466b9c] warn_slowpath_null+0x1c/0x40
  [000000000055a18c] exit_mmap+0x14c/0x160
  [0000000000465014] mmput+0x54/0xe0
  [000000000046841c] exit_mm+0x13c/0x1a0
  [0000000000469ab0] do_exit+0x130/0x440
  [0000000000469df0] do_group_exit+0x30/0xc0
  [0000000000469e9c] SyS_exit_group+0x1c/0x40
  [00000000004061d4] linux_sparc_syscall+0x34/0x44
---[ end trace 178c5f2c2644bf93 ]---
------------[ cut here ]------------
WARNING: CPU: 33 PID: 384 at mm/mmap.c:2729 exit_mmap+0x14c/0x160()
Modules linked in:
CPU: 33 PID: 384 Comm: init Tainted: G        W 3.12.0-16.mainline.sparc64
usb 1-4: New USB device found, idVendor=04b4, idProducte60
usb 1-4: New USB device strings: Mfr=3D0, Product=3D0, SerialNumber=3D0
hub 1-4:1.0: USB hub found
hub 1-4:1.0: 4 ports detected
Call Trace:
  [0000000000466b5c] warn_slowpath_common+0x5c/0x80
  [0000000000466b9c] warn_slowpath_null+0x1c/0x40
  [000000000055a18c] exit_mmap+0x14c/0x160
  [0000000000465014] mmput+0x54/0xe0
usb 1-2.3: new high-spe USB device number 4 using ehci-pci
  [0000000000594ea0] exec_mmap+0x180/0x220
  [0000000000594ffc] flush_old_exec+0xbc/0x140
  [00000000005e46cc] load_elf_binary+0x24c/0xac0
  [0000000000594468] search_binary_handler+0xe8/0x2c0
  [0000000000594670] exec_binprm+0x30/0x140
  [0000000000595f8c] do_execve_common+0x36c/0x440
  [000000000059610c] do_execve+0x2c/0x40
  [000000000059614c] SyS_execve+0x2c/0x60
  [00000000004061d4] linux_sparc_syscall+0x34/0x44
---[ end trace 178c5f2c2644bf94 ]---
usb 1-2.3: config 1 interface 0 altsetting 0 endpoint 0x81 has an=20
invalid bInterval 255, changing to 11
usb 1-2.3: New USB device found, idVendor=046b, idProduct=FF01
usb 1-2.3: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D0
usb 1-2.3: Product: Generic Hub
usb 1-2.3: Manufacturer: American Megatrends Inc.
hub 1-2.3:1.0: USB hub found
hub 1-2.3:1.0: 3 ports detected
------------[ cut here ]------------
usb 1-2.4: new low-speed USB device number 5 using ehci-pci
WARNING: CPU: 33 PID: 386 at mm/mmap.c:2729 exit_mmap+0x14c/0x160()
Modules linked in:
CPU: 33 PID: 386 Comm: init Tainted: G        W=20
3.12.0-16.mainline.sparc64 #1
Call Trace:
  [0000000000466b5c] warn_slowpath_common+0x5c/0x80
  [0000000000466b9c] warn_slowpath_null+0x1c/0x40
  [000000000055a18c] exit_mmap+0x14c/0x160
  [0000000000465014] mmput+0x54/0xe0
  [0000000000594ea0] exec_mmap+0x180/0x220
  [0000000000594ffc] flush_old_exec+0xbc/0x140
  [00000000005e46cc] load_elf_binary+0x24c/0xac0


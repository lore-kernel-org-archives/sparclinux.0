From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Fri, 11 Oct 2013 21:26:52 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <52586D1C.4000205@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/30/2013 09:31 AM, David Miller wrote:
> This is a respin of the original page_offset and 64-bit page
> table changes with some minor changes and a bug fix:
>
> 1) Bob's ACKs for the first 6 patches added.
>
> 2) Don't use "UL" postfix for shift counts, there is code that
>     wants those to be "int", particularly printfs in mm/mm_init.c
>     that use the "%d" format specifier for SECTIONS_SHIFT.
>
> 3) Adjust VA_HOLE defines to match what the new 3-level page
>     tables can actually provide.
>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

This is on a  SPARC M10-1

PROMLIB: Sun IEEE Boot Prom 'OBP 4.34.0 2013/06/04 19:09'
PROMLIB: Root node compatible: sun4v
Initializing cgroup subsys cpuset
Initializing cgroup subsys cpu
Initializing cgroup subsys cpuacct
Linux version 3.12.0-16mainline.sparc64 (root@xxx) (gcc version 4.4.7 20120313 (Red Hat 4.4.7-3) (GCC) ) #1 SMP Wed Oct 2 15:50:47 EDT 2013
bootconsole [earlyprom0] enabled
ARCH: SUN4V
Ethernet address: b0:99:28:9a:98:43
PAGE_OFFSET is 0xffff800000000000 (max_phys_bits = 47)
Kernel: Using 5 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /virtual-devices@100/console@1
PROM: Built device tree with 115806 bytes of memory.
MDESC: Size is 44112 bytes.
PLATFORM: banner-name [SPARC M10-1]
PLATFORM: name [ORCL,SPARC64-X]
PLATFORM: hostid [90060144]
PLATFORM: serial# [00000000]
PLATFORM: stick-frequency [05f5e100]
PLATFORM: mac-address [b099289a9843]
PLATFORM: watchdog-resolution [1000 ms]
PLATFORM: watchdog-max-timeout [31536000000 ms]
PLATFORM: max-cpus [32]
Top of RAM: 0x7e0ffffdc000, Total RAM: 0xf8f83e000
Memory hole size: 132122375MB
  [fc00800000-fc1fffffff] on node 0
Zone ranges:
   Normal   [mem 0x7e0070400000-0x7e0ffffdbfff]
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x7e0070400000-0x7e007fc9dfff]
   node   0: [mem 0x7e007fd40000-0x7e007fd5bfff]
   node   0: [mem 0x7e0080000000-0x7e0ffff61fff]
   node   0: [mem 0x7e0ffff72000-0x7e0ffff87fff]
   node   0: [mem 0x7e0ffffd0000-0x7e0ffffdbfff]
On node 0 totalpages: 8158239
   Normal zone: 63740 pages used for memmap
   Normal zone: 0 pages reserved
   Normal zone: 8158239 pages, LIFO batch:15
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,ima]
PERCPU: Embedded 7 pages/cpu @fffffe0fe0000000 s23296 r8192 d25856 u131072
pcpu-alloc: s23296 r8192 d25856 u131072 alloc=1*4194304
pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
SUN4V: Mondo queue sizes [cpu(4096) dev(16384) r(8192) nr(256)]
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 8094499
Policy zone: Normal
Kernel command line: root=/dev/mapper/vg_m101370l0-lv_root ro rd_LVM_LV=vg_m101370l0/vol_swap rd_NO_LUKS rd_NO_MD KEYTABLE=us rd_LVM_LV=vg_m101370l0/lv_root LANG=ja_JP.UTF-8 rd_NO_DM
PID hash table entries: 4096 (order: 2, 32768 bytes)
Sorting __ex_table...
Memory: 64703096K/65265912K available (5333K kernel code, 708K rwdata, 2216K rodata, 488K init, 7896K bss, 562816K reserved)
Hierarchical RCU implementation.
	RCU restricting CPUs from NR_CPUSd to nr_cpu_ids2.
NR_IRQS:255
clocksource: mult[a000000] shift[24]
clockevent: mult[1999999a] shift[32]
Console: colour dummy device 80x25
console [tty0] enabled, bootconsole disabled
allocated 132120576 bytes of page_cgroup
please try 'cgroup_disable=memory' option if you don't want memory cgroups
Calibrating delay using timer specific routine.. 200.06 BogoMIPS (lpj@0128)
pid_max: default: 32768 minimum: 301
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Dentry cache hash table entries: 8388608 (order: 13, 67108864 bytes)
Inode-cache hash table entries: 4194304 (order: 12, 33554432 bytes)
Mount-cache hash table entries: 512
Initializing cgroup subsys memory
Initializing cgroup subsys devices
Initializing cgroup subsys freezer
Initializing cgroup subsys net_cls
Initializing cgroup subsys blkio
Initializing cgroup subsys perf_event
Initializing cgroup subsys hugetlb
ftrace: allocating 19188 entries in 38 pages
Performance events: No support for PMU type 'sparc64-x'
Brought up 32 CPUs
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
pci_sun4v: Registered hvapi major[1] minor[0]
/pci@8000: SUN4V PCI Bus Module
/pci@8000: On NUMA node -1
/pci@8000: PCI IO[801100000000] MEM[800000000000]
/pci@8000: Unable to request IOMMU resource.
/pci@8000: Imported 2 TSB entries from OBP
/pci@8000: MSI Queue first[0] num[56] count[1024] devino[0x6]
/pci@8000: MSI first[0] num[1024] mask[0x3ff] width[32]
/pci@8000: MSI addr32[0x7f800000:0x800000] addr64[0xe00000003f800000:0x800000]
/pci@8000: MSI queues at RA [00007e0fd0800000]
PCI: Scanning PBM /pci@8000
pci_sun4v f0294a18: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x801100000000-0x80110fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007fffffff] (bus address [0x00000000-0x7fffffff])
pci_bus 0000:00: root bus resource [bus 00-08]
pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
pci_bus 0000:01: busn_res: can not insert [bus 01-ff] under [bus 00-08] (conflicts with (null) [bus 00-08])
pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
pci 0000:03:00.0: supports D1 D2
pci 0000:02:01.0: PME# supported from D0 D3hot D3cold
pci 0000:04:00.0: PME# supported from D0 D3hot
pci 0000:04:00.0: reg 0x184: [mem 0x110000000-0x110003fff 64bit pref]
pci 0000:04:00.0: reg 0x190: [mem 0x110020000-0x110023fff 64bit pref]
pci 0000:04:00.1: PME# supported from D0 D3hot
pci 0000:04:00.1: reg 0x184: [mem 0x110040000-0x110043fff 64bit pref]
pci 0000:04:00.1: reg 0x190: [mem 0x110060000-0x110063fff 64bit pref]
pci 0000:02:02.0: PME# supported from D0 D3hot D3cold
pci 0000:06:00.0: supports D1
pci 0000:06:00.0: PME# supported from D0 D1 D3hot
pci 0000:07:04.0: supports D1 D2
pci 0000:07:04.0: PME# supported from D0 D1 D2 D3hot
pci 0000:07:04.1: supports D1 D2
pci 0000:07:04.1: PME# supported from D0 D1 D2 D3hot
pci 0000:02:08.0: PME# supported from D0 D3hot D3cold
pci 0000:02:08.0: PCI bridge to [bus 08]
/pci@8100: SUN4V PCI Bus Module
/pci@8100: On NUMA node -1
/pci@8100: PCI IO[803100000000] MEM[802000000000]
/pci@8100: Unable to request IOMMU resource.
/pci@8100: MSI Queue first[0] num[56] count[1024] devino[0x6]
/pci@8100: MSI first[0] num[1024] mask[0x3ff] width[32]
/pci@8100: MSI addr32[0x7f800000:0x800000] addr64[0xe00000003f800000:0x800000]
/pci@8100: MSI queues at RA [00007e0fd0c00000]
PCI: Scanning PBM /pci@8100
pci_sun4v f02a0958: PCI host bridge to bus 0001:00
pci_bus 0001:00: root bus resource [io  0x803100000000-0x80310fffffff] (bus address [0x0000-0xfffffff])
pci_bus 0001:00: root bus resource [mem 0x802000000000-0x80207fffffff] (bus address [0x00000000-0x7fffffff])
pci_bus 0001:00: root bus resource [bus 00-06]
pci 0001:00:04.0: PME# supported from D0 D3hot D3cold
pci_bus 0001:01: busn_res: can not insert [bus 01-ff] under [bus 00-06] (conflicts with (null) [bus 00-06])
pci 0001:01:00.0: PME# supported from D0 D3hot D3cold
pci 0001:02:00.0: PME# supported from D0 D3hot D3cold
pci 0001:03:00.0: PME# supported from D0 D3hot
pci 0001:03:00.0: reg 0x184: [mem 0x100000000-0x100003fff 64bit pref]
pci 0001:03:00.0: reg 0x190: [mem 0x100020000-0x100023fff 64bit pref]
pci 0001:03:00.1: PME# supported from D0 D3hot
pci 0001:03:00.1: reg 0x184: [mem 0x100040000-0x100043fff 64bit pref]
pci 0001:03:00.1: reg 0x190: [mem 0x100060000-0x100063fff 64bit pref]
pci 0001:02:01.0: PME# supported from D0 D3hot D3cold
pci 0001:02:09.0: PME# supported from D0 D3hot D3cold
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
SUN4V: Reboot data supported (maj=1,min=0).
ds.c:v1.0 (Jul 11, 2007)
Switched to clocksource stick
NET: Registered protocol family 2
TCP established hash table entries: 524288 (order: 10, 8388608 bytes)
TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP: reno registered
UDP hash table entries: 32768 (order: 7, 1048576 bytes)
UDP-Lite hash table entries: 32768 (order: 7, 1048576 bytes)
NET: Registered protocol family 1
PCI: CLS mismatch (64 != 512), using 64 bytes
PCI: Enabling device: (0000:00:04.0), cmd 407
PCI: Enabling device: (0000:07:04.1), cmd 2
Trying to unpack rootfs image as initramfs...
Freeing initrd memory: 26744K (fffffe0084000000 - fffffe0085a1e000)
Initialise module verification
audit: initializing netlink socket (disabled)
type 00 audit(1380862254.904:1): initialized
ds-1: Registered pri service.
HugeTLB registered 8 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
msgmni has been set to 32768
SELinux:  Registering netfilter hooks
alg: No test for stdrng (krng)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler deadline registered (default)
io scheduler cfq registered
f0291a78: ttyS0 at I/O 0x0 (irq = 1, base_baud = 115200) is a SUN4V HCONS
ds-1: Registered var-config-backup service.
console [ttyHV0] enabled
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
brd: module loaded
loop: module loaded
libphy: Fixed MDIO Bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-pci: EHCI PCI platform driver
ehci-pci 0000:07:04.1: EHCI Host Controller
ehci-pci 0000:07:04.1: new USB bus registered, assigned bus number 1
ehci-pci 0000:07:04.1: irq 6, io mem 0x800000402000
ehci-pci 0000:07:04.1: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor6b, idProduct 02
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 3.12.0-16mainline3.el6uek.sparc64 ehci_hcd
usb usb1: SerialNumber: 0000:07:04.1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ohci-pci: OHCI PCI platform driver
ohci-pci 0000:07:04.0: OHCI PCI host controller
ohci-pci 0000:07:04.0: new USB bus registered, assigned bus number 2
ohci-pci 0000:07:04.0: irq 6, io mem 0x800000400000
usb usb2: New USB device found, idVendor6b, idProduct 01
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OHCI PCI host controller
usb usb2: Manufacturer: Linux 3.12.0-16mainline3.el6uek.sparc64 ohci_hcd
usb usb2: SerialNumber: 0000:07:04.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
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
registered taskstats version 1
IMA: No TPM chip found, activating TPM-bypass!
rtc-sun4v rtc-sun4v: setting system clock to 2013-10-04 04:50:57 UTC (1380862257)
dracut: dracut-004-303.0.9.el6
dracut: rd_NO_LUKS: removing cryptoluks activation
Loading iSCSI transport class v2.0-870.
iscsi: registered transport (qla4xxx)
QLogic iSCSI HBA Driver
libcxgbi:libcxgbi_init_module: tag itt 0x1fff, 13 bits, age 0xf, 4 bits.
libcxgbi:ddp_setup_host_page_size: system PAGE 8192, ddp idx 1.
Chelsio T3 iSCSI Driver cxgb3i v2.0.0 (Jun. 2010)
iscsi: registered transport (cxgb3i)
Chelsio T4/T5 iSCSI Driver cxgb4i v0.9.4
iscsi: registered transport (cxgb4i)
NET: Registered protocol family 10
cnic: Broadcom NetXtreme II CNIC Driver cnic v2.5.18 (Sept 01, 2013)
Broadcom NetXtreme II iSCSI Driver bnx2i v2.7.6.2 (Jun 06, 2013)
iscsi: registered transport (bnx2i)
usb 1-2: new high-speed USB device number 2 using ehci-pci
iscsi: registered transport (be2iscsi)
In beiscsi_module_init, tt 000000101fe960
device-mapper: uevent: version 1.0.3
device-mapper: ioctl: 4.26.0-ioctl (2013-08-15) initialised:dm-devel@redhat.com
udev: starting version 147
dracut: Starting plymouth daemon
usb 1-2: New USB device found, idVendor11, idProduct 94
usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-2: Product: BUFFALO INC. USB2.0-IDE Bridge
usb 1-2: Manufacturer: BUFFALO INC.
usb 1-2: SerialNumber: 000000001C042125
usb-storage 1-2:1.0: USB Mass Storage device detected
scsi0 : usb-storage 1-2:1.0
usbcore: registered new interface driver usb-storage
dracut: rd_NO_DM: removing DM RAID activation
dracut: rd_NO_MD: removing MD RAID activation
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
scsi 0:0:0:0: CD-ROM            PIONEER  DVD-RW  DVR-112D 8.05 PQ: 0 ANSI: 0
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
camellia_sparc64: sparc64 camellia opcodes not available.
crc32c_sparc64: sparc64 crc32c opcode not available.
sha256_sparc64: sparc64 sha256 opcode not available.
aes_sparc64: sparc64 aes opcodes not available.
sha512_sparc64: sparc64 sha512 opcode not available.
des_sparc64: sparc64 des opcodes not available.
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti<giometti@linux.it>
PTP clock support registered
igb: Intel(R) Gigabit Ethernet Network Driver - version 5.0.5-k
igb: Copyright (c) 2007-2013 Intel Corporation.
PCI: Enabling device: (0000:04:00.0), cmd 146
igb 0000:04:00.0: added PHC on eth0
igb 0000:04:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:04:00.0: eth0: (PCIe:2.5Gb/s:Width x2) b0:99:28:98:58:6c
igb 0000:04:00.0: eth0: PBA No: Unknown
igb 0000:04:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
PCI: Enabling device: (0000:04:00.1), cmd 146
igb 0000:04:00.1: added PHC on eth1
igb 0000:04:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0000:04:00.1: eth1: (PCIe:2.5Gb/s:Width x2) b0:99:28:98:58:6d
igb 0000:04:00.1: eth1: PBA No: Unknown
igb 0000:04:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
PCI: Enabling device: (0001:00:04.0), cmd 407
PCI: Enabling device: (0001:03:00.0), cmd 146
igb 0001:03:00.0: added PHC on eth2
igb 0001:03:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0001:03:00.0: eth2: (PCIe:2.5Gb/s:Width x2) b0:99:28:98:58:6e
igb 0001:03:00.0: eth2: PBA No: Unknown
igb 0001:03:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
PCI: Enabling device: (0001:03:00.1), cmd 146
igb 0001:03:00.1: added PHC on eth3
igb 0001:03:00.1: Intel(R) Gigabit Ethernet Network Connection
igb 0001:03:00.1: eth3: (PCIe:2.5Gb/s:Width x2) b0:99:28:98:58:6f
igb 0001:03:00.1: eth3: PBA No: Unknown
igb 0001:03:00.1: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
mpt2sas version 16.100.00.00 loaded
scsi1 : Fusion MPT SAS Host
mpt2sas0: 32 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (64730328 kB)
mpt2sas0-msix0: PCI-MSI-X enabled: IRQ 179
mpt2sas0-msix1: PCI-MSI-X enabled: IRQ 180
mpt2sas0-msix2: PCI-MSI-X enabled: IRQ 181
mpt2sas0-msix3: PCI-MSI-X enabled: IRQ 182
mpt2sas0-msix4: PCI-MSI-X enabled: IRQ 183
mpt2sas0-msix5: PCI-MSI-X enabled: IRQ 184
mpt2sas0-msix6: PCI-MSI-X enabled: IRQ 185
mpt2sas0-msix7: PCI-MSI-X enabled: IRQ 186
mpt2sas0-msix8: PCI-MSI-X enabled: IRQ 187
mpt2sas0-msix9: PCI-MSI-X enabled: IRQ 188
mpt2sas0-msix10: PCI-MSI-X enabled: IRQ 189
mpt2sas0-msix11: PCI-MSI-X enabled: IRQ 190
mpt2sas0-msix12: PCI-MSI-X enabled: IRQ 191
mpt2sas0-msix13: PCI-MSI-X enabled: IRQ 192
mpt2sas0-msix14: PCI-MSI-X enabled: IRQ 193
mpt2sas0-msix15: PCI-MSI-X enabled: IRQ 194
mpt2sas0: iomem(0x0000800100000000), mapped(0x0000800100000000), size(65536)
mpt2sas0: ioport(0x0000801100000000), size(256)
mpt2sas0: Allocated physical memory: size(4992 kB)
mpt2sas0: Current Controller Queue Depth(2811), Max Controller Queue Depth(3072)
mpt2sas0: Scatter Gather Elements per IO(128)
mpt2sas0: LSISAS2308: FWVersion(13.00.66.00), ChipRevision(0x05), BiosVersion(00.00.00.00)
mpt2sas0: Protocol=(Initiator), Capabilities=(Raid,TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set Full,NCQ)
mpt2sas0: sending port enable !!
mpt2sas0: host_add: handle(0x0001), sas_addr(0x500000e0e0450000), phys(8)
mpt2sas0: expander_add: handle(0x0009), parent(0x0001), sas_addr(0x500000e0e049113f), phys(22)
mpt2sas0: port enable: SUCCESS
scsi 1:0:0:0: Direct-Access     TOSHIBA  MBF2600RC        3706 PQ: 0 ANSI: 5
scsi 1:0:0:0: SSP: handle(0x000a), sas_addr(0x50000394281b5b92), phy(4), device_name(0x50000394281b5b91)
scsi 1:0:0:0: SSP: enclosure_logical_id(0x500000e0e049113f), slot(4)
scsi 1:0:0:0: qdepth(254), tagged(1), simple(0), ordered(0), scsi_level(6), cmd_que(1)
scsi 1:0:1:0: Enclosure         FUJITSU  NBBEXP           0d32 PQ: 0 ANSI: 5
scsi 1:0:1:0: SSP: handle(0x000b), sas_addr(0x500000e0e049113d), phy(20), device_name(0x0000000000000000)
scsi 1:0:1:0: SSP: enclosure_logical_id(0x500000e0e049113f), slot(0)
scsi 1:0:1:0: qdepth(254), tagged(1), simple(0), ordered(0), scsi_level(6), cmd_que(1)
niu: niu.c:v1.1 (Apr 22, 2010)
niu: niu0: Found PHY 002060b1 type MII at phy_port 10
niu: niu0: Found PHY 002060b1 type MII at phy_port 11
niu: niu0: Found PHY 002060b1 type MII at phy_port 12
niu: niu0: Found PHY 002060b1 type MII at phy_port 13
niu: niu0: Port 0 [4 RX chans] [6 TX chans]
niu: niu0: Port 1 [4 RX chans] [6 TX chans]
niu: niu0: Port 2 [4 RX chans] [6 TX chans]
niu: niu0: Port 3 [4 RX chans] [6 TX chans]
niu: niu0: Port 0 RDC tbl(0) [ 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 ]
niu: niu0: Port 0 RDC tbl(1) [ 0 1 2 3 0 1 2 3 0 1 2 3 0 1 2 3 ]
niu: niu0: Port 1 RDC tbl(2) [ 4 5 6 7 4 5 6 7 4 5 6 7 4 5 6 7 ]
niu: niu0: Port 1 RDC tbl(3) [ 4 5 6 7 4 5 6 7 4 5 6 7 4 5 6 7 ]
niu: niu0: Port 2 RDC tbl(4) [ 8 9 10 11 8 9 10 11 8 9 10 11 8 9 10 11 ]
niu: niu0: Port 2 RDC tbl(5) [ 8 9 10 11 8 9 10 11 8 9 10 11 8 9 10 11 ]
niu: niu0: Port 3 RDC tbl(6) [ 12 13 14 15 12 13 14 15 12 13 14 15 12 13 14 15 ]
niu: niu0: Port 3 RDC tbl(7) [ 12 13 14 15 12 13 14 15 12 13 14 15 12 13 14 15 ]
niu: eth4: NIU Ethernet 00:10:e0:10:8b:04
niu: eth4: Port type[XMAC] mode[1G:COPPER] XCVR[MII] phy[mif]
niu: eth5: NIU Ethernet 00:10:e0:10:8b:05
niu: eth5: Port type[XMAC] mode[1G:COPPER] XCVR[MII] phy[mif]
niu: eth6: NIU Ethernet 00:10:e0:10:8b:06
niu: eth6: Port type[BMAC] mode[1G:COPPER] XCVR[MII] phy[mif]
niu: eth7: NIU Ethernet 00:10:e0:10:8b:07
niu: eth7: Port type[BMAC] mode[1G:COPPER] XCVR[MII] phy[mif]
qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 8.06.00.08-k.
qla2xxx [0001:06:00.0]-001d: : Found an ISP2532 irq 10 iobase 0x0000802120000000.
scsi2 : qla2xxx
qla2xxx [0001:06:00.0]-00fb:2: QLogic QLE2562 - PCI-Express Dual Channel 8Gb Fibre Channel HBA.
qla2xxx [0001:06:00.0]-00fc:2: ISP2532: PCIe (5.0GT/s x8) @ 0001:06:00.0 hdma- host#=2 fw=7.01.00 (90d5).
qla2xxx [0001:06:00.1]-001d: : Found an ISP2532 irq 11 iobase 0x0000802120004000.
qla2xxx [0001:06:00.0]-505f:2: Link is operational (4 Gbps).
qla2xxx [0001:06:00.0]-1020:2: **** Failed mbx[0]@06, mb[1]e, mb[2]=1, mb[3]=3, cmdj ****.
scsi 2:0:0:0: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
scsi 2:0:0:1: Direct-Access     FUJITSU  ETERNUS_DXL      0000 PQ: 0 ANSI: 5
scsi3 : qla2xxx
qla2xxx [0001:06:00.1]-00fb:3: QLogic QLE2562 - PCI-Express Dual Channel 8Gb Fibre Channel HBA.
qla2xxx [0001:06:00.1]-00fc:3: ISP2532: PCIe (5.0GT/s x8) @ 0001:06:00.1 hdma- host#=3 fw=7.01.00 (90d5).
sr0: scsi3-mmc drive: 62x/62x writer cd/rw xa/form2 cdda tray
cdrom: Uniform CD-ROM driver Revision: 3.20
sr 0:0:0:0: Attached scsi CD-ROM sr0
sd 1:0:0:0: [sda] 1172123568 512-byte logical blocks: (600 GB/558 GiB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Mode Sense: d3 00 00 08
sd 1:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
  sda: sda1 sda2 sda3
sd 1:0:0:0: [sda] Attached SCSI disk
sd 2:0:0:0: [sdb] 2048000 512-byte logical blocks: (1.04 GB/1000 MiB)
sd 2:0:0:1: [sdc] 2048000 512-byte logical blocks: (1.04 GB/1000 MiB)
sd 2:0:0:1: [sdc] Write Protect is off
sd 2:0:0:1: [sdc] Mode Sense: 8f 00 00 08
sd 2:0:0:1: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sdc: sdc1 sdc2 sdc3 sdc7
sd 2:0:0:1: [sdc] Attached SCSI disk
sd 2:0:0:0: [sdb] Write Protect is off
sd 2:0:0:0: [sdb] Mode Sense: 8f 00 00 08
sd 2:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sdb: sdb1 sdb2 sdb3 sdb7
sd 2:0:0:0: [sdb] Attached SCSI disk
dracut: Scanning devices sda2  for LVM logical volumes vg_m101370l0/vol_swap vg_m101370l0/lv_root
dracut: inactive '/dev/vg_m101370l0/lv_root' [362.59 GiB] inherit
dracut: inactive '/dev/vg_m101370l0/vol_swap' [195.31 GiB] inherit
bio: create slab <bio-1> at 1
EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
dracut: Mounted root filesystem /dev/mapper/vg_m101370l0-lv_root
dracut: Loading SELinux policy
type04 audit(1380862286.356:2): enforcing=1 old_enforcing=0 auidB94967295 sesB94967295
SELinux: 2048 avtab hash slots, 276422 rules.
SELinux: 2048 avtab hash slots, 276422 rules.
SELinux:  9 users, 12 roles, 3890 types, 201 bools, 1 sens, 1024 cats
SELinux:  81 classes, 276422 rules
SELinux:  Permission wake_alarm in class capability2 not defined in policy.
SELinux:  Permission block_suspend in class capability2 not defined in policy.
SELinux:  Permission attach_queue in class tun_socket not defined in policy.
SELinux: the above unknown classes and permissions will be allowed
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev devtmpfs, type devtmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev anon_inodefs, type anon_inodefs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses transition SIDs
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev securityfs, type securityfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev dm-0, type ext4), uses xattr
type03 audit(1380862287.036:3): policy loaded auidB94967295 sesB94967295
dracut:
dracut: Switching root
readahead-collector: starting
readahead-collector: sorting
readahead-collector: finished
udev: starting version 147
EXT4-fs (dm-0): re-mounted. Opts: (null)
Adding 204799992k swap on /dev/mapper/vg_m101370l0-vol_swap.  Priority:-1 extents:1 across:204799992k FS
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
qla2xxx [0001:06:00.1]-8038:3: Cable is unplugged...
rsyslogd (2041): Attempt to access syslog with CAP_SYS_ADMIN but no CAP_SYSLOG (deprecated).
IPv6: ADDRCONF(NETDEV_UP): eth1: link is not ready
IPv6: ADDRCONF(NETDEV_UP): eth2: link is not ready
IPv6: ADDRCONF(NETDEV_UP): eth3: link is not ready
IPv6: ADDRCONF(NETDEV_UP): eth4: link is not ready
IPv6: ADDRCONF(NETDEV_UP): eth5: link is not ready
IPv6: ADDRCONF(NETDEV_UP): eth6: link is not ready
IPv6: ADDRCONF(NETDEV_UP): eth7: link is not ready
igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready


From: Anatoly Pugachev <matorola@gmail.com>
Date: Thu, 16 Jun 2016 10:02:07 +0000
Subject: Re: 4.6-rc*: Kernel unaligned access at pci_bus_read_config_dword+0x64/0x80
Message-Id: <CADxRZqw6Q-jLCnZzzq=akP5vqd3Y8RCF34pWQGNSuL2VscrbJg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1606022203030.24438@math.ut.ee>
 <CADxRZqwuOnz8Cyedjiamyxz1nE80HxmoFANPmtZy-svr8wKfvg@mail.gmail.com>
 <alpine.LRH.2.20.1606131548260.25241@math.ut.ee> <CADxRZqzd3uDAAGsU0Tsg7vzxEvdtCv+QQDp8UM=6nVNk2VqO=A@mail.gmail.com>
 <CADxRZqw4jG3kPz6wG5Yx5DoZV0h+Xak5j682c7stq0fNOiopZQ@mail.gmail.com>
In-Reply-To: <CADxRZqw4jG3kPz6wG5Yx5DoZV0h+Xak5j682c7stq0fNOiopZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>
Cc: sparclinux@vger.kernel.org, linux-pci@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>

On Wed, Jun 15, 2016 at 1:38 AM, Anatoly Pugachev <matorola@gmail.com> wrote:
> On Tue, Jun 14, 2016 at 4:02 PM, Anatoly Pugachev <matorola@gmail.com> wrote:
>> On Mon, Jun 13, 2016 at 3:49 PM, Meelis Roos <mroos@linux.ee> wrote:
>>>> > Between 4.5.0 and 4.6.0-rc3, my Spar Enterprise T5120 has started
>>>> > showing the following messages during bootup:
>>> [...]
>>>>
>>>> got the same messages on my t5120 with kernel 4.6.1 :
>>> [...]
>>>> but 4.7.0-rc2+ (from git), does not have it, probably fixed.
>>>
>>> Nope, I still get them on 4.7-rc3:
>>>
>>> [ 4742.646120] Kernel unaligned access at TPC[6a5724] pci_bus_read_config_dword+0x64/0x80
>>> [ 4742.646197] Kernel unaligned access at TPC[6a5724] pci_bus_read_config_dword+0x64/0x80
>>> [ 4742.646265] Kernel unaligned access at TPC[6a5724] pci_bus_read_config_dword+0x64/0x80
>>> [ 4742.646333] Kernel unaligned access at TPC[6a5724] pci_bus_read_config_dword+0x64/0x80
>>> [ 4742.646401] Kernel unaligned access at TPC[6a5724] pci_bus_read_config_dword+0x64/0x80
>>
>>
>> Still don't see it with current git (4.7.0-rc3+) kernel on my T5120.
>> Probably difference with kernel config file. Can you please share your
>> kernel config file, so I can try it on my t5120 ?
>
> Got config, compared and it was indeed different kernel config files.
> Tracked down it , that enabling CONFIG_PCIEPORTBUS=y makes this
> messages appear on my t5120 as well.

bisected to git commit 63e3027
(git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git),
which introduced CONFIG_PCIEPORTBUS as well this TPC on T5120.
Anything else I could do to fix that ?

Boot log with debug:

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 4.33.6.g 2016/03/11 06:05'
[    0.000000] PROMLIB: Root node compatible: sun4v
[    0.000000] Linux version 4.5.0+ (mator@nvg5120) (gcc version 5.4.0
20160603 (Debian 5.4.0-3) ) #11 SMP Wed Jun 15 19:49:52 MSK 2016
[    0.000000] debug: skip boot console de-registration.
[    0.000000] bootconsole [earlyprom0] enabled
[    0.000000] ARCH: SUN4V
[    0.000000] Ethernet address: 00:14:4f:ac:4a:18
[    0.000000] MM: PAGE_OFFSET is 0xffff800000000000 (max_phys_bits = 39)
[    0.000000] MM: VMALLOC [0x0000000100000000 --> 0x0000600000000000]
[    0.000000] MM: VMEMMAP [0x0000600000000000 --> 0x0000c00000000000]
[    0.000000] Kernel: Using 3 locked TLB entries for main kernel image.
[    0.000000] Remapping the kernel... done.
[    0.000000] OF stdout device is: /virtual-devices@100/console@1
[    0.000000] PROM: Built device tree with 195069 bytes of memory.
[    0.000000] MDESC: Size is 61728 bytes.
[    0.000000] PLATFORM: banner-name [SPARC Enterprise T5120]
[    0.000000] PLATFORM: name [SUNW,SPARC-Enterprise-T5120]
[    0.000000] PLATFORM: hostid [84ac4a18]
[    0.000000] PLATFORM: serial# [00ab4130]
[    0.000000] PLATFORM: stick-frequency [457646c0]
[    0.000000] PLATFORM: mac-address [144fac4a18]
[    0.000000] PLATFORM: watchdog-resolution [1000 ms]
[    0.000000] PLATFORM: watchdog-max-timeout [31536000000 ms]
[    0.000000] PLATFORM: max-cpus [64]
[    0.000000] Top of RAM: 0x3ffb16000, Total RAM: 0x3f76ac000
[    0.000000] Memory hole size: 132MB
[    0.000000] Allocated 16384 bytes for kernel page tables.
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000008400000-0x00000003ffb15fff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000008400000-0x00000003ffa89fff]
[    0.000000]   node   0: [mem 0x00000003ffa9a000-0x00000003ffaadfff]
[    0.000000]   node   0: [mem 0x00000003ffb08000-0x00000003ffb15fff]
[    0.000000] Initmem setup node 0 [mem 0x0000000008400000-0x00000003ffb15fff]
[    0.000000] On node 0 totalpages: 2079574
[    0.000000]   Normal zone: 18278 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 2079574 pages, LIFO batch:15
[    0.000000] Booting Linux...
[    0.000000] CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
[    0.000000] CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit]
[    0.000000] PERCPU: Embedded 8 pages/cpu @ffff8003ff400000 s28440
r8192 d28904 u65536
[    0.000000] pcpu-alloc: s28440 r8192 d28904 u65536 alloc=1*4194304
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 08 09 10 11 12
13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35
36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58
59 60 61 62 63
[    0.000000] SUN4V: Mondo queue sizes [cpu(8192) dev(16384) r(8192) nr(256)]
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 2061296
[    0.000000] Kernel command line: root=/dev/mapper/vg1-root ro
keep_bootcon console=ttyS0 noresume zswap.enabled=1 debug
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 258048 bytes
[    0.000000] log_buf_len min size: 131072 bytes
[    0.000000] log_buf_len: 524288 bytes
[    0.000000] early log buf free: 127608(97%)
[    0.000000] PID hash table entries: 4096 (order: 2, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 2097152 (order: 11,
16777216 bytes)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 10,
8388608 bytes)
[    0.000000] Sorting __ex_table...
[    0.000000] Memory: 16431696K/16636592K available (5521K kernel
code, 683K rwdata, 1280K rodata, 456K init, 736K bss, 204896K
reserved, 0K cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000]  RCU restricting CPUs from NR_CPUS%6 to nr_cpu_idsd.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leafd, nr_cpu_idsd
[    0.000000] NR_IRQS:2048 nr_irqs:2048 1
[    0.000000] SUN4V: Using IRQ API major 1, cookie only virqs disabled
[65955.536151] clocksource: stick: mask: 0xffffffffffffffff
max_cycles: 0x10cc5ac4c8a, max_idle_ns: 440795218862 ns
[65955.536894] clocksource: mult[dbabc5] shift[24]
[65955.537224] clockevent: mult[952b25d1] shift[31]
[65955.540086] Console: colour dummy device 80x25
[65955.619226] Calibrating delay using timer specific routine..
2337.35 BogoMIPS (lpjF74713)
[65955.620192] pid_max: default: 65536 minimum: 512
[65955.621502] Security Framework initialized
[65955.621826] AppArmor: AppArmor disabled by boot time parameter
[65955.622590] Mount-cache hash table entries: 32768 (order: 5, 262144 bytes)
[65955.623100] Mountpoint-cache hash table entries: 32768 (order: 5,
262144 bytes)
[65955.627070] ftrace: allocating 18483 entries in 37 pages
[65955.740316] Brought up 64 CPUs
[65955.749701] devtmpfs: initialized
[65955.761123] Performance events:
[65955.761792] Testing NMI watchdog ...
[65955.843736] OK.
[65955.844047] Supported PMU type is 'niagara2'
[65955.884062] ldc.c:v1.1 (July 22, 2008)
[65955.885313] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[65955.888507] NET: Registered protocol family 16
[65955.913974] VIO: Adding device channel-devices
[65955.914566] VIO: Adding device vlds-port-0-0
[65955.915123] VIO: Adding device vldc-port-3-0
[65955.915662] VIO: Adding device vldc-port-3-1
[65955.916223] VIO: Adding device vldc-port-3-2
[65955.916761] VIO: Adding device vldc-port-3-3
[65955.917317] VIO: Adding device vldc-port-3-4
[65955.917857] VIO: Adding device vldc-port-3-5
[65955.918400] VIO: Adding device vldc-port-2-0
[65955.918950] VIO: Adding device vldc-port-0-0
[65955.919496] VIO: Adding device vldc-port-0-1
[65955.920058] VIO: Adding device vldc-port-0-2
[65955.920599] VIO: Adding device vldc-port-1-0
[65955.921129] VIO: Adding device vldc-port-3-7
[65955.921697] VIO: Adding device vldc-port-3-8
[65955.922257] VIO: Adding device ds-1
[65955.922744] VIO: Adding device ds-0
[65955.941343] pci_sun4v: Registered hvapi major[1] minor[0]
[65955.942051] /pci@0: SUN4V PCI Bus Module
[65955.942356] /pci@0: On NUMA node -1
[65955.942619] /pci@0: PCI IO[c0f0000000] MEM[c100000000] MEM64[c200000000]
[65955.943175] /pci@0: Unable to request IOMMU resource.
[65955.993192] /pci@0: Imported 3 TSB entries from OBP
[65955.997715] /pci@0: MSI Queue first[0] num[36] count[128] devino[0x18]
[65955.998536] /pci@0: MSI first[0] num[256] mask[0xff] width[32]
[65955.998967] /pci@0: MSI addr32[0x7fff0000:0x10000]
addr64[0x3ffff0000:0x10000]
[65955.999485] /pci@0: MSI queues at RA [00000003f2680000]
[65955.999875] PCI: Scanning PBM /pci@0
[65956.000472] pci_sun4v f028ca10: PCI host bridge to bus 0000:02
[65956.000917] pci_bus 0000:02: root bus resource [io
0xc0f0000000-0xc0ffffffff] (bus address [0x0000-0xfffffff])
[65956.001646] pci_bus 0000:02: root bus resource [mem
0xc100000000-0xc17ffeffff] (bus address [0x00000000-0x7ffeffff])
[65956.002419] pci_bus 0000:02: root bus resource [mem
0xc200000000-0xc3fffeffff] (bus address [0x100000000-0x2fffeffff])
[65956.003187] pci_bus 0000:02: root bus resource [bus 02-12]
[65956.003936] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[65956.005377] pci 0000:03:01.0: PME# supported from D0 D3hot D3cold
[65956.006805] pci 0000:04:00.0: PME# supported from D0 D3hot D3cold
[65956.008275] pci 0000:05:01.0: PME# supported from D0 D3hot D3cold
[65956.009713] pci 0000:06:00.0: supports D1
[65956.010029] pci 0000:06:00.0: PME# supported from D0 D1 D3hot
[65956.011347] pci 0000:07:00.0: supports D1 D2
[65956.011680] pci 0000:07:00.0: PME# supported from D0 D1 D2 D3hot
[65956.012727] pci 0000:07:00.1: supports D1 D2
[65956.013073] pci 0000:07:00.1: PME# supported from D0 D1 D2 D3hot
[65956.014118] pci 0000:07:00.2: supports D1 D2
[65956.014453] pci 0000:07:00.2: PME# supported from D0 D1 D2 D3hot
[65956.015585] pci 0000:05:02.0: PME# supported from D0 D3hot D3cold
[65956.017036] pci 0000:08:00.0: PME# supported from D0 D3hot
[65956.018458] pci 0000:08:00.1: PME# supported from D0 D3hot
[65956.019608] pci 0000:05:03.0: PME# supported from D0 D3hot D3cold
[65956.021025] pci 0000:09:00.0: PME# supported from D0 D3hot
[65956.022178] pci 0000:09:00.1: PME# supported from D0 D3hot
[65956.023306] pci 0000:03:02.0: PME# supported from D0 D3hot D3cold
[65956.024706] pci 0000:0a:00.0: supports D1 D2
[65956.025651] pci 0000:03:08.0: PME# supported from D0 D3hot D3cold
[65956.027110] pci 0000:0b:00.0: PME# supported from D0 D3hot D3cold
[65956.028553] pci 0000:0c:01.0: PME# supported from D0 D3hot D3cold
[65956.029995] pci 0000:0c:02.0: PME# supported from D0 D3hot D3cold
[65956.031448] pci 0000:0c:08.0: PME# supported from D0 D3hot D3cold
[65956.033119] pci 0000:0c:09.0: PME# supported from D0 D3hot D3cold
[65956.034793] pci 0000:0c:0a.0: PME# supported from D0 D3hot D3cold
[65956.036408] pci 0000:03:09.0: PME# supported from D0 D3hot D3cold
[65956.055272] HugeTLB registered 8 MB page size, pre-allocated 0 pages
[65956.059806] vgaarb: loaded
[65956.062724] SUN4V: Reboot data supported (maj=1,min=0).
[65956.063284] ds.c:v1.0 (Jul 11, 2007)
[65956.064898] clocksource: Switched to clocksource stick
[65956.080918] ds-1: Registered pri service.
[65956.105921] ds-1: Registered var-config-backup service.
[65956.135095] VFS: Disk quotas dquot_6.6.0
[65956.135889] VFS: Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
[65956.154322] NET: Registered protocol family 2
[65956.157086] TCP established hash table entries: 131072 (order: 7,
1048576 bytes)
[65956.161046] TCP bind hash table entries: 65536 (order: 7, 1048576 bytes)
[65956.165516] TCP: Hash tables configured (established 131072 bind 65536)
[65956.166199] UDP hash table entries: 8192 (order: 5, 262144 bytes)
[65956.167706] UDP-Lite hash table entries: 8192 (order: 5, 262144 bytes)
[65956.170866] NET: Registered protocol family 1
[65956.280666] PCI: Enabling device: (0000:07:00.2), cmd 2
[65956.281316] PCI: CLS mismatch (64 != 512), using 64 bytes
[65956.282095] Unpacking initramfs...
[65957.846917] Freeing initrd memory: 16744K (ffff80000c800000 -
ffff80000d85a000)
[65957.860791] futex hash table entries: 16384 (order: 7, 1048576 bytes)
[65957.862289] audit: initializing netlink subsys (disabled)
[65957.862762] audit: type 00 audit(2.235:1): initialized
[65957.863852] Initialise system trusted keyring
[65957.865417] workingset: timestamp_bitsE max_order! bucket_order=0
[65957.866352] zbud: loaded
[65957.870863] Key type asymmetric registered
[65957.871525] Asymmetric key parser 'x509' registered
[65957.872089] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 252)
[65957.873106] io scheduler noop registered
[65957.873449] io scheduler deadline registered
[65957.873968] io scheduler cfq registered (default)
[65957.875635] Kernel unaligned access at TPC[729cac]
pci_bus_read_config_dword+0x6c/0x80
[65957.880650] Kernel unaligned access at TPC[729cac]
pci_bus_read_config_dword+0x6c/0x80
[65957.881595] Kernel unaligned access at TPC[729cac]
pci_bus_read_config_dword+0x6c/0x80
[65957.882190] Kernel unaligned access at TPC[729cac]
pci_bus_read_config_dword+0x6c/0x80
[65957.883085] Kernel unaligned access at TPC[729cac]
pci_bus_read_config_dword+0x6c/0x80
[65957.895616] f0286d78: ttyS0 at I/O 0x0 (irq = 17, base_baud 115200) is a SUN4V HCONS
[65957.899542] f0298d00: ttyS1 at MMIO 0xfff0ca0000 (irq = 24,
base_baud = 115387) is a 16550A
[65957.901202] Console: ttyS1 (SU)
[65957.901477] console [ttyS0] enabled
[65957.949580] mousedev: PS/2 mouse device common for all mice
[65958.020316] rtc-sun4v rtc-sun4v: rtc core: registered sun4v as rtc0
[65958.098476] sun4v_wdt: initialized (timeout`s, nowayout=0)
[65958.168785] ledtrig-cpu: registered to indicate activity on CPUs
[65958.244322] NET: Registered protocol family 10
[65958.301696] mip6: Mobile IPv6
[65958.338440] NET: Registered protocol family 17
[65958.393427] 9pnet: Installing 9P2000 support
[65958.446177] mpls_gso: MPLS GSO support
[65958.493851] registered taskstats version 1
[65958.544550] Loading compiled-in X.509 certificates
[65958.604450] zswap: loaded using pool lzo/zbud
[65958.660762] rtc-sun4v rtc-sun4v: setting system clock to 2016-06-16
09:31:44 UTC (1466069504)
[65958.767081] This architecture does not have kernel memory protection.
[65959.388309] crc32c_sparc64: sparc64 crc32c opcode not available.
[65959.498324] crc32c_sparc64: sparc64 crc32c opcode not available.
[65959.550082] pps_core: LinuxPPS API ver. 1 registered
[65959.550087] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[65959.552022] PTP clock support registered
[65959.552250] usbcore: registered new interface driver usbfs
[65959.552382] usbcore: registered new interface driver hub
[65959.553135] usbcore: registered new device driver usb
[65959.556197] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[65959.557368] ehci-pci: EHCI PCI platform driver
[65959.557596] ehci-pci 0000:07:00.2: EHCI Host Controller
[65959.557646] ehci-pci 0000:07:00.2: new USB bus registered, assigned
bus number 1
[65959.557934] ehci-pci 0000:07:00.2: irq 20, io mem 0xc100304000
[65959.558445] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[65959.558870] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[65959.558874] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[65959.558985] PCI: Enabling device: (0000:08:00.0), cmd 146
[65959.559248] e1000e 0000:08:00.0: Interrupt Throttling Rate
(ints/sec) set to dynamic conservative mode
[65959.569823] ehci-pci 0000:07:00.2: USB 2.0 started, EHCI 1.00
[65959.570182] usb usb1: New USB device found, idVendor6b, idProduct 02
[65959.570191] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[65959.570199] usb usb1: Product: EHCI Host Controller
[65959.570206] usb usb1: Manufacturer: Linux 4.5.0+ ehci_hcd
[65959.570213] usb usb1: SerialNumber: 0000:07:00.2
[65959.571240] hub 1-0:1.0: USB hub found
[65959.571293] hub 1-0:1.0: 5 ports detected
[65959.574435] ohci-pci: OHCI PCI platform driver
[65959.574571] ohci-pci 0000:07:00.0: OHCI PCI host controller
[65959.574606] ohci-pci 0000:07:00.0: new USB bus registered, assigned
bus number 2
[65959.574757] ohci-pci 0000:07:00.0: irq 22, io mem 0xc100300000
[65959.632146] usb usb2: New USB device found, idVendor6b, idProduct 01
[65959.632155] usb usb2: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[65959.632163] usb usb2: Product: OHCI PCI host controller
[65959.632171] usb usb2: Manufacturer: Linux 4.5.0+ ohci_hcd
[65959.632178] usb usb2: SerialNumber: 0000:07:00.0
[65959.633126] hub 2-0:1.0: USB hub found
[65959.633182] hub 2-0:1.0: 3 ports detected
[65959.634318] ohci-pci 0000:07:00.1: OHCI PCI host controller
[65959.634351] ohci-pci 0000:07:00.1: new USB bus registered, assigned
bus number 3
[65959.634518] ohci-pci 0000:07:00.1: irq 23, io mem 0xc100302000
[65959.692107] usb usb3: New USB device found, idVendor6b, idProduct 01
[65959.692117] usb usb3: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[65959.692125] usb usb3: Product: OHCI PCI host controller
[65959.692132] usb usb3: Manufacturer: Linux 4.5.0+ ohci_hcd
[65959.692139] usb usb3: SerialNumber: 0000:07:00.1
[65959.693026] hub 3-0:1.0: USB hub found
[65959.693082] hub 3-0:1.0: 2 ports detected
[65959.731438] e1000e 0000:08:00.0 eth0: (PCI Express:2.5GT/s:Width
x4) 00:14:4f:ac:4a:18
[65959.731449] e1000e 0000:08:00.0 eth0: Intel(R) PRO/1000 Network Connection
[65959.731540] e1000e 0000:08:00.0 eth0: MAC: 0, PHY: 4, PBA No: FFFFFF-0FF
[65959.731643] PCI: Enabling device: (0000:08:00.1), cmd 146
[65959.731897] e1000e 0000:08:00.1: Interrupt Throttling Rate
(ints/sec) set to dynamic conservative mode
[65959.863207] SCSI subsystem initialized
[65959.865953] Fusion MPT base driver 3.04.20
[65959.865956] Copyright (c) 1999-2008 LSI Corporation
[65959.872361] Fusion MPT SAS Host driver 3.04.20
[65959.872859] mptbase: ioc0: Initiating bringup
[65959.881914] usb 1-2: new high-speed USB device number 2 using ehci-pci
[65959.903456] e1000e 0000:08:00.1 eth1: (PCI Express:2.5GT/s:Width
x4) 00:14:4f:ac:4a:19
[65959.903467] e1000e 0000:08:00.1 eth1: Intel(R) PRO/1000 Network Connection
[65959.903569] e1000e 0000:08:00.1 eth1: MAC: 0, PHY: 4, PBA No: FFFFFF-0FF
[65959.903661] PCI: Enabling device: (0000:09:00.0), cmd 146
[65959.903908] e1000e 0000:09:00.0: Interrupt Throttling Rate
(ints/sec) set to dynamic conservative mode
[65960.059900] usb 1-2: New USB device found, idVendor51, idProductb5f
[65960.059910] usb 1-2: New USB device strings: Mfr=5, Product=2, SerialNumber=1
[65960.059918] usb 1-2: Product: 6250 FW: 03.05.02.22.562AD423
[65960.059925] usb 1-2: Manufacturer: Texas Instruments Incorporated
[65960.059932] usb 1-2: SerialNumber: ACD6CE63350D
[65960.070905] usb-storage 1-2:1.0: USB Mass Storage device detected
[65960.071476] scsi host0: usb-storage 1-2:1.0
[65960.072077] usbcore: registered new interface driver usb-storage
[65960.073827] usbcore: registered new interface driver uas
[65960.075553] e1000e 0000:09:00.0 eth2: (PCI Express:2.5GT/s:Width
x4) 00:14:4f:ac:4a:1a
[65960.075562] e1000e 0000:09:00.0 eth2: Intel(R) PRO/1000 Network Connection
[65960.075649] e1000e 0000:09:00.0 eth2: MAC: 0, PHY: 4, PBA No: FFFFFF-0FF
[65960.075722] PCI: Enabling device: (0000:09:00.1), cmd 146
[65960.075962] e1000e 0000:09:00.1: Interrupt Throttling Rate
(ints/sec) set to dynamic conservative mode
[65960.170002] usb 1-4: new high-speed USB device number 3 using ehci-pci
[65960.247524] e1000e 0000:09:00.1 eth3: (PCI Express:2.5GT/s:Width
x4) 00:14:4f:ac:4a:1b
[65960.247534] e1000e 0000:09:00.1 eth3: Intel(R) PRO/1000 Network Connection
[65960.247626] e1000e 0000:09:00.1 eth3: MAC: 0, PHY: 4, PBA No: FFFFFF-0FF
[65960.257595] e1000e 0000:08:00.0 enp8s0f0: renamed from eth0
[65960.303602] usb 1-4: New USB device found, idVendorb4, idProducte60
[65960.303612] usb 1-4: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[65960.304744] hub 1-4:1.0: USB hub found
[65960.305211] hub 1-4:1.0: 4 ports detected
[65960.574152] ioc0: LSISAS1068E B1: Capabilities={Initiator}
[65965.275021] scsi 0:0:0:0: CD-ROM            TSSTcorp CD/DVDW
TS-T632A SR03 PQ: 0 ANSI: 0
[65965.913343] e1000e 0000:09:00.0 enp9s0f0: renamed from eth2
[65966.000639] e1000e 0000:08:00.1 enp8s0f1: renamed from eth1
[65966.070335] sr 0:0:0:0: [sr0] scsi3-mmc drive: 6x/24x writer
dvd-ram cd/rw xa/form2 cdda tray
[65966.175493] cdrom: Uniform CD-ROM driver Revision: 3.20
[65966.240965] sr 0:0:0:0: Attached scsi CD-ROM sr0
[65966.244658] e1000e 0000:09:00.1 enp9s0f1: renamed from eth3
[65976.639695] scsi host1: ioc0: LSISAS1068E B1, FwRev1b0000h,
Ports=1, MaxQ'7, IRQ"
[65976.781633] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id
0, phy 0, sas_addr 0x5000c5000a5c8715
[65976.905045] scsi 1:0:0:0: Direct-Access     SEAGATE
ST914602SSUN146G 0603 PQ: 0 ANSI: 5
[65977.030654] mptsas: ioc0: attaching ssp device: fw_channel 0, fw_id
1, phy 1, sas_addr 0x5000c5000ee01681
[65977.153954] scsi 1:0:1:0: Direct-Access     SEAGATE
ST914602SSUN146G 0603 PQ: 0 ANSI: 5
[65977.296078] sd 1:0:0:0: [sda] 286739329 512-byte logical blocks:
(147 GB/137 GiB)
[65977.296179] sd 1:0:1:0: [sdb] 286739329 512-byte logical blocks:
(147 GB/137 GiB)
[65977.298240] sd 1:0:1:0: [sdb] Write Protect is off
[65977.298253] sd 1:0:1:0: [sdb] Mode Sense: e3 00 10 08
[65977.300046] sd 1:0:1:0: [sdb] Write cache: disabled, read cache:
enabled, supports DPO and FUA
[65977.326921]  sdb: sdb1 sdb2 sdb3
[65977.336639] sd 1:0:1:0: [sdb] Attached SCSI disk
[65977.808696] sd 1:0:0:0: [sda] Write Protect is off
[65977.868215] sd 1:0:0:0: [sda] Mode Sense: e3 00 10 08
[65977.932685] sd 1:0:0:0: [sda] Write cache: disabled, read cache:
enabled, supports DPO and FUA
[65978.062630]  sda: sda1 sda2 sda3
[65978.112219] sd 1:0:0:0: [sda] Attached SCSI disk
[65978.651225] md: md0 stopped.
[65978.690493] md: bind<sdb2>
[65978.724982] md: bind<sda2>
[65978.764559] md: raid1 personality registered for level 1
[65978.831862] md/raid1:md0: active with 2 out of 2 mirrors
[65978.898153] created bitmap (1 pages) for device md0
[65978.958995] md0: bitmap initialized from disk: read 1 pages, set 0
of 2182 bits
[65979.052471] md0: detected capacity change from 0 to 146415419392
[65979.370599] device-mapper: uevent: version 1.0.3
[65979.428637] device-mapper: ioctl: 4.34.0-ioctl (2015-10-28)
initialised: dm-devel@redhat.com
[65979.602901] random: nonblocking pool is initialized
[65980.044842] crc32c_sparc64: sparc64 crc32c opcode not available.
[65980.199635] EXT4-fs (dm-0): mounted filesystem with ordered data
mode. Opts: (null)
[65982.172238] systemd[1]: systemd 229 running in system mode. (+PAM
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
+GCRYPT +GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
[66050.220004] EXT4-fs (dm-0): re-mounted. Opts: errors=remount-ro
[66060.232378] n2_crypto: n2_crypto.c:v0.2 (July 28, 2011)
[66060.232383] n2_crypto: Found N2CP at /virtual-devices@100/n2cp@7
[66060.232396] n2_crypto: Registered NCS HVAPI version 2.0
[66060.363676] sha1_sparc64: sparc64 sha1 opcode not available.
[66060.375837] sha256_sparc64: sparc64 sha256 opcode not available.
[66060.388011] n2_crypto: md5 alg registration failed
[66060.388023] n2cp f028681c: /virtual-devices@100/n2cp@7: Unable to
register algorithms.
[66060.388130] n2cp: probe of f028681c failed with error -22
[66060.388194] n2rng.c:v0.2 (July 27, 2011)
[66060.388211] n2rng f0286a1c: Registered RNG HVAPI major 2 minor 0
[66060.388223] n2rng f0286a1c: Found single-unit RNG, units: 1
[66060.389385] n2rng f0286a1c: Selftest passed on unit 0
[66060.389396] n2rng f0286a1c: RNG ready
[66060.389472] n2_crypto: Found NCP at /virtual-devices@100/ncp@6
[66060.389479] n2_crypto: Registered NCS HVAPI version 2.0
[66060.392692] sha512_sparc64: sparc64 sha512 opcode not available.
[66060.423507] md5_sparc64: sparc64 md5 opcode not available.
[66060.446675] aes_sparc64: sparc64 aes opcodes not available.
[66060.480897] des_sparc64: sparc64 des opcodes not available.
[66060.520654] camellia_sparc64: sparc64 camellia opcodes not available.
[66060.547777] crc32c_sparc64: sparc64 crc32c opcode not available.
[66062.723408] des_sparc64: sparc64 des opcodes not available.
[66062.811532] md5_sparc64: sparc64 md5 opcode not available.
[66062.811715] sha256_sparc64: sparc64 sha256 opcode not available.
[66062.811920] crc32c_sparc64: sparc64 crc32c opcode not available.
[66062.812226] sha512_sparc64: sparc64 sha512 opcode not available.
[66062.812297] camellia_sparc64: sparc64 camellia opcodes not available.
[66062.812383] aes_sparc64: sparc64 aes opcodes not available.
[66066.185575] des_sparc64: sparc64 des opcodes not available.
[66066.186248] aes_sparc64: sparc64 aes opcodes not available.
[66066.337303] sha512_sparc64: sparc64 sha512 opcode not available.
[66066.505030] md5_sparc64: sparc64 md5 opcode not available.
[66066.505288] sr 0:0:0:0: Attached scsi generic sg0 type 5
[66066.505775] sd 1:0:0:0: Attached scsi generic sg1 type 0
[66066.506255] sd 1:0:1:0: Attached scsi generic sg2 type 0
[66066.856621] Adding 5836792k swap on /dev/mapper/vg1-swap_1.
Priority:-1 extents:1 across:5836792k FS
[66067.168993] camellia_sparc64: sparc64 camellia opcodes not available.
[66067.304912] crc32c_sparc64: sparc64 crc32c opcode not available.
[66067.397502] aes_sparc64: sparc64 aes opcodes not available.
[66067.398396] des_sparc64: sparc64 des opcodes not available.
[66067.398757] md5_sparc64: sparc64 md5 opcode not available.
[66067.737387] camellia_sparc64: sparc64 camellia opcodes not available.
[66067.737402] des_sparc64: sparc64 des opcodes not available.
[66067.737484] aes_sparc64: sparc64 aes opcodes not available.
[66068.005427] crc32c_sparc64: sparc64 crc32c opcode not available.
[66068.005465] des_sparc64: sparc64 des opcodes not available.
[66068.005879] camellia_sparc64: sparc64 camellia opcodes not available.
[66068.429747] crc32c_sparc64: sparc64 crc32c opcode not available.
[66068.430230] camellia_sparc64: sparc64 camellia opcodes not available.
[66068.778348] crc32c_sparc64: sparc64 crc32c opcode not available.
[66069.095337] EXT4-fs (sdb1): mounting ext2 file system using the
ext4 subsystem
[66069.211026] EXT4-fs (sdb1): mounted filesystem without journal. Opts: (null)
[66069.882285] IPv6: ADDRCONF(NETDEV_UP): enp8s0f0: link is not ready
[66071.142945] e1000e: enp8s0f0 NIC Link is Up 100 Mbps Full Duplex,
Flow Control: None
[66071.256307] e1000e 0000:08:00.0 enp8s0f0: 10/100 speed: disabling TSO
[66071.351090] IPv6: ADDRCONF(NETDEV_CHANGE): enp8s0f0: link becomes ready
[66072.518634] RPC: Registered named UNIX socket transport module.
[66072.591826] RPC: Registered udp transport module.
[66072.650377] RPC: Registered tcp transport module.
[66072.708539] RPC: Registered tcp NFSv4.1 backchannel transport module.
[66072.823206] FS-Cache: Loaded
[66072.902851] FS-Cache: Netfs 'nfs' registered for caching
[66073.018503] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).

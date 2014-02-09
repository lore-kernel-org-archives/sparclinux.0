From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sun, 09 Feb 2014 17:37:38 +0000
Subject: [Debian] Kernel 3.12.9
Message-Id: <52F7BCE2.9010902@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I have several Sun Fire and Enterprise T1000. I have some trouble with 
internal SAS adapter. Some T1000 work fine with Fusion MPT SAS Host 
driver 3.04.18, some don't but perfectly run with older drivers.

	I have tested all T1000 that don't run with 3.04.18 driver with SunVTS 
and hardware seems to run fine.

	Last friday, a power supply was reported as defective and I have 
stopped all servers to maintenance. As all T1000 worked with 2.6.30.9 
and 2.6.38 linux kernel, I have upgraded all installations.

	Now, I'm trying to boot a T1000 with 3.12.9 linux kernel. I have tried 
debian binary package. Boot stops with :
INFO: rcu_sched detected stalls on CPUs/tasks: { 0 2 3 4 6 7 8 9 10 11 
12 13 14 15 16 17 18 19 20 21 22 23} (detected by 5, tY27 jiffies, 
g446744073709551319, c446744073709551318, q09)
   CPU[  0]: TSTATE[0000000080001603] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/0:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[start_kernel+0x37c/0x38c]
   CPU[  1]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/1:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[  2]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/2:0]

	I have tried to build my own kernel (with the same configuration I have 
used to build 2.6.38). Same result :

Allocated 64 Megs of memory at 0x40000000 for kernel
Loaded kernel version 3.12.9

PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4 2009/08/19 07:22'
PROMLIB: Root node compatible: sun4v
Linux version 3.12.9 (root@gershwin) (gcc version 4.6.4 (Debian 4.6.4-5) 
) #4 SMP Sun Feb 9 18:12:29 CET 2014
bootconsole [earlyprom0] enabled
ARCH: SUN4V
Ethernet address: 00:14:4f:6f:59:fe
Kernel: Using 2 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /virtual-devices@100/console@1
PROM: Built device tree with 76463 bytes of memory.
MDESC: Size is 33536 bytes.
PLATFORM: banner-name [Sun Fire(TM) T1000]
PLATFORM: name [SUNW,Sun-Fire-T1000]
PLATFORM: hostid [846f59fe]
PLATFORM: serial# [00ab4130]
PLATFORM: stick-frequency [3b9aca00]
PLATFORM: mac-address [144f6f59fe]
PLATFORM: watchdog-resolution [1000 ms]
PLATFORM: watchdog-max-timeout [31536000000 ms]
PLATFORM: max-cpus [32]
Top of RAM: 0xffdae000, Total RAM: 0xf799e000
Memory hole size: 132MB
Zone ranges:
   Normal   [mem 0x08400000-0xffdadfff]
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x08400000-0xffd7bfff]
   node   0: [mem 0xffd8c000-0xffdadfff]
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,mul32,div32]
CPU CAPS: [v8plus,ASIBlkInit]
PERCPU: Embedded 6 pages/cpu @fffff800fd800000 s13760 r8192 d27200 u131072
SUN4V: Mondo queue sizes [cpu(4096) dev(16384) r(8192) nr(256)]
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 503125
Policy zone: Normal
Kernel command line: root=/dev/md0 ro md=0,/dev/sda4,/dev/sdb4 
raid=noautodetect console=ttyHV0
md: Will configure md0 (super-block) from /dev/sda4,/dev/sdb4, below.
PID hash table entries: 4096 (order: 2, 32768 bytes)
Sorting __ex_table...
Memory: 4014952K/4056696K available (3879K kernel code, 320K rwdata, 
1120K rodata, 192K init, 538K bss, 41744K reserved)
SLUB: HWalign2, Order=0-3, MinObjects=0, CPUs2, Nodes
Hierarchical RCU implementation.
         RCU restricting CPUs from NR_CPUSd to nr_cpu_ids2.
NR_IRQS:255
clocksource: mult[800000] shift[23]
clockevent: mult[80000000] shift[31]
Console: colour dummy device 80x25
Calibrating delay using timer specific routine.. 2003.36 BogoMIPS 
(lpj016842)
pid_max: default: 32768 minimum: 301
Dentry cache hash table entries: 524288 (order: 9, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 8, 2097152 bytes)
Mount-cache hash table entries: 512
Performance events: Supported PMU type is 'niagara'
Brought up 24 CPUs
Testing NMI watchdog ... OK.
devtmpfs: initialized
ldc.c:v1.1 (July 22, 2008)
ldc: Domaining disabled.
NET: Registered protocol family 16
VIO: Adding device channel-devices
VIO: Adding device vldc-port-0-0
VIO: Adding device vldc-port-0-1
VIO: Adding device vldc-port-0-2
VIO: Adding device vldc-port-1-0
VIO: Adding device vldc-port-3-0
VIO: Adding device vldc-port-3-8
VIO: Adding device ds-1
VIO: Adding device ds-0
pci_sun4v: Registered hvapi major[1] minor[0]
/pci@780: SUN4V PCI Bus Module
/pci@780: On NUMA node -1
/pci@780: PCI IO[e810000000] MEM[ea00000000]
/pci@780: Unable to request IOMMU resource.
/pci@780: MSI Queue first[0] num[36] count[128] devino[0x18]
/pci@780: MSI first[0] num[256] mask[0xff] width[32]
/pci@780: MSI addr32[0x7fff0000:0x10000] addr64[0x3ffff0000:0x10000]
/pci@780: MSI queues at RA [00000000fb800000]
PCI: Scanning PBM /pci@780
pci_sun4v f027de0c: PCI host bridge to bus 0000:02
pci_bus 0000:02: root bus resource [io  0xe810000000-0xe81fffffff] (bus 
address [0x0000-0xfffffff])
pci_bus 0000:02: root bus resource [mem 0xea00000000-0xea7ffeffff] (bus 
address [0x00000000-0x7ffeffff])
pci_bus 0000:02: root bus resource [bus 02-03]
/pci@7c0: SUN4V PCI Bus Module
/pci@7c0: On NUMA node -1
/pci@7c0: PCI IO[f010000000] MEM[f200000000]
/pci@7c0: Unable to request IOMMU resource.
/pci@7c0: MSI Queue first[0] num[36] count[128] devino[0x18]
/pci@7c0: MSI first[0] num[256] mask[0xff] width[32]
/pci@7c0: MSI addr32[0x7fff0000:0x10000] addr64[0x3ffff0000:0x10000]
/pci@7c0: MSI queues at RA [00000000fb900000]
PCI: Scanning PBM /pci@7c0
pci_sun4v f02891e4: PCI host bridge to bus 0001:02
pci_bus 0001:02: root bus resource [io  0xf010000000-0xf01fffffff] (bus 
address [0x0000-0xfffffff])
pci_bus 0001:02: root bus resource [mem 0xf200000000-0xf27ffeffff] (bus 
address [0x00000000-0x7ffeffff])
pci_bus 0001:02: root bus resource [bus 02-04]
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti 
<giometti@linux.it>
PTP clock support registered
ds.c:v1.0 (Jul 11, 2007)
Switched to clocksource stick
FS-Cache: Loaded
CacheFiles: Loaded
NET: Registered protocol family 2
TCP established hash table entries: 32768 (order: 6, 524288 bytes)
TCP bind hash table entries: 32768 (order: 6, 524288 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP: reno registered
UDP hash table entries: 2048 (order: 3, 65536 bytes)
UDP-Lite hash table entries: 2048 (order: 3, 65536 bytes)
NET: Registered protocol family 1
HugeTLB registered 4 MB page size, pre-allocated 0 pages
VFS: Disk quotas dquot_6.5.2
Dquot-cache hash table entries: 1024 (order 0, 8192 bytes)
msgmni has been set to 7841
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
io scheduler noop registered
io scheduler deadline registered (default)
io scheduler cfq registered
f027a810: ttyS0 at I/O 0x0 (irq = 1, base_baud = 115200) is a SUN4V HCONS
console [ttyHV0] enabled, bootconsole disabled
console [ttyHV0] enabled, bootconsole disabled
f02877c8: ttyS1 at MMIO 0xf820c2c000 (irq = 20, base_baud = 115387) is a 
ST16650V2
Loading iSCSI transport class v2.0-870.
tg3.c:v3.133 (Jul 29, 2013)
INFO: rcu_sched detected stalls on CPUs/tasks: { 0 2 3 4 6 7 8 9 10 11 
12 13 14 15 16 17 18 19 20 21 22 23} (detected by 5, tY27 jiffies, 
g446744073709551319, c446744073709551318, q09)
   CPU[  0]: TSTATE[0000000080001603] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/0:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[start_kernel+0x37c/0x38c]
   CPU[  1]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/1:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[  2]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/2:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[  3]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/3:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[  4]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/4:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
* CPU[  5]: TSTATE[0000000080001602] TPC[000000000042b5ec] 
TNPC[000000000042b5f0] TASK[swapper/5:0]
              TPC[arch_cpu_idle+0x84/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[  6]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/6:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[  7]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/7:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[  8]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/8:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[  9]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/9:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[ 10]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/10:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[ 11]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/11:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[ 12]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/12:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[ 13]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/13:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[ 14]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/14:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[ 15]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/15:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[ 16]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/16:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[ 17]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/17:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[ 18]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/18:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[ 19]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/19:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[ 20]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/20:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[ 21]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/21:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[ 22]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/22:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
   CPU[ 23]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/23:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
tg3 0001:03:04.0 eth0: Tigon3 [partno(BCM95714) rev 9001] 
(PCIX:133MHz:64-bit) MAC address 00:14:4f:6f:59:fe
tg3 0001:03:04.0 eth0: attached PHY is 5714 (10/100/1000Base-T Ethernet) 
(WireSpeed[1], EEE[0])
tg3 0001:03:04.0 eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] TSOcap[1]
tg3 0001:03:04.0 eth0: dma_rwctrl[76148000] dma_mask[32-bit]
INFO: rcu_sched self-detected stall on CPU { 0}  (tT305 jiffies 
g446744073709551320 c446744073709551319 q75)
INFO: rcu_sched self-detected stall on CPU
* CPU[  0]: TSTATE[0000000080001603] TPC[000000000042b5ec] 
TNPC[000000000042b5f0] TASK[swapper/0:0]
              TPC[arch_cpu_idle+0x84/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[start_kernel+0x37c/0x38c]
   CPU[  1]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/1:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
INFO: rcu_sched self-detected stall on CPU { 3}  (tT305 jiffies 
g446744073709551320 c446744073709551319 q75)
   CPU[  2]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/2:0]
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
INFO: rcu_sched self-detected stall on CPU
INFO: rcu_sched self-detected stall on CPU
INFO: rcu_sched self-detected stall on CPU
  {
  {
  14
  12
}
}
   CPU[  3]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/3:0]
INFO: rcu_sched self-detected stall on CPU
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
  (tT305 jiffies g446744073709551320 c446744073709551319 q75)
  (tT305 jiffies g446744073709551320 c446744073709551319 q75)
   CPU[  4]: TSTATE[0000000080001602] TPC[000000000042b5e8] 
TNPC[000000000042b5ec] TASK[swapper/4:0]
  { 9
  {
              TPC[arch_cpu_idle+0x80/0x8c] O7[arch_cpu_idle+0x6c/0x8c] 
I7[cpu_startup_entry+0xe8/0x168] RPC[0x90ee58]
.......

	This kernel is a SMP kernel. Is there any issue with this kernel ?

	Regards,

	JB

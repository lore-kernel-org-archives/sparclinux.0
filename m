From: tndave <tushar.n.dave@oracle.com>
Date: Mon, 10 Jul 2017 21:35:33 +0000
Subject: Re: sun4v+DMA related boot crash on 4.13-git
Message-Id: <9f2f5843-799d-45e6-313f-db93ae09b7aa@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1707101616110.5280@math.ut.ee>
 <42dcc4e3-a646-e29c-277b-2498c37e073f@oracle.com>
In-Reply-To: <42dcc4e3-a646-e29c-277b-2498c37e073f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Meelis Roos <mroos@linux.ee>, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>



On 07/10/2017 11:47 AM, tndave wrote:
> 
> 
> On 07/10/2017 06:20 AM, Meelis Roos wrote:
>> I tested yesterdayd 4.12+git on sparc64 to see if the sparc merge works
>> fine, and on all of my sun4v machines (T1000, T2000, T5120) it crashed
>> on boot with DMA-related stacktrace (below). Allt he machines are sun4v
>> physical machines, not VM-s. Older sun4 machines do not exhibit this
>> problem.
>>
>> Maybae DMA APi realted, maybe sparc64. Will try to bisect when I get
>> time.
> I see whats going on with panic. I will reproduce locally. Will get back 
> soon.
This patch should fix panic. Please give it a try.

commit b02c2b0bfd ("sparc: remove arch specific dma_supported 
implementations") introduced a code that incorrectly allow 
dma_supported() to succeed for 64bit dma mask even if system doesn't 
have ATU IOMMU. 64bit DMA only supported on sun4v equipped with ATU 
IOMMU HW.

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 24f21c7..0a32c57 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -673,12 +673,14 @@ static void dma_4v_unmap_sg(struct device *dev, 
struct scatterlist *sglist,
  static int dma_4v_supported(struct device *dev, u64 device_mask)
  {
         struct iommu *iommu = dev->archdata.iommu;
-       u64 dma_addr_mask;
+       u64 dma_addr_mask = iommu->dma_addr_mask;

-       if (device_mask > DMA_BIT_MASK(32) && iommu->atu)
-               dma_addr_mask = iommu->atu->dma_addr_mask;
-       else
-               dma_addr_mask = iommu->dma_addr_mask;
+       if (device_mask > DMA_BIT_MASK(32)) {
+               if (iommu->atu)
+                       dma_addr_mask = iommu->atu->dma_addr_mask;
+               else
+                       return 0;
+       }

         if ((device_mask & dma_addr_mask) = dma_addr_mask)
                 return 1;


-Tushar


> 
> -Tushar
>>
>>
>> [    0.000024] PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.d 2011/07/06 
>> 14:29'
>> [    0.000033] PROMLIB: Root node compatible: sun4v
>> [    0.000079] Linux version 4.12.0-08915-gf263fbb (mroos@t2000) (gcc 
>> version 4.9.2 (Debian 4.9.2-20)) #141 SMP Sun Jul 9 17:51:12 EEST 2017
>> [    0.002047] bootconsole [earlyprom0] enabled
>> [    0.002383] ARCH: SUN4V
>> [    0.002668] Ethernet address: 00:14:4f:86:99:26
>> [    0.003406] MM: PAGE_OFFSET is 0xffff800000000000 (max_phys_bits = 
>> 39)
>> [    0.004089] MM: VMALLOC [0x0000000100000000 --> 0x0000600000000000]
>> [    0.004562] MM: VMEMMAP [0x0000600000000000 --> 0x0000c00000000000]
>> [    0.095699] Kernel: Using 3 locked TLB entries for main kernel image.
>> [    0.096387] Remapping the kernel...
>> [    0.096400] done.
>> [    1.906342] OF stdout device is: /virtual-devices@100/console@1
>> [    1.907160] PROM: Built device tree with 148821 bytes of memory.
>> [    1.907804] MDESC: Size is 42336 bytes.
>> [    1.910139] PLATFORM: banner-name [Sun Fire T200]
>> [    1.910564] PLATFORM: name [SUNW,Sun-Fire-T200]
>> [    1.910919] PLATFORM: hostid [84869926]
>> [    1.911224] PLATFORM: serial# [00ab4130]
>> [    1.911536] PLATFORM: stick-frequency [3b9aca00]
>> [    1.911894] PLATFORM: mac-address [144f869926]
>> [    1.912241] PLATFORM: watchdog-resolution [1000 ms]
>> [    1.912619] PLATFORM: watchdog-max-timeout [31536000000 ms]
>> [    1.913042] PLATFORM: max-cpus [32]
>> [    1.913501] Top of RAM: 0x3ffd34000, Total RAM: 0x3f7918000
>> [    1.913936] Memory hole size: 132MB
>> [    2.279507] Allocated 16384 bytes for kernel page tables.
>> [    2.280578] Zone ranges:
>> [    2.280819]   Normal   [mem 0x0000000008400000-0x00000003ffd33fff]
>> [    2.281292] Movable zone start for each node
>> [    2.281626] Early memory node ranges
>> [    2.281916]   node   0: [mem 0x0000000008400000-0x00000003ffc1ffff]
>> [    2.282557]   node   0: [mem 0x00000003ffc28000-0x00000003ffcfdfff]
>> [    2.283030]   node   0: [mem 0x00000003ffd0e000-0x00000003ffd27fff]
>> [    2.283514]   node   0: [mem 0x00000003ffd2c000-0x00000003ffd33fff]
>> [    2.283994] Initmem setup node 0 [mem 
>> 0x0000000008400000-0x00000003ffd33fff]
>> [    2.782262] Booting Linux...
>> [    2.782734] CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,mul32,div32]
>> [    2.783255] CPU CAPS: [v8plus,ASIBlkInit]
>> [    2.897543] percpu: Embedded 12 pages/cpu @ffff8003ff800000 s55872 
>> r8192 d34240 u262144
>> [    2.913264] SUN4V: Mondo queue sizes [cpu(4096) dev(16384) r(8192) 
>> nr(256)]
>> [    2.915492] Built 1 zonelists in Node order, mobility grouping on.  
>> Total pages: 2063634
>> [    2.916160] Policy zone: Normal
>> [    2.916420] Kernel command line: root=/dev/sda1 ro
>> [    2.918743] PID hash table entries: 4096 (order: 2, 32768 bytes)
>> [    2.919230] Sorting __ex_table...
>> [    3.220450] Memory: 16497120K/16639072K available (5521K kernel 
>> code, 530K rwdata, 1224K rodata, 336K init, 699K bss, 141952K 
>> reserved, 0K cma-reserved)
>> [    3.223109] Hierarchical RCU implementation.
>> [    3.223452]     RCU restricting CPUs from NR_CPUS%6 to 
>> nr_cpu_ids.
>> [    3.223933] RCU: Adjusting geometry for rcu_fanout_leaf, 
>> nr_cpu_ids
>> [    3.225508] NR_IRQS: 2048, nr_irqs: 2048, preallocated irqs: 1
>> [    3.225975] SUN4V: Using IRQ API major 1, cookie only virqs disabled
>> [    3.227643] clocksource: stick: mask: 0xffffffffffffffff 
>> max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
>> [    3.228400] clocksource: mult[800000] shift[23]
>> [    3.228755] clockevent: mult[80000000] shift[31]
>> [    3.230304] Console: colour dummy device 80x25
>> [    3.230662] console [tty0] enabled
>> [    3.230948] bootconsole [earlyprom0] disabled
>> [    0.000024] PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.d 2011/07/06 
>> 14:29'
>> [    0.000033] PROMLIB: Root node compatible: sun4v
>> [    0.000079] Linux version 4.12.0-08915-gf263fbb (mroos@t2000) (gcc 
>> version 4.9.2 (Debian 4.9.2-20)) #141 SMP Sun Jul 9 17:51:12 EEST 2017
>> [    0.002047] bootconsole [earlyprom0] enabled
>> [    0.002383] ARCH: SUN4V
>> [    0.002668] Ethernet address: 00:14:4f:86:99:26
>> [    0.003406] MM: PAGE_OFFSET is 0xffff800000000000 (max_phys_bits = 
>> 39)
>> [    0.004089] MM: VMALLOC [0x0000000100000000 --> 0x0000600000000000]
>> [    0.004562] MM: VMEMMAP [0x0000600000000000 --> 0x0000c00000000000]
>> [    0.095699] Kernel: Using 3 locked TLB entries for main kernel image.
>> [    0.096387] Remapping the kernel...
>> [    0.096400] done.
>> [    1.906342] OF stdout device is: /virtual-devices@100/console@1
>> [    1.907160] PROM: Built device tree with 148821 bytes of memory.
>> [    1.907804] MDESC: Size is 42336 bytes.
>> [    1.910139] PLATFORM: banner-name [Sun Fire T200]
>> [    1.910564] PLATFORM: name [SUNW,Sun-Fire-T200]
>> [    1.910919] PLATFORM: hostid [84869926]
>> [    1.911224] PLATFORM: serial# [00ab4130]pci_sun4v: Could not register hvapi ATU err=-22
>> [    1.911536] PLATFORM: stick-frequency [3b9aca00]
>> [    1.911894] PLATFORM: mac-address [144f869926]
>> [    1.912241] PLATFORM: watchdog-resolution [1000 ms]
>> [    1.912619] PLATFORM: watchdog-max-timeout [31536000000 ms]
>> [    1.913042] PLATFORM: max-cpus [32]
>> [    1.913501] Top of RAM: 0x3ffd34000, Total RAM: 0x3f7918000
>> [    1.913936] Memory hole size: 132MB
>> [    2.279507] Allocated 16384 bytes for kernel page tables.
>> [    2.280578] Zone ranges:
>> [    2.280819]   Normal   [mem 0x0000000008400000-0x00000003ffd33fff]
>> [    2.281292] Movable zone start for each node
>> [    2.281626] Early memory node ranges
>> [    2.281916]   node   0: [mem 0x0000000008400000-0x00000003ffc1ffff]
>> [    2.282557]   node   0: [mem 0x00000003ffc28000-0x00000003ffcfdfff]
>> [    2.283030]   node   0: [mem 0x00000003ffd0e000-0x00000003ffd27fff]
>> [    2.283514]   node   0: [mem 0x00000003ffd2c000-0x00000003ffd33fff]
>> [    2.283994] Initmem setup node 0 [mem 
>> 0x0000000008400000-0x00000003ffd33fff]
>> [    2.782262] Booting Linux...
>> [    2.782734] CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,mul32,div32]
>> [    2.783255] CPU CAPS: [v8plus,ASIBlkInit]
>> [    2.897543] percpu: Embedded 12 pages/cpu @ffff8003ff800000 s55872 
>> r8192 d34240 u262144
>> [    2.913264] SUN4V: Mondo queue sizes [cpu(4096) dev(16384) r(8192) 
>> nr(256)]
>> [    2.915492] Built 1 zonelists in Node order, mobility grouping on.  
>> Total pages: 2063634
>> [    2.916160] Policy zone: Normal
>> [    2.916420] Kernel command line: root=/dev/sda1 ro
>> [    2.918743] PID hash table entries: 4096 (order: 2, 32768 bytes)
>> [    2.919230] Sorting __ex_table...
>> [    3.220450] Memory: 16497120K/16639072K available (5521K kernel 
>> code, 530K rwdata, 1224K rodata, 336K init, 699K bss, 141952K 
>> reserved, 0K cma-reserved)pci_sun4v: Could not register hvapi ATU err=-22
>> [    3.223109] Hierarchical RCU implementation.
>> [    3.223452]     RCU restricting CPUs from NR_CPUS%6 to 
>> nr_cpu_ids.
>> [    3.223933] RCU: Adjusting geometry for rcu_fanout_leaf, 
>> nr_cpu_ids
>> [    3.225508] NR_IRQS: 2048, nr_irqs: 2048, preallocated irqs: 1
>> [    3.225975] SUN4V: Using IRQ API major 1, cookie only virqs disabled
>> [    3.227643] clocksource: stick: mask: 0xffffffffffffffff 
>> max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
>> [    3.228400] clocksource: mult[800000] shift[23]
>> [    3.228755] clockevent: mult[80000000] shift[31]
>> [    3.230304] Console: colour dummy device 80x25
>> [    3.230662] console [tty0] enabled
>> [    3.230948] bootconsole [earlyprom0] disabled
>> [    3.309471] Calibrating delay using timer specific routine.. 
>> 2014.88 BogoMIPS (lpj@29765)
>> [    3.309507] pid_max: default: 32768 minimum: 301
>> [    3.309791] Security Framework initialized
>> [    3.327582] Dentry cache hash table entries: 2097152 (order: 11, 
>> 16777216 bytes)
>> [    3.336474] Inode-cache hash table entries: 1048576 (order: 10, 
>> 8388608 bytes)
>> [    3.336834] Mount-cache hash table entries: 32768 (order: 5, 262144 
>> bytes)
>> [    3.337143] Mountpoint-cache hash table entries: 32768 (order: 5, 
>> 262144 bytes)
>> [    3.339484] Hierarchical SRCU implementation.
>> [    3.341250] smp: Bringing up secondary CPUs ...
>> [    3.362204] smp: Brought up 1 node, 16 CPUs
>> [    3.365605] devtmpfs: initialized
>> [    3.373758] Performance events:
>> [    3.373796] Testing NMI watchdog ...
>> [    3.453874] OK.
>> [    3.453914] Supported PMU type is 'niagara'
>> [    3.454420] ldc.c:v1.1 (July 22, 2008)
>> [    3.454439] ldc: Domaining disabled.
>> [    3.454906] clocksource: jiffies: mask: 0xffffffff max_cycles: 
>> 0xffffffff, max_idle_ns: 7645041785100000 ns
>> [    3.455041] futex hash table entries: 4096 (order: 5, 262144 bytes)
>> [    3.456859] NET: Registered protocol family 16
>> [    3.471474] VIO: Adding device channel-devices (tx_ino = 
>> ffffffffffffffff, rx_ino = ffffffffffffffff)
>> [    3.471707] VIO: Adding device vldc-port-0-0 (tx_ino = 0, rx_ino = 1)
>> [    3.471883] VIO: Adding device vldc-port-0-1 (tx_ino = 2, rx_ino = 3)
>> [    3.472070] VIO: Adding device vldc-port-0-2 (tx_ino = 6, rx_ino = 7)
>> [    3.472247] VIO: Adding device vldc-port-1-0 (tx_ino = 8, rx_ino = 9)
>> [    3.472431] VIO: Adding device vldc-port-3-0 (tx_ino = 28, rx_ino = 
>> 29)
>> [    3.472613] VIO: Adding device vldc-port-3-8 (tx_ino = 1a, rx_ino = 
>> 1b)
>> [    3.472806] VIO: Adding device domain-services-port-1 (tx_ino = 2e, 
>> rx_ino = 2f)
>> [    3.473032] VIO: Adding device domain-services-port-0 (tx_ino = 4, 
>> rx_ino = 5)
>> [    3.483410] pci_sun4v: Registered hvapi major[1] minor[0]
>> [    3.483468] pci_sun4v: Could not register hvapi ATU err=-22
>> [    3.483660] /pci@780: SUN4V PCI Bus Module
>> [    3.483712] /pci@780: On NUMA node -1
>> [    3.483765] /pci@780: PCI IO[e810000000] MEM[ea00000000]
>> [    3.483770]  MEM64[ec00000000]
>> [    3.483820]
>> [    3.483919] /pci@780: Unable to request IOMMU resource.
>> [    3.534438] /pci@780: MSI Queue first[0] num[36] count[128] 
>> devino[0x18]
>> [    3.534504] /pci@780: MSI first[0] num[256] mask[0xff] width[32]
>> [    3.534584] /pci@780: MSI addr32[0x7fff0000:0x10000] 
>> addr64[0x3ffff0000:0x10000]
>> [    3.534676] /pci@780: MSI queues at RA [00000003f1d00000]
>> [    3.534733] PCI: Scanning PBM /pci@780
>> [    3.535009] pci_sun4v f027e92c: PCI host bridge to bus 0000:02
>> [    3.535080] pci_bus 0000:02: root bus resource [io  
>> 0xe810000000-0xe81fffffff] (bus address [0x0000-0xfffffff])
>> [    3.535186] pci_bus 0000:02: root bus resource [mem 
>> 0xea00000000-0xea7ffeffff] (bus address [0x00000000-0x7ffeffff])
>> [    3.535298] pci_bus 0000:02: root bus resource [mem 
>> 0xec00000000-0xeffffeffff] (bus address [0x200000000-0x5fffeffff])
>> [    3.535401] pci_bus 0000:02: root bus resource [bus 02-07]
>> [    3.543213] /pci@7c0: SUN4V PCI Bus Module
>> [    3.543268] /pci@7c0: On NUMA node -1
>> [    3.543322] /pci@7c0: PCI IO[f010000000] MEM[f200000000]
>> [    3.543326]  MEM64[f400000000]
>> [    3.543377]
>> [    3.543476] /pci@7c0: Unable to request IOMMU resource.
>> [    3.593995] /pci@7c0: MSI Queue first[0] num[36] count[128] 
>> devino[0x18]
>> [    3.594060] /pci@7c0: MSI first[0] num[256] mask[0xff] width[32]
>> [    3.594116] /pci@7c0: MSI addr32[0x7fff0000:0x10000] 
>> addr64[0x3ffff0000:0x10000]
>> [    3.594205] /pci@7c0: MSI queues at RA [00000003f1e00000]
>> [    3.594261] PCI: Scanning PBM /pci@7c0
>> [    3.594538] pci_sun4v f0287174: PCI host bridge to bus 0001:02
>> [    3.594609] pci_bus 0001:02: root bus resource [io  
>> 0xf010000000-0xf01fffffff] (bus address [0x0000-0xfffffff])
>> [    3.594721] pci_bus 0001:02: root bus resource [mem 
>> 0xf200000000-0xf27ffeffff] (bus address [0x00000000-0x7ffeffff])
>> [    3.594827] pci_bus 0001:02: root bus resource [mem 
>> 0xf400000000-0xf7fffeffff] (bus address [0x200000000-0x5fffeffff])
>> [    3.594955] pci_bus 0001:02: root bus resource [bus 02-09]
>> [    3.606120] pci 0001:05:02.0: can't claim BAR 0 [io  
>> 0xf010000000-0xf01000ffff]: no compatible bridge window
>> [    3.612721] HugeTLB registered 8 MB page size, pre-allocated 0 pages
>> [    3.615102] vgaarb: loaded
>> [    3.615570] SCSI subsystem initialized
>> [    3.617634] ds.c:v1.0 (Jul 11, 2007)
>> [    3.618074] clocksource: Switched to clocksource stick
>> [    3.692013] VFS: Disk quotas dquot_6.6.0
>> [    3.692220] VFS: Dquot-cache hash table entries: 1024 (order 0, 
>> 8192 bytes)
>> [    3.706128] NET: Registered protocol family 2
>> [    3.707660] TCP established hash table entries: 131072 (order: 7, 
>> 1048576 bytes)
>> [    3.711826] TCP bind hash table entries: 65536 (order: 7, 1048576 
>> bytes)
>> [    3.715734] TCP: Hash tables configured (established 131072 bind 
>> 65536)
>> [    3.716217] UDP hash table entries: 8192 (order: 5, 262144 bytes)
>> [    3.717567] UDP-Lite hash table entries: 8192 (order: 5, 262144 bytes)
>> [    3.719443] NET: Registered protocol family 1
>> [    3.719775] pci 0001:05:02.0: Activating ISA DMA hang workarounds
>> [    3.841387] audit: initializing netlink subsys (disabled)
>> [    3.841702] audit: type 00 audit(0.607:1): state=initialized 
>> audit_enabled=0 res=1
>> [    3.842350] workingset: timestamp_bitsX max_order! bucket_order=0
>> [    3.851636] Block layer SCSI generic (bsg) driver version 0.4 
>> loaded (major 252)
>> [    3.851733] io scheduler noop registered
>> [    3.851785] io scheduler deadline registered
>> [    3.851915] io scheduler cfq registered (default)
>> [    3.851971] io scheduler mq-deadline registered
>> [    3.861058] f027a9b0: ttyS0 at I/O 0x0 (irq = 1, base_baud = 
>> 115200) is a SUN4V HCONS
>> [    4.422839] console [ttyHV0] enabled
>> [    4.424326] f02bd6ec: ttyS1 at MMIO 0xf0100003f8 (irq = 25, 
>> base_baud = 115387) is a 16550A
>> [    4.432085] Fusion MPT base driver 3.04.20
>> [    4.432153] Copyright (c) 1999-2008 LSI Corporation
>> [    4.432236] Fusion MPT SAS Host driver 3.04.20
>> [    4.469902] mptbase: ioc0: Initiating bringup
>> [    5.470093] ioc0: LSISAS1064E B1: Capabilities={Initiator}
>> [    5.470792] Unable to handle kernel NULL pointer dereference
>> [    5.470922] tsk->{mm,active_mm}->context = 0000000000000000
>> [    5.470999] tsk->{mm,active_mm}->pgd = ffff800008802000
>> [    5.471075]               \|/ ____ \|/
>> [    5.471075]               "@'/ .. \`@"
>> [    5.471075]               /_| \__/ |_\
>> [    5.471075]                  \__U_/
>> [    5.471302] swapper/0(1): Oops [#1]
>> [    5.471371] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 
>> 4.12.0-08915-gf263fbb #141
>> [    5.471489] task: ffff8003f1647320 task.stack: ffff8003f1648000
>> [    5.471570] TSTATE: 0000000080001602 TPC: 000000000074becc TNPC: 
>> 000000000074bed0 Y: 00000000    Not tainted
>> [    5.471709] TPC: <iommu_tbl_range_alloc+0xc/0x3e0>
>> [    5.471777] g0: ffff80000841fc00 g1: 0000000000000000 g2: 
>> ffff8003f1ccb800 g3: 0000000001080020
>> [    5.471896] g4: ffff8003f1647320 g5: ffff8003fed90000 g6: 
>> ffff8003f1648000 g7: 00000000000000e2
>> [    5.472016] o0: ffff8003f1cfd0a0 o1: 0000000000000027 o2: 
>> ffff8003f164b348 o3: 0000000001080020
>> [    5.472135] o4: 0000000000000000 o5: 0000000000000000 sp: 
>> ffff8003f164a8d1 ret_pc: 00000000007e0c48
>> [    5.472265] RPC: <PrimeIocFifos+0x2c8/0xa00>
>> [    5.472333] l0: 0000000000000006 l1: ffffffffffffffff l2: 
>> 0000000000000010 l3: ffff8003ee400000
>> [    5.472453] l4: ffff8003ee400000 l5: 0000000000002000 l6: 
>> 0000000000800700 l7: 00000000f025cfd8
>> [    5.472572] i0: ffff8003f1cfd0a0 i1: 0000000000000010 i2: 
>> 0000000000000027 i3: 0000000000000000
>> [    5.472692] i4: ffffffffffffffff i5: 0000000000000000 i6: 
>> ffff8003f164a9d1 i7: 00000000004476f8
>> [    5.472817] I7: <dma_4v_alloc_coherent+0x158/0x2e0>
>> [    5.472880] Call Trace:
>> [    5.472948]  [00000000004476f8] dma_4v_alloc_coherent+0x158/0x2e0
>> [    5.473034]  [00000000007e0c48] PrimeIocFifos+0x2c8/0xa00
>> [    5.473121]  [00000000007e74fc] mpt_do_ioc_recovery+0x5fc/0x1700
>> [    5.473207]  [00000000007e9040] mpt_attach+0x480/0xc60
>> [    5.473293]  [00000000007f4248] mptsas_probe+0x8/0x440
>> [    5.473381]  [000000000075c390] local_pci_probe+0x30/0xa0
>> [    5.473465]  [000000000075ca08] pci_device_probe+0xa8/0x140
>> [    5.473552]  [00000000007a7820] driver_probe_device+0x240/0x300
>> [    5.473635]  [00000000007a7990] __driver_attach+0xb0/0xc0
>> [    5.473717]  [00000000007a5954] bus_for_each_dev+0x54/0xa0
>> [    5.473799]  [00000000007a6d04] bus_add_driver+0x1a4/0x240
>> [    5.473882]  [00000000007a806c] driver_register+0x6c/0x100
>> [    5.473970]  [0000000000b5615c] mptsas_init+0x110/0x138
>> [    5.474052]  [0000000000426cd0] do_one_initcall+0x30/0x160
>> [    5.474165]  [0000000000b2aba8] kernel_init_freeable+0x194/0x224
>> [    5.474254]  [0000000000962de4] kernel_init+0x4/0x120
>> [    5.474329] Disabling lock debugging due to kernel taint
>> [    5.474414] Caller[00000000004476f8]: 
>> dma_4v_alloc_coherent+0x158/0x2e0
>> [    5.474502] Caller[00000000007e0c48]: PrimeIocFifos+0x2c8/0xa00
>> [    5.474590] Caller[00000000007e74fc]: mpt_do_ioc_recovery+0x5fc/0x1700
>> [    5.474678] Caller[00000000007e9040]: mpt_attach+0x480/0xc60
>> [    5.474762] Caller[00000000007f4248]: mptsas_probe+0x8/0x440
>> [    5.474848] Caller[000000000075c390]: local_pci_probe+0x30/0xa0
>> [    5.474933] Caller[000000000075ca08]: pci_device_probe+0xa8/0x140
>> [    5.475018] Caller[00000000007a7820]: driver_probe_device+0x240/0x300
>> [    5.475103] Caller[00000000007a7990]: __driver_attach+0xb0/0xc0
>> [    5.475186] Caller[00000000007a5954]: bus_for_each_dev+0x54/0xa0
>> [    5.475269] Caller[00000000007a6d04]: bus_add_driver+0x1a4/0x240
>> [    5.475353] Caller[00000000007a806c]: driver_register+0x6c/0x100
>> [    5.475439] Caller[0000000000b5615c]: mptsas_init+0x110/0x138
>> [    5.475521] Caller[0000000000426cd0]: do_one_initcall+0x30/0x160
>> [    5.475603] Caller[0000000000b2aba8]: kernel_init_freeable+0x194/0x224
>> [    5.475689] Caller[0000000000962de4]: kernel_init+0x4/0x120
>> [    5.475776] Caller[0000000000406064]: ret_from_fork+0x1c/0x2c
>> [    5.475854] Caller[0000000000000000]:           (null)
>> [    5.475928] Instruction DUMP:
>> [    5.475933]  9de3bf00
>> [    5.475994]  80a6a00f
>> [    5.476053]  82102000
>> [    5.476112] <c4066228>
>> [    5.476171]  83673001
>> [    5.476231]  a0102000
>> [    5.476289]  f477a88f
>> [    5.476348]  82088001
>> [    5.476408]  f677a897
>> [    5.476466]
>> [    5.476600] Kernel panic - not syncing: Attempted to kill init! 
>> exitcode=0x00000009
>> [    5.476600]
>> [    5.476845] OOPS: Bogus kernel PC [0000000000000f00] in fault handler
>> [    5.476850] OOPS: RPC [000000000042c6c0]
>> [    5.476865] OOPS: RPC <arch_cpu_idle+0x60/0xa0>
>> [    5.476869] OOPS: Fault was to vaddr[f00]
>> [    5.476879] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D         
>> 4.12.0-08915-gf263fbb #141
>> [    5.476883] Call Trace:
>> [    5.476899]  [0000000000457368] do_sparc64_fault+0x3c8/0x780
>> [    5.476910]  [0000000000407c1c] sparc64_realfault_common+0x10/0x20
>> [    5.476917]  [0000000000000f00] 0xf00
>> [    5.476927]  [00000000004a8d24] do_idle+0xc4/0x180
>> [    5.476936]  [00000000004a8ffc] cpu_startup_entry+0x1c/0x40
>> [    5.476945]  [0000000000b2aa04] start_kernel+0x410/0x420
>> [    5.476956]  [0000000000962d0c] tlb_fixup_done+0x4c/0x60
>> [    5.476961]  [0000000000000000]           (null)
>> [    5.476965] Unable to handle kernel NULL pointer dereference
>> [    5.476969] tsk->{mm,active_mm}->context = 0000000000000000
>> [    5.476973] tsk->{mm,active_mm}->pgd = ffff800008802000
>> [    5.476977]               \|/ ____ \|/
>> [    5.476977]               "@'/ .. \`@"
>> [    5.476977]               /_| \__/ |_\
>> [    5.476977]                  \__U_/
>> [    5.476981] swapper/0(0): Oops [#2]
>> [    5.476991] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D         
>> 4.12.0-08915-gf263fbb #141
>> [    5.476997] task: 0000000000ab38c0 task.stack: 0000000000a9c000
>> [    5.477006] TSTATE: 0000004480001604 TPC: 0000000000000f00 TNPC: 
>> 0000000000000f04 Y: 00000000    Tainted: G      D
>> [    5.477011] TPC: <0xf00>
>> [    5.477017] g0: 0000000000000008 g1: 0000000000000016 g2: 
>> 00000000f0200000 g3: 00000000fff78000
>> [    5.477024] g4: 0000000000005a20 g5: ffff8003fec90000 g6: 
>> 0000000000a9c000 g7: 0000000004004000
>> [    5.477030] o0: 0000000000000f00 o1: 0000000000000000 o2: 
>> 0000000000000000 o3: 0000000000000000
>> [    5.477037] o4: 0000000000000000 o5: 0000000000000000 sp: 
>> 0000000000a9f461 ret_pc: 000000000042c6c0
>> [    5.477047] RPC: <arch_cpu_idle+0x60/0xa0>
>> [    5.477055] l0: 0000000040004190 l1: 000000004000407c l2: 
>> 0000000040004059 l3: 0000000000000040
>> [    5.477061] l4: 00000000f027e7f8 l5: 0000000040004128 l6: 
>> 0000000000140008 l7: 00000000f025cfd8
>> [    5.477068] i0: 000000000000000e i1: 0000000000a9c008 i2: 
>> 0000000000004000 i3: 0000000000000f00
>> [    5.477074] i4: 00000000fef42ff8 i5: 00000000fef41800 i6: 
>> 0000000000a9f511 i7: 00000000004a8d24
>> [    5.477082] I7: <do_idle+0xc4/0x180>
>> [    5.477085] Call Trace:
>> [    5.477094]  [00000000004a8d24] do_idle+0xc4/0x180
>> [    5.477102]  [00000000004a8ffc] cpu_startup_entry+0x1c/0x40
>> [    5.477111]  [0000000000b2aa04] start_kernel+0x410/0x420
>> [    5.477121]  [0000000000962d0c] tlb_fixup_done+0x4c/0x60
>> [    5.477126]  [0000000000000000]           (null)
>> [    5.477135] Caller[00000000004a8d24]: do_idle+0xc4/0x180
>> [    5.477143] Caller[00000000004a8ffc]: cpu_startup_entry+0x1c/0x40
>> [    5.477152] Caller[0000000000b2aa04]: start_kernel+0x410/0x420
>> [    5.477161] Caller[0000000000962d0c]: tlb_fixup_done+0x4c/0x60
>> [    5.477166] Caller[0000000000000000]:           (null)
>> [    5.477168] Instruction DUMP:
>> [    5.477176] Unable to handle kernel NULL pointer dereference
>> [    5.477180] tsk->{mm,active_mm}->context = 0000000000000000
>> [    5.477184] tsk->{mm,active_mm}->pgd = ffff800008802000
>> [    5.477188]               \|/ ____ \|/
>> [    5.477188]               "@'/ .. \`@"
>> [    5.477188]               /_| \__/ |_\
>> [    5.477188]                  \__U_/
>> [    5.477193] swapper/0(0): Oops [#3]
>> [    5.477202] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D         
>> 4.12.0-08915-gf263fbb #141
>> [    5.477208] task: 0000000000ab38c0 task.stack: 0000000000a9c000
>> [    5.477217] TSTATE: 0000008880001600 TPC: 0000000000428a28 TNPC: 
>> 0000000000428a2c Y: 00000000    Tainted: G      D
>> [    5.477225] TPC: <die_if_kernel+0x288/0x300>
>> [    5.477232] g0: 0000000000a9ff40 g1: 0000000000a10000 g2: 
>> 0000000000000000 g3: 0000000000bc1fdc
>> [    5.477239] g4: 0000000000ab38c0 g5: ffff8003fec90000 g6: 
>> 0000000000a9c000 g7: 000000000000000e
>> [    5.477245] o0: 0000000000a10340 o1: 0000000000000000 o2: 
>> 0000000000000000 o3: 0000000000000001
>> [    5.477252] o4: 0000000000a9c000 o5: 0000000000003f40 sp: 
>> 0000000000a9f0c1 ret_pc: 0000000000428a0c
>> [    5.477259] RPC: <die_if_kernel+0x26c/0x300>
>> [    5.477266] l0: 0000000000a9cb80 l1: 0000000000b8e800 l2: 
>> 0000000000000000 l3: 0000000000b8e000
>> [    5.477273] l4: 0000000000a9ff40 l5: 0000000000000f00 l6: 
>> 0000000000a9c000 l7: 0000000080001005
>> [    5.477279] i0: 0000000000a9c000 i1: 0000000000a9fbc0 i2: 
>> 0000000000000ef4 i3: fffffffffffffffe
>> [    5.477286] i4: 0000000000a10340 i5: 0000000000000f00 i6: 
>> 0000000000a9f1a1 i7: 00000000004577a4
>> [    5.477297] I7: <unhandled_fault+0x84/0xa0>
>> [    5.477300] Call Trace:
>> [    5.477310]  [00000000004577a4] unhandled_fault+0x84/0xa0
>> [    5.477319]  [0000000000457378] do_sparc64_fault+0x3d8/0x780
>> [    5.477329]  [0000000000407c1c] sparc64_realfault_common+0x10/0x20
>> [    5.477335]  [0000000000000f00] 0xf00
>> [    5.477344]  [00000000004a8d24] do_idle+0xc4/0x180
>> [    5.477353]  [00000000004a8ffc] cpu_startup_entry+0x1c/0x40
>> [    5.477361]  [0000000000b2aa04] start_kernel+0x410/0x420
>> [    5.477372]  [0000000000962d0c] tlb_fixup_done+0x4c/0x60
>> [    5.477376]  [0000000000000000]           (null)
>> [    5.477388] Caller[00000000004577a4]: unhandled_fault+0x84/0xa0
>> [    5.477398] Caller[0000000000457378]: do_sparc64_fault+0x3d8/0x780
>> [    5.477407] Caller[0000000000407c1c]: 
>> sparc64_realfault_common+0x10/0x20
>> [    5.477419] Caller[000000000042c6c0]: arch_cpu_idle+0x60/0xa0
>> [    5.477428] Caller[00000000004a8d24]: do_idle+0xc4/0x180
>> [    5.477437] Caller[00000000004a8ffc]: cpu_startup_entry+0x1c/0x40
>> [    5.477446] Caller[0000000000b2aa04]: start_kernel+0x410/0x420
>> [    5.477456] Caller[0000000000962d0c]: tlb_fixup_done+0x4c/0x60
>> [    5.477461] Caller[0000000000000000]:           (null)
>> [    5.477463] Instruction DUMP:
>> [    5.477467]  80a6e001
>> [    5.477470]  02400014
>> [    5.477474]  9010001c
>> [    5.477478] <d4068000>
>> [    5.477481]  92102020
>> [    5.477485]  40023bb4
>> [    5.477489]  96102020
>> [    5.477492]  80a6e006
>> [    5.477496]  0247ffec
>> [    5.477499]
>> [    5.496882] OOPS: Bogus kernel PC [0000000000000740] in fault handler
>> [    5.496887] OOPS: RPC [000000000042c6c0]
>> [    5.496899] OOPS: RPC <arch_cpu_idle+0x60/0xa0>
>> [    5.496904] OOPS: Fault was to vaddr[740]
>> [    5.496914] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         
>> 4.12.0-08915-gf263fbb #141
>> [    5.496917] Call Trace:
>> [    5.496931]  [0000000000457368] do_sparc64_fault+0x3c8/0x780
>> [    5.496942]  [0000000000407c1c] sparc64_realfault_common+0x10/0x20
>> [    5.496948]  [0000000000000740] 0x740
>> [    5.496958]  [00000000004a8d24] do_idle+0xc4/0x180
>> [    5.496967]  [00000000004a8ffc] cpu_startup_entry+0x1c/0x40
>> [    5.496974]  [0000000000aba494] 0xaba494
>> [    5.496979]  [0000000000000000]           (null)
>> [    5.496983] Unable to handle kernel NULL pointer dereference
>> [    5.496987] tsk->{mm,active_mm}->context = 0000000000000000
>> [    5.496992] tsk->{mm,active_mm}->pgd = ffff800008802000
>> [    5.496996]               \|/ ____ \|/
>> [    5.496996]               "@'/ .. \`@"
>> [    5.496996]               /_| \__/ |_\
>> [    5.496996]                  \__U_/
>> [    5.497001] swapper/1(0): Oops [#4]
>> [    5.497012] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         
>> 4.12.0-08915-gf263fbb #141
>> [    5.497018] task: ffff8003f1685140 task.stack: ffff8003f1698000
>> [    5.497027] TSTATE: 0000004480001603 TPC: 0000000000000740 TNPC: 
>> 0000000000000744 Y: 00000000    Tainted: G      D
>> [    5.497033] TPC: <0x740>
>> [    5.497040] g0: 0000000000000000 g1: 0000000000000016 g2: 
>> 00000000f0200000 g3: 00000000fff78000
>> [    5.497048] g4: 0000000000005a20 g5: ffff8003fecd0000 g6: 
>> ffff8003f1698000 g7: 0000000003004000
>> [    5.497055] o0: 0000000000000740 o1: 0000000000000000 o2: 
>> 0000000000000000 o3: 0000000000000000
>> [    5.497063] o4: 0000000000000000 o5: 0000000000000000 sp: 
>> ffff8003f169b531 ret_pc: 000000000042c6c0
>> [    5.497074] RPC: <arch_cpu_idle+0x60/0xa0>
>> [    5.497082] l0: 0000000000b93e20 l1: 0000000000005a10 l2: 
>> 0000000000000011 l3: 0000000000400000
>> [    5.497089] l4: 80000000088007c3 l5: 0000000000000003 l6: 
>> 0000000000000003 l7: 0000000000000000
>> [    5.497096] i0: 000000000000000e i1: ffff8003f1698008 i2: 
>> 0000000000004000 i3: 0000000000000740
>> [    5.497104] i4: 00000000fef48ff8 i5: 00000000fef47800 i6: 
>> ffff8003f169b5e1 i7: 00000000004a8d24
>> [    5.497112] I7: <do_idle+0xc4/0x180>
>> [    5.497116] Call Trace:
>> [    5.497125]  [00000000004a8d24] do_idle+0xc4/0x180
>> [    5.497134]  [00000000004a8ffc] cpu_startup_entry+0x1c/0x40
>> [    5.497141]  [0000000000aba494] 0xaba494
>> [    5.497146]  [0000000000000000]           (null)
>> [    5.497155] Caller[00000000004a8d24]: do_idle+0xc4/0x180
>> [    5.497165] Caller[00000000004a8ffc]: cpu_startup_entry+0x1c/0x40
>> [    5.497172] Caller[0000000000aba494]: 0xaba494
>> [    5.497176] Caller[0000000000000000]:           (null)
>> [    5.497179] Instruction DUMP:
>> [    5.497186] Unable to handle kernel NULL pointer dereference
>> [    5.497191] tsk->{mm,active_mm}->context = 0000000000000000
>> [    5.497195] tsk->{mm,active_mm}->pgd = ffff800008802000
>> [    5.497199]               \|/ ____ \|/
>> [    5.497199]               "@'/ .. \`@"
>> [    5.497199]               /_| \__/ |_\
>> [    5.497199]                  \__U_/
>> [    5.497204] swapper/1(0): Oops [#5]
>> [    5.497215] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D         
>> 4.12.0-08915-gf263fbb #141
>> [    5.497222] task: ffff8003f1685140 task.stack: ffff8003f1698000
>> [    5.497231] TSTATE: 0000008880001607 TPC: 0000000000428a28 TNPC: 
>> 0000000000428a2c Y: 00000000    Tainted: G      D
>> [    5.497240] TPC: <die_if_kernel+0x288/0x300>
>> [    5.497248] g0: ffff8003f169bf40 g1: 0000000000a10000 g2: 
>> 0000000000000000 g3: 0000000000bc1fdc
>> [    5.497256] g4: ffff8003f1685140 g5: ffff8003fecd0000 g6: 
>> ffff8003f1698000 g7: 000000000000000e
>> [    5.497262] o0: 0000000000a10340 o1: 0000000000000000 o2: 
>> 0000000000000000 o3: 0000000000000001
>> [    5.497270] o4: ffff8003f1698000 o5: 0000000000003f40 sp: 
>> ffff8003f169b191 ret_pc: 0000000000428a0c
>> [    5.497279] RPC: <die_if_kernel+0x26c/0x300>
>> [    5.497287] l0: ffff8003f1698b80 l1: 0000000000b8e800 l2: 
>> 0000000000000000 l3: 0000000000b8e000
>> [    5.497295] l4: ffff8003f169bf40 l5: 0000000000000740 l6: 
>> ffff8003f1698000 l7: 0000000080001004
>> [    5.497302] i0: ffff8003f1698000 i1: ffff8003f169bc90 i2: 
>> 0000000000000734 i3: fffffffffffffffe
>> [    5.497310] i4: 0000000000a10340 i5: 0000000000000740 i6: 
>> ffff8003f169b271 i7: 00000000004577a4
>> [    5.497321] I7: <unhandled_fault+0x84/0xa0>
>> [    5.497325] Call Trace:
>> [    5.497336]  [00000000004577a4] unhandled_fault+0x84/0xa0
>> [    5.497346]  [0000000000457378] do_sparc64_fault+0x3d8/0x780
>> [    5.497357]  [0000000000407c1c] sparc64_realfault_common+0x10/0x20
>> [    5.497363]  [0000000000000740] 0x740
>> [    5.497373]  [00000000004a8d24] do_idle+0xc4/0x180
>> [    5.497383]  [00000000004a8ffc] cpu_startup_entry+0x1c/0x40
>> [    5.497389]  [0000000000aba494] 0xaba494
>> [    5.497394]  [0000000000000000]           (null)
>> [    5.497406] Caller[00000000004577a4]: unhandled_fault+0x84/0xa0
>> [    5.497417] Caller[0000000000457378]: do_sparc64_fault+0x3d8/0x780
>> [    5.497427] Caller[0000000000407c1c]: 
>> sparc64_realfault_common+0x10/0x20
>> [    5.497440] Caller[000000000042c6c0]: arch_cpu_idle+0x60/0xa0
>> [    5.497450] Caller[00000000004a8d24]: do_idle+0xc4/0x180
>> [    5.497460] Caller[00000000004a8ffc]: cpu_startup_entry+0x1c/0x40
>> [    5.497467] Caller[0000000000aba494]: 0xaba494
>> [    5.497471] Caller[0000000000000000]:           (null)
>> [    5.497474] Instruction DUMP:
>> [    5.497478]  80a6e001
>> [    5.497481]  02400014
>> [    5.497485]  9010001c
>> [    5.497489] <d4068000>
>> [    5.497493]  92102020
>> [    5.497497]  40023bb4
>> [    5.497501]  96102020
>> [    5.497505]  80a6e006
>> [    5.497509]  0247ffec
>> [    5.497511]
>> [    5.516924] OOPS: Bogus kernel PC [00000000000005c0] in fault handler
>> [    5.516929] OOPS: RPC [000000000042c6c0]
>> [    5.516943] OOPS: RPC <arch_cpu_idle+0x60/0xa0>
>> [    5.516948] OOPS: Fault was to vaddr[5c0]
>> [    5.516960] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D         
>> 4.12.0-08915-gf263fbb #141
>> [    5.516964] Call Trace:
>> [    5.516980]  [0000000000457368] do_sparc64_fault+0x3c8/0x780
>> [    5.516993]  [0000000000407c1c] sparc64_realfault_common+0x10/0x20
>> [    5.517001]  [00000000000005c0] 0x5c0
>> [    5.517012]  [00000000004a8d24] do_idle+0xc4/0x180
>> [    5.517024]  [00000000004a8ffc] cpu_startup_entry+0x1c/0x40
>> [    5.517032]  [0000000000aba494] 0xaba494
>> [    5.517038]  [0000000000000000]           (null)
>> [    5.517042] Unable to handle kernel NULL pointer dereference
>> [    5.517048] tsk->{mm,active_mm}->context = 0000000
>>
> -- 
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

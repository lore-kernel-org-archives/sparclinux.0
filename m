From: Jan Engelhardt <jengelh@inai.de>
Date: Mon, 25 Dec 2017 00:13:56 +0000
Subject: T1 regression - only 16 threads of 24 are activated
Message-Id: <nycvar.YFH.7.76.1712250037260.22715@n3.vanv.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Greetings.


Starting with commit v4.12-rc4-1-g9289ea7, a 24-thread T1 CPU only gets 
16 threads activated. This problem persists as of commit v4.15-rc5.


commit 9289ea7f952b14ef2627edc49f9508234952a85e
Author: David S. Miller <davem@davemloft.net>
Date:   Thu Jun 22 10:56:48 2017 -0400

    sparc64: Use indirect calls in hamming weight stubs

    Otherwise, depending upon link order, the branch relocation
    limits could be exceeded.


The boot log changes in an interesting way which suggests that the 
hweight implementation may have a problem. All other systems I have only 
have multiples of 16 and a problem does not show.


--- T1000-good	2017-12-25 00:35:41.376359747 +0100
+++ T1000-bad	2017-12-25 00:28:45.342789166 +0100
@@ -4,7 +4,7 @@ Loaded kernel version 4.12.0
 
 PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.b 2010/07/09 13:43'
 PROMLIB: Root node compatible: sun4v
-Linux version 4.12.0-rc4 (jengelh@a1) (gcc version 4.7.2 20120920 [gcc-4_7-branch revision 191568] (SUSE Linux) ) #25 SMP Sun Dec 24 23:33:01 UTC 2017
+Linux version 4.12.0-rc4+ (jengelh@a1) (gcc version 4.7.2 20120920 [gcc-4_7-branch revision 191568] (SUSE Linux) ) #24 SMP Sun Dec 24 23:13:50 UTC 2017
 bootconsole [earlyprom0] enabled
 ARCH: SUN4V
 Ethernet address: 00:14:4f:e1:d1:24
@@ -39,23 +39,23 @@ Initmem setup node 0 [mem 0x000000000840
 Booting Linux...
 CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,mul32,div32]
 CPU CAPS: [v8plus,ASIBlkInit]
-percpu: Embedded 10 pages/cpu @ffff8001ff800000 s41600 r8192 d32128 u131072
+percpu: Embedded 10 pages/cpu @ffff8001ff800000 s41600 r8192 d32128 u262144
 SUN4V: Mondo queue sizes [cpu(4096) dev(16384) r(8192) nr(256)]
 Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1022314
 Policy zone: Normal
 Kernel command line:
 log_buf_len individual max cpu contribution: 16384 bytes
-log_buf_len total cpu_extra contributions: 507904 bytes
+log_buf_len total cpu_extra contributions: 245760 bytes
 log_buf_len min size: 131072 bytes
-log_buf_len: 1048576 bytes
-early log buf free: 127856(97%)
+log_buf_len: 524288 bytes
+early log buf free: 127904(97%)
 PID hash table entries: 4096 (order: 2, 32768 bytes)
 Sorting __ex_table...
-Memory: 8165592K/8251032K available (4292K kernel code, 280K rwdata, 1408K rodata, 240K init, 454K bss, 85440K reserved, 0K cma-reserved)
+Memory: 8167896K/8251032K available (4292K kernel code, 280K rwdata, 1408K rodata, 240K init, 454K bss, 83136K reserved, 0K cma-reserved)
 Hierarchical RCU implementation.
         RCU debugfs-based tracing is enabled.
-        RCU restricting CPUs from NR_CPUS6 to nr_cpu_ids2.
-RCU: Adjusting geometry for rcu_fanout_leaf, nr_cpu_ids2
+        RCU restricting CPUs from NR_CPUS6 to nr_cpu_ids.
+RCU: Adjusting geometry for rcu_fanout_leaf, nr_cpu_ids
 NR_IRQS:2048 nr_irqs:2048 1
 SUN4V: Using IRQ API major 1, cookie only virqs disabled
 clocksource: stick: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
@@ -66,7 +66,7 @@ console [tty0] enabled
 bootconsole [earlyprom0] disabled
 PROMLIB: Sun IEEE Boot Prom 'OBP 4.30.4.b 2010/07/09 13:43'
 PROMLIB: Root node compatible: sun4v
-Linux version 4.12.0-rc4 (jengelh@a1) (gcc version 4.7.2 20120920 [gcc-4_7-branch revision 191568] (SUSE Linux) ) #25 SMP Sun Dec 24 23:33:01 UTC 2017
+Linux version 4.12.0-rc4+ (jengelh@a1) (gcc version 4.7.2 20120920 [gcc-4_7-branch revision 191568] (SUSE Linux) ) #24 SMP Sun Dec 24 23:13:50 UTC 2017
 bootconsole [earlyprom0] enabled
 ARCH: SUN4V
 Ethernet address: 00:14:4f:e1:d1:24
@@ -101,23 +101,23 @@ Initmem setup node 0 [mem 0x000000000840
 Booting Linux...
 CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,mul32,div32]
 CPU CAPS: [v8plus,ASIBlkInit]
-percpu: Embedded 10 pages/cpu @ffff8001ff800000 s41600 r8192 d32128 u131072
+percpu: Embedded 10 pages/cpu @ffff8001ff800000 s41600 r8192 d32128 u262144
 SUN4V: Mondo queue sizes [cpu(4096) dev(16384) r(8192) nr(256)]
 Built 1 zonelists in Node order, mobility grouping on.  Total pages: 1022314
 Policy zone: Normal
 Kernel command line:
 log_buf_len individual max cpu contribution: 16384 bytes
-log_buf_len total cpu_extra contributions: 507904 bytes
+log_buf_len total cpu_extra contributions: 245760 bytes
 log_buf_len min size: 131072 bytes
-log_buf_len: 1048576 bytes
-early log buf free: 127856(97%)
+log_buf_len: 524288 bytes
+early log buf free: 127904(97%)
 PID hash table entries: 4096 (order: 2, 32768 bytes)
 Sorting __ex_table...
-Memory: 8165592K/8251032K available (4292K kernel code, 280K rwdata, 1408K rodata, 240K init, 454K bss, 85440K reserved, 0K cma-reserved)
+Memory: 8167896K/8251032K available (4292K kernel code, 280K rwdata, 1408K rodata, 240K init, 454K bss, 83136K reserved, 0K cma-reserved)
 Hierarchical RCU implementation.
         RCU debugfs-based tracing is enabled.
-        RCU restricting CPUs from NR_CPUS6 to nr_cpu_ids2.
-RCU: Adjusting geometry for rcu_fanout_leaf, nr_cpu_ids2
+        RCU restricting CPUs from NR_CPUS6 to nr_cpu_ids.
+RCU: Adjusting geometry for rcu_fanout_leaf, nr_cpu_ids
 NR_IRQS:2048 nr_irqs:2048 1
 SUN4V: Using IRQ API major 1, cookie only virqs disabled
 clocksource: stick: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
@@ -126,18 +126,18 @@ clockevent: mult[80000000] shift[31]
 Console: colour dummy device 80x25
 console [tty0] enabled
 bootconsole [earlyprom0] disabled
-Calibrating delay using timer specific routine.. 2005.96 BogoMIPS (lpj@11934)
+Calibrating delay using timer specific routine.. 2005.88 BogoMIPS (lpj@11779)
 pid_max: default: 32768 minimum: 301
 Dentry cache hash table entries: 1048576 (order: 10, 8388608 bytes)
 Inode-cache hash table entries: 524288 (order: 9, 4194304 bytes)
 Mount-cache hash table entries: 16384 (order: 4, 131072 bytes)
 Mountpoint-cache hash table entries: 16384 (order: 4, 131072 bytes)
 smp: Bringing up secondary CPUs ...
-smp: Brought up 1 node, 24 CPUs
+smp: Brought up 1 node, 16 CPUs
 ldc.c:v1.1 (July 22, 2008)
 ldc: Domaining disabled.
 clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
-futex hash table entries: 8192 (order: 6, 524288 bytes)
+futex hash table entries: 4096 (order: 5, 262144 bytes)
 NET: Registered protocol family 16
 VIO: Adding device channel-devices
 VIO: Adding device vldc-port-0-0
@@ -159,7 +159,7 @@ pci_sun4v: Could not register hvapi ATU
 /pci@780: MSI Queue first[0] num[36] count[128] devino[0x18]
 /pci@780: MSI first[0] num[256] mask[0xff] width[32]
 /pci@780: MSI addr32[0x7fff0000:0x10000] addr64[0x3ffff0000:0x10000]
-/pci@780: MSI queues at RA [00000001f5300000]
+/pci@780: MSI queues at RA [00000001f4f80000]
 PCI: Scanning PBM /pci@780
 pci_sun4v f027de48: PCI host bridge to bus 0000:02
 pci_bus 0000:02: root bus resource [io  0xe810000000-0xe81fffffff] (bus address [0x0000-0xfffffff])
@@ -175,7 +175,7 @@ pci_bus 0000:02: root bus resource [bus
 /pci@7c0: MSI Queue first[0] num[36] count[128] devino[0x18]
 /pci@7c0: MSI first[0] num[256] mask[0xff] width[32]
 /pci@7c0: MSI addr32[0x7fff0000:0x10000] addr64[0x3ffff0000:0x10000]
-/pci@7c0: MSI queues at RA [00000001f5380000]
+/pci@7c0: MSI queues at RA [00000001f5000000]
 PCI: Scanning PBM /pci@7c0
 pci_sun4v f0289220: PCI host bridge to bus 0001:02
 pci_bus 0001:02: root bus resource [io  0xf010000000-0xf01fffffff] (bus address [0x0000-0xfffffff])
@@ -200,7 +200,7 @@ UDP hash table entries: 4096 (order: 4,
 UDP-Lite hash table entries: 4096 (order: 4, 131072 bytes)
 NET: Registered protocol family 1
 audit: initializing netlink subsys (disabled)
-audit: type 00 audit(0.351:1): state=initialized audit_enabled=0 res=1
+audit: type 00 audit(0.328:1): state=initialized audit_enabled=0 res=1
 workingset: timestamp_bitsB max_order  bucket_order=0
 Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
 io scheduler noop registered

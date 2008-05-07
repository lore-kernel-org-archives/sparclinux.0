From: Mikael Pettersson <mikpe@it.uu.se>
Date: Wed, 07 May 2008 18:36:55 +0000
Subject: [BUG] 2.6.26-rc1 lost half the RAM on UltraSPARC 5
Message-Id: <18465.63175.561233.228014@alkaid.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Now that 2.6.26-rc1 boots on my Ultra5, I noticed that it
reports having only 128MB RAM, while earlier kernels reported
the correct amount: 256MB.

A diff of the dmesg output from 2.6.25 and 2.6.26-rc1 shows:

--- dmesg-2.6.25	2008-05-07 19:41:26.000000000 +0200
+++ dmesg-2.6.26-rc1	2008-05-07 19:41:26.000000000 +0200
@@ -1,24 +1,36 @@
 PROMLIB: Sun IEEE Boot Prom 'OBP 3.25.3 2000/06/29 14:12'
 PROMLIB: Root node compatible: 
-Linux version 2.6.25 (mikpe@sparge) (gcc version 4.2.3) #1 Thu Apr 17 19:53:16 CEST 2008
+Linux version 2.6.26-rc1 (mikpe@sparge) (gcc version 4.2.3) #1 Wed May 7 17:41:33 CEST 2008
 console [earlyprom0] enabled
 ARCH: SUN4U
 Ethernet address: 08:00:20:fd:ec:1f
 Kernel: Using 1 locked TLB entries for main kernel image.
 Remapping the kernel... done.
-[0000000200000000-fffff80000400000] page_structs&2144 node=0 entry=0/0
-[0000000200000000-fffff80000800000] page_structs&2144 node=0 entry=1/0
-[0000000200000000-fffff80000c00000] page_structs&2144 node=0 entry=2/0
-[0000000200000000-fffff80001000000] page_structs&2144 node=0 entry=3/0
 OF stdout device is: /pci@1f,0/pci@1,1/SUNW,m64B@2
-PROM: Built device tree with 46848 bytes of memory.
-On node 0 totalpages: 32298
+PROM: Built device tree with 46641 bytes of memory.
+Top of RAM: 0x17f46000, Total RAM: 0xff40000
+Memory hole size: 128MB
+Entering add_active_range(0, 0, 16384) 0 entries of 256 used
+Entering add_active_range(0, 32768, 49023) 1 entries of 256 used
+Entering add_active_range(0, 49024, 49053) 2 entries of 256 used
+Entering add_active_range(0, 49055, 49059) 3 entries of 256 used
+[0000000200000000-fffff80000400000] page_structs1072 node=0 entry=0/0
+[0000000200000000-fffff80000800000] page_structs1072 node=0 entry=1/0
+Zone PFN ranges:
+  Normal          0 ->    49059
+Movable zone start PFN for each node
+early_node_map[4] active PFN ranges
+    0:        0 ->    16384
+    0:    32768 ->    49023
+    0:    49024 ->    49053
+    0:    49055 ->    49059
+On node 0 totalpages: 32672
   Normal zone: 335 pages used for memmap
   Normal zone: 0 pages reserved
-  Normal zone: 31963 pages, LIFO batch:7
+  Normal zone: 32337 pages, LIFO batch:7
   Movable zone: 0 pages used for memmap
 Booting Linux...
-Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 31963
+Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32337
 Kernel command line: ro root=/dev/sda5
 PID hash table entries: 1024 (order: 10, 8192 bytes)
 clocksource: mult[28000] shift[16]
@@ -27,11 +39,11 @@
 console handover: boot [earlyprom0] -> real [tty0]
 Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
 Inode-cache hash table entries: 16384 (order: 4, 131072 bytes)
-Memory: 237256k available (1928k kernel code, 744k data, 144k init) [fffff80000000000,0000000017f46000]
-SLUB: Genslabs, HWalign2, Order=0-2, MinObjects=8, CPUs=1, Nodes=1
-Calibrating delay using timer specific routine.. 800.81 BogoMIPS (lpj@04065)
+Memory: 127016k available (1920k kernel code, 744k data, 152k init) [fffff80000000000,0000000017f46000]
+SLUB: Genslabs, HWalign2, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
+Calibrating delay using timer specific routine.. 800.99 BogoMIPS (lpj@04959)
 Mount-cache hash table entries: 512
-net_namespace: 280 bytes
+net_namespace: 344 bytes
 NET: Registered protocol family 16
 PCI: Probing for controllers.
 /pci@1f,0: SABRE PCI Bus Module

This was with my 2.6.25 .config + make oldconfig. I also built
2.6.26-rc1 with arch/sparc64/defconfig + minor tweaks to suit
my machine, but that one also only found 128MB RAM.

dmesg logs and .configs are in <http://user.it.uu.se/~mikpe/linux/sparge/>

/Mikael

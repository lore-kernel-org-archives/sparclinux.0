From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 13 May 2008 19:31:19 +0000
Subject: Re: [BUG] 2.6.26-rc1 lost half the RAM on UltraSPARC 5
Message-Id: <18473.60551.911448.98269@alkaid.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <18472.38209.615770.265421@alkaid.it.uu.se>
	<20080512.153143.48741227.davem@davemloft.net>
	<20080512.153628.193699676.davem@davemloft.net>
	<20080512.153948.193688062.davem@davemloft.net>
In-Reply-To: <20080512.153948.193688062.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: David Miller <davem@davemloft.net>
Cc: mikpe@it.uu.se, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

David Miller writes:
 > From: David Miller <davem@davemloft.net>
 > Date: Mon, 12 May 2008 15:36:28 -0700 (PDT)
 >=20
 > > Nevermind I see why the messages don't show up.  Hold on for a second
 > > and I'll send an updated debugging patch.
 >=20
 > Try this patch instead, thanks!
 >=20
 > diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
 > index a9828d7..a628a99 100644
 > --- a/arch/sparc64/mm/init.c
 > +++ b/arch/sparc64/mm/init.c
 > @@ -1353,6 +1353,8 @@ static void __init bootmem_init_one_node(int nid)
 > =20
 >  	numadbg("bootmem_init_one_node(%d)\n", nid);
 > =20
 > +	lmb_dump_all();
 > +
 >  	p =3D NODE_DATA(nid);
 > =20
 >  	if (p->node_spanned_pages) {
 > diff --git a/lib/lmb.c b/lib/lmb.c
 > index 83287d3..f294bbc 100644
 > --- a/lib/lmb.c
 > +++ b/lib/lmb.c
 > @@ -10,6 +10,8 @@
 >   *      2 of the License, or (at your option) any later version.
 >   */
 > =20
 > +#define DEBUG
 > +
 >  #include <linux/kernel.h>
 >  #include <linux/init.h>
 >  #include <linux/bitops.h>
 > @@ -29,7 +31,7 @@ void lmb_dump_all(void)
 >  	pr_debug("    memory.size		  =3D 0x%llx\n",
 >  	    (unsigned long long)lmb.memory.size);
 >  	for (i=3D0; i < lmb.memory.cnt ;i++) {
 > -		pr_debug("    memory.region[0x%x].base       =3D 0x%llx\n",
 > +		pr_debug("    memory.region[0x%lx].base       =3D 0x%llx\n",
 >  		    i, (unsigned long long)lmb.memory.region[i].base);
 >  		pr_debug("		      .size     =3D 0x%llx\n",
 >  		    (unsigned long long)lmb.memory.region[i].size);
 > @@ -38,7 +40,7 @@ void lmb_dump_all(void)
 >  	pr_debug("    reserved.cnt	  =3D 0x%lx\n", lmb.reserved.cnt);
 >  	pr_debug("    reserved.size	  =3D 0x%lx\n", lmb.reserved.size);
 >  	for (i=3D0; i < lmb.reserved.cnt ;i++) {
 > -		pr_debug("    reserved.region[0x%x].base       =3D 0x%llx\n",
 > +		pr_debug("    reserved.region[0x%lx].base       =3D 0x%llx\n",
 >  		    i, (unsigned long long)lmb.reserved.region[i].base);
 >  		pr_debug("		      .size     =3D 0x%llx\n",
 >  		    (unsigned long long)lmb.reserved.region[i].size);
 >=20

Ok, reverting previous patch and applying this done results in:

PROMLIB: Sun IEEE Boot Prom 'OBP 3.25.3 2000/06/29 14:12'
PROMLIB: Root node compatible:=20
Linux version 2.6.26-rc2-test (mikpe@sparge) (gcc version 4.2.3) #2 Tue May=
 13 18:26:56 CEST 2008
console [earlyprom0] enabled
ARCH: SUN4U
Ethernet address: 08:00:20:fd:ec:1f
Found ramdisk at physical address 0x10800000, size 3683665
lmb_dump_all:
    memory.cnt		  =3D 0x4
    memory.size		  =3D 0xff40000
    memory.region[0x0].base       =3D 0x0
		      .size     =3D 0x8000000
    memory.region[0x1].base       =3D 0x10000000
		      .size     =3D 0x7efe000
    memory.region[0x2].base       =3D 0x17f00000
		      .size     =3D 0x3a000
    memory.region[0x3].base       =3D 0x17f3e000
		      .size     =3D 0x8000
    reserved.cnt	  =3D 0x2
    reserved.size	  =3D 0x0
    reserved.region[0x0].base       =3D 0x10000000
		      .size     =3D 0x35bf60
    reserved.region[0x1].base       =3D 0x10800000
		      .size     =3D 0x10b83551
Kernel: Using 1 locked TLB entries for main kernel image.
Remapping the kernel... done.
OF stdout device is: /pci@1f,0/pci@1,1/SUNW,m64B@2
PROM: Built device tree with 46641 bytes of memory.
bootmem_init_numa()
bootmem_init_nonnuma()
Top of RAM: 0x17f46000, Total RAM: 0xff40000
Memory hole size: 128MB
Initializing tables for non-numa.
Entering add_active_range(0, 0, 16384) 0 entries of 256 used
Entering add_active_range(0, 32768, 49023) 1 entries of 256 used
Entering add_active_range(0, 49024, 49053) 2 entries of 256 used
Entering add_active_range(0, 49055, 49059) 3 entries of 256 used
bootmem_init_one_node(0)
lmb_dump_all:
    memory.cnt		  =3D 0x4
    memory.size		  =3D 0xff40000
    memory.region[0x0].base       =3D 0x0
		      .size     =3D 0x8000000
    memory.region[0x1].base       =3D 0x10000000
		      .size     =3D 0x7efe000
    memory.region[0x2].base       =3D 0x17f00000
		      .size     =3D 0x3a000
    memory.region[0x3].base       =3D 0x17f3e000
		      .size     =3D 0x8000
    reserved.cnt	  =3D 0x4
    reserved.size	  =3D 0x0
    reserved.region[0x0].base       =3D 0x7ffc000
		      .size     =3D 0x2000
    reserved.region[0x1].base       =3D 0x7fff040
		      .size     =3D 0xfc0
    reserved.region[0x2].base       =3D 0x10000000
		      .size     =3D 0x35bf60
    reserved.region[0x3].base       =3D 0x107e8e00
		      .size     =3D 0x10b9a751
  init_bootmem_node(0, 3ffe, 0, bfa3)
  free_bootmem_with_active_regions(0, bfa3)
  trim_reserved_in_node(0)
    reserve_range_in_node(nid[0],start[7ffc000],end[7ffe000]
      MATCH reserving range [7ffc000:7ffe000]
    reserve_range_in_node(nid[0],start[7fff040],end[8000000]
      MATCH reserving range [7fff040:8001040]
    reserve_range_in_node(nid[0],start[10000000],end[1035bf60]
      MATCH reserving range [10000000:1035c000]
    reserve_range_in_node(nid[0],start[107e8e00],end[21383551]
      MATCH reserving range [107e8e00:21384e00]
  sparse_memory_present_with_active_regions(0)
[0000000200000000-fffff80000400000] page_structs=131072 node=3D0 entry=3D0/0
[0000000200000000-fffff80000800000] page_structs=131072 node=3D0 entry=3D1/0
Zone PFN ranges:
  Normal          0 ->    49059
Movable zone start PFN for each node
early_node_map[4] active PFN ranges
    0:        0 ->    16384
    0:    32768 ->    49023
    0:    49024 ->    49053
    0:    49055 ->    49059
On node 0 totalpages: 32672
  Normal zone: 335 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 32337 pages, LIFO batch:7
  Movable zone: 0 pages used for memmap
Booting Linux...
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 32337
Policy zone: Normal
Kernel command line: ro root=3D/dev/sda5 numa=DEbug
PID hash table entries: 1024 (order: 10, 8192 bytes)
clocksource: mult[28000] shift[16]
clockevent: mult[66666666] shift[32]
Console: colour dummy device 80x25
console handover: boot [earlyprom0] -> real [tty0]
Dentry cache hash table entries: 32768 (order: 5, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 4, 131072 bytes)
Memory: 127056k available (2040k kernel code, 808k data, 152k init) [fffff8=
0000000000,0000000017f46000]
SLUB: Genslabs=14, HWalign2, Order=3D0-3, MinObjects=3D0, CPUs=3D1, Nodes=16
Calibrating delay using timer specific routine.. 800.75 BogoMIPS (lpj@03776)
Mount-cache hash table entries: 512
net_namespace: 344 bytes
NET: Registered protocol family 16
PCI: Probing for controllers.
/pci@1f,0: SABRE PCI Bus Module
/pci@1f,0: PCI IO[1fe02000000] MEM[1ff00000000]
PCI: Scanning PBM /pci@1f,0
ebus0: [auxio] [power] [SUNW,pll] [se] [su] [su] [ecpp] [fdthree] [eeprom] =
[flashprom] [SUNW,CS4231]
power: Control reg at 1fff1724000
SCSI subsystem initialized
libata version 3.00 loaded.
AUXIO: Found device at /pci@1f,0/pci@1,1/ebus@1/auxio@14,726000
/pci@1f,0/pci@1,1/ebus@1/eeprom@14,0: Clock regs at 000001fff1000000
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 16384 bytes)
TCP established hash table entries: 8192 (order: 4, 131072 bytes)
TCP bind hash table entries: 8192 (order: 3, 65536 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
Unpacking initramfs... done
Freeing initrd memory: 3597k freed
Mini RTC Driver
msgmni has been set to 255 for ipc namespace 00000000006b27c8
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
atyfb: 3D RAGE PRO (Mach64 GP, PQFP, PCI) [0x4750 rev 0x7c]
atyfb: 4M SGRAM (1:1), 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK, 100 MH=
z XCLK
fbcon: ATY Mach64 (fb0) is primary device
Console: switching to colour frame buffer device 144x56
atyfb: fb0: ATY Mach64 frame buffer device on PCI
/pci@1f,0/pci@1,1/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, irq 6
/pci@1f,0/pci@1,1/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq 7
f006159c: ttyS0 at MMIO 0x1fff1400000 (irq =3D 5) is a SAB82532 V3.2
f006159c: ttyS1 at MMIO 0x1fff1400040 (irq =3D 5) is a SAB82532 V3.2
Driver 'sd' needs updating - please use bus_type methods
scsi0 : pata_cmd64x
scsi1 : pata_cmd64x
ata1: PATA max MWDMA2 cmd 0x1fe02c00000 ctl 0x1fe02c00008 bmdma 0x1fe02c000=
20 irq 14
ata2: PATA max MWDMA2 cmd 0x1fe02c00010 ctl 0x1fe02c00018 bmdma 0x1fe02c000=
28 irq 14
pata_cmd64x: active 10 recovery 10 setup 3.
pata_cmd64x: active 10 recovery 10 setup 3.
ata1.00: ATA-4: ST320420A, 3.21, max UDMA/66
ata1.00: 39851760 sectors, multi 0: LBA=20
pata_cmd64x: active 3 recovery 1 setup 1.
pata_cmd64x: active 3 recovery 1 setup 1.
ata1.00: configured for MWDMA2
pata_cmd64x: active 10 recovery 10 setup 3.
pata_cmd64x: active 10 recovery 10 setup 3.
ata2.00: ATAPI: CRD-8483B, 1.00, max UDMA/33
pata_cmd64x: active 3 recovery 1 setup 1.
pata_cmd64x: active 3 recovery 1 setup 1.
ata2.00: configured for MWDMA2
scsi 0:0:0:0: Direct-Access     ATA      ST320420A        3.21 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 39851760 512-byte hardware sectors (20404 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
sd 0:0:0:0: [sda] 39851760 512-byte hardware sectors (20404 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sda: sda1 sda2 sda3 sda4 sda5
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: CD-ROM            LG       CD-ROM CRD-8483B 1.00 PQ: 0 ANSI: 5
mice: PS/2 mouse device common for all mice
input: Sun Type 5 keyboard as /class/input/input0
input: Sun Mouse as /class/input/input1
TCP cubic registered
NET: Registered protocol family 17
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
PCI: Enabling device: (0000:01:01.1), cmd 2
sunhme.c:v3.00 June 23, 2006 David S. Miller (davem@davemloft.net)
eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:fd:ec:1f
EXT3 FS on sda5, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1048808k swap on /dev/sda4.  Priority:-1 extents:1 across:1048808k
eth0: Link is up using internal transceiver at 100Mb/s, Full Duplex.

I also tried your two lmb patches from today (had to revert this patch firs=
t),
but they made no significant difference.

/Mikael

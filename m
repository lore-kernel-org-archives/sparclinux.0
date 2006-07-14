From: Marc Zyngier <maz@misterjones.org>
Date: Fri, 14 Jul 2006 10:18:47 +0000
Subject: 2.6.18-rc1 fails to boot on E250 (was Re: 2.6.18-rc1 fails to boot on Ultra 5)
Message-Id: <wrpmzbch4l4.fsf_-_@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David,

I tried to boot my E250 (2x400MHz, 2GB) with 2.6.18-rc1 and your
latest patches, without success.

It crashes while probing the PSYCHO PCI controller:

[    0.000000] PROMLIB: Sun IEEE Boot Prom 'OBP 3.30.0 2003/11/11 10:37'
[    0.000000] PROMLIB: Root node compatible: sun4u
[    0.000000] Linux version 2.6.18-rc1 (maz@positive) (gcc version 4.0.3 (Ubunt
u 4.0.3-1ubuntu5)) #4 SMP Fri Jul 14 11:13:05 CEST 2006
[    0.000000] ARCH: SUN4U
[    0.000000] Ethernet address: 08:00:20:d8:e4:6d
Remapping the kernel... done.
[    0.000000] PROM: Built device tree with 75588 bytes of memory.
Booting Linux...
[    0.000000] Built 1 zonelists.  Total pages: 260721
[    0.000000] Kernel command line: root=/dev/sda2 ro -p
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   11.683088] Console: colour dummy device 80x25
[   11.745443] Dentry cache hash table entries: 262144 (order: 8, 2097152 bytes)

[   11.839304] Inode-cache hash table entries: 131072 (order: 7, 1048576 bytes)^
M
[   12.042839] Memory: 2066520k available (2544k kernel code, 832k data, 168k in
it) [fffff80000000000,000000007fecc000]
[   12.245820] Calibrating delay using timer specific routine.. 800.46 BogoMIPS
(lpj00920)
[   12.343301] Security Framework v1.0.0 initialized
[   12.399292] SELinux:  Disabled at boot.
[   12.445162] Mount-cache hash table entries: 512
[   12.500165] CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)]
E[sz(2097152):line_sz(64)]
[   12.611828] Using max_cache_size of 2MB
[   12.749823] Calibrating delay using timer specific routine.. 800.05 BogoMIPS
(lpj00114)
[   12.749973] CPU[1]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)]
E[sz(2097152):line_sz(64)]
[   12.750711] CPU 1: synchronized TICK with master CPU (last diff -23 cycles,ma
xerr 715 cycles)
[   12.750730] Brought up 2 CPUs
[   12.750749] Total of 2 processors activated (1600.51 BogoMIPS).
[   14.860492] migration_costA930
[   14.897991] checking if image is initramfs... it is
[    0.549078] Freeing initrd memory: 5983k freed
[    0.602704] NET: Registered protocol family 16
[    0.666957] PCI: Probing for controllers.
[    0.719940] Unable to handle kernel NULL pointer dereference
[    0.786037] tsk->{mm,active_mm}->context = 0000000000000000
[    0.852676] tsk->{mm,active_mm}->pgd = fffff8000079b330
[    0.915170]               \|/ ____ \|/
[    0.915179]               "@'/ .. \`@"
[    0.915187]               /_| \__/ |_\
[    0.915194]                  \__U_/
[    1.091337] swapper(1): Oops [#1]
[    1.130758] TSTATE: 0000000080001602 TPC: 0000000000535070 TNPC: 000000000053
5074 Y: 00000000    Not tainted
[    1.248424] TPC: <vsnprintf+0x58/0x6a0>
[    1.294231] g0: 0000000000000840 g1: 0000000000000050 g2: 000000000000ffff g3
: 000001ffffffffff
[    1.398399] g4: fffff8007fddf9e0 g5: fffff8000107a000 g6: fffff80001c04000 g7
: 000001fe0201ffff
[    1.502550] o0: 0000000000000001 o1: fffff80001c04400 o2: 000000000042ba78 o3
: 0000000000000000
[    1.606712] o4: 000000000074ac00 o5: 000000000074ac00 sp: fffff80001c070f1 re
t_pc: 00000000004109d4
[    1.715037] RPC: <tl0_irq14+0x1c/0x20>
[    1.759822] l0: 0000000000000000 l1: 000000007fffffff l2: 000000000042ba74 l3
: 0000000000000400
[    1.863978] l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7
: 0000000000000008
[    1.968144] i0: 0000000000000000 i1: 000000007fffffff i2: 0000000000000050 i3
: fffff80001c07b20
[    2.072307] i4: ffff800000001fff i5: 0000000000020000 i6: fffff80001c071c1 i7
: 00000000005357ec
[    2.176470] I7: <sprintf+0x34/0x40>
[    2.219448] Caller[00000000005357ec]: sprintf+0x34/0x40
[    2.280616] Caller[000000000042d7f8]: psycho_pbm_init+0x100/0x300
[    2.353526] Caller[00000000007602b4]: pci_controller_init+0x5c/0x80
[    2.428522] Caller[000000000076039c]: pci_controller_scan+0x64/0x100
[    2.504557] Caller[0000000000760494]: pcibios_init+0x3c/0xa0
[    2.572261] Caller[0000000000416fd0]: init+0xf8/0x3a0
[    2.632673] Caller[0000000000418010]: kernel_thread+0x38/0x60
[    2.701418] Caller[0000000000416e50]: rest_init+0x18/0x40
[    2.766004] Instruction DUMP: 02400020  80a44010  38680002 <f42c0000> f45fa88
f  a0042001  8206a001  c277a88f  f40ea001 
[    2.895168] Kernel panic - not syncing: Attempted to kill init!
[    2.966074]  <0>Press Stop-A (L1-A) to return to the boot prom


Quick investigation shows that pbm->name is used a tad too early in
pbm_register_toplevel_resources. The included patchlet fixes that,
allowing the boot to go a little further, but not much :


[   10.157354] [drm] Initialized drm 1.0.1 20051102
[   10.213220] /pci@1f,4000/ebus@1/su@14,3083f8: Keyboard port at 1fff13083f8, i
rq 41
[   10.303165] su: Cannot register IRQ 41
[   10.347882] /pci@1f,4000/ebus@1/su@14,3062f8: Mouse port at 1fff13062f8, irq
42
[   10.435361] su: Cannot register IRQ 42
[   10.480680] sab: probe of se@14,400000 failed with error -90
[   10.547849] sab: probe of se@14,200000 failed with error -90
[   10.619041] RAMDISK driver initialized: 16 RAM disks of 65536K size 1024 bloc
ksize
[   10.709646] loop: loaded (max 8 devices)
[   10.755481] sunhme.c:v3.00 June 23, 2006 David S. Miller (davem@davemloft.net
)
[   10.842746] eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:d8:e
4:6d 
[   10.933251] eth1: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:d8:e
4:6d 
[   11.023467] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   11.098850] ide: Assuming 33MHz system bus speed for PIO modes; override with
 idebus=xx
[   11.195219] rtc_sun_init: Registered Mostek RTC driver.
[   11.257149] usbmon: debugfs is not available
[   11.308319] usbcore: registered new driver usbhid
[   11.364440] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   11.439074] mice: PS/2 mouse device common for all mice
[   11.502076] TCP bic registered
[   11.537368] NET: Registered protocol family 1
[   11.589422] NET: Registered protocol family 17
[   11.643899] Warning: unable to open an initial console.
[   12.499085] input: Sun Mouse as /class/input/input0
[   15.584294] SCSI subsystem initialized
[   15.647608] sym0: <875> rev 0x14 at pci 0001:00:03.0 irq 32
[   15.799332] sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
[   15.867651] sym0: request irq 32 failure
[   15.914320] sym0: giving up ...
[   15.953160] sym0: <875> rev 0x14 at pci 0001:00:03.1 irq 38
[   16.105485] sym0: No NVRAM, ID 7, Fast-20, SE, parity checking
[   16.173768] sym0: request irq 38 failure
[   16.220447] sym0: giving up ...

Looks like no IRQ can be requested, probably a problem with the new
IRQ framework.

Cheers,

	M.

[SPARC64] Fix PSYCHO PCI controler init.

pbm->name should be initialized before calling
pbm_register_toplevel_resources. Move the call a few lines down to
avoid a nice Oops.

Signed-off-by: Marc Zyngier <maz@misterjones.org>

diff --git a/arch/sparc64/kernel/pci_psycho.c b/arch/sparc64/kernel/pci_psycho.c
index 197a7ff..717c65d 100644
--- a/arch/sparc64/kernel/pci_psycho.c
+++ b/arch/sparc64/kernel/pci_psycho.c
@@ -1203,12 +1203,13 @@ static void psycho_pbm_init(struct pci_c
 	pbm->io_space.flags = IORESOURCE_IO;
 	pbm->mem_space.end = pbm->mem_space.start + PSYCHO_MEMSPACE_SIZE;
 	pbm->mem_space.flags = IORESOURCE_MEM;
-	pbm_register_toplevel_resources(p, pbm);
 
 	pbm->parent = p;
 	pbm->prom_node = dp;
 	pbm->name = dp->full_name;
 
+	pbm_register_toplevel_resources(p, pbm);
+
 	printk("%s: PSYCHO PCI Bus Module ver[%x:%x]\n",
 	       pbm->name,
 	       pbm->chip_version, pbm->chip_revision);

-- 
And if you don't know where you're going, any road will take you there...

From: Chris Newport <crn@netunix.com>
Date: Wed, 18 Aug 2004 21:28:01 +0000
Subject: Sun4d progress
Message-Id: <Pine.LNX.4.53.0408182135050.391@mailgate.netunix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


I have cleaned up Thomas Bogendoerfer's patches from the list archives
which seem to be infested with html. ( clean version pasted in below ).

Building 2.4.22 and 2.4.27 with both gcc-egcs-2.91.66 and gcc 3.2.2
I get a bootable UP system but SMP locks up after
ioremap: done with statics, switching to malloc.

Does anyone know what is happening ?

=3D=3D boot messages


Linux   - Linux (Linux native partition)
Linux2.2 - Safe kernel version 2.2.20

boot: Linux -p
PROMLIB: Sun Boot Prom Version 3 Revision 2
<4>Linux version 2.4.27 (root@phobos) (gcc version 3.2.3) #1 SMP Wed Aug 18=
 16:14:49 BST 2004
<4>ARCH: SUN4D
Linux version 2.4.27 (root@phobos) (gcc version 3.2.3) #1 SMP Wed Aug 18 16=
:14:49 BST 2004
<4>ARCH: SUN4D
ARCH: SUN4D
TYPE: SPARCserver 1000E
Ethernet address: 8:0:20:7d:15:c8
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching =
kernel for srmmu[TI Viking/MXCC]/io-unit
bootmem_init: Scan sp_banks,  319145MB HIGHMEM available.
init_bootmem(spfn[236],bpfn[236],mlpfn[c000])
free_bootmem: base[0] size[c000000]
reserve_bootmem: base[0] size[236000]
reserve_bootmem: base[236000] size[1800]
On node 0 totalpages: 367729
zone(0): 49152 pages.
zone(1): 0 pages.
zone(2): 319427 pages.
Booting Linux...
Found CPU 0 <node=FFd8e6b8,mid=3D0>
Found CPU 1 <node=FFd8ea34,mid=3D1>
Found CPU 2 <node=FFd8edb0,mid=3D2>
Found CPU 3 <node=FFd8f12c,mid=3D3>
Found CPU 4 <node=FFd8f4a8,mid=3D4>
Found CPU 5 <node=FFd8f824,mid=3D5>
Found 6 CPU prom device tree node(s).
Kernel command line: root=3D/dev/sda1 ro -p
Calibrating delay loop... 84.99 BogoMIPS
mem_init: Calling free_all_bootmem().
Memory: 1447348k available (1528k kernel code, 236k data, 116k init, 127658=
0k highmem) [f0000000,59fc3000]
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
POSIX conformance testing by UNIFIX
Entering SMP Mode...
Calibrating delay loop... 85.19 BogoMIPS
Calibrating delay loop... 85.19 BogoMIPS
Calibrating delay loop... 85.19 BogoMIPS
Calibrating delay loop... 84.99 BogoMIPS
Calibrating delay loop... 84.99 BogoMIPS
Total of 6 Processors activated (510.56 BogoMIPS).
All sbus IRQs directed to CPU1
Waiting on wait_init_idle (map =3D 0x3e)
All processors have done init_idle
sbus0: Clock 25.0 MHz
dma0: ESC Revision 1
sbus1: Clock 25.0 MHz
dma1: ESC Revision 1
sbus2: Clock 25.0 MHz
dma2: ESC Revision 1
dma3: ESC Revision 1
Sparc Zilog8530 serial driver version 1.68.2.2
ioremap: done with statics, switching to malloc

=3D=3D=3D  Patches


<#0> ok cat mydiffs
diff -ru linux-2.4.27-orig/arch/sparc/kernel/sun4d_smp.c linux-2.4.27/arch/=
sparc/kernel/sun4d_smp.c
--- linux-2.4.27-orig/arch/sparc/kernel/sun4d_smp.c	2003-11-28 18:26:19.000=
000000 +0000
+++ linux-2.4.27/arch/sparc/kernel/sun4d_smp.c	2004-08-18 11:29:07.00000000=
0 +0100
@@ -132,8 +132,7 @@

 	/* Fix idle thread fields. */
 	__asm__ __volatile__("ld [%0], %%g6\n\t"
-			     "sta %%g6, [%%g0] %1\n\t"
-			     : : "r" (&current_set[cpuid]), "i" (ASI_M_VIKING_TMP2)
+			     : : "r" (&current_set[cpuid])
 			     : "memory" /* paranoid */);

 	cpu_leds[cpuid] =3D 0x9;
@@ -494,25 +493,18 @@

 void __init smp4d_blackbox_current(unsigned *addr)
 {
-	/* We have a nice Linux current register :) */
-	int rd =3D addr[1] & 0x3e000000;
+	int rd =3D *addr & 0x3e000000;

-	addr[0] =3D 0x10800006;			/* b .+24 */
-	addr[1] =3D 0xc0800820 | rd;		/* lda [%g0] ASI_M_VIKING_TMP2, reg */
+	addr[0] =3D 0xc0800800 | rd;		/* lda [%g0] ASI_M_VIKING_TMP1, reg */
+	addr[2] =3D 0x81282002 | rd | (rd >> 11);	/* sll reg, 2, reg */
+	addr[4] =3D 0x01000000;			/* nop */
 }

 void __init sun4d_init_smp(void)
 {
 	int i;
-	extern unsigned int patchme_store_new_current[];
 	extern unsigned int t_nmi[], linux_trap_ipi15_sun4d[], linux_trap_ipi15_s=
un4m[];

-	/* Store current into Linux current register :) */
-	__asm__ __volatile__("sta %%g6, [%%g0] %0" : : "i"(ASI_M_VIKING_TMP2));
-
-	/* Patch switch_to */
-	patchme_store_new_current[0] =3D (patchme_store_new_current[0] & 0x3e0000=
00) | 0xc0a00820;
-
 	/* Patch ipi15 trap table */
 	t_nmi[1] =3D t_nmi[1] + (linux_trap_ipi15_sun4d - linux_trap_ipi15_sun4m);

diff -ru linux-2.4.27-orig/arch/sparc/mm/io-unit.c linux-2.4.27/arch/sparc/=
mm/io-unit.c
--- linux-2.4.27-orig/arch/sparc/mm/io-unit.c	2002-11-28 23:53:12.000000000=
 +0000
+++ linux-2.4.27/arch/sparc/mm/io-unit.c	2004-08-18 11:32:29.000000000 +0100
@@ -188,7 +188,7 @@
 			pte_t *ptep;
 			long i;

-			pgdp =3D pgd_offset(init_task.mm, addr);
+			pgdp =3D pgd_offset(&init_mm, addr);
 			pmdp =3D pmd_offset(pgdp, addr);
 			ptep =3D pte_offset(pmdp, addr);

diff -ru linux-2.4.27-orig/arch/sparc/prom/ranges.c linux-2.4.27/arch/sparc=
/prom/ranges.c
--- linux-2.4.27-orig/arch/sparc/prom/ranges.c	2002-02-25 19:37:56.00000000=
0 +0000
+++ linux-2.4.27/arch/sparc/prom/ranges.c	2004-08-18 11:33:59.000000000 +01=
00
@@ -34,7 +34,7 @@
 	}
 }

-static void
+/* static */ void
 prom_adjust_ranges(struct linux_prom_ranges *ranges1, int nranges1,
 		   struct linux_prom_ranges *ranges2, int nranges2)
 {
diff -ru linux-2.4.27-orig/drivers/sbus/sbus.c linux-2.4.27/drivers/sbus/sb=
us.c
--- linux-2.4.27-orig/drivers/sbus/sbus.c	2003-08-25 12:44:42.000000000 +01=
00
+++ linux-2.4.27/drivers/sbus/sbus.c	2004-08-18 11:35:46.000000000 +0100
@@ -215,6 +215,8 @@
  * prom_sbus_ranges_init(), with all sun4d stuff cut away.
  * Ask DaveM what is going on here, how is sun4d supposed to work... XXX
  */
+/* added back sun4d patch from Thomas Bogendoerfer - should be OK (crn) */
+
 static void __init sbus_bus_ranges_init(int parent_node, struct sbus_bus *=
sbus)
 {
 	int len;
@@ -227,6 +229,18 @@
 		return;
 	}
 	sbus->num_sbus_ranges =3D len / sizeof(struct linux_prom_ranges);
+	if (sparc_cpu_model =3D sun4d) {
+		struct linux_prom_ranges iounit_ranges[PROMREG_MAX];
+		int num_iounit_ranges;
+
+	len =3D prom_getproperty(parent_node, "ranges",
+				(char *) iounit_ranges,
+				sizeof (iounit_ranges));
+		if (len !=3D -1) {
+			num_iounit_ranges =3D (len/sizeof(struct linux_prom_ranges));
+			prom_adjust_ranges (sbus->sbus_ranges, sbus->num_sbus_ranges, iounit_ra=
nges, num_iounit_ranges);
+		}
+	}
 }

 static void __init __apply_ranges_to_regs(struct linux_prom_ranges *ranges,
diff -ru linux-2.4.27-orig/include/asm-sparc/asi.h linux-2.4.27/include/asm=
-sparc/asi.h
--- linux-2.4.27-orig/include/asm-sparc/asi.h	1998-04-15 01:44:23.000000000=
 +0100
+++ linux-2.4.27/include/asm-sparc/asi.h	2004-08-18 11:37:14.000000000 +0100
@@ -104,7 +104,8 @@
 #define ASI_M_DCDR         0x39   /* Data Cache Diagnostics Register rw, s=
s */

 #define ASI_M_VIKING_TMP1  0x40	  /* Emulation temporary 1 on Viking */
-#define ASI_M_VIKI

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 04 Feb 2005 21:37:24 +0000
Subject: Re: Badness in map_area_pte
Message-Id: <1107553044.3951.199.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-4Maekpf331UIlb/RDd4F"
List-Id: <sparclinux.vger.kernel.org>
References: <41E96A42.7090501@mc.net>
In-Reply-To: <41E96A42.7090501@mc.net>
To: sparclinux@vger.kernel.org


--=-4Maekpf331UIlb/RDd4F
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-01-15 at 20:29 -0800, William Lee Irwin III wrote:

> I suspected the same. Perhaps time to brew up another BTFIXUP.

I tried to whip up a BTFIXUP patch for this, but it wouldn't work, since
VMALLOC_START is in entry.S. Peter Jones took my patch and made a
version that works. His patch to resolve this is attached.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
-- Sir Winston Churchill

--=-4Maekpf331UIlb/RDd4F
Content-Disposition: attachment; filename=linux-2.6.10-sparc-vmallocstartfix.patch
Content-Type: text/x-patch; name=linux-2.6.10-sparc-vmallocstartfix.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.10/arch/sparc/kernel/entry.S.BAD	2005-01-30 14:28:32.537336110 -0500
+++ linux-2.6.10/arch/sparc/kernel/entry.S	2005-01-30 14:33:24.781908182 -0500
@@ -863,8 +863,11 @@
 	.globl	vac_hwflush_patch2
 
 	.align	4
+	.globl	vmalloc_start_addr
+vmalloc_start_addr:
+	.word	0xfe300000
	.globl	sun4c_fault

 ! %l0 = %psr
 ! %l1 = %pc
 ! %l2 = %npc
@@ -944,7 +947,8 @@
 	 and	%l5, %l4, %l5
 
 	/* Test for NULL pte_t * in vmalloc area. */
-	sethi   %hi(VMALLOC_START), %l4
+	sethi	%hi(vmalloc_start_addr), %l4
+	ld	[%l4 + %lo(vmalloc_start_addr)], %l4
 	cmp     %l5, %l4
 	blu,a   invalid_segment_patch1
 	 lduXa	[%l5] ASI_SEGMAP, %l4
@@ -1072,7 +1076,8 @@
 	andn	%l4, 0x1ff, %l5
 
 1:
-	sethi	%hi(VMALLOC_START), %l4
+	sethi	%hi(vmalloc_start_addr), %l4
+	ld	[%l4 + %lo(vmalloc_start_addr)], %l4
 	cmp	%l5, %l4
 
 	bgeu	1f
--- linux-2.6.10/arch/sparc/mm/init.c.BAD	2005-01-30 14:33:34.300461142 -0500
+++ linux-2.6.10/arch/sparc/mm/init.c	2005-01-30 14:36:27.501130638 -0500
@@ -402,6 +402,23 @@
 	int reservedpages = 0;
 	int i;
 
+	switch(sparc_cpu_model) {
+		case sun4:
+		case sun4c:
+			vmalloc_start_addr = VMALLOC_START_SUN4;
+			break;
+		case sun4d:
+		case sun4e:
+		case sun4m:
+			vmalloc_start_addr = VMALLOC_START_SUN4M;
+			break;
+		/* these are just to pacify gcc warnings */
+		case sun4u:
+		case sun_unknown:
+		case ap1000:
+			break;
+	};
+
 	if (PKMAP_BASE+LAST_PKMAP*PAGE_SIZE >= FIXADDR_START) {
 		prom_printf("BUG: fixmap and pkmap areas overlap\n");
 		prom_printf("pkbase: 0x%lx pkend: 0x%lx fixstart 0x%lx\n",
--- linux-2.6.10/arch/sparc/mm/sun4c.c.BAD	2005-01-30 14:38:04.846331918 -0500
+++ linux-2.6.10/arch/sparc/mm/sun4c.c	2005-01-30 14:38:30.156484190 -0500
@@ -2085,7 +2085,7 @@
 	memset(pg3, 0, PAGE_SIZE);
 
 	/* Save work later. */
-	vaddr = VMALLOC_START;
+	vaddr = vmalloc_start_addr;
 	swapper_pg_dir[vaddr>>SUN4C_PGDIR_SHIFT] = __pgd(PGD_TABLE | (unsigned long) pg0);
 	vaddr += SUN4C_PGDIR_SIZE;
 	swapper_pg_dir[vaddr>>SUN4C_PGDIR_SHIFT] = __pgd(PGD_TABLE | (unsigned long) pg1);
--- linux-2.6.10/include/asm-sparc/vaddrs.h.BAD	2005-01-30 14:36:39.942239302 -0500
+++ linux-2.6.10/include/asm-sparc/vaddrs.h	2005-01-30 14:37:56.557591998 -0500
@@ -35,7 +35,13 @@
 #define IOBASE_VADDR		0xfe000000
 #define IOBASE_END		0xfe600000
 
-#define VMALLOC_START		0xfe600000
+#ifndef __ASSEMBLY__
+extern unsigned long vmalloc_start_addr;
+#endif
+
+#define VMALLOC_START_SUN4	0xfe600000
+#define VMALLOC_START_SUN4M	0xfe300000
+#define VMALLOC_START		vmalloc_start_addr
 
 /* XXX Alter this when I get around to fixing sun4c - Anton */
 #define VMALLOC_END		0xffc00000
--- linux-2.6.10/arch/sparc/kernel/sparc_ksyms.c.BAD	2005-01-30 18:06:30.221225966 -0500
+++ linux-2.6.10/arch/sparc/kernel/sparc_ksyms.c	2005-01-30 18:06:59.802728894 -0500
@@ -135,6 +135,7 @@
 EXPORT_SYMBOL(__down_trylock);
 EXPORT_SYMBOL(__down_interruptible);
 
+EXPORT_SYMBOL(vmalloc_start_addr);
 EXPORT_SYMBOL(sparc_valid_addr_bitmap);
 EXPORT_SYMBOL(phys_base);
 EXPORT_SYMBOL(pfn_base);

--=-4Maekpf331UIlb/RDd4F--


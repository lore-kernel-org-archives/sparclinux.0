From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sat, 05 Feb 2005 18:34:45 +0000
Subject: Re: Badness in map_area_pte
Message-Id: <1107628485.3951.249.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-5Gx+/J1wOuj8qjemrRhT"
List-Id: <sparclinux.vger.kernel.org>
References: <41E96A42.7090501@mc.net>
In-Reply-To: <41E96A42.7090501@mc.net>
To: sparclinux@vger.kernel.org


--=-5Gx+/J1wOuj8qjemrRhT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-02-05 at 10:30 -0600, Tom 'spot' Callaway wrote:

> OK, how about this patch?

Sorry. That patch was broken, this patch is not.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
-- Sir Winston Churchill

--=-5Gx+/J1wOuj8qjemrRhT
Content-Disposition: attachment; filename=linux-2.6.10-sparc-vmallocstartfix3.patch
Content-Type: text/x-patch; name=linux-2.6.10-sparc-vmallocstartfix3.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.10/arch/sparc/kernel/entry.S.BAD	2005-02-05 09:41:05.967434326 -0500
+++ linux-2.6.10/arch/sparc/kernel/entry.S	2005-02-05 09:41:36.828742694 -0500
@@ -944,7 +944,7 @@
 	 and	%l5, %l4, %l5
 
 	/* Test for NULL pte_t * in vmalloc area. */
-	sethi   %hi(VMALLOC_START), %l4
+	sethi   %hi(VMALLOC_START_SUN4), %l4
 	cmp     %l5, %l4
 	blu,a   invalid_segment_patch1
 	 lduXa	[%l5] ASI_SEGMAP, %l4
@@ -1072,7 +1072,7 @@
 	andn	%l4, 0x1ff, %l5
 
 1:
-	sethi	%hi(VMALLOC_START), %l4
+	sethi	%hi(VMALLOC_START_SUN4), %l4
 	cmp	%l5, %l4
 
 	bgeu	1f
--- linux-2.6.10/arch/sparc/mm/init.c.BAD	2005-02-05 09:47:32.849619294 -0500
+++ linux-2.6.10/arch/sparc/mm/init.c	2005-02-05 09:56:03.119046550 -0500
@@ -44,6 +44,7 @@
 
 struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
 unsigned long sparc_unmapped_base;
+unsigned long vmalloc_start_addr;
 
 struct pgtable_cache_struct pgt_quicklists;
 
@@ -402,6 +403,27 @@
 	int reservedpages = 0;
 	int i;
 
+	switch(sparc_cpu_model) {
+	case sun4:
+	case sun4c:
+		vmalloc_start_addr = VMALLOC_START_SUN4;
+		BTFIXUPSET_SETHI(vmalloc_start_addr, VMALLOC_START_SUN4);
+		break;
+	case sun4d:
+	case sun4e:
+	case sun4m:
+		vmalloc_start_addr = VMALLOC_START_SUN4M;
+		BTFIXUPSET_SETHI(vmalloc_start_addr, VMALLOC_START_SUN4M);
+		break;
+	/* these are just to pacify gcc warnings */
+	case sun4u:
+	case sun_unknown:
+	case ap1000:
+	default:
+		break;
+	}
+
+
 	if (PKMAP_BASE+LAST_PKMAP*PAGE_SIZE >= FIXADDR_START) {
 		prom_printf("BUG: fixmap and pkmap areas overlap\n");
 		prom_printf("pkbase: 0x%lx pkend: 0x%lx fixstart 0x%lx\n",
--- linux-2.6.10/include/asm-sparc/vaddrs.h.BAD	2005-02-05 09:45:57.662089998 -0500
+++ linux-2.6.10/include/asm-sparc/vaddrs.h	2005-02-05 09:51:33.763994742 -0500
@@ -3,6 +3,7 @@
 #define _SPARC_VADDRS_H
 
 #include <asm/head.h>
+#include <asm/btfixup.h>
 
 /*
  * asm-sparc/vaddrs.h:  Here we define the virtual addresses at
@@ -35,7 +36,15 @@
 #define IOBASE_VADDR		0xfe000000
 #define IOBASE_END		0xfe600000
 
-#define VMALLOC_START		0xfe600000
+#define VMALLOC_START_SUN4	0xfe600000
+#define VMALLOC_START_SUN4M	0xfe300000
+#ifndef __ASSEMBLY__
+extern unsigned long vmalloc_start_addr;
+
+BTFIXUPDEF_SETHI(vmalloc_start_addr)
+
+#define VMALLOC_START		BTFIXUP_SETHI(vmalloc_start_addr)
+#endif
 
 /* XXX Alter this when I get around to fixing sun4c - Anton */
 #define VMALLOC_END		0xffc00000

--=-5Gx+/J1wOuj8qjemrRhT--


From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 21 Dec 2004 11:39:46 +0000
Subject: [sparc32] [2/4] pcic.c etc. __iomem annotation warnings
Message-Id: <20041221113946.GM771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Lots of warnings going about from __iomem annotations in/around pcic.
This patch silences the pcic-related ones.

Index: sparc32-2.6.10-rc3/include/asm-sparc/pcic.h
=================================--- sparc32-2.6.10-rc3.orig/include/asm-sparc/pcic.h	2004-06-15 22:19:13.000000000 -0700
+++ sparc32-2.6.10-rc3/include/asm-sparc/pcic.h	2004-12-21 03:00:03.122592490 -0800
@@ -16,10 +16,10 @@
 #include <asm/pbm.h>
 
 struct linux_pcic {
-        unsigned long           pcic_regs;
+        void * __iomem          pcic_regs;
         unsigned long           pcic_io;
-        unsigned long           pcic_config_space_addr;
-        unsigned long           pcic_config_space_data;
+        void * __iomem          pcic_config_space_addr;
+        void * __iomem          pcic_config_space_data;
 	struct resource		pcic_res_regs;
 	struct resource		pcic_res_io;
 	struct resource		pcic_res_cfg_addr;
Index: sparc32-2.6.10-rc3/arch/sparc/kernel/pcic.c
=================================--- sparc32-2.6.10-rc3.orig/arch/sparc/kernel/pcic.c	2004-12-16 06:19:27.000000000 -0800
+++ sparc32-2.6.10-rc3/arch/sparc/kernel/pcic.c	2004-12-21 03:02:31.782992674 -0800
@@ -161,7 +161,7 @@
 static int pcic0_up;
 static struct linux_pcic pcic0;
 
-unsigned int pcic_regs;
+void * __iomem pcic_regs;
 volatile int pcic_speculative;
 volatile int pcic_trapped;
 
@@ -313,8 +313,7 @@
 	pcic0_up = 1;
 
 	pcic->pcic_res_regs.name = "pcic_registers";
-	pcic->pcic_regs = (unsigned long)
-	    ioremap(regs[0].phys_addr, regs[0].reg_size);
+	pcic->pcic_regs = ioremap(regs[0].phys_addr, regs[0].reg_size);
 	if (!pcic->pcic_regs) {
 		prom_printf("PCIC: Error, cannot map PCIC registers.\n");
 		prom_halt();
@@ -328,7 +327,7 @@
 	}
 
 	pcic->pcic_res_cfg_addr.name = "pcic_cfg_addr";
-	if ((pcic->pcic_config_space_addr = (unsigned long)
+	if ((pcic->pcic_config_space_addr  	    ioremap(regs[2].phys_addr, regs[2].reg_size * 2)) = 0) {
 		prom_printf("PCIC: Error, cannot map" 
 			    "PCI Configuration Space Address.\n");
@@ -340,7 +339,7 @@
 	 * must be the same. Thus, we need adjust size of data.
 	 */
 	pcic->pcic_res_cfg_data.name = "pcic_cfg_data";
-	if ((pcic->pcic_config_space_data = (unsigned long)
+	if ((pcic->pcic_config_space_data  	    ioremap(regs[3].phys_addr, regs[3].reg_size * 2)) = 0) {
 		prom_printf("PCIC: Error, cannot map" 
 			    "PCI Configuration Space Data.\n");
@@ -976,7 +975,7 @@
  * We do not use horroble macroses here because we want to
  * advance pointer by sizeof(size).
  */
-void outsb(unsigned long addr, const void *src, unsigned long count) {
+void outsb(void * __iomem addr, const void *src, unsigned long count) {
 	while (count) {
 		count -= 1;
 		writeb(*(const char *)src, addr);
@@ -985,7 +984,7 @@
 	}
 }
 
-void outsw(unsigned long addr, const void *src, unsigned long count) {
+void outsw(void * __iomem addr, const void *src, unsigned long count) {
 	while (count) {
 		count -= 2;
 		writew(*(const short *)src, addr);
@@ -994,7 +993,7 @@
 	}
 }
 
-void outsl(unsigned long addr, const void *src, unsigned long count) {
+void outsl(void * __iomem addr, const void *src, unsigned long count) {
 	while (count) {
 		count -= 4;
 		writel(*(const long *)src, addr);
@@ -1003,7 +1002,7 @@
 	}
 }
 
-void insb(unsigned long addr, void *dst, unsigned long count) {
+void insb(void * __iomem addr, void *dst, unsigned long count) {
 	while (count) {
 		count -= 1;
 		*(unsigned char *)dst = readb(addr);
@@ -1012,7 +1011,7 @@
 	}
 }
 
-void insw(unsigned long addr, void *dst, unsigned long count) {
+void insw(void * __iomem addr, void *dst, unsigned long count) {
 	while (count) {
 		count -= 2;
 		*(unsigned short *)dst = readw(addr);
@@ -1021,7 +1020,7 @@
 	}
 }
 
-void insl(unsigned long addr, void *dst, unsigned long count) {
+void insl(void * __iomem addr, void *dst, unsigned long count) {
 	while (count) {
 		count -= 4;
 		/*
Index: sparc32-2.6.10-rc3/include/asm-sparc/io.h
=================================--- sparc32-2.6.10-rc3.orig/include/asm-sparc/io.h	2004-12-16 06:20:01.000000000 -0800
+++ sparc32-2.6.10-rc3/include/asm-sparc/io.h	2004-12-21 02:57:35.026106578 -0800
@@ -134,12 +134,12 @@
 #define inl_p(__addr)		inl(__addr)
 #define outl_p(__l, __addr)	outl(__l, __addr)
 
-extern void outsb(unsigned long addr, const void *src, unsigned long cnt);
-extern void outsw(unsigned long addr, const void *src, unsigned long cnt);
-extern void outsl(unsigned long addr, const void *src, unsigned long cnt);
-extern void insb(unsigned long addr, void *dst, unsigned long count);
-extern void insw(unsigned long addr, void *dst, unsigned long count);
-extern void insl(unsigned long addr, void *dst, unsigned long count);
+void outsb(void * __iomem addr, const void *src, unsigned long cnt);
+void outsw(void * __iomem addr, const void *src, unsigned long cnt);
+void outsl(void * __iomem addr, const void *src, unsigned long cnt);
+void insb(void * __iomem addr, void *dst, unsigned long count);
+void insw(void * __iomem addr, void *dst, unsigned long count);
+void insl(void * __iomem addr, void *dst, unsigned long count);
 
 #define IO_SPACE_LIMIT 0xffffffff
 

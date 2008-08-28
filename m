From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:24:55 +0000
Subject: [PATCH 38/49]: sparc: Kill sbus_ioremap() and sbus_iounmap().
Message-Id: <20080827.212455.110815996.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Kill sbus_ioremap() and sbus_iounmap().

No more users.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/io_32.h  |    8 --------
 arch/sparc/include/asm/io_64.h  |   13 -------------
 arch/sparc/kernel/ioport.c      |   16 ----------------
 arch/sparc/kernel/sparc_ksyms.c |    2 --
 4 files changed, 0 insertions(+), 39 deletions(-)

diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index 3ab3164..93fe21e 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -293,14 +293,6 @@ extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
 extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 
 /*
- * Bus number may be in res->flags... somewhere.
- */
-extern void __iomem *sbus_ioremap(struct resource *res, unsigned long offset,
-    unsigned long size, char *name);
-extern void sbus_iounmap(volatile void __iomem *vaddr, unsigned long size);
-
-
-/*
  * At the moment, we do not use CMOS_READ anywhere outside of rtc.c,
  * so rtc_port is static in it. This should not change unless a new
  * hardware pops up.
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 73a9c5d..4aee21d 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -482,19 +482,6 @@ struct pci_dev;
 extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
 extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 
-/* Similarly for SBUS. */
-#define sbus_ioremap(__res, __offset, __size, __name) \
-({	unsigned long __ret; \
-	__ret  = (__res)->start + (((__res)->flags & 0x1ffUL) << 32UL); \
-	__ret += (unsigned long) (__offset); \
-	if (! request_region((__ret), (__size), (__name))) \
-		__ret = 0UL; \
-	(void __iomem *) __ret; \
-})
-
-#define sbus_iounmap(__addr, __size)	\
-	release_region((unsigned long)(__addr), (__size))
-
 static inline int sbus_can_dma_64bit(void)
 {
 	return 1;
diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index d82a810..e6177dd 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -143,15 +143,6 @@ void iounmap(volatile void __iomem *virtual)
 	}
 }
 
-/*
- */
-void __iomem *sbus_ioremap(struct resource *phyres, unsigned long offset,
-    unsigned long size, char *name)
-{
-	return _sparc_alloc_io(phyres->flags & 0xF,
-	    phyres->start + offset, size, name);
-}
-
 void __iomem *of_ioremap(struct resource *res, unsigned long offset,
 			 unsigned long size, char *name)
 {
@@ -168,13 +159,6 @@ void of_iounmap(struct resource *res, void __iomem *base, unsigned long size)
 EXPORT_SYMBOL(of_iounmap);
 
 /*
- */
-void sbus_iounmap(volatile void __iomem *addr, unsigned long size)
-{
-	iounmap(addr);
-}
-
-/*
  * Meat of mapping
  */
 static void __iomem *_sparc_alloc_io(unsigned int busno, unsigned long phys,
diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
index 84aaac4..f2722ee 100644
--- a/arch/sparc/kernel/sparc_ksyms.c
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -154,8 +154,6 @@ EXPORT_SYMBOL(BTFIXUP_CALL(pgprot_noncached));
 
 #ifdef CONFIG_SBUS
 EXPORT_SYMBOL(sbus_set_sbus64);
-EXPORT_SYMBOL(sbus_iounmap);
-EXPORT_SYMBOL(sbus_ioremap);
 #endif
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL(ebus_chain);
-- 
1.5.6.5.GIT


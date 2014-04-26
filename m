From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 Apr 2014 07:57:36 +0000
Subject: [PATCH 3/4] sparc32: introduce asm-generic/io.h
Message-Id: <1398499057-21497-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Use asm-generic/io.h definitions where applicable.
The inxx() and outxx() methods whcih was duplicated in pcic.c +
leon_pci.c are replaced by a set of static inlins from asm-generic/io.h

iomap.c is replaced by the generic versions, but are still
present to support sparc64.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/io_32.h | 242 ++++++-----------------------------------
 arch/sparc/kernel/leon_pci.c   |  79 --------------
 arch/sparc/kernel/pcic.c       |  78 -------------
 arch/sparc/lib/Makefile        |   2 +-
 4 files changed, 35 insertions(+), 366 deletions(-)

diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index 271c94a..d281d4c 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -2,142 +2,56 @@
 #define __SPARC_IO_H
 
 #include <linux/kernel.h>
-#include <linux/types.h>
 #include <linux/ioport.h>  /* struct resource */
 
-#include <asm/page.h>      /* IO address mapping routines need this */
-#include <asm-generic/pci_iomap.h>
-
-static inline u32 flip_dword (u32 l)
-{
-	return ((l&0xff)<<24) | (((l>>8)&0xff)<<16) | (((l>>16)&0xff)<<8)| ((l>>24)&0xff);
-}
-
-static inline u16 flip_word (u16 w)
-{
-	return ((w&0xff) << 8) | ((w>>8)&0xff);
-}
-
-#define mmiowb()
-
-/*
- * Memory mapped I/O to PCI
- */
-
-static inline u8 __raw_readb(const volatile void __iomem *addr)
-{
-	return *(__force volatile u8 *)addr;
-}
-
-static inline u16 __raw_readw(const volatile void __iomem *addr)
-{
-	return *(__force volatile u16 *)addr;
-}
-
-static inline u32 __raw_readl(const volatile void __iomem *addr)
-{
-	return *(__force volatile u32 *)addr;
-}
+#define readb_relaxed(__addr)	readb(__addr)
+#define readw_relaxed(__addr)	readw(__addr)
+#define readl_relaxed(__addr)	readl(__addr)
 
-static inline void __raw_writeb(u8 b, volatile void __iomem *addr)
-{
-	*(__force volatile u8 *)addr = b;
-}
+#define IO_SPACE_LIMIT 0xffffffff
 
-static inline void __raw_writew(u16 w, volatile void __iomem *addr)
-{
-	*(__force volatile u16 *)addr = w;
-}
+#define memset_io(d,c,sz)     _memset_io(d,c,sz)
+#define memcpy_fromio(d,s,sz) _memcpy_fromio(d,s,sz)
+#define memcpy_toio(d,s,sz)   _memcpy_toio(d,s,sz)
 
-static inline void __raw_writel(u32 l, volatile void __iomem *addr)
-{
-	*(__force volatile u32 *)addr = l;
-}
+#include <asm-generic/io.h>
 
-static inline u8 __readb(const volatile void __iomem *addr)
+static inline void _memset_io(volatile void __iomem *dst,
+                              int c, __kernel_size_t n)
 {
-	return *(__force volatile u8 *)addr;
-}
+	volatile void __iomem *d = dst;
 
-static inline u16 __readw(const volatile void __iomem *addr)
-{
-	return flip_word(*(__force volatile u16 *)addr);
+	while (n--) {
+		writeb(c, d);
+		d++;
+	}
 }
 
-static inline u32 __readl(const volatile void __iomem *addr)
+static inline void _memcpy_fromio(void *dst, const volatile void __iomem *src,
+                                  __kernel_size_t n)
 {
-	return flip_dword(*(__force volatile u32 *)addr);
-}
+	char *d = dst;
 
-static inline void __writeb(u8 b, volatile void __iomem *addr)
-{
-	*(__force volatile u8 *)addr = b;
+	while (n--) {
+		char tmp = readb(src);
+		*d++ = tmp;
+		src++;
+	}
 }
 
-static inline void __writew(u16 w, volatile void __iomem *addr)
+static inline void _memcpy_toio(volatile void __iomem *dst, const void *src,
+                                __kernel_size_t n)
 {
-	*(__force volatile u16 *)addr = flip_word(w);
-}
+	const char *s = src;
+	volatile void __iomem *d = dst;
 
-static inline void __writel(u32 l, volatile void __iomem *addr)
-{
-	*(__force volatile u32 *)addr = flip_dword(l);
+	while (n--) {
+		char tmp = *s++;
+		writeb(tmp, d);
+		d++;
+	}
 }
 
-#define readb(__addr)		__readb(__addr)
-#define readw(__addr)		__readw(__addr)
-#define readl(__addr)		__readl(__addr)
-#define readb_relaxed(__addr)	readb(__addr)
-#define readw_relaxed(__addr)	readw(__addr)
-#define readl_relaxed(__addr)	readl(__addr)
-
-#define writeb(__b, __addr)	__writeb((__b),(__addr))
-#define writew(__w, __addr)	__writew((__w),(__addr))
-#define writel(__l, __addr)	__writel((__l),(__addr))
-
-/*
- * I/O space operations
- *
- * Arrangement on a Sun is somewhat complicated.
- *
- * First of all, we want to use standard Linux drivers
- * for keyboard, PC serial, etc. These drivers think
- * they access I/O space and use inb/outb.
- * On the other hand, EBus bridge accepts PCI *memory*
- * cycles and converts them into ISA *I/O* cycles.
- * Ergo, we want inb & outb to generate PCI memory cycles.
- *
- * If we want to issue PCI *I/O* cycles, we do this
- * with a low 64K fixed window in PCIC. This window gets
- * mapped somewhere into virtual kernel space and we
- * can use inb/outb again.
- */
-#define inb_local(__addr)	__readb((void __iomem *)(unsigned long)(__addr))
-#define inb(__addr)		__readb((void __iomem *)(unsigned long)(__addr))
-#define inw(__addr)		__readw((void __iomem *)(unsigned long)(__addr))
-#define inl(__addr)		__readl((void __iomem *)(unsigned long)(__addr))
-
-#define outb_local(__b, __addr)	__writeb(__b, (void __iomem *)(unsigned long)(__addr))
-#define outb(__b, __addr)	__writeb(__b, (void __iomem *)(unsigned long)(__addr))
-#define outw(__w, __addr)	__writew(__w, (void __iomem *)(unsigned long)(__addr))
-#define outl(__l, __addr)	__writel(__l, (void __iomem *)(unsigned long)(__addr))
-
-#define inb_p(__addr)		inb(__addr)
-#define outb_p(__b, __addr)	outb(__b, __addr)
-#define inw_p(__addr)		inw(__addr)
-#define outw_p(__w, __addr)	outw(__w, __addr)
-#define inl_p(__addr)		inl(__addr)
-#define outl_p(__l, __addr)	outl(__l, __addr)
-
-void outsb(unsigned long addr, const void *src, unsigned long cnt);
-void outsw(unsigned long addr, const void *src, unsigned long cnt);
-void outsl(unsigned long addr, const void *src, unsigned long cnt);
-void insb(unsigned long addr, void *dst, unsigned long count);
-void insw(unsigned long addr, void *dst, unsigned long count);
-void insl(unsigned long addr, void *dst, unsigned long count);
-
-#define IO_SPACE_LIMIT 0xffffffff
-
 /*
  * SBus accessors.
  *
@@ -192,18 +106,7 @@ static inline void sbus_memset_io(volatile void __iomem *__dst, int c, __kernel_
 	}
 }
 
-static inline void
-_memset_io(volatile void __iomem *dst, int c, __kernel_size_t n)
-{
-	volatile void __iomem *d = dst;
-
-	while (n--) {
-		writeb(c, d);
-		d++;
-	}
-}
 
-#define memset_io(d,c,sz)	_memset_io(d,c,sz)
 
 static inline void
 _sbus_memcpy_fromio(void *dst, const volatile void __iomem *src,
@@ -221,20 +124,6 @@ _sbus_memcpy_fromio(void *dst, const volatile void __iomem *src,
 #define sbus_memcpy_fromio(d, s, sz)	_sbus_memcpy_fromio(d, s, sz)
 
 static inline void
-_memcpy_fromio(void *dst, const volatile void __iomem *src, __kernel_size_t n)
-{
-	char *d = dst;
-
-	while (n--) {
-		char tmp = readb(src);
-		*d++ = tmp;
-		src++;
-	}
-}
-
-#define memcpy_fromio(d,s,sz)	_memcpy_fromio(d,s,sz)
-
-static inline void
 _sbus_memcpy_toio(volatile void __iomem *dst, const void *src,
 		  __kernel_size_t n)
 {
@@ -250,21 +139,6 @@ _sbus_memcpy_toio(volatile void __iomem *dst, const void *src,
 
 #define sbus_memcpy_toio(d, s, sz)	_sbus_memcpy_toio(d, s, sz)
 
-static inline void
-_memcpy_toio(volatile void __iomem *dst, const void *src, __kernel_size_t n)
-{
-	const char *s = src;
-	volatile void __iomem *d = dst;
-
-	while (n--) {
-		char tmp = *s++;
-		writeb(tmp, d);
-		d++;
-	}
-}
-
-#define memcpy_toio(d,s,sz)	_memcpy_toio(d,s,sz)
-
 #ifdef __KERNEL__
 
 /*
@@ -276,46 +150,6 @@ extern void __iomem *ioremap(unsigned long offset, unsigned long size);
 #define ioremap_wc(X,Y)		ioremap((X),(Y))
 extern void iounmap(volatile void __iomem *addr);
 
-#define ioread8(X)			readb(X)
-#define ioread16(X)			readw(X)
-#define ioread16be(X)			__raw_readw(X)
-#define ioread32(X)			readl(X)
-#define ioread32be(X)			__raw_readl(X)
-#define iowrite8(val,X)			writeb(val,X)
-#define iowrite16(val,X)		writew(val,X)
-#define iowrite16be(val,X)		__raw_writew(val,X)
-#define iowrite32(val,X)		writel(val,X)
-#define iowrite32be(val,X)		__raw_writel(val,X)
-
-static inline void ioread8_rep(void __iomem *port, void *buf, unsigned long count)
-{
-	insb((unsigned long __force)port, buf, count);
-}
-static inline void ioread16_rep(void __iomem *port, void *buf, unsigned long count)
-{
-	insw((unsigned long __force)port, buf, count);
-}
-
-static inline void ioread32_rep(void __iomem *port, void *buf, unsigned long count)
-{
-	insl((unsigned long __force)port, buf, count);
-}
-
-static inline void iowrite8_rep(void __iomem *port, const void *buf, unsigned long count)
-{
-	outsb((unsigned long __force)port, buf, count);
-}
-
-static inline void iowrite16_rep(void __iomem *port, const void *buf, unsigned long count)
-{
-	outsw((unsigned long __force)port, buf, count);
-}
-
-static inline void iowrite32_rep(void __iomem *port, const void *buf, unsigned long count)
-{
-	outsl((unsigned long __force)port, buf, count);
-}
-
 /* Create a virtual mapping cookie for an IO port range */
 extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
 extern void ioport_unmap(void __iomem *);
@@ -324,6 +158,8 @@ extern void ioport_unmap(void __iomem *);
 struct pci_dev;
 extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
 
+
+
 /*
  * At the moment, we do not use CMOS_READ anywhere outside of rtc.c,
  * so rtc_port is static in it. This should not change unless a new
@@ -347,15 +183,5 @@ extern void sbus_set_sbus64(struct device *, int);
 
 #define __ARCH_HAS_NO_PAGE_ZERO_MAPPED		1
 
-/*
- * Convert a physical pointer to a virtual kernel pointer for /dev/mem
- * access
- */
-#define xlate_dev_mem_ptr(p)	__va(p)
-
-/*
- * Convert a virtual cached pointer to an uncached pointer
- */
-#define xlate_dev_kmem_ptr(p)	p
 
 #endif /* !(__SPARC_IO_H) */
diff --git a/arch/sparc/kernel/leon_pci.c b/arch/sparc/kernel/leon_pci.c
index e16c415..899b720 100644
--- a/arch/sparc/kernel/leon_pci.c
+++ b/arch/sparc/kernel/leon_pci.c
@@ -98,82 +98,3 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 {
 	return res->start;
 }
-
-/* in/out routines taken from pcic.c
- *
- * This probably belongs here rather than ioport.c because
- * we do not want this crud linked into SBus kernels.
- * Also, think for a moment about likes of floppy.c that
- * include architecture specific parts. They may want to redefine ins/outs.
- *
- * We do not use horrible macros here because we want to
- * advance pointer by sizeof(size).
- */
-void outsb(unsigned long addr, const void *src, unsigned long count)
-{
-	while (count) {
-		count -= 1;
-		outb(*(const char *)src, addr);
-		src += 1;
-		/* addr += 1; */
-	}
-}
-EXPORT_SYMBOL(outsb);
-
-void outsw(unsigned long addr, const void *src, unsigned long count)
-{
-	while (count) {
-		count -= 2;
-		outw(*(const short *)src, addr);
-		src += 2;
-		/* addr += 2; */
-	}
-}
-EXPORT_SYMBOL(outsw);
-
-void outsl(unsigned long addr, const void *src, unsigned long count)
-{
-	while (count) {
-		count -= 4;
-		outl(*(const long *)src, addr);
-		src += 4;
-		/* addr += 4; */
-	}
-}
-EXPORT_SYMBOL(outsl);
-
-void insb(unsigned long addr, void *dst, unsigned long count)
-{
-	while (count) {
-		count -= 1;
-		*(unsigned char *)dst = inb(addr);
-		dst += 1;
-		/* addr += 1; */
-	}
-}
-EXPORT_SYMBOL(insb);
-
-void insw(unsigned long addr, void *dst, unsigned long count)
-{
-	while (count) {
-		count -= 2;
-		*(unsigned short *)dst = inw(addr);
-		dst += 2;
-		/* addr += 2; */
-	}
-}
-EXPORT_SYMBOL(insw);
-
-void insl(unsigned long addr, void *dst, unsigned long count)
-{
-	while (count) {
-		count -= 4;
-		/*
-		 * XXX I am sure we are in for an unaligned trap here.
-		 */
-		*(unsigned long *)dst = inl(addr);
-		dst += 4;
-		/* addr += 4; */
-	}
-}
-EXPORT_SYMBOL(insl);
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index 6996f32..aabfcab 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -875,82 +875,4 @@ void __init sun4m_pci_init_IRQ(void)
 	sparc_config.load_profile_irq = pcic_load_profile_irq;
 }
 
-/*
- * This probably belongs here rather than ioport.c because
- * we do not want this crud linked into SBus kernels.
- * Also, think for a moment about likes of floppy.c that
- * include architecture specific parts. They may want to redefine ins/outs.
- *
- * We do not use horrible macros here because we want to
- * advance pointer by sizeof(size).
- */
-void outsb(unsigned long addr, const void *src, unsigned long count)
-{
-	while (count) {
-		count -= 1;
-		outb(*(const char *)src, addr);
-		src += 1;
-		/* addr += 1; */
-	}
-}
-EXPORT_SYMBOL(outsb);
-
-void outsw(unsigned long addr, const void *src, unsigned long count)
-{
-	while (count) {
-		count -= 2;
-		outw(*(const short *)src, addr);
-		src += 2;
-		/* addr += 2; */
-	}
-}
-EXPORT_SYMBOL(outsw);
-
-void outsl(unsigned long addr, const void *src, unsigned long count)
-{
-	while (count) {
-		count -= 4;
-		outl(*(const long *)src, addr);
-		src += 4;
-		/* addr += 4; */
-	}
-}
-EXPORT_SYMBOL(outsl);
-
-void insb(unsigned long addr, void *dst, unsigned long count)
-{
-	while (count) {
-		count -= 1;
-		*(unsigned char *)dst = inb(addr);
-		dst += 1;
-		/* addr += 1; */
-	}
-}
-EXPORT_SYMBOL(insb);
-
-void insw(unsigned long addr, void *dst, unsigned long count)
-{
-	while (count) {
-		count -= 2;
-		*(unsigned short *)dst = inw(addr);
-		dst += 2;
-		/* addr += 2; */
-	}
-}
-EXPORT_SYMBOL(insw);
-
-void insl(unsigned long addr, void *dst, unsigned long count)
-{
-	while (count) {
-		count -= 4;
-		/*
-		 * XXX I am sure we are in for an unaligned trap here.
-		 */
-		*(unsigned long *)dst = inl(addr);
-		dst += 4;
-		/* addr += 4; */
-	}
-}
-EXPORT_SYMBOL(insl);
-
 subsys_initcall(pcic_init);
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index dbe119b..3269b02 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -41,7 +41,7 @@ lib-$(CONFIG_SPARC64) += GENpatch.o GENpage.o GENbzero.o
 lib-$(CONFIG_SPARC64) += copy_in_user.o user_fixup.o memmove.o
 lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o hweight.o ffs.o
 
-obj-y                 += iomap.o
+obj-$(CONFIG_SPARC64) += iomap.o
 obj-$(CONFIG_SPARC32) += atomic32.o ucmpdi2.o
 obj-y                 += ksyms.o
 obj-$(CONFIG_SPARC64) += PeeCeeI.o
-- 
1.9.0


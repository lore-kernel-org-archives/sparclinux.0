From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Jul 2014 11:39:00 +0000
Subject: [PATCH 3/6] sparc64: remove macro indirection in io_64.h
Message-Id: <1405856343-3762-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Most likely for historical reasons io_64.h used an
extra layer of macro indirections.

Fix it so we no longer use these indirections.
In the process we loose a cast to the addr argument for in*()/out*()
but all known affected users has already been fixed so
no warnings are triggered.

For each of the IO functions add a proper define like this:

    #define inb inb

This is done to make the code compatible with the way these
functions are defined in asm-generic/io.h with the objective
to later introduce the generic io.h for sparc64.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/io_64.h | 155 ++++++++++++++++++-----------------------
 1 file changed, 66 insertions(+), 89 deletions(-)

diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 05381c3..7db75eb 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -16,7 +16,8 @@
 /* BIO layer definitions. */
 extern unsigned long kern_base, kern_size;
 
-static inline u8 _inb(unsigned long addr)
+#define inb inb
+static inline u8 inb(unsigned long addr)
 {
 	u8 ret;
 
@@ -28,7 +29,8 @@ static inline u8 _inb(unsigned long addr)
 	return ret;
 }
 
-static inline u16 _inw(unsigned long addr)
+#define inw inw
+static inline u16 inw(unsigned long addr)
 {
 	u16 ret;
 
@@ -40,7 +42,8 @@ static inline u16 _inw(unsigned long addr)
 	return ret;
 }
 
-static inline u32 _inl(unsigned long addr)
+#define inl inl
+static inline u32 inl(unsigned long addr)
 {
 	u32 ret;
 
@@ -52,7 +55,8 @@ static inline u32 _inl(unsigned long addr)
 	return ret;
 }
 
-static inline void _outb(u8 b, unsigned long addr)
+#define outb outb
+static inline void outb(u8 b, unsigned long addr)
 {
 	__asm__ __volatile__("stba\t%r0, [%1] %2\t/* pci_outb */"
 			     : /* no outputs */
@@ -60,7 +64,8 @@ static inline void _outb(u8 b, unsigned long addr)
 			     : "memory");
 }
 
-static inline void _outw(u16 w, unsigned long addr)
+#define outw outw
+static inline void outw(u16 w, unsigned long addr)
 {
 	__asm__ __volatile__("stha\t%r0, [%1] %2\t/* pci_outw */"
 			     : /* no outputs */
@@ -68,7 +73,8 @@ static inline void _outw(u16 w, unsigned long addr)
 			     : "memory");
 }
 
-static inline void _outl(u32 l, unsigned long addr)
+#define outl outl
+static inline void outl(u32 l, unsigned long addr)
 {
 	__asm__ __volatile__("stwa\t%r0, [%1] %2\t/* pci_outl */"
 			     : /* no outputs */
@@ -76,12 +82,6 @@ static inline void _outl(u32 l, unsigned long addr)
 			     : "memory");
 }
 
-#define inb(__addr)		(_inb((unsigned long)(__addr)))
-#define inw(__addr)		(_inw((unsigned long)(__addr)))
-#define inl(__addr)		(_inl((unsigned long)(__addr)))
-#define outb(__b, __addr)	(_outb((u8)(__b), (unsigned long)(__addr)))
-#define outw(__w, __addr)	(_outw((u16)(__w), (unsigned long)(__addr)))
-#define outl(__l, __addr)	(_outl((u32)(__l), (unsigned long)(__addr)))
 
 #define inb_p(__addr) 		inb(__addr)
 #define outb_p(__b, __addr)	outb(__b, __addr)
@@ -127,7 +127,8 @@ static inline void iowrite32_rep(void __iomem *port, const void *buf, unsigned l
 }
 
 /* Memory functions, same as I/O accesses on Ultra. */
-static inline u8 _readb(const volatile void __iomem *addr)
+#define readb readb
+static inline u8 readb(const volatile void __iomem *addr)
 {	u8 ret;
 
 	__asm__ __volatile__("lduba\t[%1] %2, %0\t/* pci_readb */"
@@ -137,7 +138,8 @@ static inline u8 _readb(const volatile void __iomem *addr)
 	return ret;
 }
 
-static inline u16 _readw(const volatile void __iomem *addr)
+#define readw readw
+static inline u16 readw(const volatile void __iomem *addr)
 {	u16 ret;
 
 	__asm__ __volatile__("lduha\t[%1] %2, %0\t/* pci_readw */"
@@ -148,7 +150,8 @@ static inline u16 _readw(const volatile void __iomem *addr)
 	return ret;
 }
 
-static inline u32 _readl(const volatile void __iomem *addr)
+#define readl readl
+static inline u32 readl(const volatile void __iomem *addr)
 {	u32 ret;
 
 	__asm__ __volatile__("lduwa\t[%1] %2, %0\t/* pci_readl */"
@@ -159,7 +162,8 @@ static inline u32 _readl(const volatile void __iomem *addr)
 	return ret;
 }
 
-static inline u64 _readq(const volatile void __iomem *addr)
+#define readq readq
+static inline u64 readq(const volatile void __iomem *addr)
 {	u64 ret;
 
 	__asm__ __volatile__("ldxa\t[%1] %2, %0\t/* pci_readq */"
@@ -170,7 +174,8 @@ static inline u64 _readq(const volatile void __iomem *addr)
 	return ret;
 }
 
-static inline void _writeb(u8 b, volatile void __iomem *addr)
+#define writeb writeb
+static inline void writeb(u8 b, volatile void __iomem *addr)
 {
 	__asm__ __volatile__("stba\t%r0, [%1] %2\t/* pci_writeb */"
 			     : /* no outputs */
@@ -178,7 +183,8 @@ static inline void _writeb(u8 b, volatile void __iomem *addr)
 			     : "memory");
 }
 
-static inline void _writew(u16 w, volatile void __iomem *addr)
+#define writew writew
+static inline void writew(u16 w, volatile void __iomem *addr)
 {
 	__asm__ __volatile__("stha\t%r0, [%1] %2\t/* pci_writew */"
 			     : /* no outputs */
@@ -186,7 +192,8 @@ static inline void _writew(u16 w, volatile void __iomem *addr)
 			     : "memory");
 }
 
-static inline void _writel(u32 l, volatile void __iomem *addr)
+#define writel writel
+static inline void writel(u32 l, volatile void __iomem *addr)
 {
 	__asm__ __volatile__("stwa\t%r0, [%1] %2\t/* pci_writel */"
 			     : /* no outputs */
@@ -194,7 +201,8 @@ static inline void _writel(u32 l, volatile void __iomem *addr)
 			     : "memory");
 }
 
-static inline void _writeq(u64 q, volatile void __iomem *addr)
+#define writeq writeq
+static inline void writeq(u64 q, volatile void __iomem *addr)
 {
 	__asm__ __volatile__("stxa\t%r0, [%1] %2\t/* pci_writeq */"
 			     : /* no outputs */
@@ -202,21 +210,14 @@ static inline void _writeq(u64 q, volatile void __iomem *addr)
 			     : "memory");
 }
 
-#define readb(__addr)		_readb(__addr)
-#define readw(__addr)		_readw(__addr)
-#define readl(__addr)		_readl(__addr)
-#define readq(__addr)		_readq(__addr)
-#define readb_relaxed(__addr)	_readb(__addr)
-#define readw_relaxed(__addr)	_readw(__addr)
-#define readl_relaxed(__addr)	_readl(__addr)
-#define readq_relaxed(__addr)	_readq(__addr)
-#define writeb(__b, __addr)	_writeb(__b, __addr)
-#define writew(__w, __addr)	_writew(__w, __addr)
-#define writel(__l, __addr)	_writel(__l, __addr)
-#define writeq(__q, __addr)	_writeq(__q, __addr)
+#define readb_relaxed(__addr)	readb(__addr)
+#define readw_relaxed(__addr)	readw(__addr)
+#define readl_relaxed(__addr)	readl(__addr)
+#define readq_relaxed(__addr)	readq(__addr)
 
 /* Now versions without byte-swapping. */
-static inline u8 _raw_readb(unsigned long addr)
+#define __raw_readb __raw_readb
+static inline u8 __raw_readb(const volatile void __iomem *addr)
 {
 	u8 ret;
 
@@ -227,7 +228,8 @@ static inline u8 _raw_readb(unsigned long addr)
 	return ret;
 }
 
-static inline u16 _raw_readw(unsigned long addr)
+#define __raw_readw __raw_readw
+static inline u16 __raw_readw(const volatile void __iomem *addr)
 {
 	u16 ret;
 
@@ -238,7 +240,8 @@ static inline u16 _raw_readw(unsigned long addr)
 	return ret;
 }
 
-static inline u32 _raw_readl(unsigned long addr)
+#define __raw_readl __raw_readl
+static inline u32 __raw_readl(const volatile void __iomem *addr)
 {
 	u32 ret;
 
@@ -249,7 +252,8 @@ static inline u32 _raw_readl(unsigned long addr)
 	return ret;
 }
 
-static inline u64 _raw_readq(unsigned long addr)
+#define __raw_readq __raw_readq
+static inline u64 __raw_readq(const volatile void __iomem *addr)
 {
 	u64 ret;
 
@@ -260,42 +264,38 @@ static inline u64 _raw_readq(unsigned long addr)
 	return ret;
 }
 
-static inline void _raw_writeb(u8 b, unsigned long addr)
+#define __raw_writeb __raw_writeb
+static inline void __raw_writeb(u8 b, const volatile void __iomem *addr)
 {
 	__asm__ __volatile__("stba\t%r0, [%1] %2\t/* pci_raw_writeb */"
 			     : /* no outputs */
 			     : "Jr" (b), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
 }
 
-static inline void _raw_writew(u16 w, unsigned long addr)
+#define __raw_writew __raw_writew
+static inline void __raw_writew(u16 w, const volatile void __iomem *addr)
 {
 	__asm__ __volatile__("stha\t%r0, [%1] %2\t/* pci_raw_writew */"
 			     : /* no outputs */
 			     : "Jr" (w), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
 }
 
-static inline void _raw_writel(u32 l, unsigned long addr)
+#define __raw_writel __raw_writel
+static inline void __raw_writel(u32 l, const volatile void __iomem *addr)
 {
 	__asm__ __volatile__("stwa\t%r0, [%1] %2\t/* pci_raw_writel */"
 			     : /* no outputs */
 			     : "Jr" (l), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
 }
 
-static inline void _raw_writeq(u64 q, unsigned long addr)
+#define __raw_writeq __raw_writeq
+static inline void __raw_writeq(u64 q, const volatile void __iomem *addr)
 {
 	__asm__ __volatile__("stxa\t%r0, [%1] %2\t/* pci_raw_writeq */"
 			     : /* no outputs */
 			     : "Jr" (q), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
 }
 
-#define __raw_readb(__addr)		(_raw_readb((unsigned long)(__addr)))
-#define __raw_readw(__addr)		(_raw_readw((unsigned long)(__addr)))
-#define __raw_readl(__addr)		(_raw_readl((unsigned long)(__addr)))
-#define __raw_readq(__addr)		(_raw_readq((unsigned long)(__addr)))
-#define __raw_writeb(__b, __addr)	(_raw_writeb((u8)(__b), (unsigned long)(__addr)))
-#define __raw_writew(__w, __addr)	(_raw_writew((u16)(__w), (unsigned long)(__addr)))
-#define __raw_writel(__l, __addr)	(_raw_writel((u32)(__l), (unsigned long)(__addr)))
-#define __raw_writeq(__q, __addr)	(_raw_writeq((u64)(__q), (unsigned long)(__addr)))
 
 /* Valid I/O Space regions are anywhere, because each PCI bus supported
  * can live in an arbitrary area of the physical address range.
@@ -305,7 +305,7 @@ static inline void _raw_writeq(u64 q, unsigned long addr)
 /* Now, SBUS variants, only difference from PCI is that we do
  * not use little-endian ASIs.
  */
-static inline u8 _sbus_readb(const volatile void __iomem *addr)
+static inline u8 sbus_readb(const volatile void __iomem *addr)
 {
 	u8 ret;
 
@@ -317,7 +317,7 @@ static inline u8 _sbus_readb(const volatile void __iomem *addr)
 	return ret;
 }
 
-static inline u16 _sbus_readw(const volatile void __iomem *addr)
+static inline u16 sbus_readw(const volatile void __iomem *addr)
 {
 	u16 ret;
 
@@ -329,7 +329,7 @@ static inline u16 _sbus_readw(const volatile void __iomem *addr)
 	return ret;
 }
 
-static inline u32 _sbus_readl(const volatile void __iomem *addr)
+static inline u32 sbus_readl(const volatile void __iomem *addr)
 {
 	u32 ret;
 
@@ -341,7 +341,7 @@ static inline u32 _sbus_readl(const volatile void __iomem *addr)
 	return ret;
 }
 
-static inline u64 _sbus_readq(const volatile void __iomem *addr)
+static inline u64 sbus_readq(const volatile void __iomem *addr)
 {
 	u64 ret;
 
@@ -353,7 +353,7 @@ static inline u64 _sbus_readq(const volatile void __iomem *addr)
 	return ret;
 }
 
-static inline void _sbus_writeb(u8 b, volatile void __iomem *addr)
+static inline void sbus_writeb(u8 b, volatile void __iomem *addr)
 {
 	__asm__ __volatile__("stba\t%r0, [%1] %2\t/* sbus_writeb */"
 			     : /* no outputs */
@@ -361,7 +361,7 @@ static inline void _sbus_writeb(u8 b, volatile void __iomem *addr)
 			     : "memory");
 }
 
-static inline void _sbus_writew(u16 w, volatile void __iomem *addr)
+static inline void sbus_writew(u16 w, volatile void __iomem *addr)
 {
 	__asm__ __volatile__("stha\t%r0, [%1] %2\t/* sbus_writew */"
 			     : /* no outputs */
@@ -369,7 +369,7 @@ static inline void _sbus_writew(u16 w, volatile void __iomem *addr)
 			     : "memory");
 }
 
-static inline void _sbus_writel(u32 l, volatile void __iomem *addr)
+static inline void sbus_writel(u32 l, volatile void __iomem *addr)
 {
 	__asm__ __volatile__("stwa\t%r0, [%1] %2\t/* sbus_writel */"
 			     : /* no outputs */
@@ -377,7 +377,7 @@ static inline void _sbus_writel(u32 l, volatile void __iomem *addr)
 			     : "memory");
 }
 
-static inline void _sbus_writeq(u64 l, volatile void __iomem *addr)
+static inline void sbus_writeq(u64 l, volatile void __iomem *addr)
 {
 	__asm__ __volatile__("stxa\t%r0, [%1] %2\t/* sbus_writeq */"
 			     : /* no outputs */
@@ -385,16 +385,7 @@ static inline void _sbus_writeq(u64 l, volatile void __iomem *addr)
 			     : "memory");
 }
 
-#define sbus_readb(__addr)		_sbus_readb(__addr)
-#define sbus_readw(__addr)		_sbus_readw(__addr)
-#define sbus_readl(__addr)		_sbus_readl(__addr)
-#define sbus_readq(__addr)		_sbus_readq(__addr)
-#define sbus_writeb(__b, __addr)	_sbus_writeb(__b, __addr)
-#define sbus_writew(__w, __addr)	_sbus_writew(__w, __addr)
-#define sbus_writel(__l, __addr)	_sbus_writel(__l, __addr)
-#define sbus_writeq(__l, __addr)	_sbus_writeq(__l, __addr)
-
-static inline void _sbus_memset_io(volatile void __iomem *dst, int c, __kernel_size_t n)
+static inline void sbus_memset_io(volatile void __iomem *dst, int c, __kernel_size_t n)
 {
 	while(n--) {
 		sbus_writeb(c, dst);
@@ -402,10 +393,7 @@ static inline void _sbus_memset_io(volatile void __iomem *dst, int c, __kernel_s
 	}
 }
 
-#define sbus_memset_io(d,c,sz)	_sbus_memset_io(d,c,sz)
-
-static inline void
-_memset_io(volatile void __iomem *dst, int c, __kernel_size_t n)
+static inline void memset_io(volatile void __iomem *dst, int c, __kernel_size_t n)
 {
 	volatile void __iomem *d = dst;
 
@@ -415,11 +403,8 @@ _memset_io(volatile void __iomem *dst, int c, __kernel_size_t n)
 	}
 }
 
-#define memset_io(d,c,sz)	_memset_io(d,c,sz)
-
-static inline void
-_sbus_memcpy_fromio(void *dst, const volatile void __iomem *src,
-		    __kernel_size_t n)
+static inline void sbus_memcpy_fromio(void *dst, const volatile void __iomem *src,
+				      __kernel_size_t n)
 {
 	char *d = dst;
 
@@ -430,10 +415,9 @@ _sbus_memcpy_fromio(void *dst, const volatile void __iomem *src,
 	}
 }
 
-#define sbus_memcpy_fromio(d, s, sz)	_sbus_memcpy_fromio(d, s, sz)
 
-static inline void
-_memcpy_fromio(void *dst, const volatile void __iomem *src, __kernel_size_t n)
+static inline void memcpy_fromio(void *dst, const volatile void __iomem *src,
+				 __kernel_size_t n)
 {
 	char *d = dst;
 
@@ -444,11 +428,8 @@ _memcpy_fromio(void *dst, const volatile void __iomem *src, __kernel_size_t n)
 	}
 }
 
-#define memcpy_fromio(d,s,sz)	_memcpy_fromio(d,s,sz)
-
-static inline void
-_sbus_memcpy_toio(volatile void __iomem *dst, const void *src,
-		  __kernel_size_t n)
+static inline void sbus_memcpy_toio(volatile void __iomem *dst, const void *src,
+				    __kernel_size_t n)
 {
 	const char *s = src;
 	volatile void __iomem *d = dst;
@@ -460,10 +441,8 @@ _sbus_memcpy_toio(volatile void __iomem *dst, const void *src,
 	}
 }
 
-#define sbus_memcpy_toio(d, s, sz)	_sbus_memcpy_toio(d, s, sz)
-
-static inline void
-_memcpy_toio(volatile void __iomem *dst, const void *src, __kernel_size_t n)
+static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
+			       __kernel_size_t n)
 {
 	const char *s = src;
 	volatile void __iomem *d = dst;
@@ -475,8 +454,6 @@ _memcpy_toio(volatile void __iomem *dst, const void *src, __kernel_size_t n)
 	}
 }
 
-#define memcpy_toio(d,s,sz)	_memcpy_toio(d,s,sz)
-
 #define mmiowb()
 
 #ifdef __KERNEL__
-- 
1.9.3


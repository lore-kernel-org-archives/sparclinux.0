From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Jul 2014 11:39:03 +0000
Subject: [PATCH 6/6] sparc64: avoid code duplication in io_64.h
Message-Id: <1405856343-3762-6-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Several of the small IO functions ended up having the same implementation.
Use __raw_{read,write}* + {read,write}* as base for the others.

Continue to use static inline functions to get full type check.
The size of vmlinux for a defconfig build was the same when
using static inline and macros for the functions - so there
was no size win when using macros.

This was tested with gcc 4.8.2 + binutils 2.24.
For such simple constructs I assume older gcc's will
do the same job.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/io_64.h | 100 +++++++----------------------------------
 1 file changed, 15 insertions(+), 85 deletions(-)

diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 6c55c53..80b54b3 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -187,67 +187,37 @@ static inline void writeq(u64 q, volatile void __iomem *addr)
 #define inb inb
 static inline u8 inb(unsigned long addr)
 {
-	u8 ret;
-
-	__asm__ __volatile__("lduba\t[%1] %2, %0\t/* pci_inb */"
-			     : "=r" (ret)
-			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
-			     : "memory");
-
-	return ret;
+	return readb((volatile void __iomem *)addr);
 }
 
 #define inw inw
 static inline u16 inw(unsigned long addr)
 {
-	u16 ret;
-
-	__asm__ __volatile__("lduha\t[%1] %2, %0\t/* pci_inw */"
-			     : "=r" (ret)
-			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
-			     : "memory");
-
-	return ret;
+	return readw((volatile void __iomem *)addr);
 }
 
 #define inl inl
 static inline u32 inl(unsigned long addr)
 {
-	u32 ret;
-
-	__asm__ __volatile__("lduwa\t[%1] %2, %0\t/* pci_inl */"
-			     : "=r" (ret)
-			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
-			     : "memory");
-
-	return ret;
+	return readl((volatile void __iomem *)addr);
 }
 
 #define outb outb
 static inline void outb(u8 b, unsigned long addr)
 {
-	__asm__ __volatile__("stba\t%r0, [%1] %2\t/* pci_outb */"
-			     : /* no outputs */
-			     : "Jr" (b), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
-			     : "memory");
+	writeb(b, (volatile void __iomem *)addr);
 }
 
 #define outw outw
 static inline void outw(u16 w, unsigned long addr)
 {
-	__asm__ __volatile__("stha\t%r0, [%1] %2\t/* pci_outw */"
-			     : /* no outputs */
-			     : "Jr" (w), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
-			     : "memory");
+	writew(w, (volatile void __iomem *)addr);
 }
 
 #define outl outl
 static inline void outl(u32 l, unsigned long addr)
 {
-	__asm__ __volatile__("stwa\t%r0, [%1] %2\t/* pci_outl */"
-			     : /* no outputs */
-			     : "Jr" (l), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
-			     : "memory");
+	writel(l, (volatile void __iomem *)addr);
 }
 
 
@@ -309,82 +279,42 @@ static inline void iowrite32_rep(void __iomem *port, const void *buf, unsigned l
  */
 static inline u8 sbus_readb(const volatile void __iomem *addr)
 {
-	u8 ret;
-
-	__asm__ __volatile__("lduba\t[%1] %2, %0\t/* sbus_readb */"
-			     : "=r" (ret)
-			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E)
-			     : "memory");
-
-	return ret;
+	return __raw_readb(addr);
 }
 
 static inline u16 sbus_readw(const volatile void __iomem *addr)
 {
-	u16 ret;
-
-	__asm__ __volatile__("lduha\t[%1] %2, %0\t/* sbus_readw */"
-			     : "=r" (ret)
-			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E)
-			     : "memory");
-
-	return ret;
+	return __raw_readw(addr);
 }
 
 static inline u32 sbus_readl(const volatile void __iomem *addr)
 {
-	u32 ret;
-
-	__asm__ __volatile__("lduwa\t[%1] %2, %0\t/* sbus_readl */"
-			     : "=r" (ret)
-			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E)
-			     : "memory");
-
-	return ret;
+	return __raw_readl(addr);
 }
 
 static inline u64 sbus_readq(const volatile void __iomem *addr)
 {
-	u64 ret;
-
-	__asm__ __volatile__("ldxa\t[%1] %2, %0\t/* sbus_readq */"
-			     : "=r" (ret)
-			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E)
-			     : "memory");
-
-	return ret;
+	return __raw_readq(addr);
 }
 
 static inline void sbus_writeb(u8 b, volatile void __iomem *addr)
 {
-	__asm__ __volatile__("stba\t%r0, [%1] %2\t/* sbus_writeb */"
-			     : /* no outputs */
-			     : "Jr" (b), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E)
-			     : "memory");
+	__raw_writeb(b, addr);
 }
 
 static inline void sbus_writew(u16 w, volatile void __iomem *addr)
 {
-	__asm__ __volatile__("stha\t%r0, [%1] %2\t/* sbus_writew */"
-			     : /* no outputs */
-			     : "Jr" (w), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E)
-			     : "memory");
+	__raw_writew(w, addr);
 }
 
 static inline void sbus_writel(u32 l, volatile void __iomem *addr)
 {
-	__asm__ __volatile__("stwa\t%r0, [%1] %2\t/* sbus_writel */"
-			     : /* no outputs */
-			     : "Jr" (l), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E)
-			     : "memory");
+	__raw_writel(l, addr);
 }
 
-static inline void sbus_writeq(u64 l, volatile void __iomem *addr)
+static inline void sbus_writeq(u64 q, volatile void __iomem *addr)
 {
-	__asm__ __volatile__("stxa\t%r0, [%1] %2\t/* sbus_writeq */"
-			     : /* no outputs */
-			     : "Jr" (l), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E)
-			     : "memory");
+	__raw_writeq(q, addr);
 }
 
 static inline void sbus_memset_io(volatile void __iomem *dst, int c, __kernel_size_t n)
-- 
1.9.3


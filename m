From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 Jul 2014 11:39:02 +0000
Subject: [PATCH 5/6] sparc64: reorder functions in io_64.h
Message-Id: <1405856343-3762-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Reorder functions so __raw_{read,write}* functions comes first,
followed by {read,write}*

Update comments for the two blocks of functions.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/io_64.h | 338 +++++++++++++++++++++--------------------
 1 file changed, 172 insertions(+), 166 deletions(-)

diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 6df9743..6c55c53 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -12,6 +12,178 @@
 /* BIO layer definitions. */
 extern unsigned long kern_base, kern_size;
 
+/* __raw_{read,write}{b,w,l,q} uses direct access.
+ * Access the memory as big endian bypassing the cache
+ * by using ASI_PHYS_BYPASS_EC_E
+ */
+#define __raw_readb __raw_readb
+static inline u8 __raw_readb(const volatile void __iomem *addr)
+{
+	u8 ret;
+
+	__asm__ __volatile__("lduba\t[%1] %2, %0\t/* pci_raw_readb */"
+			     : "=r" (ret)
+			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
+
+	return ret;
+}
+
+#define __raw_readw __raw_readw
+static inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+	u16 ret;
+
+	__asm__ __volatile__("lduha\t[%1] %2, %0\t/* pci_raw_readw */"
+			     : "=r" (ret)
+			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
+
+	return ret;
+}
+
+#define __raw_readl __raw_readl
+static inline u32 __raw_readl(const volatile void __iomem *addr)
+{
+	u32 ret;
+
+	__asm__ __volatile__("lduwa\t[%1] %2, %0\t/* pci_raw_readl */"
+			     : "=r" (ret)
+			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
+
+	return ret;
+}
+
+#define __raw_readq __raw_readq
+static inline u64 __raw_readq(const volatile void __iomem *addr)
+{
+	u64 ret;
+
+	__asm__ __volatile__("ldxa\t[%1] %2, %0\t/* pci_raw_readq */"
+			     : "=r" (ret)
+			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
+
+	return ret;
+}
+
+#define __raw_writeb __raw_writeb
+static inline void __raw_writeb(u8 b, const volatile void __iomem *addr)
+{
+	__asm__ __volatile__("stba\t%r0, [%1] %2\t/* pci_raw_writeb */"
+			     : /* no outputs */
+			     : "Jr" (b), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
+}
+
+#define __raw_writew __raw_writew
+static inline void __raw_writew(u16 w, const volatile void __iomem *addr)
+{
+	__asm__ __volatile__("stha\t%r0, [%1] %2\t/* pci_raw_writew */"
+			     : /* no outputs */
+			     : "Jr" (w), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
+}
+
+#define __raw_writel __raw_writel
+static inline void __raw_writel(u32 l, const volatile void __iomem *addr)
+{
+	__asm__ __volatile__("stwa\t%r0, [%1] %2\t/* pci_raw_writel */"
+			     : /* no outputs */
+			     : "Jr" (l), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
+}
+
+#define __raw_writeq __raw_writeq
+static inline void __raw_writeq(u64 q, const volatile void __iomem *addr)
+{
+	__asm__ __volatile__("stxa\t%r0, [%1] %2\t/* pci_raw_writeq */"
+			     : /* no outputs */
+			     : "Jr" (q), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
+}
+
+/* Memory functions, same as I/O accesses on Ultra.
+ * Access memory as little endian bypassing
+ * the cache by using ASI_PHYS_BYPASS_EC_E_L
+ */
+#define readb readb
+static inline u8 readb(const volatile void __iomem *addr)
+{	u8 ret;
+
+	__asm__ __volatile__("lduba\t[%1] %2, %0\t/* pci_readb */"
+			     : "=r" (ret)
+			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
+			     : "memory");
+	return ret;
+}
+
+#define readw readw
+static inline u16 readw(const volatile void __iomem *addr)
+{	u16 ret;
+
+	__asm__ __volatile__("lduha\t[%1] %2, %0\t/* pci_readw */"
+			     : "=r" (ret)
+			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
+			     : "memory");
+
+	return ret;
+}
+
+#define readl readl
+static inline u32 readl(const volatile void __iomem *addr)
+{	u32 ret;
+
+	__asm__ __volatile__("lduwa\t[%1] %2, %0\t/* pci_readl */"
+			     : "=r" (ret)
+			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
+			     : "memory");
+
+	return ret;
+}
+
+#define readq readq
+static inline u64 readq(const volatile void __iomem *addr)
+{	u64 ret;
+
+	__asm__ __volatile__("ldxa\t[%1] %2, %0\t/* pci_readq */"
+			     : "=r" (ret)
+			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
+			     : "memory");
+
+	return ret;
+}
+
+#define writeb writeb
+static inline void writeb(u8 b, volatile void __iomem *addr)
+{
+	__asm__ __volatile__("stba\t%r0, [%1] %2\t/* pci_writeb */"
+			     : /* no outputs */
+			     : "Jr" (b), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
+			     : "memory");
+}
+
+#define writew writew
+static inline void writew(u16 w, volatile void __iomem *addr)
+{
+	__asm__ __volatile__("stha\t%r0, [%1] %2\t/* pci_writew */"
+			     : /* no outputs */
+			     : "Jr" (w), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
+			     : "memory");
+}
+
+#define writel writel
+static inline void writel(u32 l, volatile void __iomem *addr)
+{
+	__asm__ __volatile__("stwa\t%r0, [%1] %2\t/* pci_writel */"
+			     : /* no outputs */
+			     : "Jr" (l), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
+			     : "memory");
+}
+
+#define writeq writeq
+static inline void writeq(u64 q, volatile void __iomem *addr)
+{
+	__asm__ __volatile__("stxa\t%r0, [%1] %2\t/* pci_writeq */"
+			     : /* no outputs */
+			     : "Jr" (q), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
+			     : "memory");
+}
+
+
 #define inb inb
 static inline u8 inb(unsigned long addr)
 {
@@ -122,177 +294,11 @@ static inline void iowrite32_rep(void __iomem *port, const void *buf, unsigned l
 	outsl((unsigned long __force)port, buf, count);
 }
 
-/* Memory functions, same as I/O accesses on Ultra. */
-#define readb readb
-static inline u8 readb(const volatile void __iomem *addr)
-{	u8 ret;
-
-	__asm__ __volatile__("lduba\t[%1] %2, %0\t/* pci_readb */"
-			     : "=r" (ret)
-			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
-			     : "memory");
-	return ret;
-}
-
-#define readw readw
-static inline u16 readw(const volatile void __iomem *addr)
-{	u16 ret;
-
-	__asm__ __volatile__("lduha\t[%1] %2, %0\t/* pci_readw */"
-			     : "=r" (ret)
-			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
-			     : "memory");
-
-	return ret;
-}
-
-#define readl readl
-static inline u32 readl(const volatile void __iomem *addr)
-{	u32 ret;
-
-	__asm__ __volatile__("lduwa\t[%1] %2, %0\t/* pci_readl */"
-			     : "=r" (ret)
-			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
-			     : "memory");
-
-	return ret;
-}
-
-#define readq readq
-static inline u64 readq(const volatile void __iomem *addr)
-{	u64 ret;
-
-	__asm__ __volatile__("ldxa\t[%1] %2, %0\t/* pci_readq */"
-			     : "=r" (ret)
-			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
-			     : "memory");
-
-	return ret;
-}
-
-#define writeb writeb
-static inline void writeb(u8 b, volatile void __iomem *addr)
-{
-	__asm__ __volatile__("stba\t%r0, [%1] %2\t/* pci_writeb */"
-			     : /* no outputs */
-			     : "Jr" (b), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
-			     : "memory");
-}
-
-#define writew writew
-static inline void writew(u16 w, volatile void __iomem *addr)
-{
-	__asm__ __volatile__("stha\t%r0, [%1] %2\t/* pci_writew */"
-			     : /* no outputs */
-			     : "Jr" (w), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
-			     : "memory");
-}
-
-#define writel writel
-static inline void writel(u32 l, volatile void __iomem *addr)
-{
-	__asm__ __volatile__("stwa\t%r0, [%1] %2\t/* pci_writel */"
-			     : /* no outputs */
-			     : "Jr" (l), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
-			     : "memory");
-}
-
-#define writeq writeq
-static inline void writeq(u64 q, volatile void __iomem *addr)
-{
-	__asm__ __volatile__("stxa\t%r0, [%1] %2\t/* pci_writeq */"
-			     : /* no outputs */
-			     : "Jr" (q), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E_L)
-			     : "memory");
-}
-
 #define readb_relaxed(__addr)	readb(__addr)
 #define readw_relaxed(__addr)	readw(__addr)
 #define readl_relaxed(__addr)	readl(__addr)
 #define readq_relaxed(__addr)	readq(__addr)
 
-/* Now versions without byte-swapping. */
-#define __raw_readb __raw_readb
-static inline u8 __raw_readb(const volatile void __iomem *addr)
-{
-	u8 ret;
-
-	__asm__ __volatile__("lduba\t[%1] %2, %0\t/* pci_raw_readb */"
-			     : "=r" (ret)
-			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
-
-	return ret;
-}
-
-#define __raw_readw __raw_readw
-static inline u16 __raw_readw(const volatile void __iomem *addr)
-{
-	u16 ret;
-
-	__asm__ __volatile__("lduha\t[%1] %2, %0\t/* pci_raw_readw */"
-			     : "=r" (ret)
-			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
-
-	return ret;
-}
-
-#define __raw_readl __raw_readl
-static inline u32 __raw_readl(const volatile void __iomem *addr)
-{
-	u32 ret;
-
-	__asm__ __volatile__("lduwa\t[%1] %2, %0\t/* pci_raw_readl */"
-			     : "=r" (ret)
-			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
-
-	return ret;
-}
-
-#define __raw_readq __raw_readq
-static inline u64 __raw_readq(const volatile void __iomem *addr)
-{
-	u64 ret;
-
-	__asm__ __volatile__("ldxa\t[%1] %2, %0\t/* pci_raw_readq */"
-			     : "=r" (ret)
-			     : "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
-
-	return ret;
-}
-
-#define __raw_writeb __raw_writeb
-static inline void __raw_writeb(u8 b, const volatile void __iomem *addr)
-{
-	__asm__ __volatile__("stba\t%r0, [%1] %2\t/* pci_raw_writeb */"
-			     : /* no outputs */
-			     : "Jr" (b), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
-}
-
-#define __raw_writew __raw_writew
-static inline void __raw_writew(u16 w, const volatile void __iomem *addr)
-{
-	__asm__ __volatile__("stha\t%r0, [%1] %2\t/* pci_raw_writew */"
-			     : /* no outputs */
-			     : "Jr" (w), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
-}
-
-#define __raw_writel __raw_writel
-static inline void __raw_writel(u32 l, const volatile void __iomem *addr)
-{
-	__asm__ __volatile__("stwa\t%r0, [%1] %2\t/* pci_raw_writel */"
-			     : /* no outputs */
-			     : "Jr" (l), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
-}
-
-#define __raw_writeq __raw_writeq
-static inline void __raw_writeq(u64 q, const volatile void __iomem *addr)
-{
-	__asm__ __volatile__("stxa\t%r0, [%1] %2\t/* pci_raw_writeq */"
-			     : /* no outputs */
-			     : "Jr" (q), "r" (addr), "i" (ASI_PHYS_BYPASS_EC_E));
-}
-
-
 /* Valid I/O Space regions are anywhere, because each PCI bus supported
  * can live in an arbitrary area of the physical address range.
  */
-- 
1.9.3


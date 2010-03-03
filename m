From: David Miller <davem@davemloft.net>
Date: Wed, 03 Mar 2010 10:53:54 +0000
Subject: [PATCH] sparc: Provide io{read,write}{16,32}be().
Message-Id: <20100303.025354.65744092.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This fixes the build of a few drivers that can be enabled
via "make allmodconfig", committed to sparc-2.6

sparc: Provide io{read,write}{16,32}be().

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/io_32.h |    4 ++++
 arch/sparc/include/asm/io_64.h |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index 679c750..2889574 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -249,10 +249,14 @@ extern void iounmap(volatile void __iomem *addr);
 
 #define ioread8(X)			readb(X)
 #define ioread16(X)			readw(X)
+#define ioread16be(X)			__raw_readw(X)
 #define ioread32(X)			readl(X)
+#define ioread32be(X)			__raw_readl(X)
 #define iowrite8(val,X)			writeb(val,X)
 #define iowrite16(val,X)		writew(val,X)
+#define iowrite16be(val,X)		__raw_writew(val,X)
 #define iowrite32(val,X)		writel(val,X)
+#define iowrite32be(val,X)		__raw_writel(val,X)
 
 static inline void ioread8_rep(void __iomem *port, void *buf, unsigned long count)
 {
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 4aee21d..9517d06 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -468,10 +468,14 @@ static inline void iounmap(volatile void __iomem *addr)
 
 #define ioread8(X)			readb(X)
 #define ioread16(X)			readw(X)
+#define ioread16be(X)			__raw_readw(X)
 #define ioread32(X)			readl(X)
+#define ioread32be(X)			__raw_readl(X)
 #define iowrite8(val,X)			writeb(val,X)
 #define iowrite16(val,X)		writew(val,X)
+#define iowrite16be(val,X)		__raw_writew(val,X)
 #define iowrite32(val,X)		writel(val,X)
+#define iowrite32be(val,X)		__raw_writel(val,X)
 
 /* Create a virtual mapping cookie for an IO port range */
 extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
-- 
1.6.6.1


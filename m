From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 Apr 2014 07:57:37 +0000
Subject: [PATCH 4/4] sparc32: clean up io_32.h
Message-Id: <1398499057-21497-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

After introducing asm-generic/io.h a few things could still be cleaned up
o Drop useless macro indirection for sbus_* io access methods
  They were in the past used to hide casts between long and pointers
  but this is no longer so
o Fix function definitions for sbus memory functions so
  return value appear on same line as function name

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/io_32.h | 43 ++++++++++++++----------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/arch/sparc/include/asm/io_32.h b/arch/sparc/include/asm/io_32.h
index d281d4c..383f513 100644
--- a/arch/sparc/include/asm/io_32.h
+++ b/arch/sparc/include/asm/io_32.h
@@ -58,47 +58,38 @@ static inline void _memcpy_toio(volatile void __iomem *dst, const void *src,
  * SBus has only one, memory mapped, I/O space.
  * We do not need to flip bytes for SBus of course.
  */
-static inline u8 _sbus_readb(const volatile void __iomem *addr)
+static inline u8 sbus_readb(const volatile void __iomem *addr)
 {
 	return *(__force volatile u8 *)addr;
 }
 
-static inline u16 _sbus_readw(const volatile void __iomem *addr)
+static inline u16 sbus_readw(const volatile void __iomem *addr)
 {
 	return *(__force volatile u16 *)addr;
 }
 
-static inline u32 _sbus_readl(const volatile void __iomem *addr)
+static inline u32 sbus_readl(const volatile void __iomem *addr)
 {
 	return *(__force volatile u32 *)addr;
 }
 
-static inline void _sbus_writeb(u8 b, volatile void __iomem *addr)
+static inline void sbus_writeb(u8 b, volatile void __iomem *addr)
 {
 	*(__force volatile u8 *)addr = b;
 }
 
-static inline void _sbus_writew(u16 w, volatile void __iomem *addr)
+static inline void sbus_writew(u16 w, volatile void __iomem *addr)
 {
 	*(__force volatile u16 *)addr = w;
 }
 
-static inline void _sbus_writel(u32 l, volatile void __iomem *addr)
+static inline void sbus_writel(u32 l, volatile void __iomem *addr)
 {
 	*(__force volatile u32 *)addr = l;
 }
 
-/*
- * The only reason for #define's is to hide casts to unsigned long.
- */
-#define sbus_readb(__addr)		_sbus_readb(__addr)
-#define sbus_readw(__addr)		_sbus_readw(__addr)
-#define sbus_readl(__addr)		_sbus_readl(__addr)
-#define sbus_writeb(__b, __addr)	_sbus_writeb(__b, __addr)
-#define sbus_writew(__w, __addr)	_sbus_writew(__w, __addr)
-#define sbus_writel(__l, __addr)	_sbus_writel(__l, __addr)
-
-static inline void sbus_memset_io(volatile void __iomem *__dst, int c, __kernel_size_t n)
+static inline void sbus_memset_io(volatile void __iomem *__dst, int c,
+                                  __kernel_size_t n)
 {
 	while(n--) {
 		sbus_writeb(c, __dst);
@@ -106,11 +97,9 @@ static inline void sbus_memset_io(volatile void __iomem *__dst, int c, __kernel_
 	}
 }
 
-
-
-static inline void
-_sbus_memcpy_fromio(void *dst, const volatile void __iomem *src,
-		    __kernel_size_t n)
+static inline void sbus_memcpy_fromio(void *dst,
+                                      const volatile void __iomem *src,
+                                      __kernel_size_t n)
 {
 	char *d = dst;
 
@@ -121,11 +110,9 @@ _sbus_memcpy_fromio(void *dst, const volatile void __iomem *src,
 	}
 }
 
-#define sbus_memcpy_fromio(d, s, sz)	_sbus_memcpy_fromio(d, s, sz)
-
-static inline void
-_sbus_memcpy_toio(volatile void __iomem *dst, const void *src,
-		  __kernel_size_t n)
+static inline void sbus_memcpy_toio(volatile void __iomem *dst,
+                                    const void *src,
+                                    __kernel_size_t n)
 {
 	const char *s = src;
 	volatile void __iomem *d = dst;
@@ -137,8 +124,6 @@ _sbus_memcpy_toio(volatile void __iomem *dst, const void *src,
 	}
 }
 
-#define sbus_memcpy_toio(d, s, sz)	_sbus_memcpy_toio(d, s, sz)
-
 #ifdef __KERNEL__
 
 /*
-- 
1.9.0


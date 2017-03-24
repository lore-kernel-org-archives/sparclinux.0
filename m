From: Matthew Wilcox <willy@infradead.org>
Date: Fri, 24 Mar 2017 16:13:15 +0000
Subject: [PATCH v3 4/7] alpha: Add support for memset16
Message-Id: <20170324161318.18718-5-willy@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20170324161318.18718-1-willy@infradead.org>
In-Reply-To: <20170324161318.18718-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>, x86@kernel.org, Minchan Kim <minchan@kernel.org>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Alpha already had an optimised memset-16-bit-quantity assembler routine
called memsetw().  It has a slightly different calling convention
from memset16() in that it takes a byte count, not a count of words.
That's the same convention used by ARM's __memset16(), so rename Alpha's
routine to match and add a memset16() wrapper around it.  Then convert
Alpha's scr_memsetw() to call memset16() instead of memsetw().

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 arch/alpha/include/asm/string.h | 15 ++++++++-------
 arch/alpha/include/asm/vga.h    |  2 +-
 arch/alpha/lib/memset.S         | 10 +++++-----
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/alpha/include/asm/string.h b/arch/alpha/include/asm/string.h
index c2911f591704..74c0a693b76b 100644
--- a/arch/alpha/include/asm/string.h
+++ b/arch/alpha/include/asm/string.h
@@ -65,13 +65,14 @@ extern void * memchr(const void *, int, size_t);
    aligned values.  The DEST and COUNT parameters must be even for 
    correct operation.  */
 
-#define __HAVE_ARCH_MEMSETW
-extern void * __memsetw(void *dest, unsigned short, size_t count);
-
-#define memsetw(s, c, n)						 \
-(__builtin_constant_p(c)						 \
- ? __constant_c_memset((s),0x0001000100010001UL*(unsigned short)(c),(n)) \
- : __memsetw((s),(c),(n)))
+#define __HAVE_ARCH_MEMSET16
+extern void * __memset16(void *dest, unsigned short, size_t count);
+static inline void *memset16(uint16_t *p, uint16_t v, size_t n)
+{
+	if (__builtin_constant_p(v))
+		return __constant_c_memset(p, 0x0001000100010001UL * v, n * 2)
+	return __memset16(p, v, n * 2);
+}
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/alpha/include/asm/vga.h b/arch/alpha/include/asm/vga.h
index c00106bac521..3c1c2b6128e7 100644
--- a/arch/alpha/include/asm/vga.h
+++ b/arch/alpha/include/asm/vga.h
@@ -34,7 +34,7 @@ static inline void scr_memsetw(u16 *s, u16 c, unsigned int count)
 	if (__is_ioaddr(s))
 		memsetw_io((u16 __iomem *) s, c, count);
 	else
-		memsetw(s, c, count);
+		memset16(s, c, count / 2);
 }
 
 /* Do not trust that the usage will be correct; analyze the arguments.  */
diff --git a/arch/alpha/lib/memset.S b/arch/alpha/lib/memset.S
index 89a26f5e89de..f824969e9e77 100644
--- a/arch/alpha/lib/memset.S
+++ b/arch/alpha/lib/memset.S
@@ -20,7 +20,7 @@
 	.globl memset
 	.globl __memset
 	.globl ___memset
-	.globl __memsetw
+	.globl __memset16
 	.globl __constant_c_memset
 
 	.ent ___memset
@@ -110,8 +110,8 @@ EXPORT_SYMBOL(___memset)
 EXPORT_SYMBOL(__constant_c_memset)
 
 	.align 5
-	.ent __memsetw
-__memsetw:
+	.ent __memset16
+__memset16:
 	.prologue 0
 
 	inswl $17,0,$1		/* E0 */
@@ -123,8 +123,8 @@ __memsetw:
 	or $1,$4,$17		/* E0 */
 	br __constant_c_memset	/* .. E1 */
 
-	.end __memsetw
-EXPORT_SYMBOL(__memsetw)
+	.end __memset16
+EXPORT_SYMBOL(__memset16)
 
 memset = ___memset
 __memset = ___memset
-- 
2.11.0


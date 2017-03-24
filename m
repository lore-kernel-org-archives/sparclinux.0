From: Matthew Wilcox <willy@infradead.org>
Date: Fri, 24 Mar 2017 16:13:13 +0000
Subject: [PATCH v3 2/7] ARM: Implement memset16, memset32 & memset64
Message-Id: <20170324161318.18718-3-willy@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20170324161318.18718-1-willy@infradead.org>
In-Reply-To: <20170324161318.18718-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, linux-fbdev@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>, x86@kernel.org, Minchan Kim <minchan@kernel.org>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

From: Matthew Wilcox <mawilcox@microsoft.com>

ARM is only 32-bit, so it doesn't really need a memset64, but it was
essentially free to add it to the existing implementation.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Reviewed-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/string.h | 21 +++++++++++++++++++++
 arch/arm/kernel/armksyms.c    |  3 +++
 arch/arm/lib/memset.S         | 44 ++++++++++++++++++++++++++++++++++---------
 3 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/string.h b/arch/arm/include/asm/string.h
index cf4f3aad0fc1..bc7a1be7a76a 100644
--- a/arch/arm/include/asm/string.h
+++ b/arch/arm/include/asm/string.h
@@ -24,6 +24,27 @@ extern void * memchr(const void *, int, __kernel_size_t);
 #define __HAVE_ARCH_MEMSET
 extern void * memset(void *, int, __kernel_size_t);
 
+#define __HAVE_ARCH_MEMSET16
+extern void *__memset16(uint16_t *, uint16_t v, __kernel_size_t);
+static inline void *memset16(uint16_t *p, uint16_t v, __kernel_size_t n)
+{
+	return __memset16(p, v, n * 2);
+}
+
+#define __HAVE_ARCH_MEMSET32
+extern void *__memset32(uint32_t *, uint32_t v, __kernel_size_t);
+static inline void *memset32(uint32_t *p, uint32_t v, __kernel_size_t n)
+{
+	return __memset32(p, v, n * 4);
+}
+
+#define __HAVE_ARCH_MEMSET64
+extern void *__memset64(uint64_t *, uint32_t low, __kernel_size_t, uint32_t hi);
+static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
+{
+	return __memset64(p, v, n * 8, v >> 32);
+}
+
 extern void __memzero(void *ptr, __kernel_size_t n);
 
 #define memset(p,v,n)							\
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 8e8d20cdbce7..633341ed0713 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -87,6 +87,9 @@ EXPORT_SYMBOL(__raw_writesl);
 EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(__memset16);
+EXPORT_SYMBOL(__memset32);
+EXPORT_SYMBOL(__memset64);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memchr);
diff --git a/arch/arm/lib/memset.S b/arch/arm/lib/memset.S
index 3c65e3bd790f..9adc9bdf3ffb 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -21,14 +21,14 @@ ENTRY(memset)
 UNWIND( .fnstart         )
 	ands	r3, r0, #3		@ 1 unaligned?
 	mov	ip, r0			@ preserve r0 as return value
+	orr	r1, r1, r1, lsl #8
 	bne	6f			@ 1
 /*
  * we know that the pointer in ip is aligned to a word boundary.
  */
-1:	orr	r1, r1, r1, lsl #8
-	orr	r1, r1, r1, lsl #16
+1:	orr	r1, r1, r1, lsl #16
 	mov	r3, r1
-	cmp	r2, #16
+7:	cmp	r2, #16
 	blt	4f
 
 #if ! CALGN(1)+0
@@ -41,7 +41,7 @@ UNWIND( .fnend              )
 UNWIND( .fnstart            )
 UNWIND( .save {r8, lr}      )
 	mov	r8, r1
-	mov	lr, r1
+	mov	lr, r3
 
 2:	subs	r2, r2, #64
 	stmgeia	ip!, {r1, r3, r8, lr}	@ 64 bytes at a time.
@@ -73,11 +73,11 @@ UNWIND( .fnend                 )
 UNWIND( .fnstart               )
 UNWIND( .save {r4-r8, lr}      )
 	mov	r4, r1
-	mov	r5, r1
+	mov	r5, r3
 	mov	r6, r1
-	mov	r7, r1
+	mov	r7, r3
 	mov	r8, r1
-	mov	lr, r1
+	mov	lr, r3
 
 	cmp	r2, #96
 	tstgt	ip, #31
@@ -114,12 +114,13 @@ UNWIND( .fnstart            )
 	tst	r2, #4
 	strne	r1, [ip], #4
 /*
- * When we get here, we've got less than 4 bytes to zero.  We
+ * When we get here, we've got less than 4 bytes to set.  We
  * may have an unaligned pointer as well.
  */
 5:	tst	r2, #2
+	movne	r3, r1, lsr #8		@ the top half of a 16-bit pattern
 	strneb	r1, [ip], #1
-	strneb	r1, [ip], #1
+	strneb	r3, [ip], #1
 	tst	r2, #1
 	strneb	r1, [ip], #1
 	ret	lr
@@ -135,3 +136,28 @@ UNWIND( .fnstart            )
 UNWIND( .fnend   )
 ENDPROC(memset)
 ENDPROC(mmioset)
+
+ENTRY(__memset16)
+UNWIND( .fnstart         )
+	tst	r0, #2			@ pointer unaligned?
+	mov	ip, r0			@ preserve r0 as return value
+	beq	1b			@ jump into the middle of memset
+	subs	r2, r2, #2		@ cope with n = 0
+	movge	r3, r1, lsr #8		@ r3 = r1 >> 8
+	strgeb	r1, [ip], #1		@ *ip = r1
+	strgeb	r3, [ip], #1		@ *ip = r3
+	bgt	1b			@ back into memset if n > 0
+	ret	lr			@ otherwise return
+UNWIND( .fnend   )
+ENDPROC(__memset16)
+ENTRY(__memset32)
+UNWIND( .fnstart         )
+	mov	r3, r1			@ copy r1 to r3 and fall into memset64
+UNWIND( .fnend   )
+ENDPROC(__memset32)
+ENTRY(__memset64)
+UNWIND( .fnstart         )
+	mov	ip, r0			@ preserve r0 as return value
+	b	7b			@ jump into the middle of memset
+UNWIND( .fnend   )
+ENDPROC(__memset64)
-- 
2.11.0


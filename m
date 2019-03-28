From: George Spelvin <lkml@sdf.org>
Date: Thu, 28 Mar 2019 10:52:36 +0000
Subject: [PATCH] SPARC: Better fls64(), fls() and __fls() on SPARCv9
Message-Id: <201903281052.x2SAqaoH015770@sdf.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

For some reason, the asm implementations didn't take advantage
of the popc instruction, which allows a very simple fls64()
implementation.

fls() requires masking to avoid counting the high 32 bits,
since popc is a 64-bit-only instruction.

__fls() requires an extra shift right.  (Or it could be a
subtract.  Do you prefer __fls(0) to return 0 or -1?)

I don't have access to a Sparc machine to test this, but maybe
someone would be willing?  It's simple enough that any bugs
should not be subtle.

Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Vijay Kumar <vijay.ac.kumar@oracle.com>
Cc: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/include/asm/bitops_64.h |  3 +-
 arch/sparc/lib/fls.S               | 77 +++++++-----------------
 arch/sparc/lib/fls64.S             | 94 ++++++++++++++----------------
 3 files changed, 65 insertions(+), 109 deletions(-)

diff --git a/arch/sparc/include/asm/bitops_64.h b/arch/sparc/include/asm/bitops_64.h
index ca7ea5913494..888e4f786826 100644
--- a/arch/sparc/include/asm/bitops_64.h
+++ b/arch/sparc/include/asm/bitops_64.h
@@ -24,12 +24,11 @@ void clear_bit(unsigned long nr, volatile unsigned long *addr);
 void change_bit(unsigned long nr, volatile unsigned long *addr);
 
 int fls(unsigned int word);
+int fls64(unsigned long word);
 int __fls(unsigned long word);
 
 #include <asm-generic/bitops/non-atomic.h>
 
-#include <asm-generic/bitops/fls64.h>
-
 #ifdef __KERNEL__
 
 int ffs(int x);
diff --git a/arch/sparc/lib/fls.S b/arch/sparc/lib/fls.S
index 06b8d300bcae..48556ceadf92 100644
--- a/arch/sparc/lib/fls.S
+++ b/arch/sparc/lib/fls.S
@@ -1,67 +1,30 @@
-/* fls.S: SPARC default fls definition.
+/* fls.S: SPARCv9 default fls definition.
  *
- * SPARC default fls definition, which follows the same algorithm as
- * in generic fls(). This function will be boot time patched on T4
- * and onward.
+ * SPARCv9 default fls definition, which performs a "smear-right"
+ * operations, doing repeated shifts and ors to turn binary 001xxxx
+ * to 0011111.  Finally, a popc returns the number of 1 bits, which
+ * equals the position of the most significant set bit.
+ *
+ * This function will be boot time patched on T4 and onward.
  */
 
 #include <linux/linkage.h>
 #include <asm/export.h>
 
 	.text
-	.register	%g2, #scratch
-	.register	%g3, #scratch
 ENTRY(fls)
-	brz,pn	%o0, 6f
-	 mov	0, %o1
-	sethi	%hi(0xffff0000), %g3
-	mov	%o0, %g2
-	andcc	%o0, %g3, %g0
-	be,pt	%icc, 8f
-	 mov	32, %o1
-	sethi	%hi(0xff000000), %g3
-	andcc	%g2, %g3, %g0
-	bne,pt	%icc, 3f
-	 sethi	%hi(0xf0000000), %g3
-	sll	%o0, 8, %o0
-1:
-	add	%o1, -8, %o1
-	sra	%o0, 0, %o0
-	mov	%o0, %g2
-2:
-	sethi	%hi(0xf0000000), %g3
-3:
-	andcc	%g2, %g3, %g0
-	bne,pt	%icc, 4f
-	 sethi	%hi(0xc0000000), %g3
-	sll	%o0, 4, %o0
-	add	%o1, -4, %o1
-	sra	%o0, 0, %o0
-	mov	%o0, %g2
-4:
-	andcc	%g2, %g3, %g0
-	be,a,pt	%icc, 7f
-	 sll	%o0, 2, %o0
-5:
-	xnor	%g0, %o0, %o0
-	srl	%o0, 31, %o0
-	sub	%o1, %o0, %o1
-6:
-	jmp	%o7 + 8
-	 sra	%o1, 0, %o0
-7:
-	add	%o1, -2, %o1
-	ba,pt	%xcc, 5b
-	 sra	%o0, 0, %o0
-8:
-	sll	%o0, 16, %o0
-	sethi	%hi(0xff000000), %g3
-	sra	%o0, 0, %o0
-	mov	%o0, %g2
-	andcc	%g2, %g3, %g0
-	bne,pt	%icc, 2b
-	 mov	16, %o1
-	ba,pt	%xcc, 1b
-	 sll	%o0, 8, %o0
+	srl	%o0, 1, %g1
+	srl	%o0, %g0, %o0
+	or	%o0, %g1, %o0
+	srl	%o0, 2, %g1
+	or	%o0, %g1, %o0
+	srl	%o0, 4, %g1
+	or	%o0, %g1, %o0
+	srl	%o0, 8, %g1
+	or	%o0, %g1, %o0
+	srl	%o0, 16, %g1
+	or	%o0, %g1, %o0
+	retl
+	 popc	%o0, %o0
 ENDPROC(fls)
 EXPORT_SYMBOL(fls)
diff --git a/arch/sparc/lib/fls64.S b/arch/sparc/lib/fls64.S
index c83e22ae9586..620807691ae1 100644
--- a/arch/sparc/lib/fls64.S
+++ b/arch/sparc/lib/fls64.S
@@ -1,61 +1,55 @@
 /* fls64.S: SPARC default __fls definition.
  *
- * SPARC default __fls definition, which follows the same algorithm as
- * in generic __fls(). This function will be boot time patched on T4
- * and onward.
+ * SPARCv9 default fls definition, which performs a "smear-right"
+ * operations, doing repeated shifts and ors to turn binary 001xxxx
+ * to 0011111.  Finally, a popc returns the number of 1 bits, which
+ * equals the position of the most significant set bit.
+ *
+ * __fls (which returns 0..63 for 1<<0 through 1<<63) is
+ * actually trickier; what do we want to do if it's passed 0?
+ * This returns 0 by ignoring the lsbit.  Another option would
+ * return -1.
+ *
+ * This function will be boot time patched on T4 and onward.
  */
 
 #include <linux/linkage.h>
 #include <asm/export.h>
 
 	.text
-	.register	%g2, #scratch
-	.register	%g3, #scratch
+ENTRY(fls64)
+	srlx	%o0, 1, %g1
+	or	%o0, %g1, %o0
+	srlx	%o0, 2, %g1
+	or	%o0, %g1, %o0
+	srlx	%o0, 4, %g1
+	or	%o0, %g1, %o0
+	srlx	%o0, 8, %g1
+	or	%o0, %g1, %o0
+	srlx	%o0, 16, %g1
+	or	%o0, %g1, %o0
+	srlx	%o0, 32, %g1
+	or	%o0, %g1, %o0
+	retl
+	 popc	%o0, %o0
+ENDPROC(fls64)
+EXPORT_SYMBOL(fls64)
+
 ENTRY(__fls)
-	mov	-1, %g2
-	sllx	%g2, 32, %g2
-	and	%o0, %g2, %g2
-	brnz,pt	%g2, 1f
-	 mov	63, %g1
-	sllx	%o0, 32, %o0
-	mov	31, %g1
-1:
-	mov	-1, %g2
-	sllx	%g2, 48, %g2
-	and	%o0, %g2, %g2
-	brnz,pt	%g2, 2f
-	 mov	-1, %g2
-	sllx	%o0, 16, %o0
-	add	%g1, -16, %g1
-2:
-	mov	-1, %g2
-	sllx	%g2, 56, %g2
-	and	%o0, %g2, %g2
-	brnz,pt	%g2, 3f
-	 mov	-1, %g2
-	sllx	%o0, 8, %o0
-	add	%g1, -8, %g1
-3:
-	sllx	%g2, 60, %g2
-	and	%o0, %g2, %g2
-	brnz,pt	%g2, 4f
-	 mov	-1, %g2
-	sllx	%o0, 4, %o0
-	add	%g1, -4, %g1
-4:
-	sllx	%g2, 62, %g2
-	and	%o0, %g2, %g2
-	brnz,pt	%g2, 5f
-	 mov	-1, %g3
-	sllx	%o0, 2, %o0
-	add	%g1, -2, %g1
-5:
-	mov	0, %g2
-	sllx	%g3, 63, %g3
-	and	%o0, %g3, %o0
-	movre	%o0, 1, %g2
-	sub	%g1, %g2, %g1
-	jmp	%o7+8
-	 sra	%g1, 0, %o0
+	srlx	%o0, 1, %g1
+	srlx	%o0, 2, %o0
+	or	%o0, %g1, %o0
+	srlx	%o0, 2, %g1
+	or	%o0, %g1, %o0
+	srlx	%o0, 4, %g1
+	or	%o0, %g1, %o0
+	srlx	%o0, 8, %g1
+	or	%o0, %g1, %o0
+	srlx	%o0, 16, %g1
+	or	%o0, %g1, %o0
+	srlx	%o0, 32, %g1
+	or	%o0, %g1, %o0
+	retl
+	 popc	%o0, %o0
 ENDPROC(__fls)
 EXPORT_SYMBOL(__fls)
-- 
2.20.1

From: David Miller <davem@davemloft.net>
Date: Tue, 09 Dec 2008 23:35:51 +0000
Subject: [PATCH 3/4]: sparc: Unify strlen assembler.
Message-Id: <20081209.153551.105983881.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Unify strlen assembler.

Use the new asm/asm.h header to help commonize the
strlen assembler between 32-bit and 64-bit

While we're here, use proper linux/linkage.h macros
instead of by-hand stuff.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/lib/Makefile    |    2 +-
 arch/sparc/lib/strlen.S    |   80 +++++++++++++++++++++++++++++++++++++++++++
 arch/sparc/lib/strlen_32.S |   81 --------------------------------------------
 arch/sparc/lib/strlen_64.S |   80 -------------------------------------------
 4 files changed, 81 insertions(+), 162 deletions(-)
 create mode 100644 arch/sparc/lib/strlen.S
 delete mode 100644 arch/sparc/lib/strlen_32.S
 delete mode 100644 arch/sparc/lib/strlen_64.S

diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 05ae5c9..0db2c61 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -6,7 +6,7 @@ ccflags-y := -Werror
 
 lib-$(CONFIG_SPARC32) += mul.o rem.o sdiv.o udiv.o umul.o urem.o ashrdi3.o
 lib-$(CONFIG_SPARC32) += memcpy.o memset.o
-lib-y                 += strlen_$(BITS).o
+lib-y                 += strlen.o
 lib-y                 += checksum_$(BITS).o
 lib-$(CONFIG_SPARC32) += blockops.o
 lib-y                 += memscan_$(BITS).o memcmp_$(BITS).o strncmp_$(BITS).o
diff --git a/arch/sparc/lib/strlen.S b/arch/sparc/lib/strlen.S
new file mode 100644
index 0000000..536f835
--- /dev/null
+++ b/arch/sparc/lib/strlen.S
@@ -0,0 +1,80 @@
+/* strlen.S: Sparc optimized strlen code
+ * Hand optimized from GNU libc's strlen
+ * Copyright (C) 1991,1996 Free Software Foundation
+ * Copyright (C) 1996,2008 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 1996, 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+
+#define LO_MAGIC 0x01010101
+#define HI_MAGIC 0x80808080
+
+	.text
+ENTRY(strlen)
+	mov	%o0, %o1
+	andcc	%o0, 3, %g0
+	BRANCH32(be, pt, 9f)
+	 sethi	%hi(HI_MAGIC), %o4
+	ldub	[%o0], %o5
+	BRANCH_REG_ZERO(pn, %o5, 11f)
+	 add	%o0, 1, %o0
+	andcc	%o0, 3, %g0
+	BRANCH32(be, pn, 4f)
+	 or	%o4, %lo(HI_MAGIC), %o3
+	ldub	[%o0], %o5
+	BRANCH_REG_ZERO(pn, %o5, 12f)
+	 add	%o0, 1, %o0
+	andcc	%o0, 3, %g0
+	BRANCH32(be, pt, 5f)
+	 sethi	%hi(LO_MAGIC), %o4
+	ldub	[%o0], %o5
+	BRANCH_REG_ZERO(pn, %o5, 13f)
+	 add	%o0, 1, %o0
+	BRANCH32(ba, pt, 8f)
+	 or	%o4, %lo(LO_MAGIC), %o2
+9:
+	or	%o4, %lo(HI_MAGIC), %o3
+4:
+	sethi	%hi(LO_MAGIC), %o4
+5:
+	or	%o4, %lo(LO_MAGIC), %o2
+8:
+	ld	[%o0], %o5
+2:
+	sub	%o5, %o2, %o4
+	andcc	%o4, %o3, %g0
+	BRANCH32(be, pt, 8b)
+	 add	%o0, 4, %o0
+
+	/* Check every byte. */
+	srl	%o5, 24, %g7
+	andcc	%g7, 0xff, %g0
+	BRANCH32(be, pn, 1f)
+	 add	%o0, -4, %o4
+	srl	%o5, 16, %g7
+	andcc	%g7, 0xff, %g0
+	BRANCH32(be, pn, 1f)
+	 add	%o4, 1, %o4
+	srl	%o5, 8, %g7
+	andcc	%g7, 0xff, %g0
+	BRANCH32(be, pn, 1f)
+	 add	%o4, 1, %o4
+	andcc	%o5, 0xff, %g0
+	BRANCH32_ANNUL(bne, pt, 2b)
+	 ld	[%o0], %o5
+	add	%o4, 1, %o4
+1:
+	retl
+	 sub	%o4, %o1, %o0
+11:
+	retl
+	 mov	0, %o0
+12:
+	retl
+	 mov	1, %o0
+13:
+	retl
+	 mov	2, %o0
+ENDPROC(strlen)
diff --git a/arch/sparc/lib/strlen_32.S b/arch/sparc/lib/strlen_32.S
deleted file mode 100644
index ed9a763..0000000
--- a/arch/sparc/lib/strlen_32.S
+++ /dev/null
@@ -1,81 +0,0 @@
-/* strlen.S: Sparc optimized strlen code
- * Hand optimized from GNU libc's strlen
- * Copyright (C) 1991,1996 Free Software Foundation
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 1996 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- */
-
-#define LO_MAGIC 0x01010101
-#define HI_MAGIC 0x80808080
-
-0:
-	ldub	[%o0], %o5
-	cmp	%o5, 0
-	be	1f
-	 add	%o0, 1, %o0
-	andcc	%o0, 3, %g0
-	be	4f
-	 or	%o4, %lo(HI_MAGIC), %o3
-	ldub	[%o0], %o5
-	cmp	%o5, 0
-	be	2f
-	 add	%o0, 1, %o0
-	andcc	%o0, 3, %g0
-	be	5f
-	 sethi	%hi(LO_MAGIC), %o4
-	ldub	[%o0], %o5
-	cmp	%o5, 0
-	be	3f
-	 add	%o0, 1, %o0
-	b	8f
-	 or	%o4, %lo(LO_MAGIC), %o2
-1:
-	retl
-	 mov	0, %o0
-2:
-	retl
-	 mov	1, %o0
-3:
-	retl
-	 mov	2, %o0
-
-	.align 4
-	.global strlen
-strlen:
-	mov	%o0, %o1
-	andcc	%o0, 3, %g0
-	bne	0b
-	 sethi	%hi(HI_MAGIC), %o4
-	or	%o4, %lo(HI_MAGIC), %o3
-4:
-	sethi	%hi(LO_MAGIC), %o4
-5:
-	or	%o4, %lo(LO_MAGIC), %o2
-8:
-	ld	[%o0], %o5
-2:
-	sub	%o5, %o2, %o4
-	andcc	%o4, %o3, %g0
-	be	8b
-	 add	%o0, 4, %o0
-
-	/* Check every byte. */
-	srl	%o5, 24, %g5
-	andcc	%g5, 0xff, %g0
-	be	1f
-	 add	%o0, -4, %o4
-	srl	%o5, 16, %g5
-	andcc	%g5, 0xff, %g0
-	be	1f
-	 add	%o4, 1, %o4
-	srl	%o5, 8, %g5
-	andcc	%g5, 0xff, %g0
-	be	1f
-	 add	%o4, 1, %o4
-	andcc	%o5, 0xff, %g0
-	bne,a	2b
-	 ld	[%o0], %o5
-	add	%o4, 1, %o4
-1:
-	retl
-	 sub	%o4, %o1, %o0
diff --git a/arch/sparc/lib/strlen_64.S b/arch/sparc/lib/strlen_64.S
deleted file mode 100644
index e9ba192..0000000
--- a/arch/sparc/lib/strlen_64.S
+++ /dev/null
@@ -1,80 +0,0 @@
-/* strlen.S: Sparc64 optimized strlen code
- * Hand optimized from GNU libc's strlen
- * Copyright (C) 1991,1996 Free Software Foundation
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 1996, 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- */
-
-#define LO_MAGIC 0x01010101
-#define HI_MAGIC 0x80808080
-
-	.align	32
-	.globl	strlen
-	.type	strlen,#function
-strlen:
-	mov	%o0, %o1
-	andcc	%o0, 3, %g0
-	be,pt	%icc, 9f
-	 sethi	%hi(HI_MAGIC), %o4
-	ldub	[%o0], %o5
-	brz,pn	%o5, 11f
-	 add	%o0, 1, %o0
-	andcc	%o0, 3, %g0
-	be,pn	%icc, 4f
-	 or	%o4, %lo(HI_MAGIC), %o3
-	ldub	[%o0], %o5
-	brz,pn	%o5, 12f
-	 add	%o0, 1, %o0
-	andcc	%o0, 3, %g0
-	be,pt	%icc, 5f
-	 sethi	%hi(LO_MAGIC), %o4
-	ldub	[%o0], %o5
-	brz,pn	%o5, 13f
-	 add	%o0, 1, %o0
-	ba,pt	%icc, 8f
-	 or	%o4, %lo(LO_MAGIC), %o2
-9:
-	or	%o4, %lo(HI_MAGIC), %o3
-4:
-	sethi	%hi(LO_MAGIC), %o4
-5:
-	or	%o4, %lo(LO_MAGIC), %o2
-8:
-	ld	[%o0], %o5
-2:
-	sub	%o5, %o2, %o4
-	andcc	%o4, %o3, %g0
-	be,pt	%icc, 8b
-	 add	%o0, 4, %o0
-
-	/* Check every byte. */
-	srl	%o5, 24, %g7
-	andcc	%g7, 0xff, %g0
-	be,pn	%icc, 1f
-	 add	%o0, -4, %o4
-	srl	%o5, 16, %g7
-	andcc	%g7, 0xff, %g0
-	be,pn	%icc, 1f
-	 add	%o4, 1, %o4
-	srl	%o5, 8, %g7
-	andcc	%g7, 0xff, %g0
-	be,pn	%icc, 1f
-	 add	%o4, 1, %o4
-	andcc	%o5, 0xff, %g0
-	bne,a,pt %icc, 2b
-	 ld	[%o0], %o5
-	add	%o4, 1, %o4
-1:
-	retl
-	 sub	%o4, %o1, %o0
-11:
-	retl
-	 mov	0, %o0
-12:
-	retl
-	 mov	1, %o0
-13:
-	retl
-	 mov	2, %o0
-
-	.size	strlen, .-strlen
-- 
1.5.6.5


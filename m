From: David Miller <davem@davemloft.net>
Date: Tue, 09 Dec 2008 23:35:53 +0000
Subject: [PATCH 4/4]: sparc: Commonize memcmp assembler.
Message-Id: <20081209.153553.40556152.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Commonize memcmp assembler.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/sparc_ksyms_32.c |    2 --
 arch/sparc/kernel/sparc_ksyms_64.c |    2 --
 arch/sparc/lib/Makefile            |    2 +-
 arch/sparc/lib/memcmp.S            |   27 +++++++++++++++++++++++++++
 arch/sparc/lib/memcmp_32.S         |   30 ------------------------------
 arch/sparc/lib/memcmp_64.S         |   28 ----------------------------
 6 files changed, 28 insertions(+), 63 deletions(-)
 create mode 100644 arch/sparc/lib/memcmp.S
 delete mode 100644 arch/sparc/lib/memcmp_32.S
 delete mode 100644 arch/sparc/lib/memcmp_64.S

diff --git a/arch/sparc/kernel/sparc_ksyms_32.c b/arch/sparc/kernel/sparc_ksyms_32.c
index 3c80562..a4d45fc 100644
--- a/arch/sparc/kernel/sparc_ksyms_32.c
+++ b/arch/sparc/kernel/sparc_ksyms_32.c
@@ -61,7 +61,6 @@ extern void (*bzero_1page)(void *);
 extern void *__bzero(void *, size_t);
 extern void *__memscan_zero(void *, size_t);
 extern void *__memscan_generic(void *, int, size_t);
-extern int __memcmp(const void *, const void *, __kernel_size_t);
 extern int __strncmp(const char *, const char *, __kernel_size_t);
 
 extern int __ashrdi3(int, int);
@@ -211,7 +210,6 @@ EXPORT_SYMBOL(bzero_1page);
 EXPORT_SYMBOL(__bzero);
 EXPORT_SYMBOL(__memscan_zero);
 EXPORT_SYMBOL(__memscan_generic);
-EXPORT_SYMBOL(__memcmp);
 EXPORT_SYMBOL(__strncmp);
 EXPORT_SYMBOL(__memmove);
 
diff --git a/arch/sparc/kernel/sparc_ksyms_64.c b/arch/sparc/kernel/sparc_ksyms_64.c
index e6d2bb8..59e7ca0 100644
--- a/arch/sparc/kernel/sparc_ksyms_64.c
+++ b/arch/sparc/kernel/sparc_ksyms_64.c
@@ -62,7 +62,6 @@ extern pid_t kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 extern void *__bzero(void *, size_t);
 extern void *__memscan_zero(void *, size_t);
 extern void *__memscan_generic(void *, int, size_t);
-extern int __memcmp(const void *, const void *, __kernel_size_t);
 extern __kernel_size_t strlen(const char *);
 extern void sys_sigsuspend(void);
 extern int compat_sys_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
@@ -223,7 +222,6 @@ EXPORT_SYMBOL(copy_user_page);
 EXPORT_SYMBOL(__bzero);
 EXPORT_SYMBOL(__memscan_zero);
 EXPORT_SYMBOL(__memscan_generic);
-EXPORT_SYMBOL(__memcmp);
 EXPORT_SYMBOL(__memset);
 
 EXPORT_SYMBOL(csum_partial);
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 0db2c61..375016e 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -9,7 +9,7 @@ lib-$(CONFIG_SPARC32) += memcpy.o memset.o
 lib-y                 += strlen.o
 lib-y                 += checksum_$(BITS).o
 lib-$(CONFIG_SPARC32) += blockops.o
-lib-y                 += memscan_$(BITS).o memcmp_$(BITS).o strncmp_$(BITS).o
+lib-y                 += memscan_$(BITS).o memcmp.o strncmp_$(BITS).o
 lib-y                 += strncpy_from_user_$(BITS).o strlen_user_$(BITS).o
 lib-$(CONFIG_SPARC32) += divdi3.o udivdi3.o
 lib-$(CONFIG_SPARC32) += copy_user.o locks.o
diff --git a/arch/sparc/lib/memcmp.S b/arch/sparc/lib/memcmp.S
new file mode 100644
index 0000000..efa106c
--- /dev/null
+++ b/arch/sparc/lib/memcmp.S
@@ -0,0 +1,27 @@
+/* Sparc optimized memcmp code.
+ *
+ * Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
+ * Copyright (C) 2000, 2008 David S. Miller (davem@davemloft.net)
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm.h>
+
+	.text
+ENTRY(memcmp)
+	cmp	%o2, 0
+1:	BRANCH32(be, pn, 2f)
+	 nop
+	ldub	[%o0], %g7
+	ldub	[%o1], %g3
+	sub	%o2, 1, %o2
+	add	%o0, 1, %o0
+	add	%o1, 1, %o1
+	subcc	%g7, %g3, %g3
+	BRANCH32(be, pt, 1b)
+	 cmp	%o2, 0
+	retl
+	 mov	%g3, %o0
+2:	retl
+	 mov	0, %o0
+ENDPROC(memcmp)
diff --git a/arch/sparc/lib/memcmp_32.S b/arch/sparc/lib/memcmp_32.S
deleted file mode 100644
index 9e21f02..0000000
--- a/arch/sparc/lib/memcmp_32.S
+++ /dev/null
@@ -1,30 +0,0 @@
-	.text
-	.align 4
-	.global __memcmp, memcmp
-__memcmp:
-memcmp:
-	cmp	%o2, 0
-	ble	L3
-	 mov	0, %g3
-L5:
-	ldub	[%o0], %g2
-	ldub	[%o1], %g3
-	sub	%g2, %g3, %g2
-	mov	%g2, %g3
-	sll	%g2, 24, %g2
-
-	cmp	%g2, 0
-	bne	L3
-	 add	%o0, 1, %o0
-
-	add	%o2, -1, %o2
-
-	cmp	%o2, 0
-	bg	L5
-	 add	%o1, 1, %o1
-L3:
-	sll	%g3, 24, %o0
-	sra	%o0, 24, %o0
-
-	retl
-	 nop
diff --git a/arch/sparc/lib/memcmp_64.S b/arch/sparc/lib/memcmp_64.S
deleted file mode 100644
index d3fdaa8..0000000
--- a/arch/sparc/lib/memcmp_64.S
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * Sparc64 optimized memcmp code.
- *
- * Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
- * Copyright (C) 2000 David S. Miller (davem@redhat.com)
- */
-
-	.text
-	.align	32
-	.globl	__memcmp, memcmp
-__memcmp:
-memcmp:
-	cmp	%o2, 0		! IEU1	Group
-loop:	be,pn	%icc, ret_0	! CTI
-	 nop			! IEU0
-	ldub	[%o0], %g7	! LSU	Group
-	ldub	[%o1], %g3	! LSU	Group
-	sub	%o2, 1, %o2	! IEU0
-	add	%o0, 1, %o0	! IEU1
-	add	%o1, 1, %o1	! IEU0	Group
-	subcc	%g7, %g3, %g3	! IEU1	Group
-	be,pt	%icc, loop	! CTI
-	 cmp	%o2, 0		! IEU1	Group
-
-ret_n0:	retl
-	 mov	%g3, %o0
-ret_0:	retl
-	 mov	0, %o0
-- 
1.5.6.5


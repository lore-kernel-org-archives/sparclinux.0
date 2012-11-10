From: David Miller <davem@davemloft.net>
Date: Sat, 10 Nov 2012 03:47:29 +0000
Subject: [PATCH] sparc: Support atomic64_dec_if_positive properly.
Message-Id: <20121109.224729.1209663931097733465.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Sparc32 already supported it, as a consequence of using the
generic atomic64 implementation.  And the sparc64 implementation
is rather trivial.

This allows us to set ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE for all
of sparc, and avoid the annoying warning from lib/atomic64_test.c

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig                 |  1 +
 arch/sparc/include/asm/atomic_64.h |  4 +++-
 arch/sparc/lib/atomic_64.S         | 16 +++++++++++++++-
 arch/sparc/lib/ksyms.c             |  1 +
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index b6b442b..9f2edb5 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -20,6 +20,7 @@ config SPARC
 	select HAVE_ARCH_TRACEHOOK
 	select SYSCTL_EXCEPTION_TRACE
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select RTC_CLASS
 	select RTC_DRV_M48T59
 	select HAVE_IRQ_WORK
diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
index ce35a1c..be56a24 100644
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -1,7 +1,7 @@
 /* atomic.h: Thankfully the V9 is at least reasonable for this
  *           stuff.
  *
- * Copyright (C) 1996, 1997, 2000 David S. Miller (davem@redhat.com)
+ * Copyright (C) 1996, 1997, 2000, 2012 David S. Miller (davem@redhat.com)
  */
 
 #ifndef __ARCH_SPARC64_ATOMIC__
@@ -106,6 +106,8 @@ static inline long atomic64_add_unless(atomic64_t *v, long a, long u)
 
 #define atomic64_inc_not_zero(v) atomic64_add_unless((v), 1, 0)
 
+extern long atomic64_dec_if_positive(atomic64_t *v);
+
 /* Atomic operations are already serializing */
 #define smp_mb__before_atomic_dec()	barrier()
 #define smp_mb__after_atomic_dec()	barrier()
diff --git a/arch/sparc/lib/atomic_64.S b/arch/sparc/lib/atomic_64.S
index 4d502da..85c233d 100644
--- a/arch/sparc/lib/atomic_64.S
+++ b/arch/sparc/lib/atomic_64.S
@@ -1,6 +1,6 @@
 /* atomic.S: These things are too big to do inline.
  *
- * Copyright (C) 1999, 2007 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 1999, 2007 2012 David S. Miller (davem@davemloft.net)
  */
 
 #include <linux/linkage.h>
@@ -117,3 +117,17 @@ ENTRY(atomic64_sub_ret) /* %o0 = decrement, %o1 = atomic_ptr */
 	 sub	%g1, %o0, %o0
 2:	BACKOFF_SPIN(%o2, %o3, 1b)
 ENDPROC(atomic64_sub_ret)
+
+ENTRY(atomic64_dec_if_positive) /* %o0 = atomic_ptr */
+	BACKOFF_SETUP(%o2)
+1:	ldx	[%o0], %g1
+	brlez,pn %g1, 3f
+	 sub	%g1, 1, %g7
+	casx	[%o0], %g1, %g7
+	cmp	%g1, %g7
+	bne,pn	%xcc, BACKOFF_LABEL(2f, 1b)
+	 nop
+3:	retl
+	 sub	%g1, 1, %o0
+2:	BACKOFF_SPIN(%o2, %o3, 1b)
+ENDPROC(atomic64_dec_if_positive)
diff --git a/arch/sparc/lib/ksyms.c b/arch/sparc/lib/ksyms.c
index ee31b88..0c4e35e 100644
--- a/arch/sparc/lib/ksyms.c
+++ b/arch/sparc/lib/ksyms.c
@@ -116,6 +116,7 @@ EXPORT_SYMBOL(atomic64_add);
 EXPORT_SYMBOL(atomic64_add_ret);
 EXPORT_SYMBOL(atomic64_sub);
 EXPORT_SYMBOL(atomic64_sub_ret);
+EXPORT_SYMBOL(atomic64_dec_if_positive);
 
 /* Atomic bit operations. */
 EXPORT_SYMBOL(test_and_set_bit);
-- 
1.7.12.2.dirty


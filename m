From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Tue, 17 Feb 2004 09:04:47 +0000
Subject: [SPARC32] Uninline atomic_t functions
Message-Id: <20040217090447.GA31580@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Feb 13, 2004 at 09:26:38PM -0800, David S. Miller wrote:

> I am going to apply this now to 2.6.x, but we should uninline some of this
> stuff afterwards as I agree with Peter.

Indeed, it saves a whopping 115KB in the final image.  For 2.6.4 I
think.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1692  -> 1.1693 
#	arch/sparc/kernel/smp.c	1.11    -> 1.12   
#	include/asm-sparc/atomic.h	1.9     -> 1.10   
#	arch/sparc/lib/Makefile	1.6     -> 1.7    
#	               (new)	        -> 1.1     arch/sparc/lib/atomic32.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/15	wesolows@foobazco.org	1.1693
# [SPARC32] Outline the atomic functions.
# --------------------------------------------
#
diff -Nru a/arch/sparc/kernel/smp.c b/arch/sparc/kernel/smp.c
--- a/arch/sparc/kernel/smp.c	Mon Feb 16 23:13:24 2004
+++ b/arch/sparc/kernel/smp.c	Mon Feb 16 23:13:24 2004
@@ -56,9 +56,6 @@
 volatile int __cpu_number_map[NR_CPUS];
 volatile int __cpu_logical_map[NR_CPUS];
 cycles_t cacheflush_time = 0; /* XXX */
-spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] = {
-	[0 ... (ATOMIC_HASH_SIZE-1)] = SPIN_LOCK_UNLOCKED
-};
 
 /* The only guaranteed locking primitive available on all Sparc
  * processors is 'ldstub [%reg + immediate], %dest_reg' which atomically
diff -Nru a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
--- a/arch/sparc/lib/Makefile	Mon Feb 16 23:13:24 2004
+++ b/arch/sparc/lib/Makefile	Mon Feb 16 23:13:24 2004
@@ -7,5 +7,5 @@
 lib-y := mul.o rem.o sdiv.o udiv.o umul.o urem.o ashrdi3.o memcpy.o memset.o \
          strlen.o checksum.o blockops.o memscan.o memcmp.o strncmp.o \
 	 strncpy_from_user.o divdi3.o udivdi3.o strlen_user.o \
-	 copy_user.o locks.o atomic.o bitops.o debuglocks.o lshrdi3.o \
-	 ashldi3.o rwsem.o muldi3.o bitext.o
+	 copy_user.o locks.o atomic.o atomic32.o bitops.o debuglocks.o \
+	 lshrdi3.o ashldi3.o rwsem.o muldi3.o bitext.o
diff -Nru a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/sparc/lib/atomic32.c	Mon Feb 16 23:13:24 2004
@@ -0,0 +1,52 @@
+/*
+ * atomic32.c: 32-bit atomic_t implementation
+ *
+ * Copyright (C) 2004 Keith M Wesolowski
+ * 
+ * Based on asm-parisc/atomic.h Copyright (C) 2000 Philipp Rumpf
+ */
+
+#include <asm/atomic.h>
+#include <linux/spinlock.h>
+#include <linux/module.h>
+
+#ifdef CONFIG_SMP
+#define ATOMIC_HASH_SIZE	4
+#define ATOMIC_HASH(a)	(&__atomic_hash[(((unsigned long)a)>>8) & (ATOMIC_HASH_SIZE-1)])
+
+spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] = {
+	[0 ... (ATOMIC_HASH_SIZE-1)] = SPIN_LOCK_UNLOCKED
+};
+
+#else /* SMP */
+
+#define ATOMIC_HASH_SIZE	1
+#define ATOMIC_HASH(a)		0
+
+#endif /* SMP */
+
+int __atomic_add_return(int i, atomic_t *v)
+{
+	int ret;
+	unsigned long flags;
+	spin_lock_irqsave(ATOMIC_HASH(v), flags);
+
+	ret = (v->counter += i);
+
+	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
+	return ret;
+}
+
+void atomic_set(atomic_t *v, int i)
+{
+	unsigned long flags;
+	spin_lock_irqsave(ATOMIC_HASH(v), flags);
+
+	v->counter = i;
+
+	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
+}
+
+EXPORT_SYMBOL(__atomic_add_return);
+EXPORT_SYMBOL(atomic_set);
+
--- 2.5-bk/include/asm-sparc/atomic.h	2004-02-14 09:12:28.000000000 -0800
+++ 2.5-sparc-smp/include/asm-sparc/atomic.h	2004-02-15 23:13:59.628464706 -0800
@@ -11,49 +11,16 @@
 #define __ARCH_SPARC_ATOMIC__
 
 #include <linux/config.h>
-#include <linux/spinlock.h>
 
 typedef struct { volatile int counter; } atomic_t;
 
 #ifdef __KERNEL__
 
-#ifdef CONFIG_SMP
-
-#define ATOMIC_HASH_SIZE	4
-#define ATOMIC_HASH(a)	(&__atomic_hash[(((unsigned long)a)>>8) & (ATOMIC_HASH_SIZE-1)])
-extern spinlock_t __atomic_hash[ATOMIC_HASH_SIZE];
-
-#else /* SMP */
-
-#define ATOMIC_HASH_SIZE	1
-#define ATOMIC_HASH(a)		0
-
-#endif /* SMP */
-
-static inline int __atomic_add_return(int i, atomic_t *v)
-{
-	int ret;
-	unsigned long flags;
-	spin_lock_irqsave(ATOMIC_HASH(v), flags);
-
-	ret = (v->counter += i);
-
-	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
-	return ret;
-}
-
-static inline void atomic_set(atomic_t *v, int i)
-{
-	unsigned long flags;
-	spin_lock_irqsave(ATOMIC_HASH(v), flags);
-
-	v->counter = i;
-
-	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
-}
-
 #define ATOMIC_INIT(i)  { (i) }
 
+extern int __atomic_add_return(int, atomic_t *);
+extern void atomic_set(atomic_t *, int);
+
 #define atomic_read(v)          ((v)->counter)
 
 #define atomic_add(i, v)	((void)__atomic_add_return( (int)(i), (v)))


-- 
Keith M Wesolowski

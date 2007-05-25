From: Kyle McMartin <kyle@parisc-linux.org>
Date: Fri, 25 May 2007 20:11:43 +0000
Subject: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <20070525201143.GB14171@fattire.cabal.ca>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

---

PS: Anyone have a nice prebuilt i386->sparc{32,64} xcompiler setup
I could snag? Would be nice to testbuild these patches before I send
them out next time.

diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 559335f..a45caca 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -2,6 +2,7 @@
  * atomic32.c: 32-bit atomic_t implementation
  *
  * Copyright (C) 2004 Keith M Wesolowski
+ * Copyright (C) 2007 Kyle McMartin
  * 
  * Based on asm-parisc/atomic.h Copyright (C) 2000 Philipp Rumpf
  */
@@ -117,3 +118,17 @@ unsigned long ___change_bit(unsigned long *addr, unsigned long mask)
 	return old & mask;
 }
 EXPORT_SYMBOL(___change_bit);
+
+unsigned long __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
+{
+	unsigned long flags;
+	u32 prev;
+
+	spin_lock_irqsave(ATOMIC_HASH(addr), flags);
+	if ((prev = *addr) = old)
+		*addr = new;
+	spin_unlock_irqrestore(ATOMIC_HASH(addr), flags);
+
+	return (unsigned long)prev;
+}
+EXPORT_SYMBOL(__cmpxchg_u32);
diff --git a/include/asm-sparc/atomic.h b/include/asm-sparc/atomic.h
index 731fa56..ac55f6f 100644
--- a/include/asm-sparc/atomic.h
+++ b/include/asm-sparc/atomic.h
@@ -2,6 +2,7 @@
  *
  * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
  * Copyright (C) 2000 Anton Blanchard (anton@linuxcare.com.au)
+ * Copyright (C) 2007 Kyle McMartin (kyle@parisc-linux.org)
  *
  * Additions by Keith M Wesolowski (wesolows@foobazco.org) based
  * on asm-parisc/atomic.h Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org>.
@@ -15,6 +16,42 @@ typedef struct { volatile int counter; } atomic_t;
 
 #ifdef __KERNEL__
 
+/* Emulate cmpxchg() the same way we emulate atomics,
+ * by hashing the object address and indexing into an array
+ * of spinlocks to get a bit of performance...
+ *
+ * See arch/sparc/lib/atomic32.c for implementation.
+ *
+ * Cribbed from <asm-parisc/atomic.h>
+ */
+#define __HAVE_ARCH_CMPXCHG	1
+
+/* bug catcher for when unsupported size is used - won't link */
+extern void __cmpxchg_called_with_bad_pointer(void);
+/* we only need to support cmpxchg of a u32 on sparc */
+extern unsigned long __cmpxchg_u32(u32 *m, u32 old, u32 new_);
+
+/* don't worry...optimizer will get rid of most of this */
+static __inline__ unsigned long
+__cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
+{
+	switch(size) {
+	case 4:
+		return __cmpxchg_u32((u32 *)ptr, (u32)old, (u32)new_);
+	default:
+		__cmpxchg_called_with_bad_pointer();
+		break;
+	}
+	return old;
+}
+
+#define cmpxchg(ptr,o,n) ({						\
+	__typeof__(*(ptr)) _o_ = (o);					\
+	__typeof__(*(ptr)) _n_ = (n);					\
+	(__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,	\
+			(unsigned long)_n_, sizeof(*(ptr)));		\
+})
+
 #define ATOMIC_INIT(i)  { (i) }
 
 extern int __atomic_add_return(int, atomic_t *);

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sat, 26 May 2007 00:24:40 +0000
Subject: Re: [RFT] [SPARC] Emulate cmpxchg like parisc
Message-Id: <20070526002440.GA15449@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20070525201143.GB14171@fattire.cabal.ca>
In-Reply-To: <20070525201143.GB14171@fattire.cabal.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Kyle,

After some minor fixes this builds, and the DRM drivers also
build again. I cannot test this since I do not have a machine with
PCI or these cards.
Removed your name in the comment, as that went out of fashion after
we started using proper versioning systems.

I've got a ppc->sparc32 compiler if that would help...

Thanks,
Martin

	Acked-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

On Fri, May 25, 2007 at 04:11:43PM -0400, Kyle McMartin wrote:
> Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>
> 
> ---
> 
> PS: Anyone have a nice prebuilt i386->sparc{32,64} xcompiler setup
> I could snag? Would be nice to testbuild these patches before I send
> them out next time.


Index: 2.6.21_drm/arch/sparc/lib/atomic32.c
=================================--- 2.6.21_drm.orig/arch/sparc/lib/atomic32.c	2007-05-23 19:31:00.000000000 +0100
+++ 2.6.21_drm/arch/sparc/lib/atomic32.c	2007-05-26 01:07:09.000000000 +0100
@@ -117,3 +117,17 @@
 	return old & mask;
 }
 EXPORT_SYMBOL(___change_bit);
+
+unsigned long __cmpxchg_u32(volatile u32 *addr, u32 old, u32 new)
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
Index: 2.6.21_drm/include/asm-sparc/atomic.h
=================================--- 2.6.21_drm.orig/include/asm-sparc/atomic.h	2007-05-23 19:31:39.000000000 +0100
+++ 2.6.21_drm/include/asm-sparc/atomic.h	2007-05-26 01:06:37.000000000 +0100
@@ -10,11 +10,48 @@
 #ifndef __ARCH_SPARC_ATOMIC__
 #define __ARCH_SPARC_ATOMIC__
 
+#include <linux/types.h>
 
 typedef struct { volatile int counter; } atomic_t;
 
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
+extern unsigned long __cmpxchg_u32(volatile u32 *m, u32 old, u32 new_);
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

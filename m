From: Matthew Wilcox <matthew@wil.cx>
Date: Thu, 31 Aug 2006 13:42:55 +0000
Subject: generic__raw_read_trylock Considered Harmful
Message-Id: <20060831134254.GE4919@parisc-linux.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: rmk@arm.linux.org.uk, takata@linux-m32r.org, lethal@linux-sh.org, kkojima@rr.iij4u.or.jp, linuxsh-dev@lists.sourceforge.net, wli@holomorphy.com, sparclinux@vger.kernel.org


Back in January 2005, Ingo wrote:

NOTE to architecture maintainers: generic_raw_read_trylock() is a crude
version that should be replaced with the proper arch-optimized version
ASAP.

He didn't really phrase that strongly enough.  It should have read:

NOTE to architecture maintainers: generic_raw_read_trylock() is
completely unfit for use and will cause lockups if used in interrupt
context.

I propose we delete this from the tree, turning a rather nasty and hard
to track down runtime failure into a simple to fix buildtime failure on
the following architectures:

include/asm-arm/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-m32r/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-mips/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-parisc/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-sh/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
include/asm-sparc/spinlock.h:#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)

MIPS is already fixed out of tree.  ARM, M32R, SH and SPARC need to
be fixed.  We're redoing the PA-RISC implementation right now, which is
how I noticed this, er, minor problem.

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 31473db..6ed1e54 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -77,8 +77,6 @@ #define __lockfunc fastcall __attribute_
  */
 #include <linux/spinlock_types.h>
 
-extern int __lockfunc generic__raw_read_trylock(raw_rwlock_t *lock);
-
 /*
  * Pull the __raw*() functions/declarations (UP-nondebug doesnt need them):
  */
diff --git a/kernel/spinlock.c b/kernel/spinlock.c
index bfd6ad9..c9f1541 100644
--- a/kernel/spinlock.c
+++ b/kernel/spinlock.c
@@ -16,17 +16,6 @@ #include <linux/interrupt.h>
 #include <linux/debug_locks.h>
 #include <linux/module.h>
 
-/*
- * Generic declaration of the raw read_trylock() function,
- * architectures are supposed to optimize this:
- */
-int __lockfunc generic__raw_read_trylock(raw_rwlock_t *lock)
-{
-	__raw_read_lock(lock);
-	return 1;
-}
-EXPORT_SYMBOL(generic__raw_read_trylock);
-
 int __lockfunc _spin_trylock(spinlock_t *lock)
 {
 	preempt_disable();

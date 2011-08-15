From: Mikael Pettersson <mikpe@it.uu.se>
Date: Mon, 15 Aug 2011 11:09:09 +0000
Subject: [PATCH,SPARC] make sparc32 arch_write_unlock() match the sparc64 version
Message-Id: <20040.65109.439941.444670@pilspetsen.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

The sparc32 version of arch_write_unlock() is just a plain assignment.
Unfortunately this allows the compiler to schedule side-effects in a
protected region to occur after the HW-level unlock, which is broken.
E.g., the following trivial test case gets miscompiled:

	#include <linux/spinlock.h>
	rwlock_t lock;
	int counter;
	void foo(void) { write_lock(&lock); ++counter; write_unlock(&lock); }

Fixed by adding a compiler memory barrier to arch_write_unlock().  The
sparc64 version combines the barrier and assignment into a single asm(),
so that's what I did here as well.

Compiled-tested with a sparc32 SMP kernel.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>
---
--- linux-3.1-rc2/arch/sparc/include/asm/spinlock_32.h.~1~	2011-07-22 12:01:08.000000000 +0200
+++ linux-3.1-rc2/arch/sparc/include/asm/spinlock_32.h	2011-08-15 11:43:49.000000000 +0200
@@ -131,6 +131,15 @@ static inline void arch_write_lock(arch_
 	*(volatile __u32 *)&lp->lock = ~0U;
 }
 
+static void inline arch_write_unlock(arch_rwlock_t *lock)
+{
+	__asm__ __volatile__(
+"	st		%%g0, [%0]"
+	: /* no outputs */
+	: "r" (lock)
+	: "memory");
+}
+
 static inline int arch_write_trylock(arch_rwlock_t *rw)
 {
 	unsigned int val;
@@ -175,7 +184,7 @@ static inline int __arch_read_trylock(ar
 	res; \
 })
 
-#define arch_write_unlock(rw)	do { (rw)->lock = 0; } while(0)
+#define arch_write_unlock(rw)	arch_write_unlock(rw)
 
 #define arch_spin_lock_flags(lock, flags) arch_spin_lock(lock)
 #define arch_read_lock_flags(rw, flags)   arch_read_lock(rw)

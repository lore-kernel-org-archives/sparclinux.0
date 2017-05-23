From: Babu Moger <babu.moger@oracle.com>
Date: Tue, 23 May 2017 21:45:58 +0000
Subject: [PATCH v3 7/7] arch/sparc: Enable queued spinlock support for SPARC
Message-Id: <1495575958-1022566-8-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1495575958-1022566-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1495575958-1022566-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, arnd@arndb.de
Cc: babu.moger@oracle.com, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

This patch makes the necessary changes in SPARC architecture to enable
queued spinlock support. Here are some of the earlier discussions about
this feature.
https://lwn.net/Articles/561775/
https://lwn.net/Articles/590243/

Cleaned-up the spinlock_64.h. The definitions of arch_spin_xxx are
replaced by the function in <asm-generic/qspinlock.h>

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/Kconfig                      |    1 +
 arch/sparc/include/asm/qspinlock.h      |    7 +++
 arch/sparc/include/asm/spinlock_64.h    |   84 +--------------------------=
----
 arch/sparc/include/asm/spinlock_types.h |    5 ++
 4 files changed, 14 insertions(+), 83 deletions(-)
 create mode 100644 arch/sparc/include/asm/qspinlock.h

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 4bf2dc6..f7183d0 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -84,6 +84,7 @@ config SPARC64
 	select HAVE_NMI
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_USE_QUEUED_SPINLOCKS
=20
 config ARCH_DEFCONFIG
 	string
diff --git a/arch/sparc/include/asm/qspinlock.h b/arch/sparc/include/asm/qs=
pinlock.h
new file mode 100644
index 0000000..5ae9a28
--- /dev/null
+++ b/arch/sparc/include/asm/qspinlock.h
@@ -0,0 +1,7 @@
+#ifndef _ASM_SPARC_QSPINLOCK_H
+#define _ASM_SPARC_QSPINLOCK_H
+
+#include <asm-generic/qspinlock_types.h>
+#include <asm-generic/qspinlock.h>
+
+#endif /* _ASM_SPARC_QSPINLOCK_H */
diff --git a/arch/sparc/include/asm/spinlock_64.h b/arch/sparc/include/asm/=
spinlock_64.h
index 8901c2d..f7028f5 100644
--- a/arch/sparc/include/asm/spinlock_64.h
+++ b/arch/sparc/include/asm/spinlock_64.h
@@ -11,89 +11,7 @@
 #include <asm/processor.h>
 #include <asm/barrier.h>
 #include <asm/qrwlock.h>
-
-/* To get debugging spinlocks which detect and catch
- * deadlock situations, set CONFIG_DEBUG_SPINLOCK
- * and rebuild your kernel.
- */
-
-/* Because we play games to save cycles in the non-contention case, we
- * need to be extra careful about branch targets into the "spinning"
- * code.  They live in their own section, but the newer V9 branches
- * have a shorter range than the traditional 32-bit sparc branch
- * variants.  The rule is that the branches that go into and out of
- * the spinner sections must be pre-V9 branches.
- */
-
-#define arch_spin_is_locked(lp)	((lp)->lock !=3D 0)
-
-static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
-{
-	smp_cond_load_acquire(&lock->lock, !VAL);
-}
-
-static inline void arch_spin_lock(arch_spinlock_t *lock)
-{
-	unsigned long tmp;
-
-	__asm__ __volatile__(
-"1:	ldstub		[%1], %0\n"
-"	brnz,pn		%0, 2f\n"
-"	 nop\n"
-"	.subsection	2\n"
-"2:	ldub		[%1], %0\n"
-"	brnz,pt		%0, 2b\n"
-"	 nop\n"
-"	ba,a,pt		%%xcc, 1b\n"
-"	.previous"
-	: "=3D&r" (tmp)
-	: "r" (lock)
-	: "memory");
-}
-
-static inline int arch_spin_trylock(arch_spinlock_t *lock)
-{
-	unsigned long result;
-
-	__asm__ __volatile__(
-"	ldstub		[%1], %0\n"
-	: "=3Dr" (result)
-	: "r" (lock)
-	: "memory");
-
-	return (result =3D 0UL);
-}
-
-static inline void arch_spin_unlock(arch_spinlock_t *lock)
-{
-	__asm__ __volatile__(
-"	stb		%%g0, [%0]"
-	: /* No outputs */
-	: "r" (lock)
-	: "memory");
-}
-
-static inline void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned lo=
ng flags)
-{
-	unsigned long tmp1, tmp2;
-
-	__asm__ __volatile__(
-"1:	ldstub		[%2], %0\n"
-"	brnz,pn		%0, 2f\n"
-"	 nop\n"
-"	.subsection	2\n"
-"2:	rdpr		%%pil, %1\n"
-"	wrpr		%3, %%pil\n"
-"3:	ldub		[%2], %0\n"
-"	brnz,pt		%0, 3b\n"
-"	 nop\n"
-"	ba,pt		%%xcc, 1b\n"
-"	 wrpr		%1, %%pil\n"
-"	.previous"
-	: "=3D&r" (tmp1), "=3D&r" (tmp2)
-	: "r"(lock), "r"(flags)
-	: "memory");
-}
+#include <asm/qspinlock.h>
=20
 #define arch_read_lock_flags(p, f) arch_read_lock(p)
 #define arch_write_lock_flags(p, f) arch_write_lock(p)
diff --git a/arch/sparc/include/asm/spinlock_types.h b/arch/sparc/include/a=
sm/spinlock_types.h
index 64fce21..bce8ef4 100644
--- a/arch/sparc/include/asm/spinlock_types.h
+++ b/arch/sparc/include/asm/spinlock_types.h
@@ -1,11 +1,16 @@
 #ifndef __SPARC_SPINLOCK_TYPES_H
 #define __SPARC_SPINLOCK_TYPES_H
=20
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm-generic/qspinlock_types.h>
+#else
+
 typedef struct {
 	volatile unsigned char lock;
 } arch_spinlock_t;
=20
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
+#endif /* CONFIG_QUEUED_SPINLOCKS */
=20
 #ifdef CONFIG_QUEUED_RWLOCKS
 #include <asm-generic/qrwlock_types.h>
--=20
1.7.1


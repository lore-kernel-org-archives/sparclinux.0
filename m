From: Babu Moger <babu.moger@oracle.com>
Date: Tue, 23 May 2017 21:45:56 +0000
Subject: [PATCH v3 5/7] arch/sparc: Enable queued rwlocks for SPARC
Message-Id: <1495575958-1022566-6-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1495575958-1022566-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1495575958-1022566-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, arnd@arndb.de
Cc: babu.moger@oracle.com, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Enable queued rwlocks for SPARC. Here are the discussions on this feature
when this was introduced.
https://lwn.net/Articles/572765/
https://lwn.net/Articles/582200/

Cleaned-up the arch_read_xxx and arch_write_xxx definitions in spinlock_64.=
h.
These routines are replaced by the functions in include/asm-generic/qrwlock=
.h

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/Kconfig                      |    1 +
 arch/sparc/include/asm/qrwlock.h        |    7 ++
 arch/sparc/include/asm/spinlock_64.h    |  124 +--------------------------=
----
 arch/sparc/include/asm/spinlock_types.h |    5 +-
 4 files changed, 13 insertions(+), 124 deletions(-)
 create mode 100644 arch/sparc/include/asm/qrwlock.h

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 2f58c16..4bf2dc6 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -83,6 +83,7 @@ config SPARC64
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select HAVE_NMI
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select ARCH_USE_QUEUED_RWLOCKS
=20
 config ARCH_DEFCONFIG
 	string
diff --git a/arch/sparc/include/asm/qrwlock.h b/arch/sparc/include/asm/qrwl=
ock.h
new file mode 100644
index 0000000..d68a4b1
--- /dev/null
+++ b/arch/sparc/include/asm/qrwlock.h
@@ -0,0 +1,7 @@
+#ifndef _ASM_SPARC_QRWLOCK_H
+#define _ASM_SPARC_QRWLOCK_H
+
+#include <asm-generic/qrwlock_types.h>
+#include <asm-generic/qrwlock.h>
+
+#endif /* _ASM_SPARC_QRWLOCK_H */
diff --git a/arch/sparc/include/asm/spinlock_64.h b/arch/sparc/include/asm/=
spinlock_64.h
index 07c9f2e..8901c2d 100644
--- a/arch/sparc/include/asm/spinlock_64.h
+++ b/arch/sparc/include/asm/spinlock_64.h
@@ -10,6 +10,7 @@
=20
 #include <asm/processor.h>
 #include <asm/barrier.h>
+#include <asm/qrwlock.h>
=20
 /* To get debugging spinlocks which detect and catch
  * deadlock situations, set CONFIG_DEBUG_SPINLOCK
@@ -94,132 +95,9 @@ static inline void arch_spin_lock_flags(arch_spinlock_t=
 *lock, unsigned long fla
 	: "memory");
 }
=20
-/* Multi-reader locks, these are much saner than the 32-bit Sparc ones... =
*/
-
-static inline void arch_read_lock(arch_rwlock_t *lock)
-{
-	unsigned long tmp1, tmp2;
-
-	__asm__ __volatile__ (
-"1:	ldsw		[%2], %0\n"
-"	brlz,pn		%0, 2f\n"
-"4:	 add		%0, 1, %1\n"
-"	cas		[%2], %0, %1\n"
-"	cmp		%0, %1\n"
-"	bne,pn		%%icc, 1b\n"
-"	 nop\n"
-"	.subsection	2\n"
-"2:	ldsw		[%2], %0\n"
-"	brlz,pt		%0, 2b\n"
-"	 nop\n"
-"	ba,a,pt		%%xcc, 4b\n"
-"	.previous"
-	: "=3D&r" (tmp1), "=3D&r" (tmp2)
-	: "r" (lock)
-	: "memory");
-}
-
-static inline int arch_read_trylock(arch_rwlock_t *lock)
-{
-	int tmp1, tmp2;
-
-	__asm__ __volatile__ (
-"1:	ldsw		[%2], %0\n"
-"	brlz,a,pn	%0, 2f\n"
-"	 mov		0, %0\n"
-"	add		%0, 1, %1\n"
-"	cas		[%2], %0, %1\n"
-"	cmp		%0, %1\n"
-"	bne,pn		%%icc, 1b\n"
-"	 mov		1, %0\n"
-"2:"
-	: "=3D&r" (tmp1), "=3D&r" (tmp2)
-	: "r" (lock)
-	: "memory");
-
-	return tmp1;
-}
-
-static inline void arch_read_unlock(arch_rwlock_t *lock)
-{
-	unsigned long tmp1, tmp2;
-
-	__asm__ __volatile__(
-"1:	lduw	[%2], %0\n"
-"	sub	%0, 1, %1\n"
-"	cas	[%2], %0, %1\n"
-"	cmp	%0, %1\n"
-"	bne,pn	%%xcc, 1b\n"
-"	 nop"
-	: "=3D&r" (tmp1), "=3D&r" (tmp2)
-	: "r" (lock)
-	: "memory");
-}
-
-static inline void arch_write_lock(arch_rwlock_t *lock)
-{
-	unsigned long mask, tmp1, tmp2;
-
-	mask =3D 0x80000000UL;
-
-	__asm__ __volatile__(
-"1:	lduw		[%2], %0\n"
-"	brnz,pn		%0, 2f\n"
-"4:	 or		%0, %3, %1\n"
-"	cas		[%2], %0, %1\n"
-"	cmp		%0, %1\n"
-"	bne,pn		%%icc, 1b\n"
-"	 nop\n"
-"	.subsection	2\n"
-"2:	lduw		[%2], %0\n"
-"	brnz,pt		%0, 2b\n"
-"	 nop\n"
-"	ba,a,pt		%%xcc, 4b\n"
-"	.previous"
-	: "=3D&r" (tmp1), "=3D&r" (tmp2)
-	: "r" (lock), "r" (mask)
-	: "memory");
-}
-
-static inline void arch_write_unlock(arch_rwlock_t *lock)
-{
-	__asm__ __volatile__(
-"	stw		%%g0, [%0]"
-	: /* no outputs */
-	: "r" (lock)
-	: "memory");
-}
-
-static inline int arch_write_trylock(arch_rwlock_t *lock)
-{
-	unsigned long mask, tmp1, tmp2, result;
-
-	mask =3D 0x80000000UL;
-
-	__asm__ __volatile__(
-"	mov		0, %2\n"
-"1:	lduw		[%3], %0\n"
-"	brnz,pn		%0, 2f\n"
-"	 or		%0, %4, %1\n"
-"	cas		[%3], %0, %1\n"
-"	cmp		%0, %1\n"
-"	bne,pn		%%icc, 1b\n"
-"	 nop\n"
-"	mov		1, %2\n"
-"2:"
-	: "=3D&r" (tmp1), "=3D&r" (tmp2), "=3D&r" (result)
-	: "r" (lock), "r" (mask)
-	: "memory");
-
-	return result;
-}
-
 #define arch_read_lock_flags(p, f) arch_read_lock(p)
 #define arch_write_lock_flags(p, f) arch_write_lock(p)
=20
-#define arch_read_can_lock(rw)		(!((rw)->lock & 0x80000000UL))
-#define arch_write_can_lock(rw)	(!(rw)->lock)
-
 #define arch_spin_relax(lock)	cpu_relax()
 #define arch_read_relax(lock)	cpu_relax()
 #define arch_write_relax(lock)	cpu_relax()
diff --git a/arch/sparc/include/asm/spinlock_types.h b/arch/sparc/include/a=
sm/spinlock_types.h
index 019c085..64fce21 100644
--- a/arch/sparc/include/asm/spinlock_types.h
+++ b/arch/sparc/include/asm/spinlock_types.h
@@ -7,10 +7,13 @@
=20
 #define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
=20
+#ifdef CONFIG_QUEUED_RWLOCKS
+#include <asm-generic/qrwlock_types.h>
+#else
 typedef struct {
 	volatile unsigned int lock;
 } arch_rwlock_t;
=20
 #define __ARCH_RW_LOCK_UNLOCKED		{ 0 }
-
+#endif /* CONFIG_QUEUED_RWLOCKS */
 #endif
--=20
1.7.1


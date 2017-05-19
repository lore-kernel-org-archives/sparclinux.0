From: Babu Moger <babu.moger@oracle.com>
Date: Fri, 19 May 2017 00:36:08 +0000
Subject: [PATCH 4/6] arch/sparc: Enable queued rwlocks for SPARC
Message-Id: <1495154170-854693-5-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, arnd@arndb.de
Cc: babu.moger@oracle.com, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Enable queued rwlocks for SPARC. Here are the discussions on this feature
when this was introduced.
https://lwn.net/Articles/572765/
https://lwn.net/Articles/582200/

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/Kconfig                      |    1 +
 arch/sparc/include/asm/qrwlock.h        |    7 +++++++
 arch/sparc/include/asm/spinlock_64.h    |    9 ++++++---
 arch/sparc/include/asm/spinlock_types.h |    5 ++++-
 4 files changed, 18 insertions(+), 4 deletions(-)
 create mode 100644 arch/sparc/include/asm/qrwlock.h

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8787fc4..caeda1c 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -82,6 +82,7 @@ config SPARC64
 	select HAVE_ARCH_AUDITSYSCALL
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select HAVE_NMI
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
index 07c9f2e..562dbd8 100644
--- a/arch/sparc/include/asm/spinlock_64.h
+++ b/arch/sparc/include/asm/spinlock_64.h
@@ -94,6 +94,7 @@ static inline void arch_spin_lock_flags(arch_spinlock_t *=
lock, unsigned long fla
 	: "memory");
 }
=20
+#ifndef CONFIG_QUEUED_RWLOCKS
 /* Multi-reader locks, these are much saner than the 32-bit Sparc ones... =
*/
=20
 static inline void arch_read_lock(arch_rwlock_t *lock)
@@ -214,12 +215,14 @@ static inline int arch_write_trylock(arch_rwlock_t *l=
ock)
 	return result;
 }
=20
-#define arch_read_lock_flags(p, f) arch_read_lock(p)
-#define arch_write_lock_flags(p, f) arch_write_lock(p)
-
 #define arch_read_can_lock(rw)		(!((rw)->lock & 0x80000000UL))
 #define arch_write_can_lock(rw)	(!(rw)->lock)
=20
+#endif /* #ifndef CONFIG_QUEUED_RWLOCKS */
+#include <asm/qrwlock.h>
+#define arch_read_lock_flags(p, f) arch_read_lock(p)
+#define arch_write_lock_flags(p, f) arch_write_lock(p)
+
 #define arch_spin_relax(lock)	cpu_relax()
 #define arch_read_relax(lock)	cpu_relax()
 #define arch_write_relax(lock)	cpu_relax()
diff --git a/arch/sparc/include/asm/spinlock_types.h b/arch/sparc/include/a=
sm/spinlock_types.h
index 9c454fd..e052d28 100644
--- a/arch/sparc/include/asm/spinlock_types.h
+++ b/arch/sparc/include/asm/spinlock_types.h
@@ -11,10 +11,13 @@
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


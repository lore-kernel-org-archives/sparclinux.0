From: Tobias Klauser <tklauser@distanz.ch>
Date: Fri, 21 Oct 2016 13:25:54 +0000
Subject: [PATCH] sparc64: Fix old style declaration GCC warnings
Message-Id: <20161021132554.20839-1-tklauser@distanz.ch>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix [-Wold-style-declaration] GCC warnings by moving the inline keyword
before the return type.

Signed-off-by: Tobias Klnuser <tklauser@distanz.ch>
---
 arch/sparc/include/asm/spinlock_64.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/spinlock_64.h b/arch/sparc/include/asm/spinlock_64.h
index 87990b7c6b0d..07c9f2e9bf57 100644
--- a/arch/sparc/include/asm/spinlock_64.h
+++ b/arch/sparc/include/asm/spinlock_64.h
@@ -96,7 +96,7 @@ static inline void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long fla
 
 /* Multi-reader locks, these are much saner than the 32-bit Sparc ones... */
 
-static void inline arch_read_lock(arch_rwlock_t *lock)
+static inline void arch_read_lock(arch_rwlock_t *lock)
 {
 	unsigned long tmp1, tmp2;
 
@@ -119,7 +119,7 @@ static void inline arch_read_lock(arch_rwlock_t *lock)
 	: "memory");
 }
 
-static int inline arch_read_trylock(arch_rwlock_t *lock)
+static inline int arch_read_trylock(arch_rwlock_t *lock)
 {
 	int tmp1, tmp2;
 
@@ -140,7 +140,7 @@ static int inline arch_read_trylock(arch_rwlock_t *lock)
 	return tmp1;
 }
 
-static void inline arch_read_unlock(arch_rwlock_t *lock)
+static inline void arch_read_unlock(arch_rwlock_t *lock)
 {
 	unsigned long tmp1, tmp2;
 
@@ -156,7 +156,7 @@ static void inline arch_read_unlock(arch_rwlock_t *lock)
 	: "memory");
 }
 
-static void inline arch_write_lock(arch_rwlock_t *lock)
+static inline void arch_write_lock(arch_rwlock_t *lock)
 {
 	unsigned long mask, tmp1, tmp2;
 
@@ -181,7 +181,7 @@ static void inline arch_write_lock(arch_rwlock_t *lock)
 	: "memory");
 }
 
-static void inline arch_write_unlock(arch_rwlock_t *lock)
+static inline void arch_write_unlock(arch_rwlock_t *lock)
 {
 	__asm__ __volatile__(
 "	stw		%%g0, [%0]"
@@ -190,7 +190,7 @@ static void inline arch_write_unlock(arch_rwlock_t *lock)
 	: "memory");
 }
 
-static int inline arch_write_trylock(arch_rwlock_t *lock)
+static inline int arch_write_trylock(arch_rwlock_t *lock)
 {
 	unsigned long mask, tmp1, tmp2, result;
 
-- 
2.9.0



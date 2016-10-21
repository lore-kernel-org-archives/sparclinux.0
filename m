From: Tobias Klauser <tklauser@distanz.ch>
Date: Fri, 21 Oct 2016 13:39:03 +0000
Subject: [PATCH] sparc32: Fix old style declaration GCC warnings
Message-Id: <20161021133903.7608-1-tklauser@distanz.ch>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix [-Wold-style-declaration] GCC warnings by moving the inline keyword
before the return type.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/sparc/include/asm/spinlock_32.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/spinlock_32.h b/arch/sparc/include/asm/spinlock_32.h
index d9c5876c6121..8011e79f59c9 100644
--- a/arch/sparc/include/asm/spinlock_32.h
+++ b/arch/sparc/include/asm/spinlock_32.h
@@ -134,7 +134,7 @@ static inline void arch_write_lock(arch_rwlock_t *rw)
 	*(volatile __u32 *)&lp->lock = ~0U;
 }
 
-static void inline arch_write_unlock(arch_rwlock_t *lock)
+static inline void arch_write_unlock(arch_rwlock_t *lock)
 {
 	__asm__ __volatile__(
 "	st		%%g0, [%0]"
-- 
2.9.0



From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 23 Jan 2011 15:17:04 +0000
Subject: [patch 4/9] sparc: Replace deprecated spinlock initialization
Message-Id: <20110123143837.223928325@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20110123143631.392446736@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

SPIN_LOCK_UNLOCK is deprecated. Use the lockdep capable variant
instead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/lib/atomic32.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/sparc/lib/atomic32.c
=================================--- linux-2.6.orig/arch/sparc/lib/atomic32.c
+++ linux-2.6/arch/sparc/lib/atomic32.c
@@ -16,7 +16,7 @@
 #define ATOMIC_HASH(a)	(&__atomic_hash[(((unsigned long)a)>>8) & (ATOMIC_HASH_SIZE-1)])
 
 spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] = {
-	[0 ... (ATOMIC_HASH_SIZE-1)] = SPIN_LOCK_UNLOCKED
+	[0 ... (ATOMIC_HASH_SIZE-1)] = __SPIN_LOCK_UNLOCKED(__atomic_hash)
 };
 
 #else /* SMP */



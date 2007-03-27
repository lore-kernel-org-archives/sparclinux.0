From: Robert Reif <reif@earthlink.net>
Date: Tue, 27 Mar 2007 02:03:10 +0000
Subject: [PATCH] fix sparc32 SMP build regression
Message-Id: <1174960990.13037.7.camel@dell>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

commit b19cbe2a1695c09c74f83646c4b82b51123b3690 [BRIDGE]: Fix fdb RCU
race

breaks sparc SMP build because atomic_add_unless is not exported.

This patch exports atomic_add_unless and atomic_cmpxchg.

Compile tested only.

Signed-off-by: Robert Reif <reif@earthlink.net>

diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 53ddcd9..559335f 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -52,6 +52,7 @@ int atomic_cmpxchg(atomic_t *v, int old,
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
 	return ret;
 }
+EXPORT_SYMBOL(atomic_cmpxchg);
 
 int atomic_add_unless(atomic_t *v, int a, int u)
 {
@@ -65,6 +66,7 @@ int atomic_add_unless(atomic_t *v, int a
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
 	return ret != u;
 }
+EXPORT_SYMBOL(atomic_add_unless);
 
 /* Atomic operations are already serializing */
 void atomic_set(atomic_t *v, int i)




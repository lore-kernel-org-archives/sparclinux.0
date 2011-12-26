From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 26 Dec 2011 22:29:55 +0000
Subject: [PATCH 2/2] sparc32: drop useless preprocessor conditional in
Message-Id: <20111226222955.GB20839@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 87e57f5d7e32a974416f91e238b33fb6d8297e93 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 26 Dec 2011 21:05:27 +0100
Subject: [PATCH 2/2] sparc32: drop useless preprocessor conditional in atomic_32.h

arch/sparc/include/asm/atomic_32.h is not exported to userspace.
So there is no need to protect code using __KERNEL__.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/atomic_32.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/atomic_32.h
index 534832f..03fd0c5 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -13,8 +13,6 @@
 
 #include <linux/types.h>
 
-#ifdef __KERNEL__
-
 #include <asm/system.h>
 
 #define ATOMIC_INIT(i)  { (i) }
@@ -58,6 +56,4 @@ extern void atomic_set(atomic_t *, int);
 #define smp_mb__before_atomic_inc()	barrier()
 #define smp_mb__after_atomic_inc()	barrier()
 
-#endif /* !(__KERNEL__) */
-
 #endif /* !(__ARCH_SPARC_ATOMIC__) */
-- 
1.6.0.6


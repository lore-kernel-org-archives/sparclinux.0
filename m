From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 15:33:34 +0000
Subject: [PATCH 2/2] sparc32: use flushi when run-time patching in per_cpu_patch
Message-Id: <20120520153334.GB13857@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From ddbad389ff8ab3b0c3c2a04fb31c3bffdc8e578f Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 17:27:53 +0200
Subject: [PATCH 2/2] sparc32: use flushi when run-time patching in per_cpu_patch

Davis S. Miller wrote:
"
The way we do that now is overkill.  We only needed to use the MMU
cache ops when we had sun4c around because sun4c lacked support for
the "flush" instruction.

But all sun4m and later chips have it so we can use it
unconditionally.

So in the per_cpu_patch() code, get rid of the cache ops invocation,
and instead execute a "flush %reg" after each of the instruction patch
assignments, where %reg is set to the address of the instruction that
was stored into.

Perhaps take the flushi() definition from asm/cacheflush_64.h and
place it into asm/cacheflush.h, then you can simply use that.
"

Implemented as per suggestion.
Moved run-time patching before we call paging_init(),
so helper methods in paging_init() may utilise run-time patching too.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/cacheflush.h    |    4 ++++
 arch/sparc/include/asm/cacheflush_64.h |    3 ---
 arch/sparc/kernel/setup_32.c           |   16 ++++++----------
 3 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/include/asm/cacheflush.h b/arch/sparc/include/asm/cacheflush.h
index 0491680..f6c4839 100644
--- a/arch/sparc/include/asm/cacheflush.h
+++ b/arch/sparc/include/asm/cacheflush.h
@@ -1,5 +1,9 @@
 #ifndef ___ASM_SPARC_CACHEFLUSH_H
 #define ___ASM_SPARC_CACHEFLUSH_H
+
+/* flush addr - to allow use of self-modifying code */
+#define flushi(addr)	__asm__ __volatile__ ("flush %0" : : "r" (addr) : "memory")
+
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/cacheflush_64.h>
 #else
diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/asm/cacheflush_64.h
index 2efea2f..301736d 100644
--- a/arch/sparc/include/asm/cacheflush_64.h
+++ b/arch/sparc/include/asm/cacheflush_64.h
@@ -8,9 +8,6 @@
 #include <linux/mm.h>
 
 /* Cache flush operations. */
-
-
-#define flushi(addr)	__asm__ __volatile__ ("flush %0" : : "r" (addr) : "memory")
 #define flushw_all()	__asm__ __volatile__("flushw")
 
 extern void __flushw_user(void);
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index d65b5a1..c052313 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -227,16 +227,14 @@ static void __init per_cpu_patch(void)
 			prom_halt();
 		}
 		*(unsigned int *) (addr + 0) = insns[0];
+		flushi(addr + 0);
 		*(unsigned int *) (addr + 4) = insns[1];
+		flushi(addr + 4);
 		*(unsigned int *) (addr + 8) = insns[2];
+		flushi(addr + 8);
 
 		p++;
 	}
-#ifdef CONFIG_SMP
-	local_ops->cache_all();
-#else
-	sparc32_cachetlb_ops->cache_all();
-#endif
 }
 
 enum sparc_cpu sparc_cpu_model;
@@ -340,13 +338,11 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.context = (unsigned long) NO_CONTEXT;
 	init_task.thread.kregs = &fake_swapper_regs;
 
-	paging_init();
-
-	/* Now that we have the cache ops hooked up, we can patch
-	 * instructions.
-	 */
+	/* Run-time patch instructions to match the cpu model */
 	per_cpu_patch();
 
+	paging_init();
+
 	smp_setup_cpu_possible_map();
 }
 
-- 
1.6.0.6


From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:26:07 +0000
Subject: [PATCH 29/34] sparc64: fix sparse warnings in init_64.c
Message-Id: <1400275572-17424-29-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-29-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-29-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
init_64.c:191:10: warning: symbol 'dcpage_flushes' was not declared. Should it be static?
init_64.c:193:10: warning: symbol 'dcpage_flushes_xcall' was not declared. Should it be static?

Add extern declaration to asm/setup.h and drop local declaration in smp_64.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/setup.h | 4 ++++
 arch/sparc/kernel/smp_64.c     | 6 +-----
 arch/sparc/mm/init_64.c        | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 0c4f695..f5fffd8 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -52,6 +52,10 @@ unsigned long safe_compute_effective_address(struct pt_regs *, unsigned int);
 int handle_ldf_stq(u32 insn, struct pt_regs *regs);
 void handle_ld_nf(u32 insn, struct pt_regs *regs);
 
+/* init_64.c */
+extern atomic_t dcpage_flushes;
+extern atomic_t dcpage_flushes_xcall;
+
 extern int sysctl_tsb_ratio;
 #endif
 
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index afc71bf..61605b3 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -36,6 +36,7 @@
 #include <asm/hvtramp.h>
 #include <asm/io.h>
 #include <asm/timer.h>
+#include <asm/setup.h>
 
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
@@ -861,11 +862,6 @@ extern unsigned long xcall_flush_dcache_page_cheetah;
 #endif
 extern unsigned long xcall_flush_dcache_page_spitfire;
 
-#ifdef CONFIG_DEBUG_DCFLUSH
-extern atomic_t dcpage_flushes;
-extern atomic_t dcpage_flushes_xcall;
-#endif
-
 static inline void __local_flush_dcache_page(struct page *page)
 {
 #ifdef DCACHE_ALIASING_POSSIBLE
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index eafbc65..0ebe2fd 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -47,6 +47,7 @@
 #include <asm/prom.h>
 #include <asm/mdesc.h>
 #include <asm/cpudata.h>
+#include <asm/setup.h>
 #include <asm/irq.h>
 
 #include "init_64.h"
-- 
1.9.0


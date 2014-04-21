From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:30 +0000
Subject: [PATCH 15/29] sparc: fix sparse warnings in cpu.c
Message-Id: <1398109184-3283-15-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following sparc32 warning:
cpu.c:430:29: warning: symbol 'cpuinfo_op' was not declared. Should it be static?

Fix following sparc64 warnings:
cpu.c:364:14: warning: symbol 'dcache_parity_tl1_occurred' was not declared. Should it be static?
cpu.c:365:14: warning: symbol 'icache_parity_tl1_occurred' was not declared. Should it be static?

Rearrange asm/cpu.h to share more stuff between sparc32 and sparc64.
Added missing include to cpu.c of kernel.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/cpudata.h    | 10 ++++++++++
 arch/sparc/include/asm/cpudata_64.h |  5 -----
 arch/sparc/kernel/cpu.c             |  1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/cpudata.h b/arch/sparc/include/asm/cpudata.h
index b5976de..128b56b 100644
--- a/arch/sparc/include/asm/cpudata.h
+++ b/arch/sparc/include/asm/cpudata.h
@@ -1,5 +1,15 @@
 #ifndef ___ASM_SPARC_CPUDATA_H
 #define ___ASM_SPARC_CPUDATA_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/threads.h>
+#include <linux/percpu.h>
+
+extern const struct seq_operations cpuinfo_op;
+
+#endif /* !(__ASSEMBLY__) */
+
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/cpudata_64.h>
 #else
diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm/cpudata_64.h
index 050ef35..0e59407 100644
--- a/arch/sparc/include/asm/cpudata_64.h
+++ b/arch/sparc/include/asm/cpudata_64.h
@@ -8,9 +8,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/percpu.h>
-#include <linux/threads.h>
-
 typedef struct {
 	/* Dcache line 1 */
 	unsigned int	__softirq_pending; /* must be 1st, see rtrap.S */
@@ -35,8 +32,6 @@ DECLARE_PER_CPU(cpuinfo_sparc, __cpu_data);
 #define cpu_data(__cpu)		per_cpu(__cpu_data, (__cpu))
 #define local_cpu_data()	__get_cpu_var(__cpu_data)
 
-extern const struct seq_operations cpuinfo_op;
-
 #endif /* !(__ASSEMBLY__) */
 
 #include <asm/trap_block.h>
diff --git a/arch/sparc/kernel/cpu.c b/arch/sparc/kernel/cpu.c
index 5c51258..82a3a71 100644
--- a/arch/sparc/kernel/cpu.c
+++ b/arch/sparc/kernel/cpu.c
@@ -22,6 +22,7 @@
 #include <asm/cpudata.h>
 
 #include "kernel.h"
+#include "entry.h"
 
 DEFINE_PER_CPU(cpuinfo_sparc, __cpu_data) = { 0 };
 EXPORT_PER_CPU_SYMBOL(__cpu_data);
-- 
1.8.3.1


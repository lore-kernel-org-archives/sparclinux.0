From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:26:02 +0000
Subject: [PATCH 24/34] sparc64: fix sparse warning in tsb.c
Message-Id: <1400275572-17424-24-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-24-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-24-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
tsb.c:290:5: warning: symbol 'sysctl_tsb_ratio' was not declared. Should it be static?

Add extern declaration in asm/setup.h and remove local declaration
in kernel/sysctl.c

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/setup.h | 1 +
 arch/sparc/mm/tsb.c            | 1 +
 kernel/sysctl.c                | 4 ----
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index b5f5686..0c4f695 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -52,6 +52,7 @@ unsigned long safe_compute_effective_address(struct pt_regs *, unsigned int);
 int handle_ldf_stq(u32 insn, struct pt_regs *regs);
 void handle_ld_nf(u32 insn, struct pt_regs *regs);
 
+extern int sysctl_tsb_ratio;
 #endif
 
 void sun_do_break(void);
diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index f5d506f..33ca936 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -9,6 +9,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/mmu_context.h>
+#include <asm/setup.h>
 #include <asm/tsb.h>
 #include <asm/tlb.h>
 #include <asm/oplib.h>
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 74f5b58..3c202d0 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -152,10 +152,6 @@ static unsigned long hung_task_timeout_max = (LONG_MAX/HZ);
 #ifdef CONFIG_SPARC
 #endif
 
-#ifdef CONFIG_SPARC64
-extern int sysctl_tsb_ratio;
-#endif
-
 #ifdef __hppa__
 extern int pwrsw_enabled;
 #endif
-- 
1.9.0


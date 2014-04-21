From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:28 +0000
Subject: [PATCH 13/29] sparc32: fix sparse warnings in setup_32.c
Message-Id: <1398109184-3283-13-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
setup_32.c:106:15: warning: symbol 'cmdline_memory_size' was not declared. Should it be static?
setup_32.c:270:16: warning: symbol 'fake_swapper_regs' was not declared. Should it be static?
setup_32.c:368:55: warning: Using plain integer as NULL pointer

Add missing declaration of cmdline_memory_size and remove the local one in init_32.c
fake_swapper_regs was only used locally - so defined static.
When replacing 0 with NULL also add a few spaces around operators

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/setup.h | 3 +++
 arch/sparc/kernel/setup_32.c   | 4 ++--
 arch/sparc/mm/init_32.c        | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/setup.h b/arch/sparc/include/asm/setup.h
index 4b7465a..c7cd435 100644
--- a/arch/sparc/include/asm/setup.h
+++ b/arch/sparc/include/asm/setup.h
@@ -36,6 +36,9 @@ extern unsigned long pdma_areasize;
 
 int sparc_floppy_request_irq(unsigned int irq, irq_handler_t irq_handler);
 
+/* setup_32.c */
+extern unsigned long cmdline_memory_size;
+
 #endif
 
 extern void sun_do_break(void);
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 1434526..baef495 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -267,7 +267,7 @@ static __init void leon_patch(void)
 }
 
 struct tt_entry *sparc_ttable;
-struct pt_regs fake_swapper_regs;
+static struct pt_regs fake_swapper_regs;
 
 /* Called from head_32.S - before we have setup anything
  * in the kernel. Be very careful with what you do here.
@@ -365,7 +365,7 @@ void __init setup_arch(char **cmdline_p)
 
 	prom_setsync(prom_sync_me);
 
-	if((boot_flags&BOOTME_DEBUG) && (linux_dbvec!=0) && 
+	if((boot_flags & BOOTME_DEBUG) && (linux_dbvec != NULL) &&
 	   ((*(short *)linux_dbvec) != -1)) {
 		printk("Booted under KADB. Syncing trap table.\n");
 		(*(linux_dbvec->teach_debugger))();
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index cf09e6e..d0c7327 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -31,6 +31,7 @@
 #include <asm/pgtable.h>
 #include <asm/vaddrs.h>
 #include <asm/pgalloc.h>	/* bug in asm-generic/tlb.h: check_pgt_cache */
+#include <asm/setup.h>
 #include <asm/tlb.h>
 #include <asm/prom.h>
 #include <asm/leon.h>
@@ -65,7 +66,6 @@ void show_mem(unsigned int filter)
 }
 
 
-extern unsigned long cmdline_memory_size;
 unsigned long last_valid_pfn;
 
 unsigned long calc_highpages(void)
-- 
1.8.3.1


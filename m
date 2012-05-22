From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 22 May 2012 20:10:43 +0000
Subject: [PATCH 5/5] sparc32: handle leon in irq_32.c
Message-Id: <1337717443-11904-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/kernel/irq_32.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index ae04914..c145f6f 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -241,9 +241,6 @@ int sparc_floppy_request_irq(unsigned int irq, irq_handler_t irq_handler)
 	unsigned int cpu_irq;
 	int err;
 
-#if defined CONFIG_SMP && !defined CONFIG_SPARC_LEON
-	struct tt_entry *trap_table;
-#endif
 
 	err = request_irq(irq, irq_handler, 0, "floppy", NULL);
 	if (err)
@@ -264,13 +261,18 @@ int sparc_floppy_request_irq(unsigned int irq, irq_handler_t irq_handler)
 	table[SP_TRAP_IRQ1+(cpu_irq-1)].inst_four = SPARC_NOP;
 
 	INSTANTIATE(sparc_ttable)
-#if defined CONFIG_SMP && !defined CONFIG_SPARC_LEON
-	trap_table = &trapbase_cpu1;
-	INSTANTIATE(trap_table)
-	trap_table = &trapbase_cpu2;
-	INSTANTIATE(trap_table)
-	trap_table = &trapbase_cpu3;
-	INSTANTIATE(trap_table)
+
+#if defined CONFIG_SMP
+	if (sparc_cpu_model != sparc_leon) {
+		struct tt_entry *trap_table;
+
+		trap_table = &trapbase_cpu1;
+		INSTANTIATE(trap_table)
+		trap_table = &trapbase_cpu2;
+		INSTANTIATE(trap_table)
+		trap_table = &trapbase_cpu3;
+		INSTANTIATE(trap_table)
+	}
 #endif
 #undef INSTANTIATE
 	/*
-- 
1.6.0.6


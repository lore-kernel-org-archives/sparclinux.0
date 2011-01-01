From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 01 Jan 2011 22:53:10 +0000
Subject: [PATCH 3/4] sparc: remove unused prom cpu functions
Message-Id: <1293922391-17661-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Remove the following unused funtions:
prom_stopcpu()
prom_idlecpu()
prom_restartcpu()

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/oplib_32.h |    9 ----
 arch/sparc/prom/mp.c              |   78 -------------------------------------
 2 files changed, 0 insertions(+), 87 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index 91411bc..6405588 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -105,15 +105,6 @@ extern void prom_write(const char *buf, unsigned int len);
 extern int prom_startcpu(int cpunode, struct linux_prom_registers *context_table,
 			 int context, char *program_counter);
 
-/* Stop the CPU with the passed device tree node. */
-extern int prom_stopcpu(int cpunode);
-
-/* Idle the CPU with the passed device tree node. */
-extern int prom_idlecpu(int cpunode);
-
-/* Re-Start the CPU with the passed device tree node. */
-extern int prom_restartcpu(int cpunode);
-
 /* Sun4/sun4c specific memory-management startup hook. */
 
 /* Map the passed segment in the given context at the passed
diff --git a/arch/sparc/prom/mp.c b/arch/sparc/prom/mp.c
index 4c4dc79..97c44c9 100644
--- a/arch/sparc/prom/mp.c
+++ b/arch/sparc/prom/mp.c
@@ -41,81 +41,3 @@ prom_startcpu(int cpunode, struct linux_prom_registers *ctable_reg, int ctx, cha
 
 	return ret;
 }
-
-/* Stop CPU with device prom-tree node 'cpunode'.
- * XXX Again, what does the return value really mean? XXX
- */
-int
-prom_stopcpu(int cpunode)
-{
-	int ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(&prom_lock, flags);
-	switch(prom_vers) {
-	case PROM_V0:
-	case PROM_V2:
-	default:
-		ret = -1;
-		break;
-	case PROM_V3:
-		ret = (*(romvec->v3_cpustop))(cpunode);
-		break;
-	};
-	restore_current();
-	spin_unlock_irqrestore(&prom_lock, flags);
-
-	return ret;
-}
-
-/* Make CPU with device prom-tree node 'cpunode' idle.
- * XXX Return value, anyone? XXX
- */
-int
-prom_idlecpu(int cpunode)
-{
-	int ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(&prom_lock, flags);
-	switch(prom_vers) {
-	case PROM_V0:
-	case PROM_V2:
-	default:
-		ret = -1;
-		break;
-	case PROM_V3:
-		ret = (*(romvec->v3_cpuidle))(cpunode);
-		break;
-	};
-	restore_current();
-	spin_unlock_irqrestore(&prom_lock, flags);
-
-	return ret;
-}
-
-/* Resume the execution of CPU with nodeid 'cpunode'.
- * XXX Come on, somebody has to know... XXX
- */
-int
-prom_restartcpu(int cpunode)
-{
-	int ret;
-	unsigned long flags;
-
-	spin_lock_irqsave(&prom_lock, flags);
-	switch(prom_vers) {
-	case PROM_V0:
-	case PROM_V2:
-	default:
-		ret = -1;
-		break;
-	case PROM_V3:
-		ret = (*(romvec->v3_cpuresume))(cpunode);
-		break;
-	};
-	restore_current();
-	spin_unlock_irqrestore(&prom_lock, flags);
-
-	return ret;
-}
-- 
1.6.0.6


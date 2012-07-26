From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 26 Jul 2012 21:02:26 +0000
Subject: [PATCH 16/18] sparc32: move probe_memory() to srmmu.c
Message-Id: <1343336548-3879-16-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Only one user so move it to the file using it.
It had nothing to do in fault_32.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/fault_32.c |   12 ------------
 arch/sparc/mm/srmmu.c    |   12 +++++++++++-
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index e58f9ee..77ac917 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -32,18 +32,6 @@
 
 int show_unhandled_signals = 1;
 
-/* Return how much physical memory we have.  */
-unsigned long probe_memory(void)
-{
-	unsigned long total = 0;
-	int i;
-
-	for (i = 0; sp_banks[i].num_bytes; i++)
-		total += sp_banks[i].num_bytes;
-
-	return total;
-}
-
 static void unhandled_fault(unsigned long, struct task_struct *,
 		struct pt_regs *) __attribute__ ((noreturn));
 
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index ad93d2e..c38bb72 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -228,7 +228,17 @@ void srmmu_free_nocache(void *addr, int size)
 static void srmmu_early_allocate_ptable_skeleton(unsigned long start,
 						 unsigned long end);
 
-extern unsigned long probe_memory(void);	/* in fault.c */
+/* Return how much physical memory we have.  */
+static unsigned long __init probe_memory(void)
+{
+	unsigned long total = 0;
+	int i;
+
+	for (i = 0; sp_banks[i].num_bytes; i++)
+		total += sp_banks[i].num_bytes;
+
+	return total;
+}
 
 /*
  * Reserve nocache dynamically proportionally to the amount of
-- 
1.6.0.6


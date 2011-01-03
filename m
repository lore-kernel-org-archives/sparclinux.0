From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 03 Jan 2011 18:27:55 +0000
Subject: [PATCH] sparc: fix sparse warnings in arch/sparc/prom for 32 bit
Message-Id: <20110103182755.GA9524@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following sparse warnings:
arch/sparc/prom/bootstr_32.c:32:35: warning: Using plain integer as NULL pointer
arch/sparc/prom/memory.c:61:13: warning: symbol 'prom_meminit' was not declared. Should it be static?
arch/sparc/prom/misc_32.c:74:1: error: symbol 'prom_halt' redeclared with different type (originally declared at arch/sparc/include/asm/oplib_32.h:67) - different modifiers
arch/sparc/prom/ranges.c:16:26: warning: symbol 'promlib_obio_ranges' was not declared. Should it be static?
arch/sparc/prom/ranges.c:17:5: warning: symbol 'num_obio_ranges' was not declared. Should it be static?
arch/sparc/prom/ranges.c:39:1: warning: symbol 'prom_adjust_ranges' was not declared. Should it be static?
arch/sparc/prom/ranges.c:69:13: warning: symbol 'prom_ranges_init' was not declared. Should it be static?
arch/sparc/prom/tree_32.c:286:22: warning: Using plain integer as NULL pointer
arch/sparc/prom/tree_32.c:286:38: warning: Using plain integer as NULL pointer

None of the warnings indicated any serious issues.

We are now sparse clean for 32 bit build in arch/sparc/prom.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/oplib_32.h |    6 +++++-
 arch/sparc/prom/bootstr_32.c      |    3 ++-
 arch/sparc/prom/misc_32.c         |    2 +-
 arch/sparc/prom/ranges.c          |    6 +++---
 arch/sparc/prom/tree_32.c         |    6 ++++--
 5 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index 98f7082..71e5e9a 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -64,7 +64,7 @@ extern void prom_cmdline(void);
 /* Enter the prom, with no chance of continuation for the stand-alone
  * which calls this.
  */
-extern void prom_halt(void) __attribute__ ((noreturn));
+extern void __noreturn prom_halt(void);
 
 /* Set the PROM 'sync' callback function to the passed function pointer.
  * When the user gives the 'sync' command at the prom prompt while the
@@ -113,6 +113,8 @@ extern int prom_startcpu(int cpunode, struct linux_prom_registers *context_table
 extern void prom_putsegment(int context, unsigned long virt_addr,
 			    int physical_segment);
 
+/* Initialize the memory lists based upon the prom version. */
+void prom_meminit(void);
 
 /* PROM device tree traversal functions... */
 
@@ -177,6 +179,8 @@ extern void prom_apply_obio_ranges(struct linux_prom_registers *obioregs, int nr
 extern void prom_apply_generic_ranges(phandle node, phandle parent,
 				      struct linux_prom_registers *sbusregs, int nregs);
 
+void prom_ranges_init(void);
+
 /* CPU probing helpers.  */
 int cpu_find_by_instance(int instance, phandle *prom_node, int *mid);
 int cpu_find_by_mid(int mid, phandle *prom_node);
diff --git a/arch/sparc/prom/bootstr_32.c b/arch/sparc/prom/bootstr_32.c
index 916831d..f5ec32e 100644
--- a/arch/sparc/prom/bootstr_32.c
+++ b/arch/sparc/prom/bootstr_32.c
@@ -29,7 +29,8 @@ prom_getbootargs(void)
 		/* Start from 1 and go over fd(0,0,0)kernel */
 		for(iter = 1; iter < 8; iter++) {
 			arg = (*(romvec->pv_v0bootargs))->argv[iter];
-			if(arg = 0) break;
+			if (arg = NULL)
+				break;
 			while(*arg != 0) {
 				/* Leave place for space and null. */
 				if(cp >= barg_buf + BARG_LEN-2){
diff --git a/arch/sparc/prom/misc_32.c b/arch/sparc/prom/misc_32.c
index 4d61c54..8c278c3 100644
--- a/arch/sparc/prom/misc_32.c
+++ b/arch/sparc/prom/misc_32.c
@@ -70,7 +70,7 @@ prom_cmdline(void)
 /* Drop into the prom, but completely terminate the program.
  * No chance of continuing.
  */
-void
+void __noreturn
 prom_halt(void)
 {
 	unsigned long flags;
diff --git a/arch/sparc/prom/ranges.c b/arch/sparc/prom/ranges.c
index 541fc82..0857aa9 100644
--- a/arch/sparc/prom/ranges.c
+++ b/arch/sparc/prom/ranges.c
@@ -13,8 +13,8 @@
 #include <asm/types.h>
 #include <asm/system.h>
 
-struct linux_prom_ranges promlib_obio_ranges[PROMREG_MAX];
-int num_obio_ranges;
+static struct linux_prom_ranges promlib_obio_ranges[PROMREG_MAX];
+static int num_obio_ranges;
 
 /* Adjust register values based upon the ranges parameters. */
 static void
@@ -35,7 +35,7 @@ prom_adjust_regs(struct linux_prom_registers *regp, int nregs,
 	}
 }
 
-void
+static void
 prom_adjust_ranges(struct linux_prom_ranges *ranges1, int nranges1,
 		   struct linux_prom_ranges *ranges2, int nranges2)
 {
diff --git a/arch/sparc/prom/tree_32.c b/arch/sparc/prom/tree_32.c
index f8860eb..bc8e4cb 100644
--- a/arch/sparc/prom/tree_32.c
+++ b/arch/sparc/prom/tree_32.c
@@ -282,8 +282,10 @@ int prom_setprop(phandle node, const char *pname, char *value, int size)
 	unsigned long flags;
 	int ret;
 
-	if(size = 0) return 0;
-	if((pname = 0) || (value = 0)) return 0;
+	if (size = 0)
+		return 0;
+	if ((pname = NULL) || (value = NULL))
+		return 0;
 	spin_lock_irqsave(&prom_lock, flags);
 	ret = prom_nodeops->no_setprop(node, pname, value, size);
 	restore_current();
-- 
1.6.0.6


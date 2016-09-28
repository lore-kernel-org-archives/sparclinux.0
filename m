From: netmonk@netmonk.org
Date: Wed, 28 Sep 2016 21:46:25 +0000
Subject: [PATCH] Sparc/prom/ranges.c cosmetic improvement
Message-Id: <20160928214625.GA24725@netmonk.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Following Linux Coding Style documentation, removed, added some spaces 
to improve compliance to the formating standard.

Signed-of-by: Netmonk <netmonk@netmonk.org>



--5mCyUwZo2JvN/JJP
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
 filename="0001-Cosmetic-improvement-in-arch-sparc-prom-ranges.c.patch"

From 276b83b74716cbd39c6c72428c6e385881b089e7 Mon Sep 17 00:00:00 2001
From: netmonk <netmonk@netmonk.org>
Date: Wed, 28 Sep 2016 23:26:33 +0200
Subject: [PATCH]  Cosmetic improvement in arch/sparc/prom/ranges.c

---
 arch/sparc/prom/ranges.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/prom/ranges.c b/arch/sparc/prom/ranges.c
index ad143c1..a493de3 100644
--- a/arch/sparc/prom/ranges.c
+++ b/arch/sparc/prom/ranges.c
@@ -16,8 +16,7 @@ static struct linux_prom_ranges promlib_obio_ranges[PROMREG_MAX];
 static int num_obio_ranges;
 
 /* Adjust register values based upon the ranges parameters. */
-static void
-prom_adjust_regs(struct linux_prom_registers *regp, int nregs,
+static void prom_adjust_regs(struct linux_prom_registers *regp, int nregs,
 		 struct linux_prom_ranges *rangep, int nranges)
 {
 	int regc, rngc;
@@ -34,19 +33,18 @@ prom_adjust_regs(struct linux_prom_registers *regp, int nregs,
 	}
 }
 
-static void
-prom_adjust_ranges(struct linux_prom_ranges *ranges1, int nranges1,
+static void prom_adjust_ranges(struct linux_prom_ranges *ranges1, int nranges1,
 		   struct linux_prom_ranges *ranges2, int nranges2)
 {
 	int rng1c, rng2c;
 
-	for(rng1c=0; rng1c < nranges1; rng1c++) {
-		for(rng2c=0; rng2c < nranges2; rng2c++)
-			if(ranges1[rng1c].ot_parent_space == ranges2[rng2c].ot_child_space &&
+	for (rng1c = 0; rng1c < nranges1; rng1c++) {
+		for (rng2c = 0; rng2c < nranges2; rng2c++)
+			if (ranges1[rng1c].ot_parent_space == ranges2[rng2c].ot_child_space &&
 			   ranges1[rng1c].ot_parent_base >= ranges2[rng2c].ot_child_base &&
 			   ranges2[rng2c].ot_child_base + ranges2[rng2c].or_size - ranges1[rng1c].ot_parent_base > 0U)
 			break;
-		if(rng2c == nranges2) /* oops */
+		if (rng2c == nranges2) /* oops */
 			prom_printf("adjust_ranges: Could not find matching bus type...\n");
 		else if (ranges1[rng1c].ot_parent_base + ranges1[rng1c].or_size > ranges2[rng2c].ot_child_base + ranges2[rng2c].or_size)
 			ranges1[rng1c].or_size =
@@ -57,10 +55,9 @@ prom_adjust_ranges(struct linux_prom_ranges *ranges1, int nranges1,
 }
 
 /* Apply probed obio ranges to registers passed, if no ranges return. */
-void
-prom_apply_obio_ranges(struct linux_prom_registers *regs, int nregs)
+void prom_apply_obio_ranges(struct linux_prom_registers *regs, int nregs)
 {
-	if(num_obio_ranges)
+	if (num_obio_ranges)
 		prom_adjust_regs(regs, nregs, promlib_obio_ranges, num_obio_ranges);
 }
 EXPORT_SYMBOL(prom_apply_obio_ranges);
@@ -76,15 +73,15 @@ void __init prom_ranges_init(void)
 	node = prom_getchild(prom_root_node);
 	obio_node = prom_searchsiblings(node, "obio");
 
-	if(obio_node) {
+	if (obio_node) {
 		success = prom_getproperty(obio_node, "ranges",
 					   (char *) promlib_obio_ranges,
 					   sizeof(promlib_obio_ranges));
-		if(success != -1)
+		if (success != -1)
 			num_obio_ranges = (success/sizeof(struct linux_prom_ranges));
 	}
 
-	if(num_obio_ranges)
+	if (num_obio_ranges)
 		prom_printf("PROMLIB: obio_ranges %d\n", num_obio_ranges);
 }
 
@@ -94,7 +91,6 @@ void prom_apply_generic_ranges(phandle node, phandle parent,
 	int success;
 	int num_ranges;
 	struct linux_prom_ranges ranges[PROMREG_MAX];
-	
 	success = prom_getproperty(node, "ranges",
 				   (char *) ranges,
 				   sizeof (ranges));
@@ -103,10 +99,9 @@ void prom_apply_generic_ranges(phandle node, phandle parent,
 		if (parent) {
 			struct linux_prom_ranges parent_ranges[PROMREG_MAX];
 			int num_parent_ranges;
-		
 			success = prom_getproperty(parent, "ranges",
-				   		   (char *) parent_ranges,
-				   		   sizeof (parent_ranges));
+						(char *) parent_ranges,
+						sizeof (parent_ranges));
 			if (success != -1) {
 				num_parent_ranges = (success/sizeof(struct linux_prom_ranges));
 				prom_adjust_ranges (ranges, num_ranges, parent_ranges, num_parent_ranges);
-- 
2.10.0


--5mCyUwZo2JvN/JJP--

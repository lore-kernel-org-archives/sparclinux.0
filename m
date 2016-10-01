From: netmonk@netmonk.org
Date: Sat, 01 Oct 2016 21:42:41 +0000
Subject: [PATCH v4] sparc: fixing ident and beautifying code
Message-Id: <20161001214241.lz6owcs7g62hkdv3@netmonk.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Good evening,

Following LinuxCodingStyle documentation and with the help of Sam, fixed
severals identation issues in the code, and few others cosmetic changes

And last and i hope least fixing my name :)

Signed-off-by : Dominique Carrel <netmonk@netmonk.org>
---
 arch/sparc/prom/ranges.c | 52 ++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/arch/sparc/prom/ranges.c b/arch/sparc/prom/ranges.c
index ad143c1..6d8dc2a 100644
--- a/arch/sparc/prom/ranges.c
+++ b/arch/sparc/prom/ranges.c
@@ -16,9 +16,8 @@ static struct linux_prom_ranges promlib_obio_ranges[PROMREG_MAX];
 static int num_obio_ranges;
 
 /* Adjust register values based upon the ranges parameters. */
-static void
-prom_adjust_regs(struct linux_prom_registers *regp, int nregs,
-		 struct linux_prom_ranges *rangep, int nranges)
+static void prom_adjust_regs(struct linux_prom_registers *regp, int nregs,
+			     struct linux_prom_ranges *rangep, int nranges)
 {
 	int regc, rngc;
 
@@ -34,33 +33,30 @@ prom_adjust_regs(struct linux_prom_registers *regp, int nregs,
 	}
 }
 
-static void
-prom_adjust_ranges(struct linux_prom_ranges *ranges1, int nranges1,
-		   struct linux_prom_ranges *ranges2, int nranges2)
+static void prom_adjust_ranges(struct linux_prom_ranges *ranges1, int nranges1,
+			       struct linux_prom_ranges *ranges2, int nranges2)
 {
 	int rng1c, rng2c;
 
-	for(rng1c=0; rng1c < nranges1; rng1c++) {
-		for(rng2c=0; rng2c < nranges2; rng2c++)
-			if(ranges1[rng1c].ot_parent_space = ranges2[rng2c].ot_child_space &&
+	for (rng1c = 0; rng1c < nranges1; rng1c++) {
+		for (rng2c = 0; rng2c < nranges2; rng2c++)
+			if (ranges1[rng1c].ot_parent_space = ranges2[rng2c].ot_child_space &&
 			   ranges1[rng1c].ot_parent_base >= ranges2[rng2c].ot_child_base &&
 			   ranges2[rng2c].ot_child_base + ranges2[rng2c].or_size - ranges1[rng1c].ot_parent_base > 0U)
 			break;
-		if(rng2c = nranges2) /* oops */
+		if (rng2c = nranges2) /* oops */
 			prom_printf("adjust_ranges: Could not find matching bus type...\n");
 		else if (ranges1[rng1c].ot_parent_base + ranges1[rng1c].or_size > ranges2[rng2c].ot_child_base + ranges2[rng2c].or_size)
-			ranges1[rng1c].or_size -				ranges2[rng2c].ot_child_base + ranges2[rng2c].or_size - ranges1[rng1c].ot_parent_base;
+			ranges1[rng1c].or_size = ranges2[rng2c].ot_child_base + ranges2[rng2c].or_size - ranges1[rng1c].ot_parent_base;
 		ranges1[rng1c].ot_parent_space = ranges2[rng2c].ot_parent_space;
 		ranges1[rng1c].ot_parent_base += ranges2[rng2c].ot_parent_base;
 	}
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
@@ -76,40 +72,40 @@ void __init prom_ranges_init(void)
 	node = prom_getchild(prom_root_node);
 	obio_node = prom_searchsiblings(node, "obio");
 
-	if(obio_node) {
+	if (obio_node) {
 		success = prom_getproperty(obio_node, "ranges",
 					   (char *) promlib_obio_ranges,
 					   sizeof(promlib_obio_ranges));
-		if(success != -1)
-			num_obio_ranges = (success/sizeof(struct linux_prom_ranges));
+		if (success != -1)
+			num_obio_ranges = (success / sizeof(struct linux_prom_ranges));
 	}
 
-	if(num_obio_ranges)
+	if (num_obio_ranges)
 		prom_printf("PROMLIB: obio_ranges %d\n", num_obio_ranges);
 }
 
 void prom_apply_generic_ranges(phandle node, phandle parent,
-		struct linux_prom_registers *regs, int nregs)
+			       struct linux_prom_registers *regs, int nregs)
 {
 	int success;
 	int num_ranges;
 	struct linux_prom_ranges ranges[PROMREG_MAX];
-	
+
 	success = prom_getproperty(node, "ranges",
 				   (char *) ranges,
-				   sizeof (ranges));
+				   sizeof(ranges));
 	if (success != -1) {
-		num_ranges = (success/sizeof(struct linux_prom_ranges));
+		num_ranges = (success / sizeof(struct linux_prom_ranges));
 		if (parent) {
 			struct linux_prom_ranges parent_ranges[PROMREG_MAX];
 			int num_parent_ranges;
-		
+
 			success = prom_getproperty(parent, "ranges",
-				   		   (char *) parent_ranges,
-				   		   sizeof (parent_ranges));
+						   (char *) parent_ranges,
+						   sizeof(parent_ranges));
 			if (success != -1) {
-				num_parent_ranges = (success/sizeof(struct linux_prom_ranges));
-				prom_adjust_ranges (ranges, num_ranges, parent_ranges, num_parent_ranges);
+				num_parent_ranges = (success / sizeof(struct linux_prom_ranges));
+				prom_adjust_ranges(ranges, num_ranges, parent_ranges, num_parent_ranges);
 			}
 		}
 		prom_adjust_regs(regs, nregs, ranges, num_ranges);
-- 
2.10.0


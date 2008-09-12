From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:48:11 +0000
Subject: [PATCH 7/16]: sparc64: Fix sparse warnings in visemul.c
Message-Id: <20080912.144811.32005982.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Fix sparse warnings in visemul.c

1) edge8 tables should be static
2) add vis_emul() extern decl. to asm/visasm.h

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/visasm.h |    1 +
 arch/sparc64/kernel/traps.c     |    1 -
 arch/sparc64/kernel/visemul.c   |   12 ++++++------
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/asm/visasm.h b/arch/sparc/include/asm/visasm.h
index de797b9..39ca301 100644
--- a/arch/sparc/include/asm/visasm.h
+++ b/arch/sparc/include/asm/visasm.h
@@ -57,6 +57,7 @@ static inline void save_and_clear_fpu(void) {
 "		" : : "i" (FPRS_FEF|FPRS_DU) :
 		"o5", "g1", "g2", "g3", "g7", "cc");
 }
+extern int vis_emul(struct pt_regs *, unsigned int);
 #endif
 
 #endif /* _SPARC64_ASI_H */
diff --git a/arch/sparc64/kernel/traps.c b/arch/sparc64/kernel/traps.c
index 71644da..9378896 100644
--- a/arch/sparc64/kernel/traps.c
+++ b/arch/sparc64/kernel/traps.c
@@ -2270,7 +2270,6 @@ void die_if_kernel(char *str, struct pt_regs *regs)
 
 extern int handle_popc(u32 insn, struct pt_regs *regs);
 extern int handle_ldf_stq(u32 insn, struct pt_regs *regs);
-extern int vis_emul(struct pt_regs *, unsigned int);
 
 void do_illegal_instruction(struct pt_regs *regs)
 {
diff --git a/arch/sparc64/kernel/visemul.c b/arch/sparc64/kernel/visemul.c
index c3fd647..9e05cb5 100644
--- a/arch/sparc64/kernel/visemul.c
+++ b/arch/sparc64/kernel/visemul.c
@@ -243,7 +243,7 @@ static inline unsigned int *fps_regaddr(struct fpustate *f,
 struct edge_tab {
 	u16 left, right;
 };
-struct edge_tab edge8_tab[8] = {
+static struct edge_tab edge8_tab[8] = {
 	{ 0xff, 0x80 },
 	{ 0x7f, 0xc0 },
 	{ 0x3f, 0xe0 },
@@ -253,7 +253,7 @@ struct edge_tab edge8_tab[8] = {
 	{ 0x03, 0xfe },
 	{ 0x01, 0xff },
 };
-struct edge_tab edge8_tab_l[8] = {
+static struct edge_tab edge8_tab_l[8] = {
 	{ 0xff, 0x01 },
 	{ 0xfe, 0x03 },
 	{ 0xfc, 0x07 },
@@ -263,23 +263,23 @@ struct edge_tab edge8_tab_l[8] = {
 	{ 0xc0, 0x7f },
 	{ 0x80, 0xff },
 };
-struct edge_tab edge16_tab[4] = {
+static struct edge_tab edge16_tab[4] = {
 	{ 0xf, 0x8 },
 	{ 0x7, 0xc },
 	{ 0x3, 0xe },
 	{ 0x1, 0xf },
 };
-struct edge_tab edge16_tab_l[4] = {
+static struct edge_tab edge16_tab_l[4] = {
 	{ 0xf, 0x1 },
 	{ 0xe, 0x3 },
 	{ 0xc, 0x7 },
 	{ 0x8, 0xf },
 };
-struct edge_tab edge32_tab[2] = {
+static struct edge_tab edge32_tab[2] = {
 	{ 0x3, 0x2 },
 	{ 0x1, 0x3 },
 };
-struct edge_tab edge32_tab_l[2] = {
+static struct edge_tab edge32_tab_l[2] = {
 	{ 0x3, 0x1 },
 	{ 0x2, 0x3 },
 };
-- 
1.5.6.5.GIT


From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 06 Jan 2009 20:52:09 +0000
Subject: [PATCH] sparc: refactor code in fault_32.c
Message-Id: <20090106205209.GA24034@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The sparc allmodconfig build broke due to enabling of the
branch_tracer that does some very clever things with
all if conditions. This caused my gcc 3.4.5 to be so confused that
it emitted a warning:

arch/sparc/mm/fault_32.c: In function `do_sparc_fault':
arch/sparc/mm/fault_32.c:176: warning: 'fixup' might be used uninitialized in this function

And with -Werror this broke the build.

Refactor code so it:
1) becomes more readable
2) no longer emit a warning with the branch_tracer enabled

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index a507e11..12e447f 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -283,7 +283,8 @@ bad_area_nosemaphore:
 	/* Is this in ex_table? */
 no_context:
 	g2 = regs->u_regs[UREG_G2];
-	if (!from_user && (fixup = search_extables_range(regs->pc, &g2))) {
+	if (!from_user) {
+		fixup = search_extables_range(regs->pc, &g2);
 		if (fixup > 10) { /* Values below are reserved for other things */
 			extern const unsigned __memset_start[];
 			extern const unsigned __memset_end[];

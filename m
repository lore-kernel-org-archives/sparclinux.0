From: Douglas Anderson <dianders@chromium.org>
Date: Tue, 04 Feb 2020 22:12:25 +0000
Subject: [PATCH] kdb: Fix compiling on architectures w/out DBG_MAX_REG_NUM defined
Message-Id: <20200204141219.1.Ief3f3a7edbbd76165901b14813e90381c290786d@changeid>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>, Anatoly Pugachev <matorola@gmail.com>
Cc: sparclinux@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, Jason Wessel <jason.wessel@windriver.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Chuhong Yuan <hslester96@gmail.com>, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

In commit bbfceba15f8d ("kdb: Get rid of confusing diag msg from "rd"
if current task has no regs") I tried to clean things up by using "if"
instead of "#ifdef".  Turns out we really need "#ifdef" since not all
architectures define some of the structures that the code is referring
to.

Let's switch to #ifdef again, but at least avoid using it inside of
the function.

Fixes: bbfceba15f8d ("kdb: Get rid of confusing diag msg from "rd" if current task has no regs")
Reported-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't have a sparc64 compiler but I'm pretty sure this should work.
Testing appreciated.

 kernel/debug/kdb/kdb_main.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index b22292b649c4..c84e61747267 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1833,6 +1833,16 @@ static int kdb_go(int argc, const char **argv)
 /*
  * kdb_rd - This function implements the 'rd' command.
  */
+
+/* Fallback to Linux showregs() if we don't have DBG_MAX_REG_NUM */
+#if DBG_MAX_REG_NUM <= 0
+static int kdb_rd(int argc, const char **argv)
+{
+	if (!kdb_check_regs())
+		kdb_dumpregs(kdb_current_regs);
+	return 0;
+}
+#else
 static int kdb_rd(int argc, const char **argv)
 {
 	int len = 0;
@@ -1847,12 +1857,6 @@ static int kdb_rd(int argc, const char **argv)
 	if (kdb_check_regs())
 		return 0;
 
-	/* Fallback to Linux showregs() if we don't have DBG_MAX_REG_NUM */
-	if (DBG_MAX_REG_NUM <= 0) {
-		kdb_dumpregs(kdb_current_regs);
-		return 0;
-	}
-
 	for (i = 0; i < DBG_MAX_REG_NUM; i++) {
 		rsize = dbg_reg_def[i].size * 2;
 		if (rsize > 16)
@@ -1896,6 +1900,7 @@ static int kdb_rd(int argc, const char **argv)
 
 	return 0;
 }
+#endif
 
 /*
  * kdb_rm - This function implements the 'rm' (register modify)  command.
-- 
2.25.0.341.g760bfbb309-goog

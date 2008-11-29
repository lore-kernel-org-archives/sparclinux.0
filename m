From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 Nov 2008 22:05:47 +0000
Subject: [PATCH 03/10] sparc,sparc64: unify asm-offsets.c
Message-Id: <1227996354-11478-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc64 does not use constants generated from asm-offsets
but to prepare it to do so the parts that could be
shared do now generate constants for sparc64 too.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/asm-offsets.c   |   19 ++++++++++++++++---
 arch/sparc64/kernel/asm-offsets.c |    2 +-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/asm-offsets.c b/arch/sparc/kernel/asm-offsets.c
index b5bb99e..68f7e11 100644
--- a/arch/sparc/kernel/asm-offsets.c
+++ b/arch/sparc/kernel/asm-offsets.c
@@ -14,15 +14,28 @@
 // #include <linux/mm.h>
 #include <linux/kbuild.h>
 
-int foo(void)
+#ifdef CONFIG_SPARC32
+int sparc32_foo(void)
 {
-	DEFINE(AOFF_task_thread, offsetof(struct task_struct, thread));
-	BLANK();
 	DEFINE(AOFF_thread_fork_kpsr,
 			offsetof(struct thread_struct, fork_kpsr));
+	return 0;
+}
+#else
+int sparc64_foo(void)
+{
+	return 0;
+}
+#endif
+
+int foo(void)
+{
+	BLANK();
+	DEFINE(AOFF_task_thread, offsetof(struct task_struct, thread));
 	BLANK();
 	DEFINE(AOFF_mm_context, offsetof(struct mm_struct, context));
 
 	/* DEFINE(NUM_USER_SEGMENTS, TASK_SIZE>>28); */
 	return 0;
 }
+
diff --git a/arch/sparc64/kernel/asm-offsets.c b/arch/sparc64/kernel/asm-offsets.c
index 9e26311..8cbd958 100644
--- a/arch/sparc64/kernel/asm-offsets.c
+++ b/arch/sparc64/kernel/asm-offsets.c
@@ -1 +1 @@
-/* Dummy asm-offsets.c file. Required by kbuild and ready to be used - hint! */
+#include "../../sparc/kernel/asm-offsets.c"
-- 
1.5.6.GIT


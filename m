From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 04 Dec 2008 21:25:43 +0000
Subject: [PATCH] sparc: unify kernel/init_task
Message-Id: <20081204212543.GB28342@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

A closer inspection revealed that these two files had identical
functionality - but the implementation of it differed slightly.

Base it on the sparc version as it was the best.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

On purpose I did not use "-M -B" so you could see
the content of the deleted file.
I expect git to see that we deleted one file and moved another.

	Sam

 arch/sparc/Makefile              |    2 +-
 arch/sparc/kernel/Makefile       |    2 +-
 arch/sparc/kernel/init_task.c    |   28 ++++++++++++++++++++++++++++
 arch/sparc/kernel/init_task_32.c |   28 ----------------------------
 arch/sparc/kernel/init_task_64.c |   35 -----------------------------------
 5 files changed, 30 insertions(+), 65 deletions(-)
 create mode 100644 arch/sparc/kernel/init_task.c
 delete mode 100644 arch/sparc/kernel/init_task_32.c
 delete mode 100644 arch/sparc/kernel/init_task_64.c

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index efc9071..2003ded 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -68,7 +68,7 @@ endif
 endif
 
 head-y                 := arch/sparc/kernel/head_$(BITS).o
-head-y                 += arch/sparc/kernel/init_task_$(BITS).o
+head-y                 += arch/sparc/kernel/init_task.o
 
 core-y                 += arch/sparc/kernel/
 core-y                 += arch/sparc/mm/ arch/sparc/math-emu/
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 4643946..cd13d7f 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -6,7 +6,7 @@ asflags-y := -ansi
 ccflags-y := -Werror
 
 extra-y     := head_$(BITS).o
-extra-y     += init_task_$(BITS).o
+extra-y     += init_task.o
 extra-y     += vmlinux.lds
 
 obj-$(CONFIG_SPARC32)   += entry.o wof.o wuf.o
diff --git a/arch/sparc/kernel/init_task.c b/arch/sparc/kernel/init_task.c
new file mode 100644
index 0000000..8e64ebc
--- /dev/null
+++ b/arch/sparc/kernel/init_task.c
@@ -0,0 +1,28 @@
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/init_task.h>
+#include <linux/mqueue.h>
+
+#include <asm/pgtable.h>
+#include <asm/uaccess.h>
+
+static struct fs_struct init_fs = INIT_FS;
+static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
+static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
+struct mm_struct init_mm = INIT_MM(init_mm);
+struct task_struct init_task = INIT_TASK(init_task);
+
+EXPORT_SYMBOL(init_mm);
+EXPORT_SYMBOL(init_task);
+
+/* .text section in head.S is aligned at 8k boundary and this gets linked
+ * right after that so that the init_thread_union is aligned properly as well.
+ * If this is not aligned on a 8k boundry, then you should change code
+ * in etrap.S which assumes it.
+ */
+union thread_union init_thread_union
+	__attribute__((section (".text\"\n\t#")))
+	__attribute__((aligned (THREAD_SIZE)))
+	= { INIT_THREAD_INFO(init_task) };
diff --git a/arch/sparc/kernel/init_task_32.c b/arch/sparc/kernel/init_task_32.c
deleted file mode 100644
index 8e64ebc..0000000
--- a/arch/sparc/kernel/init_task_32.c
+++ /dev/null
@@ -1,28 +0,0 @@
-#include <linux/mm.h>
-#include <linux/fs.h>
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/init_task.h>
-#include <linux/mqueue.h>
-
-#include <asm/pgtable.h>
-#include <asm/uaccess.h>
-
-static struct fs_struct init_fs = INIT_FS;
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
-struct mm_struct init_mm = INIT_MM(init_mm);
-struct task_struct init_task = INIT_TASK(init_task);
-
-EXPORT_SYMBOL(init_mm);
-EXPORT_SYMBOL(init_task);
-
-/* .text section in head.S is aligned at 8k boundary and this gets linked
- * right after that so that the init_thread_union is aligned properly as well.
- * If this is not aligned on a 8k boundry, then you should change code
- * in etrap.S which assumes it.
- */
-union thread_union init_thread_union
-	__attribute__((section (".text\"\n\t#")))
-	__attribute__((aligned (THREAD_SIZE)))
-	= { INIT_THREAD_INFO(init_task) };
diff --git a/arch/sparc/kernel/init_task_64.c b/arch/sparc/kernel/init_task_64.c
deleted file mode 100644
index d2b3123..0000000
--- a/arch/sparc/kernel/init_task_64.c
+++ /dev/null
@@ -1,35 +0,0 @@
-#include <linux/mm.h>
-#include <linux/fs.h>
-#include <linux/module.h>
-#include <linux/sched.h>
-#include <linux/init_task.h>
-#include <linux/mqueue.h>
-
-#include <asm/pgtable.h>
-#include <asm/uaccess.h>
-#include <asm/processor.h>
-
-static struct fs_struct init_fs = INIT_FS;
-static struct signal_struct init_signals = INIT_SIGNALS(init_signals);
-static struct sighand_struct init_sighand = INIT_SIGHAND(init_sighand);
-struct mm_struct init_mm = INIT_MM(init_mm);
-
-EXPORT_SYMBOL(init_mm);
-
-/* .text section in head.S is aligned at 2 page boundary and this gets linked
- * right after that so that the init_thread_union is aligned properly as well.
- * We really don't need this special alignment like the Intel does, but
- * I do it anyways for completeness.
- */
-__asm__ (".text");
-union thread_union init_thread_union = { INIT_THREAD_INFO(init_task) };
-
-/*
- * Initial task structure.
- *
- * All other task structs will be allocated on slabs in fork.c
- */
-EXPORT_SYMBOL(init_task);
-
-__asm__(".data");
-struct task_struct init_task = INIT_TASK(init_task);
-- 
1.5.6.GIT


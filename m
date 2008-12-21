From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 21 Dec 2008 20:40:54 +0000
Subject: [PATCH] sparc: use .data.init_task section for init_thread_union
Message-Id: <20081221204054.GA18284@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Use a dedicated aligned section for the init_thread_union
variable and declare this section in vmlinux.lds.

This align sparc with most other architectures.
Eventually this allow the init_task bits to be unified across all architectures.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>
---

Build tested on sparc32 and sparc64 - no boot test!

	Sam

 arch/sparc/kernel/init_task.c   |    3 +--
 arch/sparc/kernel/vmlinux.lds.S |    9 +++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/init_task.c b/arch/sparc/kernel/init_task.c
index 8e64ebc..62126e4 100644
--- a/arch/sparc/kernel/init_task.c
+++ b/arch/sparc/kernel/init_task.c
@@ -23,6 +23,5 @@ EXPORT_SYMBOL(init_task);
  * in etrap.S which assumes it.
  */
 union thread_union init_thread_union
-	__attribute__((section (".text\"\n\t#")))
-	__attribute__((aligned (THREAD_SIZE)))
+	__attribute__((section (".data.init_task")))
 	= { INIT_THREAD_INFO(init_task) };
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 4bfbeff..59c8d09 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -1,7 +1,9 @@
 /* ld script for sparc32/sparc64 kernel */
 
 #include <asm-generic/vmlinux.lds.h>
+
 #include <asm/page.h>
+#include <asm/thread_info.h>
 
 #ifdef CONFIG_SPARC32
 #define INITIAL_ADDRESS  0x10000 + SIZEOF_HEADERS
@@ -65,8 +67,15 @@ SECTIONS
 	.data.read_mostly : {
 		*(.data.read_mostly)
 	}
+	/* End of data section */
 	_edata = .;
 	PROVIDE (edata = .);
+
+	/* init_task */
+	. = ALIGN(THREAD_SIZE);
+	.data.init_task : {
+		*(.data.init_task)
+	}
 	.fixup : {
 		__start___fixup = .;
 		*(.fixup)
-- 
1.6.0.2.GIT


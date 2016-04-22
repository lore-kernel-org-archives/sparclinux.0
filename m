From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 22 Apr 2016 17:41:04 +0000
Subject: [PATCH 2/5] sparc32: drop local prototype in kgdb_32
Message-Id: <1461346867-9736-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/kgdb_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/kgdb_32.c b/arch/sparc/kernel/kgdb_32.c
index 5d0a323..8602e88 100644
--- a/arch/sparc/kernel/kgdb_32.c
+++ b/arch/sparc/kernel/kgdb_32.c
@@ -12,6 +12,8 @@
 #include <asm/irq.h>
 #include <asm/cacheflush.h>
 
+#include "entry.h"
+
 extern unsigned long trapbase;
 
 void pt_regs_to_gdb_regs(unsigned long *gdb_regs, struct pt_regs *regs)
@@ -133,8 +135,6 @@ int kgdb_arch_handle_exception(int e_vector, int signo, int err_code,
 	return -1;
 }
 
-extern void do_hw_interrupt(struct pt_regs *regs, unsigned long type);
-
 asmlinkage void kgdb_trap(unsigned long trap_level, struct pt_regs *regs)
 {
 	unsigned long flags;
-- 
2.5.0


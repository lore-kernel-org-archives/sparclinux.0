From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 05 Sep 2013 09:17:33 +0000
Subject: [PATCH v2] sparc64: Export flush_ptrace_access() (needed by lustre)
Message-Id: <1378372653-5822-1-git-send-email-geert@linux-m68k.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

ERROR: "flush_ptrace_access" [drivers/staging/lustre/lustre/libcfs/libcfs.ko]
undefined!

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2: Use EXPORT_SYMBOL_GPL instead of EXPORT_SYMBOL

 arch/sparc/kernel/ptrace_64.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 7ff45e4..5573998 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/smp.h>
@@ -116,6 +117,7 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 
 	preempt_enable();
 }
+EXPORT_SYMBOL_GPL(flush_ptrace_access);
 
 static int get_from_target(struct task_struct *target, unsigned long uaddr,
 			   void *kbuf, int len)
-- 
1.7.9.5


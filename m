From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 30 Mar 2012 19:31:24 +0000
Subject: [PATCH] sparc: fix compile failure in kgdb_64.c
Message-Id: <1333135884-12815-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

To fix:

  CC      arch/sparc/kernel/kgdb_64.o
 arch/sparc/kernel/kgdb_64.c: In function 'smp_kgdb_capture_client':
 arch/sparc/kernel/kgdb_64.c:121: error: implicit declaration of function 'flushw_all'
 make[2]: *** [arch/sparc/kernel/kgdb_64.o] Error 1

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[tested on linux-next; presumably caused by the asm/system.h split]

diff --git a/arch/sparc/kernel/kgdb_64.c b/arch/sparc/kernel/kgdb_64.c
index 768290a..e916169 100644
--- a/arch/sparc/kernel/kgdb_64.c
+++ b/arch/sparc/kernel/kgdb_64.c
@@ -8,6 +8,7 @@
 #include <linux/ftrace.h>
 
 #include <asm/kdebug.h>
+#include <asm/cacheflush.h>
 #include <asm/ptrace.h>
 #include <asm/irq.h>
 
-- 
1.7.9.1


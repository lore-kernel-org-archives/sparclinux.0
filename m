From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 06 Jan 2014 19:51:03 +0000
Subject: [PATCH] sparc: fix kgdb build failure due to context tracking
Message-Id: <1389037863-8866-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The following allmodconfig build failure is seen:

  CC      arch/sparc/kernel/kgdb_64.o
arch/sparc/kernel/kgdb_64.c: In function 'kgdb_trap':
arch/sparc/kernel/kgdb_64.c:162:7: error: implicit declaration of function 'exception_enter' [-Werror=implicit-function-declaration]
arch/sparc/kernel/kgdb_64.c:176:2: error: implicit declaration of function 'exception_exit' [-Werror=implicit-function-declaration]
cc1: all warnings being treated as errors

Bisection leads to commit 812cb83a56a908729c453a7db3fb2c262119bc9d
("sparc64: Implement HAVE_CONTEXT_TRACKING").  This commit failed
to include the proper header for the above two functions in this file.

Cc: Kirill Tkhai <tkhai@yandex.ru>
Fixes: 812cb83a56a9 ("sparc64: Implement HAVE_CONTEXT_TRACKING")
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/arch/sparc/kernel/kgdb_64.c b/arch/sparc/kernel/kgdb_64.c
index 60b19f50c80a..3860e692fedc 100644
--- a/arch/sparc/kernel/kgdb_64.c
+++ b/arch/sparc/kernel/kgdb_64.c
@@ -5,6 +5,7 @@
 
 #include <linux/kgdb.h>
 #include <linux/kdebug.h>
+#include <linux/context_tracking.h>
 #include <linux/ftrace.h>
 
 #include <asm/cacheflush.h>
-- 
1.8.5.1


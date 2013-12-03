From: Kirill Tkhai <tkhai@yandex.ru>
Date: Tue, 03 Dec 2013 16:12:37 +0000
Subject: [PATCH] sparc64: Fix build regression
Message-Id: <13601386087157@web22j.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch fixes build error which was introduced by commit

812cb83a56a908729c453a7db3fb2c262119bc9d (Implement HAVE_CONTEXT_TRACKING).

[*]https://lkml.org/lkml/2013/11/23/103

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
---
 arch/sparc/kernel/kgdb_64.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
diff --git a/arch/sparc/kernel/kgdb_64.c b/arch/sparc/kernel/kgdb_64.c
index 60b19f5..b45fe3f 100644
--- a/arch/sparc/kernel/kgdb_64.c
+++ b/arch/sparc/kernel/kgdb_64.c
@@ -6,6 +6,7 @@
 #include <linux/kgdb.h>
 #include <linux/kdebug.h>
 #include <linux/ftrace.h>
+#include <linux/context_tracking.h>
 
 #include <asm/cacheflush.h>
 #include <asm/kdebug.h>

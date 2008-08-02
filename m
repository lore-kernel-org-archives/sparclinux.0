From: Huang Weiyi <weiyi.huang@gmail.com>
Date: Sat, 02 Aug 2008 13:02:48 +0000
Subject: arch/sparc64/kernel/signal.c: removed duplicated #include
Message-Id: <20080802205932.D632.WEIYI.HUANG@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Removed duplicated #include <linux/tracehook.h> in 
arch/sparc64/kernel/signal.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/arch/sparc64/kernel/signal.c b/arch/sparc64/kernel/signal.c
index d1b8445..e12bece 100644
--- a/arch/sparc64/kernel/signal.c
+++ b/arch/sparc64/kernel/signal.c
@@ -23,7 +23,6 @@
 #include <linux/tty.h>
 #include <linux/binfmts.h>
 #include <linux/bitops.h>
-#include <linux/tracehook.h>

 #include <asm/uaccess.h>
 #include <asm/ptrace.h>


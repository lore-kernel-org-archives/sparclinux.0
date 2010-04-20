From: Meelis Roos <mroos@linux.ee>
Date: Tue, 20 Apr 2010 06:56:35 +0000
Subject: [PATCH] Fix kmemleak include in arch/sparc/kernel/irq_64.c
Message-Id: <alpine.SOC.1.00.1004200947380.22959@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Trying 2.6.34-rc5 on my minimal-config Ultra 1 gave me this error:

  CC      arch/sparc/kernel/irq_64.o
arch/sparc/kernel/irq_64.c: In function 'sun4v_build_virq':
arch/sparc/kernel/irq_64.c:657: error: implicit declaration of function 'kmemleak_not_leak'
make[1]: *** [arch/sparc/kernel/irq_64.o] Error 1

Fix it by including kmemleak.h for the inline function.

Signed-off-by: Meelis Roos <mroos@linux.ee>

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 454ce3a..2b04c72 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -22,6 +22,7 @@
 #include <linux/seq_file.h>
 #include <linux/ftrace.h>
 #include <linux/irq.h>
+#include <linux/kmemleak.h>
 
 #include <asm/ptrace.h>
 #include <asm/processor.h>

-- 
Meelis Roos (mroos@linux.ee)

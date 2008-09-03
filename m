From: David Miller <davem@davemloft.net>
Date: Wed, 03 Sep 2008 23:00:26 +0000
Subject: [PATCH 2/3]: sparc32: Kill remaining asm/mostek.h inclusions.
Message-Id: <20080903.160026.08745795.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Kill remaining asm/mostek.h inclusions.

No longer needed.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/sparc_ksyms.c |    1 -
 arch/sparc/kernel/tick14.c      |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
index 0ce002e..b0dfff8 100644
--- a/arch/sparc/kernel/sparc_ksyms.c
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -38,7 +38,6 @@
 #include <asm/idprom.h>
 #include <asm/head.h>
 #include <asm/smp.h>
-#include <asm/mostek.h>
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
 #include <asm/checksum.h>
diff --git a/arch/sparc/kernel/tick14.c b/arch/sparc/kernel/tick14.c
index 707bfda..77a4f3a 100644
--- a/arch/sparc/kernel/tick14.c
+++ b/arch/sparc/kernel/tick14.c
@@ -20,7 +20,6 @@
 
 #include <asm/oplib.h>
 #include <asm/timer.h>
-#include <asm/mostek.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-- 
1.5.6.5.GIT


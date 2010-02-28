From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Sun, 28 Feb 2010 10:58:17 +0000
Subject: [PATCH] sparc: use __ratelimit
Message-Id: <1267354697-6456-5-git-send-email-akinobu.mita@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1267354697-6456-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1267354697-6456-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Replace open-coded rate limiting logic with __ratelimit().

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/unaligned_64.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index 378ca82..f03641f 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -21,6 +21,7 @@
 #include <linux/smp.h>
 #include <linux/bitops.h>
 #include <linux/perf_event.h>
+#include <linux/ratelimit.h>
 #include <asm/fpumacro.h>
 
 enum direction {
@@ -274,13 +275,9 @@ static void kernel_mna_trap_fault(int fixup_tstate_asi)
 
 static void log_unaligned(struct pt_regs *regs)
 {
-	static unsigned long count, last_time;
+	static DEFINE_RATELIMIT_STATE(ratelimit, 5 * HZ, 5);
 
-	if (time_after(jiffies, last_time + 5 * HZ))
-		count = 0;
-	if (count < 5) {
-		last_time = jiffies;
-		count++;
+	if (__ratelimit(&ratelimit)) {
 		printk("Kernel unaligned access at TPC[%lx] %pS\n",
 		       regs->tpc, (void *) regs->tpc);
 	}
-- 
1.6.0.6


From: David Miller <davem@davemloft.net>
Date: Mon, 13 Oct 2008 03:57:06 +0000
Subject: [PATCH]: sparc64: Add missing notify_cpu_starting() call.
Message-Id: <20081012.205706.66825182.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: manfred@colorfullife.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


Manfred please be much more careful next time.

You broke the sparc32 build (missing linux/cpu.h includes), and
you skipped over sparc64 entirely.

I checked in a fix for the sparc32 build failure and the following
sparc64 patch to my sparc-2.6 tree to fix this stuff.

And I'll push this off to Linus shortly.

sparc64: Add missing notify_cpu_starting() call.

Commit e545a6140b698b2494daf0b32107bdcc5e901390 ("kernel/cpu.c: create
a CPU_STARTING cpu_chain notifier") added a notify_cpu_starting()
notifier event, and hit every arch except sparc64.

Fix that missed case.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/smp.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sparc64/kernel/smp.c b/arch/sparc64/kernel/smp.c
index 2be166c..e562711 100644
--- a/arch/sparc64/kernel/smp.c
+++ b/arch/sparc64/kernel/smp.c
@@ -21,6 +21,7 @@
 #include <linux/jiffies.h>
 #include <linux/profile.h>
 #include <linux/lmb.h>
+#include <linux/cpu.h>
 
 #include <asm/head.h>
 #include <asm/ptrace.h>
@@ -115,6 +116,9 @@ void __cpuinit smp_callin(void)
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
 
+	/* inform the notifiers about the new cpu */
+	notify_cpu_starting(cpuid);
+
 	while (!cpu_isset(cpuid, smp_commenced_mask))
 		rmb();
 
-- 
1.5.6.5


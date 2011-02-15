From: David Miller <davem@davemloft.net>
Date: Tue, 15 Feb 2011 23:05:00 +0000
Subject: [PATCH] sparc64: Fix NMI startup bug which also breaks perf.
Message-Id: <20110215.150500.28828108.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Doing NMI startup as an early initcall doesn't work because we need
to have SMP started up by then.

So we'd only NMI startup one cpu, which causes perf PMU grab to
BUG because the nmi_active count isn't what it's supposed to be.

This also points out that we don't have proper CPU up/down notifiers
for the NMI code which will need to be fixed at some point.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/pcr.h |    2 ++
 arch/sparc/kernel/pcr.c      |    2 --
 arch/sparc/kernel/smp_64.c   |    2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/pcr.h b/arch/sparc/include/asm/pcr.h
index a2f5c61..843e4fa 100644
--- a/arch/sparc/include/asm/pcr.h
+++ b/arch/sparc/include/asm/pcr.h
@@ -43,4 +43,6 @@ static inline u64 picl_value(unsigned int nmi_hz)
 
 extern u64 pcr_enable;
 
+extern int pcr_arch_init(void);
+
 #endif /* __PCR_H */
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index ae96cf5..7c2ced6 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -167,5 +167,3 @@ out_unregister:
 	unregister_perf_hsvc();
 	return err;
 }
-
-early_initcall(pcr_arch_init);
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index b6a2b8f..555a76d 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -49,6 +49,7 @@
 #include <asm/mdesc.h>
 #include <asm/ldc.h>
 #include <asm/hypervisor.h>
+#include <asm/pcr.h>
 
 #include "cpumap.h"
 
@@ -1358,6 +1359,7 @@ void __cpu_die(unsigned int cpu)
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
+	pcr_arch_init();
 }
 
 void smp_send_reschedule(int cpu)
-- 
1.7.4.1


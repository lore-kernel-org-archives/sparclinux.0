From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 12 Dec 2013 14:09:50 +0000
Subject: [PATCH] sparc64: smp_callin: Enable irqs after preemption is disabled
Message-Id: <62771386857390@web21m.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Most of other architectures have below suggested order.
So lets do the same to fit generic idle loop scheme better.

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
---
 arch/sparc/kernel/smp_64.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index b66a533..b085311 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -123,11 +123,12 @@ void smp_callin(void)
 		rmb();
 
 	set_cpu_online(cpuid, true);
-	local_irq_enable();
 
 	/* idle thread is expected to have preempt disabled */
 	preempt_disable();
 
+	local_irq_enable();
+
 	cpu_startup_entry(CPUHP_ONLINE);
 }
 

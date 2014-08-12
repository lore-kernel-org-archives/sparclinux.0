From: David Miller <davem@davemloft.net>
Date: Tue, 12 Aug 2014 03:46:30 +0000
Subject: [PATCH] sparc64: Do not disable interrupts in nmi_cpu_busy()
Message-Id: <20140811.204630.506728512299279797.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


nmi_cpu_busy() is a SMP function call that just makes sure that all of the
cpus are spinning using cpu cycles while the NMI test runs.

It does not need to disable IRQs because we just care about NMIs executing
which will even with 'normal' IRQs disabled.

It is not legal to enable hard IRQs in a SMP cross call, in fact this bug
triggers the BUG check in irq_work_run_list():

	BUG_ON(!irqs_disabled());

Because now irq_work_run() is invoked from the tail of
generic_smp_call_function_single_interrupt().

Signed-off-by: David S. Miller <davem@davemloft.net>
---

This should fix bootup failures with Linus's current tree.

 arch/sparc/kernel/nmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 3370945..5b1151d 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -130,7 +130,6 @@ static inline unsigned int get_nmi_count(int cpu)
 
 static __init void nmi_cpu_busy(void *data)
 {
-	local_irq_enable_in_hardirq();
 	while (endflag = 0)
 		mb();
 }
-- 
1.8.1.2


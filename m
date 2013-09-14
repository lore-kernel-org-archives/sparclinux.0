From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sat, 14 Sep 2013 12:00:09 +0000
Subject: [PATCH 1/2] sparc64: Add self-IPI support for smp_send_reschedule()
Message-Id: <147951379160009@web12j.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

CONFIG_NO_HZ_FULL requires possibility of smp_send_reschedule()
for the calling CPU. Currently, it is used in inc_nr_running()
scheduler primitive only.
    
Nobody calls smp_send_reschedule() from preemptible context
(furthermore, it looks like it will be save if anybody use it
another way in the future). But anyway I add WARN_ON() here
just to return here if anything changes.

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
CC: David Miller <davem@davemloft.net>
---
 arch/sparc/kernel/smp_64.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index e142545..b66a533 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1399,8 +1399,13 @@ void __init smp_cpus_done(unsigned int max_cpus)
 
 void smp_send_reschedule(int cpu)
 {
-	xcall_deliver((u64) &xcall_receive_signal, 0, 0,
-		      cpumask_of(cpu));
+	if (cpu = smp_processor_id()) {
+		WARN_ON_ONCE(preemptible());
+		set_softint(1 << PIL_SMP_RECEIVE_SIGNAL);
+	} else {
+		xcall_deliver((u64) &xcall_receive_signal,
+			      0, 0, cpumask_of(cpu));
+	}
 }
 
 void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs)

From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Thu, 10 Nov 2016 22:43:33 +0000
Subject: [PATCH 1/4] sparc64: Set cpu state to offline when stopped
Message-Id: <1478817816-98939-1-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org
Cc: karl.volz@oracle.com, rob.gardner@oracle.com, linux-kernel@vger.kernel.org

CPU needs to be marked offline before stopping it. When not marked
offline, the xcall receives HV_EWOULDBLOCK and so assumes that not all
CPUs received the message, and retries. After 10000 retries, it finally
fails with fatal mondo timeout.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/kernel/smp_64.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index d3035ba..14138ad 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1435,6 +1435,7 @@ void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs)
 
 static void stop_this_cpu(void *dummy)
 {
+	set_cpu_online(smp_processor_id(), false);
 	prom_stopself();
 }
 
@@ -1446,6 +1447,8 @@ void smp_send_stop(void)
 		for_each_online_cpu(cpu) {
 			if (cpu = smp_processor_id())
 				continue;
+
+			set_cpu_online(cpu, false);
 #ifdef CONFIG_SUN_LDOMS
 			if (ldom_domaining_enabled) {
 				unsigned long hv_err;
-- 
1.7.1


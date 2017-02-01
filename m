From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Wed, 01 Feb 2017 19:34:37 +0000
Subject: [PATCH v3 1/4] sparc64: Set cpu state to offline when stopped
Message-Id: <1485977680-203775-2-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1485977680-203775-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1485977680-203775-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, karl.volz@oracle.com, rob.gardner@oracle.com, linux-kernel@vger.kernel.org, vijay.ac.kumar@oracle.com

CPU needs to be marked offline before stopping it. When not marked
offline, the xcall receives HV_EWOULDBLOCK and so assumes that not all
CPUs received the message, and retries. After 10000 retries, it finally
fails with fatal mondo timeout.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/kernel/smp_64.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 0ce347f..712bf1b 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1443,6 +1443,7 @@ void __irq_entry smp_receive_signal_client(int irq, struct pt_regs *regs)
 
 static void stop_this_cpu(void *dummy)
 {
+	set_cpu_online(smp_processor_id(), false);
 	prom_stopself();
 }
 
@@ -1454,6 +1455,8 @@ void smp_send_stop(void)
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


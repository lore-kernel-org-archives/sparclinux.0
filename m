From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 04 May 2005 00:05:09 +0000
Subject: [PATCH] 2.6.x SMP UltraSPARC instability
Message-Id: <20050503170509.5fa93b26.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Can folks seeing problems on SMP sparc64 boxes with 2.6.x
give this patch a try?

--- 1/arch/sparc64/kernel/irq.c.~1~	2005-04-29 05:51:44.000000000 -0700
+++ 2/arch/sparc64/kernel/irq.c	2005-04-29 05:52:10.000000000 -0700
@@ -756,7 +756,7 @@
 		clear_softint(clr_mask);
 	}
 #else
-	int should_forward = 1;
+	int should_forward = 0;
 
 	clear_softint(1 << irq);
 #endif
@@ -1007,10 +1007,10 @@
 	}
 	upa_writel(tid | IMAP_VALID, imap);
 
-	while (!cpu_online(goal_cpu)) {
+	do {
 		if (++goal_cpu >= NR_CPUS)
 			goal_cpu = 0;
-	}
+	} while (!cpu_online(goal_cpu));
 
 	return goal_cpu;
 }

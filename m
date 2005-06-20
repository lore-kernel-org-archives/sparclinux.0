From: domen@coderock.org
Date: Mon, 20 Jun 2005 21:50:33 +0000
Subject: [patch 2/4] sbus/envctrl: replace schedule_timeout() with msleep_interruptible()
Message-Id: <20050620215033.613583000@nd47.coderock.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Use msleep_interruptible() instead of
schedule_timeout() to guarantee the task delays as expected. Change the units of
poll_interval to msecs as it is only used in this delay.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 envctrl.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

Index: quilt/drivers/sbus/char/envctrl.c
=================================--- quilt.orig/drivers/sbus/char/envctrl.c
+++ quilt/drivers/sbus/char/envctrl.c
@@ -1007,7 +1007,7 @@ static int kenvctrld(void *__unused)
 		return -ENODEV;
 	}
 
-	poll_interval = 5 * HZ; /* TODO env_mon_interval */
+	poll_interval = 5000; /* TODO env_mon_interval */
 
 	daemonize("kenvctrld");
 	allow_signal(SIGKILL);
@@ -1016,10 +1016,7 @@ static int kenvctrld(void *__unused)
 
 	printk(KERN_INFO "envctrl: %s starting...\n", current->comm);
 	for (;;) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(poll_interval);
-
-		if(signal_pending(current))
+		if(msleep_interruptible(poll_interval))
 			break;
 
 		for (whichcpu = 0; whichcpu < ENVCTRL_MAX_CPU; ++whichcpu) {

--

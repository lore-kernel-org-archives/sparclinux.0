From: domen@coderock.org
Date: Sun, 06 Mar 2005 22:29:00 +0000
Subject: [patch 2/4] sbus/envctrl: replace schedule_timeout() with msleep_interruptible()
Message-Id: <20050306222900.90F341F201@trashy.coderock.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



Use msleep_interruptible() instead of
schedule_timeout() to guarantee the task delays as expected. Change the units of
poll_interval to msecs as it is only used in this delay.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/sbus/char/envctrl.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff -puN drivers/sbus/char/envctrl.c~msleep_interruptible-drivers_sbus_char_envctrl drivers/sbus/char/envctrl.c
--- kj/drivers/sbus/char/envctrl.c~msleep_interruptible-drivers_sbus_char_envctrl	2005-03-05 16:11:02.000000000 +0100
+++ kj-domen/drivers/sbus/char/envctrl.c	2005-03-05 16:11:02.000000000 +0100
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
_

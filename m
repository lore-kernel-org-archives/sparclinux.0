From: Joel Stanley <joel@jms.id.au>
Date: Wed, 01 Apr 2015 07:16:46 +0000
Subject: [PATCH v2 1/3] envctrl: Ignore orderly_poweroff return value
Message-Id: <1427871888-27331-1-git-send-email-joel@jms.id.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Cc: rusty@rustcorp.com.au, fabf@skynet.be, jk@ozlabs.org, akpm@linux-foundation.org, davem@davemloft.net

orderly_poweroff() unconditionally returns 0, so remove the dead code
that checks the return value.

A future patch will change the return type to void.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/sbus/char/bbc_envctrl.c | 3 +--
 drivers/sbus/char/envctrl.c     | 7 +------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/sbus/char/bbc_envctrl.c b/drivers/sbus/char/bbc_envctrl.c
index 0787b97..228c782 100644
--- a/drivers/sbus/char/bbc_envctrl.c
+++ b/drivers/sbus/char/bbc_envctrl.c
@@ -160,8 +160,7 @@ static void do_envctrl_shutdown(struct bbc_cpu_temperature *tp)
 	printk(KERN_CRIT "kenvctrld: Shutting down the system now.\n");
 
 	shutting_down = 1;
-	if (orderly_poweroff(true) < 0)
-		printk(KERN_CRIT "envctrl: shutdown execution failed\n");
+	orderly_poweroff(true);
 }
 
 #define WARN_INTERVAL	(30 * HZ)
diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index af15a2f..7946852 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -970,18 +970,13 @@ static struct i2c_child_t *envctrl_get_i2c_child(unsigned char mon_type)
 static void envctrl_do_shutdown(void)
 {
 	static int inprog = 0;
-	int ret;
 
 	if (inprog != 0)
 		return;
 
 	inprog = 1;
 	printk(KERN_CRIT "kenvctrld: WARNING: Shutting down the system now.\n");
-	ret = orderly_poweroff(true);
-	if (ret < 0) {
-		printk(KERN_CRIT "kenvctrld: WARNING: system shutdown failed!\n"); 
-		inprog = 0;  /* unlikely to succeed, but we could try again */
-	}
+	orderly_poweroff(true);
 }
 
 static struct task_struct *kenvctrld_task;
-- 
2.1.4


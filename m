From: domen@coderock.org
Date: Mon, 20 Jun 2005 21:50:32 +0000
Subject: [patch 1/4] sbus/aurora: replace schedule_timeout() with msleep_interruptible()
Message-Id: <20050620215032.289663000@nd47.coderock.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nishanth Aravamudan <nacc@us.ibm.com>



Use msleep_interruptible() instead of
schedule_timeout() to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 aurora.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

Index: quilt/drivers/sbus/char/aurora.c
=================================--- quilt.orig/drivers/sbus/char/aurora.c
+++ quilt/drivers/sbus/char/aurora.c
@@ -1515,8 +1515,7 @@ static void aurora_close(struct tty_stru
 		 */
 		timeout = jiffies+HZ;
 		while(port->SRER & SRER_TXEMPTY)  {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(port->timeout);
+			msleep_interruptible(jiffies_to_msecs(port->timeout));
 			if (time_after(jiffies, timeout))
 				break;
 		}
@@ -1533,8 +1532,7 @@ static void aurora_close(struct tty_stru
 	port->tty = 0;
 	if (port->blocked_open) {
 		if (port->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(port->close_delay);
+			msleep_interruptible(jiffies_to_msecs(port->close_delay));
 		}
 		wake_up_interruptible(&port->open_wait);
 	}

--

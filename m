From: domen@coderock.org
Date: Sun, 06 Mar 2005 22:28:56 +0000
Subject: [patch 1/4] Re: sbus/aurora: replace schedule_timeout() with msleep_interruptible()
Message-Id: <20050306222857.302E11EC90@trashy.coderock.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org




Use msleep_interruptible() instead of
schedule_timeout() to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/sbus/char/aurora.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/sbus/char/aurora.c~msleep_interruptible-drivers_sbus_char_aurora drivers/sbus/char/aurora.c
--- kj/drivers/sbus/char/aurora.c~msleep_interruptible-drivers_sbus_char_aurora	2005-03-05 16:09:38.000000000 +0100
+++ kj-domen/drivers/sbus/char/aurora.c	2005-03-05 16:09:38.000000000 +0100
@@ -1519,8 +1519,7 @@ static void aurora_close(struct tty_stru
 		 */
 		timeout = jiffies+HZ;
 		while(port->SRER & SRER_TXEMPTY)  {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(port->timeout);
+			msleep_interruptible(jiffies_to_msecs(port->timeout));
 			if (time_after(jiffies, timeout))
 				break;
 		}
@@ -1537,8 +1536,7 @@ static void aurora_close(struct tty_stru
 	port->tty = 0;
 	if (port->blocked_open) {
 		if (port->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(port->close_delay);
+			msleep_interruptible(jiffies_to_msecs(port->close_delay));
 		}
 		wake_up_interruptible(&port->open_wait);
 	}
_

From: domen@coderock.org
Date: Sun, 06 Mar 2005 22:29:03 +0000
Subject: [patch 3/4] sbus/bpp: remove sleep_on() usage
Message-Id: <20050306222904.42ED41F1F0@trashy.coderock.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



Use wait-queue directly instead of the deprecated sleep_on()
function. This required adding a local wait-queue.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/sbus/char/bpp.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -puN drivers/sbus/char/bpp.c~sleep_on-drivers_sbus_char_bpp drivers/sbus/char/bpp.c
--- kj/drivers/sbus/char/bpp.c~sleep_on-drivers_sbus_char_bpp	2005-03-05 16:11:49.000000000 +0100
+++ kj-domen/drivers/sbus/char/bpp.c	2005-03-05 16:11:49.000000000 +0100
@@ -20,6 +20,7 @@
 #include <linux/timer.h>
 #include <linux/ioport.h>
 #include <linux/major.h>
+#include <linux/wait.h>
 #include <linux/devfs_fs_kernel.h>
 
 #include <asm/uaccess.h>
@@ -302,11 +303,14 @@ static void bpp_wake_up(unsigned long va
 
 static void snooze(unsigned long snooze_time, unsigned minor)
 {
+      DEFINE_WAIT(wait);
       init_timer(&instances[minor].timer_list);
       instances[minor].timer_list.expires = jiffies + snooze_time + 1;
       instances[minor].timer_list.data    = minor;
       add_timer(&instances[minor].timer_list);
-      sleep_on (&instances[minor].wait_queue);
+      prepare_to_wait(&instances[minor].wait_queue, &wait, TASK_UNINTERRUPTIBLE);
+      schedule();
+      finish_wait(&instances[minor].wait_queue, &wait);
 }
 
 static int wait_for(unsigned short set, unsigned short clr,
_

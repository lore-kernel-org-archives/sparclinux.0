From: Christoph Hellwig <hch@lst.de>
Date: Mon, 20 Jun 2005 10:57:50 +0000
Subject: [PATCH] bpp: remove sleep_on usage
Message-Id: <20050620105750.GA4679@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Use schedule_timeout() instead of sleep_on + timer.  Totally untested
due to lack of hardware, but the changes are rather trivial.


Index: linux-2.6/drivers/sbus/char/bpp.c
=================================--- linux-2.6.orig/drivers/sbus/char/bpp.c	2005-04-30 10:17:16.000000000 +0200
+++ linux-2.6/drivers/sbus/char/bpp.c	2005-05-27 14:13:47.000000000 +0200
@@ -79,10 +79,6 @@
 
       unsigned char run_length;
       unsigned char repeat_byte;
-
-      /* These members manage timeouts for programmed delays */
-      wait_queue_head_t wait_queue;
-      struct timer_list timer_list;
 };
 
 static struct inst instances[BPP_NO];
@@ -297,16 +293,10 @@
 
 #endif /* __sparc__ */
 
-static void bpp_wake_up(unsigned long val)
-{ wake_up(&instances[val].wait_queue); }
-
 static void snooze(unsigned long snooze_time, unsigned minor)
 {
-      init_timer(&instances[minor].timer_list);
-      instances[minor].timer_list.expires = jiffies + snooze_time + 1;
-      instances[minor].timer_list.data    = minor;
-      add_timer(&instances[minor].timer_list);
-      sleep_on (&instances[minor].wait_queue);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+	schedule_timeout(snooze_time + 1);
 }
 
 static int wait_for(unsigned short set, unsigned short clr,
@@ -880,11 +870,8 @@
       instances[idx].enhanced = 0;
       instances[idx].direction = 0;
       instances[idx].mode = COMPATIBILITY;
-      instances[idx].wait_queue = 0;
       instances[idx].run_length = 0;
       instances[idx].run_flag = 0;
-      init_timer(&instances[idx].timer_list);
-      instances[idx].timer_list.function = bpp_wake_up;
       if (!request_region(lpAddr,3, dev_name)) return;
 
       /*
@@ -977,11 +964,8 @@
       instances[idx].enhanced = 0;
       instances[idx].direction = 0;
       instances[idx].mode = COMPATIBILITY;
-      init_waitqueue_head(&instances[idx].wait_queue);
       instances[idx].run_length = 0;
       instances[idx].run_flag = 0;
-      init_timer(&instances[idx].timer_list);
-      instances[idx].timer_list.function = bpp_wake_up;
 
       if (!rp) return;
 

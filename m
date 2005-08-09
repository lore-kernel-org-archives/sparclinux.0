From: Christoph Hellwig <hch@lst.de>
Date: Tue, 09 Aug 2005 20:28:59 +0000
Subject: Re: [PATCH] use kthread infrastructure in envctrl
Message-Id: <20050809202859.GA28729@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20050809135128.GA22257@lst.de>
In-Reply-To: <20050809135128.GA22257@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Aug 09, 2005 at 12:33:09PM -0700, David S. Miller wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Tue, 9 Aug 2005 15:51:28 +0200
> 
> > envctrl currently uses very odd ways to stop a thread, using various
> > things that should be exposed to drivers at all.
> > 
> > This patch (which is untested as I don't have sparc hardware) switches
> > it to use the proper kthread infrastructure.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks good, applied.
> 
> Same exact kind of gross code (written by me of course) exists
> in bbc_envctrl.c as well.  Would you mind sending me a patch
> to fix up that driver as well?

Sure.  While we're at it, is there a specific reason various sbus
drivers reimplement i2c functionality instead of using the common
code?

Index: linux-2.6/drivers/sbus/char/bbc_envctrl.c
=================================--- linux-2.6.orig/drivers/sbus/char/bbc_envctrl.c	2005-07-28 19:32:23.000000000 +0200
+++ linux-2.6/drivers/sbus/char/bbc_envctrl.c	2005-08-09 22:27:48.000000000 +0200
@@ -7,6 +7,7 @@
 #define __KERNEL_SYSCALLS__
 
 #include <linux/kernel.h>
+#include <linux/kthread.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
@@ -459,10 +460,6 @@
 
 static int kenvctrld(void *__unused)
 {
-	daemonize("kenvctrld");
-	allow_signal(SIGKILL);
-	kenvctrld_task = current;
-
 	printk(KERN_INFO "bbc_envctrl: kenvctrld starting...\n");
 	last_warning_jiffies = jiffies - WARN_INTERVAL;
 	for (;;) {
@@ -470,7 +467,7 @@
 		struct bbc_fan_control *fp;
 
 		msleep_interruptible(POLL_INTERVAL);
-		if (signal_pending(current))
+		if (kthread_should_stop())
 			break;
 
 		for (tp = all_bbc_temps; tp; tp = tp->next) {
@@ -577,7 +574,6 @@
 	int temp_index = 0;
 	int fan_index = 0;
 	int devidx = 0;
-	int err = 0;
 
 	while ((echild = bbc_i2c_getdev(devidx++)) != NULL) {
 		if (!strcmp(echild->prom_name, "temperature"))
@@ -585,9 +581,13 @@
 		if (!strcmp(echild->prom_name, "fan-control"))
 			attach_one_fan(echild, fan_index++);
 	}
-	if (temp_index != 0 && fan_index != 0)
-		err = kernel_thread(kenvctrld, NULL, CLONE_FS | CLONE_FILES);
-	return err;
+	if (temp_index != 0 && fan_index != 0) {
+		kenvctrld_task = kthread_run(kenvctrld, NULL, "kenvctrld");
+		if (IS_ERR(kenvctrld_task))
+			return PTR_ERR(kenvctrld_task);
+	}
+
+	return 0;
 }
 
 static void destroy_one_temp(struct bbc_cpu_temperature *tp)
@@ -607,26 +607,7 @@
 	struct bbc_cpu_temperature *tp;
 	struct bbc_fan_control *fp;
 
-	if (kenvctrld_task != NULL) {
-		force_sig(SIGKILL, kenvctrld_task);
-		for (;;) {
-			struct task_struct *p;
-			int found = 0;
-
-			read_lock(&tasklist_lock);
-			for_each_process(p) {
-				if (p = kenvctrld_task) {
-					found = 1;
-					break;
-				}
-			}
-			read_unlock(&tasklist_lock);
-			if (!found)
-				break;
-			msleep(1000);
-		}
-		kenvctrld_task = NULL;
-	}
+	kthread_stop(kenvctrld_task);
 
 	tp = all_bbc_temps;
 	while (tp != NULL) {

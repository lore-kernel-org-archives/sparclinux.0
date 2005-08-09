From: Christoph Hellwig <hch@lst.de>
Date: Tue, 09 Aug 2005 13:51:28 +0000
Subject: [PATCH] use kthread infrastructure in envctrl
Message-Id: <20050809135128.GA22257@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

envctrl currently uses very odd ways to stop a thread, using various
things that should be exposed to drivers at all.

This patch (which is untested as I don't have sparc hardware) switches
it to use the proper kthread infrastructure.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/drivers/sbus/char/envctrl.c
=================================--- linux-2.6.orig/drivers/sbus/char/envctrl.c	2005-07-28 19:32:23.000000000 +0200
+++ linux-2.6/drivers/sbus/char/envctrl.c	2005-08-09 15:48:45.000000000 +0200
@@ -24,6 +24,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/sched.h>
+#include <linux/kthread.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
@@ -1010,16 +1011,13 @@
 
 	poll_interval = 5000; /* TODO env_mon_interval */
 
-	daemonize("kenvctrld");
-	allow_signal(SIGKILL);
-
-	kenvctrld_task = current;
-
 	printk(KERN_INFO "envctrl: %s starting...\n", current->comm);
 	for (;;) {
-		if(msleep_interruptible(poll_interval))
-			break;
+		msleep_interruptible(poll_interval);
 
+		if (kthread_should_stop())
+			break;
+		
 		for (whichcpu = 0; whichcpu < ENVCTRL_MAX_CPU; ++whichcpu) {
 			if (0 < envctrl_read_cpu_info(whichcpu, cputemp,
 						      ENVCTRL_CPUTEMP_MON,
@@ -1118,9 +1116,11 @@
 			i2c_childlist[i].addr, (0 = i) ? ("\n") : (" "));
 	}
 
-	err = kernel_thread(kenvctrld, NULL, CLONE_FS | CLONE_FILES);
-	if (err < 0)
+	kenvctrld_task = kthread_run(kenvctrld, NULL, "kenvctrld");
+	if (IS_ERR(kenvctrld_task)) {
+		err = ERR_PTR(kenvctrld_task);
 		goto out_deregister;
+	}
 
 	return 0;
 
@@ -1142,28 +1142,7 @@
 {
 	int i;
 
-	if (NULL != kenvctrld_task) {
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
-
-			if (!found)
-				break;
-
-			msleep(1000);
-		}
-		kenvctrld_task = NULL;
-	}
+	kthread_stop(kenvctrld_task);
 
 	iounmap(i2c);
 	misc_deregister(&envctrl_dev);

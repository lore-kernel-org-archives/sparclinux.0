From: Christoph Hellwig <hch@lst.de>
Date: Tue, 15 Jun 2004 17:29:56 +0000
Subject: sparc env monitorin vs tasklist_lock
Message-Id: <20040615172956.GA21361@lst.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Strange stuff going on here, bbc_envctrl.c and envctrl.c iterate over
the complete task list to check whether the thread has been killed,
yikes!

I've attached a patch to convert it to the kthread infrastructure, but
it has been completely untested, not even compiled.

p.s. the drivers also have other strangenesses like calling execve
directly instead of call_usermodehelper and the bbc driver having it's
own i2c layer..


--- 1.7/drivers/sbus/char/bbc_envctrl.c	2003-09-30 02:35:22 +02:00
+++ edited/drivers/sbus/char/bbc_envctrl.c	2004-06-14 13:33:26 +02:00
@@ -7,6 +7,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/kthread.h>
 #include <asm/oplib.h>
 #include <asm/ebus.h>
 #define __KERNEL_SYSCALLS__
@@ -457,32 +458,27 @@
 
 static int kenvctrld(void *__unused)
 {
-	daemonize("kenvctrld");
-	allow_signal(SIGKILL);
-	kenvctrld_task = current;
-
 	printk(KERN_INFO "bbc_envctrl: kenvctrld starting...\n");
 	last_warning_jiffies = jiffies - WARN_INTERVAL;
-	for (;;) {
+
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
 		struct bbc_cpu_temperature *tp;
 		struct bbc_fan_control *fp;
 
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(POLL_INTERVAL);
-		if (signal_pending(current))
-			break;
-
 		for (tp = all_bbc_temps; tp; tp = tp->next) {
 			get_current_temps(tp);
 			analyze_temps(tp, &last_warning_jiffies);
 		}
 		for (fp = all_bbc_fans; fp; fp = fp->next)
 			maybe_new_fan_speeds(fp);
+
+		set_current_state(TASK_INTERRUPTIBLE);
 	}
+	__set_current_state(TASK_RUNNING);
 	printk(KERN_INFO "bbc_envctrl: kenvctrld exiting...\n");
 
 	fans_full_blast();
-
 	return 0;
 }
 
@@ -576,7 +574,6 @@
 	int temp_index = 0;
 	int fan_index = 0;
 	int devidx = 0;
-	int err = 0;
 
 	while ((echild = bbc_i2c_getdev(devidx++)) != NULL) {
 		if (!strcmp(echild->prom_name, "temperature"))
@@ -584,9 +581,14 @@
 		if (!strcmp(echild->prom_name, "fan-control"))
 			attach_one_fan(echild, fan_index++);
 	}
-	if (temp_index != 0 && fan_index != 0)
-		err = kernel_thread(kenvctrld, NULL, CLONE_FS | CLONE_FILES);
-	return err;
+
+	if (temp_index = 0 || fan_index = 0)
+		return 0;
+
+	kenvctrld_task = kthread_create(kenvctrld, NULL, "%s", "kenvctrld");
+	if (IS_ERR(kenvctrld_task))
+		return PTR_ERR(kenvctrld_task);
+	return 0;
 }
 
 static void destroy_one_temp(struct bbc_cpu_temperature *tp)
@@ -606,28 +608,7 @@
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
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(HZ);
-			current->state = TASK_RUNNING;
-		}
-		kenvctrld_task = NULL;
-	}
+	kthread_stop(kenvctrld_task);
 
 	tp = all_bbc_temps;
 	while (tp != NULL) {
=== drivers/sbus/char/envctrl.c 1.18 vs edited ==--- 1.18/drivers/sbus/char/envctrl.c	2003-10-07 10:17:34 +02:00
+++ edited/drivers/sbus/char/envctrl.c	2004-06-14 13:32:58 +02:00
@@ -30,6 +30,7 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
+#include <linux/kthread.h>
 
 #include <asm/ebus.h>
 #include <asm/uaccess.h>
@@ -1027,19 +1028,10 @@
 
 	poll_interval = 5 * HZ; /* TODO env_mon_interval */
 
-	daemonize("kenvctrld");
-	allow_signal(SIGKILL);
-
-	kenvctrld_task = current;
-
 	printk(KERN_INFO "envctrl: %s starting...\n", current->comm);
-	for (;;) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(poll_interval);
-
-		if(signal_pending(current))
-			break;
 
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
 		for (whichcpu = 0; whichcpu < ENVCTRL_MAX_CPU; ++whichcpu) {
 			if (0 < envctrl_read_cpu_info(whichcpu, cputemp,
 						      ENVCTRL_CPUTEMP_MON,
@@ -1054,7 +1046,10 @@
 				}
 			}
 		}
+		set_current_state(TASK_INTERRUPTIBLE);
 	}
+	__set_current_state(TASK_RUNNING);
+
 	printk(KERN_INFO "envctrl: %s exiting...\n", current->comm);
 	return 0;
 }
@@ -1139,9 +1134,11 @@
 			i2c_childlist[i].addr, (0 = i) ? ("\n") : (" "));
 	}
 
-	err = kernel_thread(kenvctrld, NULL, CLONE_FS | CLONE_FILES);
-	if (err < 0)
+	kenvctrld_task = kthread_create(kenvctrld, NULL, "%s", "kenvctrld");
+	if (IS_ERR(kenvctrld_task)) {
+		err = PTR_ERR(kenvctrld_task);
 		goto out_deregister;
+	}
 
 	return 0;
 

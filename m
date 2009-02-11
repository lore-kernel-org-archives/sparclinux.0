From: David Miller <davem@davemloft.net>
Date: Wed, 11 Feb 2009 23:15:13 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090211.151513.146695340.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Mon, 9 Feb 2009 23:21:01 +0100

> kobject_uevent_env: Invoking uevent_helper[/sbin/hotplug]
> 

Ok, let's see if it's the fork or the exec attempt which
dies.  Please reboot the same with the following debugging
patch added.

Thanks.

diff --git a/kernel/kmod.c b/kernel/kmod.c
index 2456d1a..e1eab36 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -137,6 +137,8 @@ static int ____call_usermodehelper(void *data)
 	struct key *new_session, *old_session;
 	int retval;
 
+	printk(KERN_ERR "call_usermodehelper: Enter\n");
+
 	/* Unblock all signals and set the session keyring. */
 	new_session = key_get(sub_info->ring);
 	spin_lock_irq(&current->sighand->siglock);
@@ -146,12 +148,17 @@ static int ____call_usermodehelper(void *data)
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
+	printk(KERN_ERR "call_usermodehelper: key_put(old_session)\n");
+
 	key_put(old_session);
 
 	/* Install input pipe when needed */
 	if (sub_info->stdin) {
 		struct files_struct *f = current->files;
 		struct fdtable *fdt;
+
+		printk(KERN_ERR "call_usermodehelper: stdin pipe\n");
+
 		/* no races because files should be private here */
 		sys_close(0);
 		fd_install(0, sub_info->stdin);
@@ -165,17 +172,25 @@ static int ____call_usermodehelper(void *data)
 		current->signal->rlim[RLIMIT_CORE] = (struct rlimit){0, 0};
 	}
 
+	printk(KERN_ERR "call_usermodehelper: set_cpus_allowed_ptr()\n");
+
 	/* We can run anywhere, unlike our parent keventd(). */
 	set_cpus_allowed_ptr(current, CPU_MASK_ALL_PTR);
 
+	printk(KERN_ERR "call_usermodehelper: set_user_nice()\n");
+
 	/*
 	 * Our parent is keventd, which runs with elevated scheduling priority.
 	 * Avoid propagating that into the userspace child.
 	 */
 	set_user_nice(current, 0);
 
+	printk(KERN_ERR "call_usermodehelper: kernel_execve()\n");
+
 	retval = kernel_execve(sub_info->path, sub_info->argv, sub_info->envp);
 
+	printk(KERN_ERR "call_usermodehelper: retval=%d\n", retval);
+
 	/* Exec failed? */
 	sub_info->retval = retval;
 	do_exit(0);
@@ -243,12 +258,14 @@ static void __call_usermodehelper(struct work_struct *work)
 	/* CLONE_VFORK: wait until the usermode helper has execve'd
 	 * successfully We need the data structures to stay around
 	 * until that is done.  */
+	printk(KERN_ERR "__call_usermodehelper: wait=%d\n", (int) wait);
 	if (wait = UMH_WAIT_PROC || wait = UMH_NO_WAIT)
 		pid = kernel_thread(wait_for_helper, sub_info,
 				    CLONE_FS | CLONE_FILES | SIGCHLD);
 	else
 		pid = kernel_thread(____call_usermodehelper, sub_info,
 				    CLONE_VFORK | SIGCHLD);
+	printk(KERN_ERR "__call_usermodehelper: pid=%d\n", (int) pid);
 
 	switch (wait) {
 	case UMH_NO_WAIT:
@@ -362,9 +379,16 @@ struct subprocess_info *call_usermodehelper_setup(char *path, char **argv,
 						  char **envp, gfp_t gfp_mask)
 {
 	struct subprocess_info *sub_info;
+
+	printk(KERN_ERR "call_usermodehelper_setup: kzalloc()\n");
+
 	sub_info = kzalloc(sizeof(struct subprocess_info), gfp_mask);
-	if (!sub_info)
+	if (!sub_info) {
+		printk(KERN_ERR "call_usermodehelper_setup: failed\n");
 		goto out;
+	}
+
+	printk(KERN_ERR "call_usermodehelper_setup: INIT_WORK and done\n");
 
 	INIT_WORK(&sub_info->work, __call_usermodehelper);
 	sub_info->path = path;
@@ -452,11 +476,16 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info,
 	DECLARE_COMPLETION_ONSTACK(done);
 	int retval = 0;
 
+	printk(KERN_ERR "call_usermodehelper_exec: helper_lock()\n");
+
 	helper_lock();
-	if (sub_info->path[0] = '\0')
+	if (sub_info->path[0] = '\0') {
+		printk(KERN_ERR "call_usermodehelper_exec: bad path\n");
 		goto out;
+	}
 
 	if (!khelper_wq || usermodehelper_disabled) {
+		printk(KERN_ERR "call_usermodehelper_exec: disabled or !wq\n");
 		retval = -EBUSY;
 		goto out;
 	}
@@ -464,16 +493,22 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info,
 	sub_info->complete = &done;
 	sub_info->wait = wait;
 
+	printk(KERN_ERR "call_usermodehelper_exec: queue_work()\n");
 	queue_work(khelper_wq, &sub_info->work);
 	if (wait = UMH_NO_WAIT)	/* task has freed sub_info */
 		goto unlock;
+	printk(KERN_ERR "call_usermodehelper_exec: wait_for_completion\n");
 	wait_for_completion(&done);
+	printk(KERN_ERR "call_usermodehelper_exec: back from wait\n");
 	retval = sub_info->retval;
 
 out:
+	printk(KERN_ERR "call_usermodehelper_exec: free sub_info\n");
 	call_usermodehelper_freeinfo(sub_info);
 unlock:
+	printk(KERN_ERR "call_usermodehelper_exec: helper_unlock()\n");
 	helper_unlock();
+	printk(KERN_ERR "call_usermodehelper_exec: retval=%d\n", retval);
 	return retval;
 }
 EXPORT_SYMBOL(call_usermodehelper_exec);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 51daae5..c9ab51a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -46,6 +46,7 @@
 #include <linux/page-isolation.h>
 #include <linux/memcontrol.h>
 #include <linux/debugobjects.h>
+#include <linux/nmi.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -707,7 +708,26 @@ static int move_freepages(struct zone *zone,
 	 * Remove at a later date when no bug reports exist related to
 	 * grouping pages by mobility
 	 */
-	BUG_ON(page_zone(start_page) != page_zone(end_page));
+	if (unlikely(page_zone(start_page) != page_zone(end_page))) {
+		printk(KERN_ERR "move_freepages: Bogus zones: "
+		       "start_page[%p] end_page[%p] zone[%p]\n",
+		       start_page, end_page, zone);
+		printk(KERN_ERR "move_freepages: "
+		       "start_zone[%p] end_zone[%p]\n",
+		       page_zone(start_page), page_zone(end_page));
+		printk(KERN_ERR "move_freepages: "
+		       "start_pfn[0x%lx] end_pfn[0x%lx]\n",
+		       page_to_pfn(start_page), page_to_pfn(end_page));
+		printk(KERN_ERR "move_freepages: "
+		       "start_nid[%d] end_nid[%d]\n",
+		       page_to_nid(start_page), page_to_nid(end_page));
+		spin_unlock(&zone->lock);
+		local_irq_enable();
+		while (1) {
+			barrier();
+			touch_nmi_watchdog();
+		}
+	}
 #endif
 
 	for (page = start_page; page <= end_page;) {
@@ -2583,6 +2603,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 	unsigned long end_pfn = start_pfn + size;
 	unsigned long pfn;
 	struct zone *z;
+	int tmp;
 
 	z = &NODE_DATA(nid)->node_zones[zone];
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
@@ -2594,7 +2615,8 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		if (context = MEMMAP_EARLY) {
 			if (!early_pfn_valid(pfn))
 				continue;
-			if (!early_pfn_in_nid(pfn, nid))
+			tmp = early_pfn_to_nid(pfn);
+			if (tmp > -1 && tmp != nid)
 				continue;
 		}
 		page = pfn_to_page(pfn);
@@ -2961,8 +2983,9 @@ int __meminit early_pfn_to_nid(unsigned long pfn)
 			return early_node_map[i].nid;
 	}
 
-	return 0;
+	return -1;
 }
+
 #endif /* CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID */
 
 /* Basic iterator support to walk early_node_map[] */

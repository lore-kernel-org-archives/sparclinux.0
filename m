From: "David S. Miller" <davem@redhat.com>
Date: Thu, 29 Jan 2004 19:47:57 +0000
Subject: Re: [PATCH] removing interruptible_sleep_on in
Message-Id: <20040129114757.3c7396b0.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1074055200.4990.37.camel@zorak>
In-Reply-To: <1074055200.4990.37.camel@zorak>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 13 Jan 2004 22:40:03 -0600
"Tom 'spot' Callaway" <tcallawa@redhat.com> wrote:

> Fedora Core 2's 2.6.1 kernel package is patching interruptible_sleep_on
> (and sleep_on) as deprecated. This causes 
> sparc64 to stop building, since it uses interruptible_sleep_on in
> arch/sparc64/kernel/power.c. I made a best effort to fix this in the
> attached patch, feedback is appreciated.

I did things slightly differently to make sure there were no
subtle races, this is what I'll push to Linus.

Thanks Tom.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1507  -> 1.1508 
#	arch/sparc64/kernel/power.c	1.14    -> 1.15   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/29	davem@cheetah.(none)	1.1508
# [SPARC64]: Remove interruptible_sleep_on() usage, with help from Tom Callaway.
# --------------------------------------------
#
diff -Nru a/arch/sparc64/kernel/power.c b/arch/sparc64/kernel/power.c
--- a/arch/sparc64/kernel/power.c	Thu Jan 29 11:47:21 2004
+++ b/arch/sparc64/kernel/power.c	Thu Jan 29 11:47:21 2004
@@ -69,18 +69,26 @@
 {
 	static char *envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
 	char *argv[] = { "/sbin/shutdown", "-h", "now", NULL };
+	DECLARE_WAITQUEUE(wait, current);
 
 	daemonize("powerd");
 
+	add_wait_queue(&powerd_wait, &wait);
 again:
-	while (button_pressed = 0) {
+	for (;;) {
+		set_task_state(current, TASK_INTERRUPTIBLE);
+		if (button_pressed)
+			break;
 		flush_signals(current);
-		interruptible_sleep_on(&powerd_wait);
+		schedule();
 	}
+	__set_current_state(TASK_RUNNING);
+	remove_wait_queue(&powerd_wait, &wait);
 
 	/* Ok, down we go... */
 	if (execve("/sbin/shutdown", argv, envp) < 0) {
 		printk("powerd: shutdown execution failed\n");
+		add_wait_queue(&powerd_wait, &wait);
 		button_pressed = 0;
 		goto again;
 	}

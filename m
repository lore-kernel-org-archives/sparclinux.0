From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Tue, 13 Jan 2004 16:47:16 +0000
Subject: [PATCH] removing interruptible_sleep_on in
Message-Id: <1074055200.4990.37.camel@zorak>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-KMPb3kOLTJOy0Qo1KofB"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-KMPb3kOLTJOy0Qo1KofB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Fedora Core 2's 2.6.1 kernel package is patching interruptible_sleep_on
(and sleep_on) as deprecated. This causes 
sparc64 to stop building, since it uses interruptible_sleep_on in
arch/sparc64/kernel/power.c. I made a best effort to fix this in the
attached patch, feedback is appreciated.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"The author's mathematical treatment of the conception of purpose is
novel and highly ingenious, but heretical and, so far as the present
social order is concerned, dangerous and potentially subversive. Not to
be published." -- Aldous Huxley's "Brave New World"

--=-KMPb3kOLTJOy0Qo1KofB
Content-Disposition: attachment; filename=linux-2.6.1-sparc64-powerdfix.patch
Content-Type: text/x-patch; name=linux-2.6.1-sparc64-powerdfix.patch; charset=
Content-Transfer-Encoding: 7bit

--- linux-2.6.1/arch/sparc64/kernel/power.c.BAD	2004-01-13 16:42:36.000000000 -0500
+++ linux-2.6.1/arch/sparc64/kernel/power.c	2004-01-13 17:00:35.000000000 -0500
@@ -69,13 +69,16 @@
 {
 	static char *envp[] = { "HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
 	char *argv[] = { "/sbin/shutdown", "-h", "now", NULL };
+	DECLARE_WAITQUEUE(wait, current);
+	add_wait_queue(&powerd_wait, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
 
 	daemonize("powerd");
 
 again:
 	while (button_pressed == 0) {
 		flush_signals(current);
-		interruptible_sleep_on(&powerd_wait);
+		schedule();
 	}
 
 	/* Ok, down we go... */
@@ -84,6 +87,8 @@
 		button_pressed = 0;
 		goto again;
 	}
+	remove_wait_queue(&powerd_wait, &wait);
+	set_current_state(TASK_RUNNING);
 	return 0;
 }
 

--=-KMPb3kOLTJOy0Qo1KofB--


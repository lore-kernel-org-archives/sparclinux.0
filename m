From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 04 Mar 2005 06:38:34 +0000
Subject: [PATCH 2.6] dump_stack for sparc
Message-Id: <1109918315.17038.92.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-iHJOk59K0+lPRtctrP9Q"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-iHJOk59K0+lPRtctrP9Q
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Bob Breuer wrote a patch to add dump_stack for sparc. Supposedly, this
was applied, but it doesn't exist in 2.6.11.

This is the same patch, rediffed against 2.6.11.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway: Red Hat Sales Engineer || GPG Fingerprint: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-iHJOk59K0+lPRtctrP9Q
Content-Disposition: attachment; filename=linux-2.6.11-sparc-dumpstack.patch
Content-Type: text/x-patch; name=linux-2.6.11-sparc-dumpstack.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.11/arch/sparc/kernel/process.c.BAD	2005-03-04 01:31:26.187937059 -0500
+++ linux-2.6.11/arch/sparc/kernel/process.c	2005-03-04 01:33:28.853289091 -0500
@@ -333,6 +333,17 @@ void show_stack(struct task_struct *tsk,
 	printk("\n");
 }
 
+void dump_stack(void)
+{
+	unsigned long *ksp;
+
+	__asm__ __volatile__("mov	%%fp, %0"
+			     : "=r" (ksp));
+	show_stack(current, ksp);
+}
+
+EXPORT_SYMBOL(dump_stack);
+
 /*
  * Note: sparc64 has a pretty intricated thread_saved_pc, check it out.
  */

--=-iHJOk59K0+lPRtctrP9Q--


From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 04 Mar 2005 04:24:29 +0000
Subject: [PATCH 2.6] Stop-A printk cleanup
Message-Id: <1109910269.17038.35.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-TuIORTSKOXTbdZ2ZKCfk"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-TuIORTSKOXTbdZ2ZKCfk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch is incredibly trivial, but it does resolve some of the user
confusion as to what "L1-A" actually is.

Clarify printk message to refer to Stop-A (L1-A).

Gentoo has a virtually identical patch in their kernel sources.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway: Red Hat Sales Engineer || GPG Fingerprint: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-TuIORTSKOXTbdZ2ZKCfk
Content-Disposition: attachment; filename=linux-2.6.11-sparc-stopafix.patch
Content-Type: text/x-patch; name=linux-2.6.11-sparc-stopafix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.11/kernel/panic.c.BAD	2005-03-03 23:20:53.794641827 -0500
+++ linux-2.6.11/kernel/panic.c	2005-03-03 23:21:38.598830555 -0500
@@ -105,9 +105,9 @@ NORET_TYPE void panic(const char * fmt, 
 #ifdef __sparc__
 	{
 		extern int stop_a_enabled;
-		/* Make sure the user can actually press L1-A */
+		/* Make sure the user can actually press Stop-A (L1-A) */
 		stop_a_enabled = 1;
-		printk(KERN_EMERG "Press L1-A to return to the boot prom\n");
+		printk(KERN_EMERG "Press Stop-A (L1-A) to return to the boot prom\n");
 	}
 #endif
 #if defined(CONFIG_ARCH_S390)

--=-TuIORTSKOXTbdZ2ZKCfk--


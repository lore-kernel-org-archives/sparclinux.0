From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 05 Jan 2004 22:06:24 +0000
Subject: [PATCH] add asm/setup.h placeholder files
Message-Id: <1073340384.22653.268.camel@zorak>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-KkMgq8OAi/SOH88ZxLCU"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-KkMgq8OAi/SOH88ZxLCU
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

In 2.6, Sparc and sparc64 are missing asm/setup.h, this patch just makes
placeholder files to allow mtd compilation. Yes, this is ugly, but 
this is what everyone else is doing (e.g asm-i386/setup.h).

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"The author's mathematical treatment of the conception of purpose is
novel and highly ingenious, but heretical and, so far as the present
social order is concerned, dangerous and potentially subversive. Not to
be published." -- Aldous Huxley's "Brave New World"

--=-KkMgq8OAi/SOH88ZxLCU
Content-Disposition: attachment; filename=linux-2.6.0-sparc-setuph.patch
Content-Type: text/x-patch; name=linux-2.6.0-sparc-setuph.patch; charset=
Content-Transfer-Encoding: 7bit

--- linux-2.6.0-test11/include/asm-sparc/setup.h.BAD	2003-12-17 20:42:27.000000000 -0500
+++ linux-2.6.0-test11/include/asm-sparc/setup.h	2003-12-17 20:42:09.000000000 -0500
@@ -0,0 +1,9 @@
+/*
+ *	Just a place holder. 
+ */
+
+#ifndef _SPARC_SETUP_H
+#define _SPARC_SETUP_H
+
+
+#endif /* _SPARC_SETUP_H */
--- linux-2.6.0-test11/include/asm-sparc64/setup.h.BAD	2003-12-17 20:42:33.000000000 -0500
+++ linux-2.6.0-test11/include/asm-sparc64/setup.h	2003-12-17 20:42:20.000000000 -0500
@@ -0,0 +1,9 @@
+/*
+ *	Just a place holder. 
+ */
+
+#ifndef _SPARC64_SETUP_H
+#define _SPARC64_SETUP_H
+
+
+#endif /* _SPARC64_SETUP_H */

--=-KkMgq8OAi/SOH88ZxLCU--


From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Wed, 25 Aug 2004 00:18:40 +0000
Subject: [PATCH 2.6] Keep sparc32 consistent
Message-Id: <1093393120.10698.11.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-qQrYy8BOqhF3b5AcLSte"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-qQrYy8BOqhF3b5AcLSte
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch changes the name of the sparc32 Kconfig menu from "General
Setup" to "General Machine Setup", to match the changes committed to
most other arches in 2.6.9-rc1.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
- Sir Winston Churchill

--=-qQrYy8BOqhF3b5AcLSte
Content-Disposition: attachment; filename=linux-2.6.9rc1-sparcKconfig.patch
Content-Type: text/x-patch; name=linux-2.6.9rc1-sparcKconfig.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.8/arch/sparc/Kconfig.BAD	2004-08-25 00:39:44.370385048 -0400
+++ linux-2.6.8/arch/sparc/Kconfig	2004-08-25 00:39:52.841097304 -0400
@@ -23,7 +23,7 @@
 
 source "init/Kconfig"
 
-menu "General setup"
+menu "General machine setup"
 
 config VT
 	bool

--=-qQrYy8BOqhF3b5AcLSte--


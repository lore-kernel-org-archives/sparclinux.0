From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Wed, 22 Dec 2004 15:59:35 +0000
Subject: [sparc64] rtc compile warning fix
Message-Id: <1103731175.3913.84.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-J7TJe9OjnrEOPMH1Hsjw"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-J7TJe9OjnrEOPMH1Hsjw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Wli's change to sbus/char/rtc.c (see: http://marc.theaimsgroup.com/?
l=linux-sparc&m=110362936306577&w=2) causes sparc64 to throw warnings.

This is fixed upstream for sparc32 by adding asm/io.h as an include in
asm/mostek.h. Doing the same for sparc64 resolves the warnings, so
here's the patch.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
- Sir Winston Churchill

--=-J7TJe9OjnrEOPMH1Hsjw
Content-Disposition: attachment; filename=linux-2.6.9-sparc64-mostek.patch
Content-Type: text/x-patch; name=linux-2.6.9-sparc64-mostek.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.9/include/asm-sparc64/mostek.h.BAD	2004-12-22 10:44:10.554754475 -0500
+++ linux-2.6.9/include/asm-sparc64/mostek.h	2004-12-22 10:44:14.821105891 -0500
@@ -9,6 +9,7 @@
 #define _SPARC64_MOSTEK_H
 
 #include <asm/idprom.h>
+#include <asm/io.h>
 
 /*       M48T02 Register Map (adapted from Sun NVRAM/Hostid FAQ)
  *

--=-J7TJe9OjnrEOPMH1Hsjw--


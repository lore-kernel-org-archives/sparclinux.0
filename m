From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Wed, 22 Dec 2004 05:38:37 +0000
Subject: [sparc32] [1/3] Floppy compile warning
Message-Id: <1103693917.3913.70.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-SvtyWau8c8OnGrM+uXYC"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-SvtyWau8c8OnGrM+uXYC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Squelch the floppy compile warning:

include/asm/floppy.h: In function `sun_fd_request_irq':
include/asm/floppy.h:276: warning: passing arg 2 of `request_fast_irq'
from incompatible pointer type

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora Linux Project Leader

"If you are going through hell, keep going."
- Sir Winston Churchill

--=-SvtyWau8c8OnGrM+uXYC
Content-Disposition: attachment; filename=linux-2.6.9-sparc-floppyfix.patch
Content-Type: text/x-patch; name=linux-2.6.9-sparc-floppyfix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.9/include/asm-sparc/floppy.h.BAD	2004-12-21 22:54:16.229076227 -0500
+++ linux-2.6.9/include/asm-sparc/floppy.h	2004-12-21 22:58:26.304059051 -0500
@@ -264,7 +264,7 @@ static __inline__ void sun_fd_enable_dma
 }
 
 /* Our low-level entry point in arch/sparc/kernel/entry.S */
-extern void floppy_hardint(int irq, void *unused, struct pt_regs *regs);
+extern irqreturn_t floppy_hardint(int irq, void *unused, struct pt_regs *regs);
 
 static int sun_fd_request_irq(void)
 {

--=-SvtyWau8c8OnGrM+uXYC--


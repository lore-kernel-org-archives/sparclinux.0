From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Mon, 05 Jan 2004 22:57:11 +0000
Subject: [PATCH] missing module_init & module_exit (a mystery?)
Message-Id: <1073343430.22653.318.camel@zorak>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-nu9WPXla9XLZrr6KTLl7"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-nu9WPXla9XLZrr6KTLl7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

When I tried to build drivers/media/dvb/ttusb-dec/ttusb_dec.c in the 2.6
kernel tree, it failed, because it couldn't find the definitions of
module_init and module_exit, found in linux/init.h.

Now, this puzzled me, because it should have failed for all arches. I
spent some time digging into it, and the best conclusion I can draw is
that its due to the following:

ttusb_dec.c includes linux/interrupt.h, which includes asm/hardirq.h. On
many of the architectures (h8300, i386, ia64, mips, ppc, sh, x86_64),
hardirq.h includes linux/irq.h, which includes asm/hw_irq.h. On a subset
of the previously listed architectures (i386, ia64, mips, x86_64),
asm/hw_irq.h includes linux/profile.h, which includes linux/init.h.

Sparc and sparc64 are missing the needed includes in asm/hw_irq.h and
asm/hardiq.h (in fact, hw_irq.h is a dummy include for both arches).

This explains why ttusb_dec.c (and drivers/mtd/chips/jedec_probe.c) were
missing the init.h definitions on sparc64, but built fine in the main
tree.

Now, the obvious fix is to add #include <linux/init.h> to ttusb_dec.c,
but if this is a recurring problem (dbus.c had it as well), then perhaps
we should complete the chain? Thoughts?

Patch for obvious fix is attached. Making a patch to fix the include
chain for sparc and sparc64 is trivial, but I want to make sure its a
good idea before I do it.

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"The author's mathematical treatment of the conception of purpose is
novel and highly ingenious, but heretical and, so far as the present
social order is concerned, dangerous and potentially subversive. Not to
be published." -- Aldous Huxley's "Brave New World"

--=-nu9WPXla9XLZrr6KTLl7
Content-Disposition: attachment; filename=linux-2.6.0-ttusbdecfix.patch
Content-Type: text/x-patch; name=linux-2.6.0-ttusbdecfix.patch; charset=
Content-Transfer-Encoding: 7bit

--- linux-2.6.0/drivers/media/dvb/ttusb-dec/ttusb_dec.c.BAD	2004-01-02 23:31:27.000000000 -0500
+++ linux-2.6.0/drivers/media/dvb/ttusb-dec/ttusb_dec.c	2004-01-02 23:31:40.000000000 -0500
@@ -29,6 +29,7 @@
 #include <linux/version.h>
 #include <linux/interrupt.h>
 #include <linux/firmware.h>
+#include <linux/init.h>
 
 #include "dmxdev.h"
 #include "dvb_demux.h"

--=-nu9WPXla9XLZrr6KTLl7--


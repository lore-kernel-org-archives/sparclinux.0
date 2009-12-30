From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Wed, 30 Dec 2009 08:58:39 +0000
Subject: [PATCH] SPARC: Simplify param.h by simply including
Message-Id: <alpine.LFD.2.00.0912300356540.13010@localhost>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  override the only difference, EXEC_PAGESIZE, then include the
generic version.

diff --git a/arch/sparc/include/asm/param.h b/arch/sparc/include/asm/param.h
index 9836d9a..0bc356b 100644
--- a/arch/sparc/include/asm/param.h
+++ b/arch/sparc/include/asm/param.h
@@ -1,22 +1,7 @@
 #ifndef _ASMSPARC_PARAM_H
 #define _ASMSPARC_PARAM_H

-#ifdef __KERNEL__
-# define HZ		CONFIG_HZ	/* Internal kernel timer frequency */
-# define USER_HZ	100	/* .. some user interfaces are in "ticks" */
-# define CLOCKS_PER_SEC (USER_HZ)
-#endif
-
-#ifndef HZ
-#define HZ 100
-#endif
-
 #define EXEC_PAGESIZE	8192    /* Thanks for sun4's we carry baggage... */
+#include <asm-generic/param.h>

-#ifndef NOGROUP
-#define NOGROUP		(-1)
-#endif
-
-#define MAXHOSTNAMELEN	64	/* max length of hostname */
-
-#endif
+#endif /* _ASMSPARC_PARAM_H */


rday
--

====================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

            Linux Consulting, Training and Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
====================================

From: David Miller <davem@davemloft.net>
Date: Sun, 29 Jul 2007 06:38:53 +0000
Subject: Re: new parport_pc BUG
Message-Id: <20070728.233853.48529582.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0707272224450.1678@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0707272224450.1678@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sat, 28 Jul 2007 22:23:09 -0700 (PDT)

> I'll deal with that build failure seperately.

Just a simple missing include, fixed thusly:

diff --git a/include/asm-sparc64/floppy.h b/include/asm-sparc64/floppy.h
index 4aa0925..1783239 100644
--- a/include/asm-sparc64/floppy.h
+++ b/include/asm-sparc64/floppy.h
@@ -1,7 +1,6 @@
-/* $Id: floppy.h,v 1.32 2001/10/26 17:59:36 davem Exp $
- * asm-sparc64/floppy.h: Sparc specific parts of the Floppy driver.
+/* floppy.h: Sparc specific parts of the Floppy driver.
  *
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
+ * Copyright (C) 1996, 2007 David S. Miller (davem@davemloft.net)
  * Copyright (C) 1997 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  *
  * Ultra/PCI support added: Sep 1997  Eddie C. Dost  (ecd@skynet.be)
@@ -11,6 +10,7 @@
 #define __ASM_SPARC64_FLOPPY_H
 
 #include <linux/init.h>
+#include <linux/pci.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>

From: David Dillow <dave@thedillows.org>
Date: Thu, 01 Jul 2004 04:15:33 +0000
Subject: dma_get_required_mask() breaks sparc64
Message-Id: <1088655333.2382.29.camel@ori.thedillows.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Building with the latest BK (as of 2200 EST) breaks sparc64 builds. This
may be related to the fact that I only enable SBUS and not PCI, but I
think it is more general.

The attached patch (untested, but compiling) seems to fix the issue,
though it may not be the proper place to add the include.

Dave



In file included from include/asm/sbus.h:10,
                 from include/asm/dma.h:15,
                 from include/linux/bootmem.h:8,
                 from init/main.c:30:
include/linux/dma-mapping.h: In function `dma_get_required_mask':
include/linux/dma-mapping.h:41: error: dereferencing pointer to
incomplete type

=== sbus.h 1.5 vs edited ==--- 1.5/include/asm-sparc64/sbus.h      2004-06-02 19:00:47 -04:00
+++ edited/include/asm-sparc64/sbus.h       2004-06-30 23:53:49 -04:00
@@ -7,6 +7,7 @@
 #ifndef _SPARC64_SBUS_H
 #define _SPARC64_SBUS_H
  
+#include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/ioport.h>
  


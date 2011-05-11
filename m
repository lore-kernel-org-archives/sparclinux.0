From: Jan Andersson <jan@gaisler.com>
Date: Wed, 11 May 2011 09:13:33 +0000
Subject: [PATCH] sparc: add {read,write}*_be routines
Message-Id: <1305105213-31675-1-git-send-email-jan@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch adds {read,write}*_be big endian memory access
routines to the io.h header used on SPARC32 and SPARC64.

Tested on SPARC32 (LEON)

Signed-off-by: Jan Andersson <jan@gaisler.com>
---
read/write_be are used in the USB layer to support big endian
host controllers, see drivers/usb/host/ehci.h.

PowerPC, MIPS and AVR32 have {read,write}*_be defined and by
also adding them to SPARC we no longer need to have an #ifdef
in the USB code to define them for SPARC_LEON, which is currently
done in usb-next.
---
 arch/sparc/include/asm/io.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/io.h b/arch/sparc/include/asm/io.h
index a34b299..f6902cf 100644
--- a/arch/sparc/include/asm/io.h
+++ b/arch/sparc/include/asm/io.h
@@ -5,4 +5,17 @@
 #else
 #include <asm/io_32.h>
 #endif
+
+/*
+ * Defines used for both SPARC32 and SPARC64
+ */
+
+/* Big endian versions of memory read/write routines */
+#define readb_be(__addr)	__raw_readb(__addr)
+#define readw_be(__addr)	__raw_readw(__addr)
+#define readl_be(__addr)	__raw_readl(__addr)
+#define writeb_be(__b, __addr)	__raw_writeb(__b, __addr)
+#define writel_be(__w, __addr)	__raw_writel(__w, __addr)
+#define writew_be(__l, __addr)	__raw_writew(__l, __addr)
+
 #endif
-- 
1.7.0.4


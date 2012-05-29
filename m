From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 29 May 2012 18:14:14 +0000
Subject: [PATCH 3/3] sparc: fix sparc64 build due to leon.h inclusion
Message-Id: <1338315254-3829-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> reported following error:
In file included from arch/sparc/kernel/prom_common.c:26:0:
arch/sparc/include/asm/leon.h:221:9: error: unknown type name 'irq_flow_handler_t'
arch/sparc/include/asm/leon.h:224:10: error: unknown type name 'irq_flow_handler_t'

Fix this by:
1) Avoid including leon.h in prom_commen.h (not needed)
2) Include irq.h in leon.h to avoid the missing symbol error

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/include/asm/leon.h   |    1 +
 arch/sparc/kernel/prom_common.c |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index ba46083..3375c62 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -213,6 +213,7 @@ struct leon3_cacheregs {
 	unsigned long dccr;	/* 0x0c - Data Cache Configuration Register */
 };
 
+#include <linux/irq.h>
 #include <linux/interrupt.h>
 
 struct device_node;
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index 741df91..1303021 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -23,7 +23,6 @@
 #include <linux/of_pdt.h>
 #include <asm/prom.h>
 #include <asm/oplib.h>
-#include <asm/leon.h>
 
 #include "prom.h"
 
-- 
1.6.0.6


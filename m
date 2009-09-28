From: akpm@linux-foundation.org
Date: Mon, 28 Sep 2009 22:55:22 +0000
Subject: [patch 1/1] sparc32: convert to asm-generic/hardirq.h
Message-Id: <200909282255.n8SMtMaa015542@imap1.linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
In-Reply-To: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

[akpm@linux-foundation.org: /arch/sparc/include/asm/irq_32.h: move NR_IRQS definition]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/sparc/include/asm/hardirq_32.h |   12 +-----------
 arch/sparc/include/asm/irq_32.h     |    4 ++--
 2 files changed, 3 insertions(+), 13 deletions(-)

diff -puN arch/sparc/include/asm/hardirq_32.h~sparc32-convert-to-asm-generic-hardirqh arch/sparc/include/asm/hardirq_32.h
--- a/arch/sparc/include/asm/hardirq_32.h~sparc32-convert-to-asm-generic-hardirqh
+++ a/arch/sparc/include/asm/hardirq_32.h
@@ -7,17 +7,7 @@
 #ifndef __SPARC_HARDIRQ_H
 #define __SPARC_HARDIRQ_H
 
-#include <linux/threads.h>
-#include <linux/spinlock.h>
-#include <linux/cache.h>
-
-/* entry.S is sensitive to the offsets of these fields */ /* XXX P3 Is it? */
-typedef struct {
-	unsigned int __softirq_pending;
-} ____cacheline_aligned irq_cpustat_t;
-
-#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
-
 #define HARDIRQ_BITS    8
+#include <asm-generic/hardirq.h>
 
 #endif /* __SPARC_HARDIRQ_H */
diff -puN arch/sparc/include/asm/irq_32.h~sparc32-convert-to-asm-generic-hardirqh arch/sparc/include/asm/irq_32.h
--- a/arch/sparc/include/asm/irq_32.h~sparc32-convert-to-asm-generic-hardirqh
+++ a/arch/sparc/include/asm/irq_32.h
@@ -6,10 +6,10 @@
 #ifndef _SPARC_IRQ_H
 #define _SPARC_IRQ_H
 
-#include <linux/interrupt.h>
-
 #define NR_IRQS    16
 
+#include <linux/interrupt.h>
+
 #define irq_canonicalize(irq)	(irq)
 
 extern void __init init_IRQ(void);
_

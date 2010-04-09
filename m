From: David Miller <davem@davemloft.net>
Date: Fri, 09 Apr 2010 23:01:37 +0000
Subject: [PATCH 2/4] sparc64: Implement local_irq_save_nmi() override.
Message-Id: <20100409.160137.48119461.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/irqflags_64.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/irqflags_64.h b/arch/sparc/include/asm/irqflags_64.h
index 8b49bf9..fa1e00e 100644
--- a/arch/sparc/include/asm/irqflags_64.h
+++ b/arch/sparc/include/asm/irqflags_64.h
@@ -49,6 +49,16 @@ static inline void raw_local_irq_disable(void)
 	);
 }
 
+static inline void raw_local_irq_disable_nmi(void)
+{
+	__asm__ __volatile__(
+		"wrpr	%0, %%pil"
+		: /* no outputs */
+		: "i" (PIL_NMI)
+		: "memory"
+	);
+}
+
 static inline void raw_local_irq_enable(void)
 {
 	__asm__ __volatile__(
@@ -83,9 +93,28 @@ static inline unsigned long __raw_local_irq_save(void)
 	return flags;
 }
 
+static inline unsigned long __raw_local_irq_save_nmi(void)
+{
+	unsigned long flags = __raw_local_save_flags();
+
+	raw_local_irq_disable_nmi();
+
+	return flags;
+}
+
 #define raw_local_irq_save(flags) \
 		do { (flags) = __raw_local_irq_save(); } while (0)
 
+#define raw_local_irq_save_nmi(flags) \
+		do { (flags) = __raw_local_irq_save_nmi(); } while (0)
+
+#define local_irq_save_nmi(flags) 			\
+	do {						\
+		 typecheck(unsigned long, flags);	\
+		 raw_local_irq_save_nmi(flags);		\
+		 trace_hardirqs_off();			\
+	} while (0)
+
 #endif /* (__ASSEMBLY__) */
 
 #endif /* !(_ASM_IRQFLAGS_H) */
-- 
1.7.0.4


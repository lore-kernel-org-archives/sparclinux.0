From: David Miller <davem@davemloft.net>
Date: Fri, 18 Mar 2011 22:04:35 +0000
Subject: [PATCH] sparc: Provide NO_IRQ definition.
Message-Id: <20110318.150435.241941372.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/irq_32.h |    3 +++
 arch/sparc/include/asm/irq_64.h |    2 ++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/irq_32.h b/arch/sparc/include/asm/irq_32.h
index cbf4801..eced3e3 100644
--- a/arch/sparc/include/asm/irq_32.h
+++ b/arch/sparc/include/asm/irq_32.h
@@ -13,4 +13,7 @@
 #define irq_canonicalize(irq)	(irq)
 
 extern void __init init_IRQ(void);
+
+#define NO_IRQ		0xffffffff
+
 #endif
diff --git a/arch/sparc/include/asm/irq_64.h b/arch/sparc/include/asm/irq_64.h
index 4f09666f..16dcae6d 100644
--- a/arch/sparc/include/asm/irq_64.h
+++ b/arch/sparc/include/asm/irq_64.h
@@ -97,4 +97,6 @@ extern void *softirq_stack[NR_CPUS];
 #define __ARCH_HAS_DO_SOFTIRQ
 #define ARCH_HAS_NMI_WATCHDOG
 
+#define NO_IRQ		0xffffffff
+
 #endif
-- 
1.7.4.1


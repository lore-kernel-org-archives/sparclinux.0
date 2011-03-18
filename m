From: David Miller <davem@davemloft.net>
Date: Fri, 18 Mar 2011 21:54:43 +0000
Subject: [PATCH] sparc: Implement irq_of_parse_and_map().
Message-Id: <20110318.145443.68116964.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Mostly this is to get allmodconfig builds going clean again.
Drivers using this interface aren't actually even possible
on sparc systems.

On sparc we pre-compute IRQ values, therefore the implementation
is simply to find the platform_device which matches the given
device node, then return the pre-computed IRQ value if the
requested index is in-range.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/irq_32.h |    3 +++
 arch/sparc/include/asm/irq_64.h |    2 ++
 arch/sparc/kernel/prom_common.c |   24 ++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 0 deletions(-)

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
diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_common.c
index ed25834..344feea 100644
--- a/arch/sparc/kernel/prom_common.c
+++ b/arch/sparc/kernel/prom_common.c
@@ -21,6 +21,9 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_pdt.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
 #include <asm/prom.h>
 #include <asm/oplib.h>
 #include <asm/leon.h>
@@ -118,6 +121,27 @@ int of_find_in_proplist(const char *list, const char *match, int len)
 }
 EXPORT_SYMBOL(of_find_in_proplist);
 
+static int match_by_dev_node(struct device *dev, void *data)
+{
+	return dev->of_node = data;
+}
+
+unsigned int irq_of_parse_and_map(struct device_node *dev, int index)
+{
+	struct platform_device *p;
+	struct device *d;
+
+	d = bus_find_device(&platform_bus_type, NULL, dev,
+			    match_by_dev_node);
+	if (!d)
+		return NO_IRQ;
+	p = to_platform_device(d);
+	if (index >= p->archdata.num_irqs)
+		return NO_IRQ;
+	return p->archdata.irqs[index];
+}
+EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
+
 /*
  * SPARC32 and SPARC64's prom_nextprop() do things differently
  * here, despite sharing the same interface.  SPARC32 doesn't fill in 'buf',
-- 
1.7.4.1


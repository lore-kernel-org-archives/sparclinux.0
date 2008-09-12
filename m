From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:48:57 +0000
Subject: [PATCH 10/16]: sparc64: Fix sparse warnings in pci.c
Message-Id: <20080912.144857.18434896.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Fix sparse warnings in pci.c

1) Declare pci_poke_* in pci_impl.h
2) of_create_pci_dev() should be static
3) ->setup_msi_irq() wants an unsigned int pointer not a plain
   int one
4) void value expression return in arch_teardown_msi_irq()

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci.c      |   14 ++++++--------
 arch/sparc64/kernel/pci_impl.h |    4 ++++
 arch/sparc64/kernel/traps.c    |    5 +----
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/sparc64/kernel/pci.c b/arch/sparc64/kernel/pci.c
index c6e81de..e12a058 100644
--- a/arch/sparc64/kernel/pci.c
+++ b/arch/sparc64/kernel/pci.c
@@ -242,9 +242,9 @@ static void pci_parse_of_addrs(struct of_device *op,
 	}
 }
 
-struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
-				  struct device_node *node,
-				  struct pci_bus *bus, int devfn)
+static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
+					 struct device_node *node,
+					 struct pci_bus *bus, int devfn)
 {
 	struct dev_archdata *sd;
 	struct of_device *op;
@@ -998,7 +998,7 @@ EXPORT_SYMBOL(pci_domain_nr);
 int arch_setup_msi_irq(struct pci_dev *pdev, struct msi_desc *desc)
 {
 	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
-	int virt_irq;
+	unsigned int virt_irq;
 
 	if (!pbm->setup_msi_irq)
 		return -EINVAL;
@@ -1012,10 +1012,8 @@ void arch_teardown_msi_irq(unsigned int virt_irq)
 	struct pci_dev *pdev = entry->dev;
 	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
 
-	if (!pbm->teardown_msi_irq)
-		return;
-
-	return pbm->teardown_msi_irq(virt_irq, pdev);
+	if (pbm->teardown_msi_irq)
+		pbm->teardown_msi_irq(virt_irq, pdev);
 }
 #endif /* !(CONFIG_PCI_MSI) */
 
diff --git a/arch/sparc64/kernel/pci_impl.h b/arch/sparc64/kernel/pci_impl.h
index b300f39..0318682 100644
--- a/arch/sparc64/kernel/pci_impl.h
+++ b/arch/sparc64/kernel/pci_impl.h
@@ -178,4 +178,8 @@ extern void pci_config_write32(u32 *addr, u32 val);
 extern struct pci_ops sun4u_pci_ops;
 extern struct pci_ops sun4v_pci_ops;
 
+extern volatile int pci_poke_in_progress;
+extern volatile int pci_poke_cpu;
+extern volatile int pci_poke_faulted;
+
 #endif /* !(PCI_IMPL_H) */
diff --git a/arch/sparc64/kernel/traps.c b/arch/sparc64/kernel/traps.c
index 9378896..342da21 100644
--- a/arch/sparc64/kernel/traps.c
+++ b/arch/sparc64/kernel/traps.c
@@ -341,10 +341,7 @@ void sun4v_data_access_exception_tl1(struct pt_regs *regs, unsigned long addr, u
 }
 
 #ifdef CONFIG_PCI
-/* This is really pathetic... */
-extern volatile int pci_poke_in_progress;
-extern volatile int pci_poke_cpu;
-extern volatile int pci_poke_faulted;
+#include "pci_impl.h"
 #endif
 
 /* When access exceptions happen, we must do this. */
-- 
1.5.6.5.GIT


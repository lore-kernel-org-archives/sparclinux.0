From: David Miller <davem@davemloft.net>
Date: Tue, 02 Sep 2008 02:07:09 +0000
Subject: [PATCH 1/2]: sparc64: Kill the scan_bus function pointer in struct
Message-Id: <20080901.190709.31328398.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Kill the scan_bus function pointer in struct pci_pbm_info.

No longer used.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/kernel/pci_impl.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc64/kernel/pci_impl.h b/arch/sparc64/kernel/pci_impl.h
index c385d12..4125f75 100644
--- a/arch/sparc64/kernel/pci_impl.h
+++ b/arch/sparc64/kernel/pci_impl.h
@@ -146,7 +146,6 @@ struct pci_pbm_info {
 	unsigned int			pci_first_busno;
 	unsigned int			pci_last_busno;
 	struct pci_bus			*pci_bus;
-	void (*scan_bus)(struct pci_pbm_info *);
 	struct pci_ops			*pci_ops;
 
 	int				numa_node;
@@ -164,7 +163,8 @@ extern int pci_num_pbms;
 
 /* PCI bus scanning and fixup support. */
 extern void pci_get_pbm_props(struct pci_pbm_info *pbm);
-extern struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm);
+extern struct pci_bus *pci_scan_one_pbm(struct pci_pbm_info *pbm,
+					struct device *parent);
 extern void pci_determine_mem_io_space(struct pci_pbm_info *pbm);
 
 /* Error reporting support. */
-- 
1.5.6.5.GIT


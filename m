From: Adrian Bunk <bunk@kernel.org>
Date: Wed, 30 Jan 2008 20:03:24 +0000
Subject: [2.6 patch] sparc64/kernel/pci_sun4v.c section fixes
Message-Id: <20080130200324.GJ29368@does.not.exist>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

This patch fixes the following section mismatch:

<--  snip  -->

...
WARNING: vmlinux.o(.text+0x39be4): Section mismatch in reference from the function probe_existing_entries() to the function .init.text:page_in_phys_avail()
...

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/sparc64/kernel/pci_sun4v.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

5a836480057dcc064ae02a69ae4bb2b7698e333f 
diff --git a/arch/sparc64/kernel/pci_sun4v.c b/arch/sparc64/kernel/pci_sun4v.c
index 1aa8e04..87c5cf5 100644
--- a/arch/sparc64/kernel/pci_sun4v.c
+++ b/arch/sparc64/kernel/pci_sun4v.c
@@ -625,8 +625,8 @@ static void __init pci_sun4v_scan_bus(struct pci_pbm_info *pbm)
 	/* XXX register error interrupt handlers XXX */
 }
 
-static unsigned long probe_existing_entries(struct pci_pbm_info *pbm,
-					    struct iommu *iommu)
+static unsigned long __init probe_existing_entries(struct pci_pbm_info *pbm,
+						   struct iommu *iommu)
 {
 	struct iommu_arena *arena = &iommu->arena;
 	unsigned long i, cnt = 0;
@@ -653,7 +653,7 @@ static unsigned long probe_existing_entries(struct pci_pbm_info *pbm,
 	return cnt;
 }
 
-static void pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
+static void __init pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
 {
 	struct iommu *iommu = pbm->iommu;
 	struct property *prop;


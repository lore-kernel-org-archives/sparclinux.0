From: Peter Senna Tschudin <peter.senna@gmail.com>
Date: Wed, 12 Sep 2012 17:03:11 +0000
Subject: [PATCH 5/15] arch/sparc/kernel/pci_sun4v.c: removes unnecessary semicolon
Message-Id: <1347469402-27557-4-git-send-email-peter.senna@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: trivial@kernel.org, kernel-janitors@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Peter Senna Tschudin <peter.senna@gmail.com>

removes unnecessary semicolon

Found by Coccinelle: http://coccinelle.lip6.fr/

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>

---
 arch/sparc/kernel/pci_sun4v.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 7661e84..051b69c 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -594,7 +594,7 @@ static int __devinit pci_sun4v_iommu_init(struct pci_pbm_info *pbm)
 		printk(KERN_ERR PFX "Strange virtual-dma[%08x:%08x].\n",
 		       vdma[0], vdma[1]);
 		return -EINVAL;
-	};
+	}
 
 	dma_mask = (roundup_pow_of_two(vdma[1]) - 1UL);
 	num_tsb_entries = vdma[1] / IO_PAGE_SIZE;


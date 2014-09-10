From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 10 Sep 2014 12:17:52 +0000
Subject: [PATCH v3] sparc32: dma_alloc_coherent must honour gfp flags
Message-Id: <1410351472-10501-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

dma_zalloc_coherent() calls dma_alloc_coherent(__GFP_ZERO)
but the sparc32 implementations sbus_alloc_coherent() and
pci32_alloc_coherent() doesn't take the gfp flags into
account.

Tested on the SPARC32/LEON GRETH Ethernet driver which fails
due to dma_alloc_coherent(__GFP_ZERO) returns non zeroed
pages.

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/ioport.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/ioport.c b/arch/sparc/kernel/ioport.c
index 2096468..6cacf2d 100644
--- a/arch/sparc/kernel/ioport.c
+++ b/arch/sparc/kernel/ioport.c
@@ -278,7 +278,8 @@ static void *sbus_alloc_coherent(struct device *dev, size_t len,
 	}
 
 	order = get_order(len_total);
-	if ((va = __get_free_pages(GFP_KERNEL|__GFP_COMP, order)) = 0)
+	va = __get_free_pages(gfp, order);
+	if (va = 0)
 		goto err_nopages;
 
 	if ((res = kzalloc(sizeof(struct resource), GFP_KERNEL)) = NULL)
@@ -443,7 +444,7 @@ static void *pci32_alloc_coherent(struct device *dev, size_t len,
 	}
 
 	order = get_order(len_total);
-	va = (void *) __get_free_pages(GFP_KERNEL, order);
+	va = (void *) __get_free_pages(gfp, order);
 	if (va = NULL) {
 		printk("pci_alloc_consistent: no %ld pages\n", len_total>>PAGE_SHIFT);
 		goto err_nopages;
-- 
1.7.0.4


From: Julia Lawall <julia@diku.dk>
Date: Sun, 01 Aug 2010 09:09:44 +0000
Subject: [PATCH] arch/sparc/mm: Use GFP_KERNEL
Message-Id: <Pine.LNX.4.64.1008011109260.21594@ask.diku.dk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

GFP_ATOMIC is not needed here, as evidenced by the other two uses of
GFP_KERNEL in the same function.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@ identifier f; @@

*f(...,GFP_ATOMIC,...)
... when != spin_unlock(...)
    when != read_unlock(...)
    when != write_unlock(...)
    when != read_unlock_irq(...)
    when != write_unlock_irq(...)
    when != read_unlock_irqrestore(...)
    when != write_unlock_irqrestore(...)
    when != spin_unlock_irq(...)
    when != spin_unlock_irqrestore(...)
*f(...,GFP_KERNEL,...)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/sparc/mm/iommu.c               |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index 7385806..07fc6a6 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -63,7 +63,7 @@ static void __init sbus_iommu_init(struct platform_device *op)
 	unsigned long *bitmap;
 	unsigned long tmp;
 
-	iommu = kmalloc(sizeof(struct iommu_struct), GFP_ATOMIC);
+	iommu = kmalloc(sizeof(struct iommu_struct), GFP_KERNEL);
 	if (!iommu) {
 		prom_printf("Unable to allocate iommu structure\n");
 		prom_halt();

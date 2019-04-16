From: Christoph Hellwig <hch@lst.de>
Date: Tue, 16 Apr 2019 18:23:39 +0000
Subject: [PATCH 1/9] sparc/iommu: use !PageHighMem to check if a page has a kernel mapping
Message-Id: <20190416182347.18441-2-hch@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20190416182347.18441-1-hch@lst.de>
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

This deobsfucates the check a bit, and prepares for future changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/mm/iommu.c b/arch/sparc/mm/iommu.c
index e8d5d73ca40d..dcdadac03fdf 100644
--- a/arch/sparc/mm/iommu.c
+++ b/arch/sparc/mm/iommu.c
@@ -273,7 +273,8 @@ static int sbus_iommu_map_sg_pflush(struct device *dev, struct scatterlist *sgl,
 		 * XXX Is this a good assumption?
 		 * XXX What if someone else unmaps it here and races us?
 		 */
-		if ((page = (unsigned long) page_address(sg_page(sg))) != 0) {
+		if (!PageHighMem(sg_page(sg))) {
+			page = (unsigned long)page_address(sg_page(sg));
 			for (i = 0; i < n; i++) {
 				if (page != oldpage) {	/* Already flushed? */
 					flush_page_for_dma(page);
-- 
2.20.1

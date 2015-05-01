From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Fri, 01 May 2015 13:56:42 +0000
Subject: [PATCH v2 09/10] sparc: use for_each_sg()
Message-Id: <1430488603-11055-9-git-send-email-akinobu.mita@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1430488603-11055-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

This replaces the plain loop over the sglist array with for_each_sg()
macro which consists of sg_next() function calls.  Since sparc does
select ARCH_HAS_SG_CHAIN, it is necessary to use for_each_sg() in
order to loop over each sg element.  This also help find problems with
drivers that do not properly initialize their sg tables when
CONFIG_DEBUG_SG is enabled.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: linux-arch@vger.kernel.org
---
* New patch from v2

 arch/sparc/kernel/ldc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/ldc.c b/arch/sparc/kernel/ldc.c
index 7d3ca30..1ae5eb1 100644
--- a/arch/sparc/kernel/ldc.c
+++ b/arch/sparc/kernel/ldc.c
@@ -2086,6 +2086,7 @@ int ldc_map_sg(struct ldc_channel *lp,
 	struct cookie_state state;
 	struct ldc_iommu *iommu;
 	int err;
+	struct scatterlist *s;
 
 	if (map_perm & ~LDC_MAP_ALL)
 		return -EINVAL;
@@ -2112,9 +2113,10 @@ int ldc_map_sg(struct ldc_channel *lp,
 	state.pte_idx = (base - iommu->page_table);
 	state.nc = 0;
 
-	for (i = 0; i < num_sg; i++)
-		fill_cookies(&state, page_to_pfn(sg_page(&sg[i])) << PAGE_SHIFT,
-			     sg[i].offset, sg[i].length);
+	for_each_sg(sg, s, num_sg, i) {
+		fill_cookies(&state, page_to_pfn(sg_page(s)) << PAGE_SHIFT,
+			     s->offset, s->length);
+	}
 
 	return state.nc;
 }
-- 
1.9.1


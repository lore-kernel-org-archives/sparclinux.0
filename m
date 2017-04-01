From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 01 Apr 2017 20:47:44 +0000
Subject: [PATCH] sparc32: Export vac_cache_size to fix build error
Message-Id: <1491079664-12615-1-git-send-email-linux@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Doug Ledford <dledford@redhat.com>

sparc32:allmodconfig fails to build with the following error.

ERROR: "vac_cache_size" [drivers/infiniband/sw/rxe/rdma_rxe.ko] undefined!

Fixes: cb8864559631 ("infiniband: Fix alignment of mmap cookies ...")
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Doug Ledford <dledford@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/mm/srmmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index def82f6d626f..8e76ebba2986 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -54,6 +54,7 @@
 enum mbus_module srmmu_modtype;
 static unsigned int hwbug_bitmask;
 int vac_cache_size;
+EXPORT_SYMBOL(vac_cache_size);
 int vac_line_size;
 
 extern struct resource sparc_iomap;
-- 
2.7.4


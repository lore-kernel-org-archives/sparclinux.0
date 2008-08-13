From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 13 Aug 2008 00:33:15 +0000
Subject: [PATCH] sparc: remove include of linux/of_device.h from
Message-Id: <20080813103315.7b4dcf8a.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Now that all the direct includes of asm/of_device.h are gone, this is
safe to do.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/include/asm/of_device.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/of_device.h b/arch/sparc/include/asm/of_device.h
index e5f5aed..bba777a 100644
--- a/arch/sparc/include/asm/of_device.h
+++ b/arch/sparc/include/asm/of_device.h
@@ -30,8 +30,7 @@ struct of_device
 extern void __iomem *of_ioremap(struct resource *res, unsigned long offset, unsigned long size, char *name);
 extern void of_iounmap(struct resource *res, void __iomem *base, unsigned long size);
 
-/* These are just here during the transition */
-#include <linux/of_device.h>
+/* This is just here during the transition */
 #include <linux/of_platform.h>
 
 #endif /* __KERNEL__ */
-- 
1.5.6.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

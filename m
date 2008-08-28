From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 04:25:01 +0000
Subject: [PATCH 41/49]: sparc32: Kill sbus_is_slave().
Message-Id: <20080827.212501.153931407.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc32: Kill sbus_is_slave().

Unused.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/sbus_32.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/asm/sbus_32.h b/arch/sparc/include/asm/sbus_32.h
index 99f79e4..d960f3e 100644
--- a/arch/sparc/include/asm/sbus_32.h
+++ b/arch/sparc/include/asm/sbus_32.h
@@ -41,13 +41,6 @@ struct sbus_bus {
 };
 #define to_sbus(d) container_of(d, struct sbus_bus, ofdev.dev)
 
-static inline int
-sbus_is_slave(struct sbus_dev *dev)
-{
-	/* XXX Have to write this for sun4c's */
-	return 0;
-}
-
 /* These yield IOMMU mappings in consistent mode. */
 void prom_adjust_ranges(struct linux_prom_ranges *, int,
 			struct linux_prom_ranges *, int);
-- 
1.5.6.5.GIT


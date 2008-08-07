From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 07 Aug 2008 00:29:08 +0000
Subject: [PATCH] of/sparc: remove include of linux/of_platform.h from
Message-Id: <20080807102908.bd3a6697.sfr@canb.auug.org.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Now that we have removed all inclusions of asm/of_platform.h, this
compatability include can be removed.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/include/asm/of_platform.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/of_platform.h b/arch/sparc/include/asm/of_platform.h
index 93a262c..2348ab9 100644
--- a/arch/sparc/include/asm/of_platform.h
+++ b/arch/sparc/include/asm/of_platform.h
@@ -13,9 +13,6 @@
  *
  */
 
-/* This is just here during the transition */
-#include <linux/of_platform.h>
-
 extern struct bus_type ebus_bus_type;
 extern struct bus_type sbus_bus_type;
 
-- 
1.5.6.3

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

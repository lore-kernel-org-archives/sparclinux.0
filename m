From: Geliang Tang <geliangtang@gmail.com>
Date: Fri, 18 Nov 2016 14:21:17 +0000
Subject: [PATCH] sparc: drop duplicate header scatterlist.h
Message-Id: <7b5cc79d24d813a888ba5c229063418fa065d010.1479459310.git.geliangtang@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <319a5803aac795e175306d4978134f0247cf87bc.1479457751.git.geliangtang@gmail.com>
In-Reply-To: <319a5803aac795e175306d4978134f0247cf87bc.1479457751.git.geliangtang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Geliang Tang <geliangtang@gmail.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Drop duplicate header scatterlist.h from iommu_common.h.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 arch/sparc/kernel/iommu_common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/kernel/iommu_common.h b/arch/sparc/kernel/iommu_common.h
index b40cec2..8284933 100644
--- a/arch/sparc/kernel/iommu_common.h
+++ b/arch/sparc/kernel/iommu_common.h
@@ -13,7 +13,6 @@
 #include <linux/scatterlist.h>
 #include <linux/device.h>
 #include <linux/iommu-helper.h>
-#include <linux/scatterlist.h>
 
 #include <asm/iommu.h>
 
-- 
2.9.3


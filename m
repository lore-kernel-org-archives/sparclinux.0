From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 19 Mar 2013 15:58:47 +0000
Subject: [PATCH] sparc: remove unused "config BITS"
Message-Id: <1363708727.1390.16.camel@x61.thuisdomein>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

sparc's asm/module.h got removed in commit
786d35d45cc40b2a51a18f73e14e135d47fdced7 ("Make most arch asm/module.h
files use asm-generic/module.h"). That removed the only two uses of this
Kconfig symbol. So we can remove its entry too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Eyeball tested.

 arch/sparc/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 289127d..991abb2 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -84,12 +84,6 @@ config ARCH_DEFCONFIG
 	default "arch/sparc/configs/sparc32_defconfig" if SPARC32
 	default "arch/sparc/configs/sparc64_defconfig" if SPARC64
 
-# CONFIG_BITS can be used at source level to get 32/64 bits
-config BITS
-	int
-	default 32 if SPARC32
-	default 64 if SPARC64
-
 config IOMMU_HELPER
 	bool
 	default y if SPARC64
-- 
1.7.11.7


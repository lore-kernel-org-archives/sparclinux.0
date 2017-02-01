From: Bob Picco <bob.picco@oracle.com>
Date: Wed, 01 Feb 2017 12:38:23 +0000
Subject: [PATCH 3/3] sparc64: increase FORCE_MAX_ZONEORDER to 16
Message-Id: <20170201123823.6273-4-bob.picco@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: bob picco <bob.picco@oracle.com>

This change enables large tsb sizes of up to 256MB. The performance
improvement is substantial for those programs with an enormous tsb rss.

Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index cf4034c66362..55976119c7ca 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -318,7 +318,7 @@ config ARCH_SPARSEMEM_DEFAULT
 
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
-	default "13"
+	default "16"
 	help
 	  The kernel memory allocator divides physically contiguous memory
 	  blocks into "zones", where each zone is a power of two number of
-- 
2.11.0


From: Rob Gardner <rob.gardner@oracle.com>
Date: Fri, 07 Aug 2015 20:47:35 +0000
Subject: [PATCH] Fix incorrect ASI_ST_BLKINIT_MRU_S value
Message-Id: <1438980455-9214-1-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

ASI_ST_BLKINIT_MRU_S is incorrectly defined as 0xf2 when it
should be 0xf3 according to section 10.3.1 of the Sparc
Architecture manual.


Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
---
 arch/sparc/include/uapi/asm/asi.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/uapi/asm/asi.h b/arch/sparc/include/uapi/asm/asi.h
index aace6f3..7ad7203d 100644
--- a/arch/sparc/include/uapi/asm/asi.h
+++ b/arch/sparc/include/uapi/asm/asi.h
@@ -279,7 +279,7 @@
 				      * Most-Recently-Used, primary,
 				      * implicit
 				      */
-#define ASI_ST_BLKINIT_MRU_S	0xf2 /* (NG4) init-store, twin load,
+#define ASI_ST_BLKINIT_MRU_S	0xf3 /* (NG4) init-store, twin load,
 				      * Most-Recently-Used, secondary,
 				      * implicit
 				      */
-- 
1.7.9.5


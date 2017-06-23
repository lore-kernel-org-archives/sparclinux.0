From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 23 Jun 2017 18:58:33 +0000
Subject: [PATCH v2 05/12] sparc64: mdesc: use __GFP_REPEAT action modifier for VM allocation
Message-Id: <2e03b48fb618eb4a8a59efee3fe72aebb02ad7d7.1498238657.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

During MDESC handle allocation, use the __GFP_REPEAT flag instead of
__GFP_NOFAIL. If memory is not available, the caller expects a NULL
pointer instead of waiting until memory is allocated.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/kernel/mdesc.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 72aca73..f024969 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -205,12 +205,10 @@ static void __init mdesc_memblock_free(struct mdesc_handle *hp)
 	handle_size = (sizeof(struct mdesc_handle) -
 		       sizeof(struct mdesc_hdr) +
 		       mdesc_size);
+	base = kmalloc(handle_size + 15, GFP_KERNEL | __GFP_REPEAT);
+	if (!base)
+		return NULL;
 
-	/*
-	 * Allocation has to succeed because mdesc update would be missed
-	 * and such events are not retransmitted.
-	 */
-	base = kmalloc(handle_size + 15, GFP_KERNEL | __GFP_NOFAIL);
 	addr = (unsigned long)base;
 	addr = (addr + 15UL) & ~15UL;
 	hp = (struct mdesc_handle *) addr;
-- 
1.7.1


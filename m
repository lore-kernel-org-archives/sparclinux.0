From: Larry Bassel <larry.bassel@oracle.com>
Date: Wed, 21 Dec 2016 22:25:49 +0000
Subject: [PATCH] sparc64: fix mmap fixed and shared on sun4u
Message-Id: <1482359149-59788-1-git-send-email-larry.bassel@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Older sparc64 must have a VAC because there is concern that mmapping fixed
and shared with incorrect align would cause cache aliases. This is not an
issue for sun4v.

We will enforce the rigid alignment condition only for tlb_type != hypervisor.

Signed-off-by: Larry Bassel <larry.bassel@oracle.com>
Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/kernel/sys_sparc_64.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index fe8b8ee..43780b2 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -95,7 +95,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
 		 */
-		if ((flags & MAP_SHARED) &&
+		if ((flags & MAP_SHARED) && (tlb_type != hypervisor) &&
 		    ((addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1)))
 			return -EINVAL;
 		return addr;
@@ -159,7 +159,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 		/* We do not accept a shared mapping if it would violate
 		 * cache aliasing constraints.
 		 */
-		if ((flags & MAP_SHARED) &&
+		if ((flags & MAP_SHARED) && (tlb_type != hypervisor) &&
 		    ((addr - (pgoff << PAGE_SHIFT)) & (SHMLBA - 1)))
 			return -EINVAL;
 		return addr;
-- 
1.7.1


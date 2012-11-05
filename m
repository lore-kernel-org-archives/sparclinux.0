From: Michel Lespinasse <walken@google.com>
Date: Mon, 05 Nov 2012 22:47:12 +0000
Subject: [PATCH 15/16] mm: use vm_unmapped_area() on sparc32 architecture
Message-Id: <1352155633-8648-16-git-send-email-walken@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1352155633-8648-1-git-send-email-walken@google.com>
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Update the sparc32 arch_get_unmapped_area function to make use of
vm_unmapped_area() instead of implementing a brute force search.

Signed-off-by: Michel Lespinasse <walken@google.com>

---
 arch/sparc/kernel/sys_sparc_32.c |   24 +++++++++---------------
 1 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index 0c9b31b22e07..653899849b27 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -39,6 +39,7 @@ asmlinkage unsigned long sys_getpagesize(void)
 unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct * vmm;
+	struct vm_unmapped_area_info info;
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -56,21 +57,14 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	if (!addr)
 		addr = TASK_UNMAPPED_BASE;
 
-	if (flags & MAP_SHARED)
-		addr = COLOUR_ALIGN(addr);
-	else
-		addr = PAGE_ALIGN(addr);
-
-	for (vmm = find_vma(current->mm, addr); ; vmm = vmm->vm_next) {
-		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (TASK_SIZE - PAGE_SIZE - len < addr)
-			return -ENOMEM;
-		if (!vmm || addr + len <= vmm->vm_start)
-			return addr;
-		addr = vmm->vm_end;
-		if (flags & MAP_SHARED)
-			addr = COLOUR_ALIGN(addr);
-	}
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = addr;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = (flags & MAP_SHARED) ?
+		(PAGE_MASK & (SHMLBA - 1)) : 0;
+	info.align_offset = pgoff << PAGE_SHIFT;
+	return vm_unmapped_area(&info);
 }
 
 /*
-- 
1.7.7.3

From: Michel Lespinasse <walken@google.com>
Date: Mon, 05 Nov 2012 22:47:05 +0000
Subject: [PATCH 08/16] mm: use vm_unmapped_area() in hugetlbfs
Message-Id: <1352155633-8648-9-git-send-email-walken@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1352155633-8648-1-git-send-email-walken@google.com>
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Update the hugetlb_get_unmapped_area function to make use of
vm_unmapped_area() instead of implementing a brute force search.

Signed-off-by: Michel Lespinasse <walken@google.com>

---
 fs/hugetlbfs/inode.c |   42 ++++++++----------------------------------
 1 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index c5bc355d8243..14bc0c1fb4fb 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -151,8 +151,8 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long start_addr;
 	struct hstate *h = hstate_file(file);
+	struct vm_unmapped_area_info info;
 
 	if (len & ~huge_page_mask(h))
 		return -EINVAL;
@@ -173,39 +173,13 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 			return addr;
 	}
 
-	if (len > mm->cached_hole_size)
-		start_addr = mm->free_area_cache;
-	else {
-		start_addr = TASK_UNMAPPED_BASE;
-		mm->cached_hole_size = 0;
-	}
-
-full_search:
-	addr = ALIGN(start_addr, huge_page_size(h));
-
-	for (vma = find_vma(mm, addr); ; vma = vma->vm_next) {
-		/* At this point:  (!vma || addr < vma->vm_end). */
-		if (TASK_SIZE - len < addr) {
-			/*
-			 * Start a new search - just in case we missed
-			 * some holes.
-			 */
-			if (start_addr != TASK_UNMAPPED_BASE) {
-				start_addr = TASK_UNMAPPED_BASE;
-				mm->cached_hole_size = 0;
-				goto full_search;
-			}
-			return -ENOMEM;
-		}
-
-		if (!vma || addr + len <= vma->vm_start) {
-			mm->free_area_cache = addr + len;
-			return addr;
-		}
-		if (addr + mm->cached_hole_size < vma->vm_start)
-			mm->cached_hole_size = vma->vm_start - addr;
-		addr = ALIGN(vma->vm_end, huge_page_size(h));
-	}
+	info.flags = 0;
+	info.length = len;
+	info.low_limit = TASK_UNMAPPED_BASE;
+	info.high_limit = TASK_SIZE;
+	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
+	info.align_offset = 0;
+	return vm_unmapped_area(&info);
 }
 #endif
 
-- 
1.7.7.3

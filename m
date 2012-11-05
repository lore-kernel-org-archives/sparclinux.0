From: Michel Lespinasse <walken@google.com>
Date: Mon, 05 Nov 2012 22:47:00 +0000
Subject: [PATCH 03/16] mm: check rb_subtree_gap correctness
Message-Id: <1352155633-8648-4-git-send-email-walken@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1352155633-8648-1-git-send-email-walken@google.com>
In-Reply-To: <1352155633-8648-1-git-send-email-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

When CONFIG_DEBUG_VM_RB is enabled, check that rb_subtree_gap is
correctly set for every vma and that mm->highest_vm_end is also correct.

Also add an explicit 'bug' variable to track if browse_rb() detected any
invalid condition.

Signed-off-by: Michel Lespinasse <walken@google.com>
Reviewed-by: Rik van Riel <riel@redhat.com>

---
 mm/mmap.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2de8bcfe859d..769a09cc71af 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -365,7 +365,7 @@ static void vma_rb_erase(struct vm_area_struct *vma, struct rb_root *root)
 #ifdef CONFIG_DEBUG_VM_RB
 static int browse_rb(struct rb_root *root)
 {
-	int i = 0, j;
+	int i = 0, j, bug = 0;
 	struct rb_node *nd, *pn = NULL;
 	unsigned long prev = 0, pend = 0;
 
@@ -373,29 +373,33 @@ static int browse_rb(struct rb_root *root)
 		struct vm_area_struct *vma;
 		vma = rb_entry(nd, struct vm_area_struct, vm_rb);
 		if (vma->vm_start < prev)
-			printk("vm_start %lx prev %lx\n", vma->vm_start, prev), i = -1;
+			printk("vm_start %lx prev %lx\n", vma->vm_start, prev), bug = 1;
 		if (vma->vm_start < pend)
-			printk("vm_start %lx pend %lx\n", vma->vm_start, pend);
+			printk("vm_start %lx pend %lx\n", vma->vm_start, pend), bug = 1;
 		if (vma->vm_start > vma->vm_end)
-			printk("vm_end %lx < vm_start %lx\n", vma->vm_end, vma->vm_start);
+			printk("vm_end %lx < vm_start %lx\n", vma->vm_end, vma->vm_start), bug = 1;
+		if (vma->rb_subtree_gap != vma_compute_subtree_gap(vma))
+			printk("free gap %lx, correct %lx\n",
+			       vma->rb_subtree_gap,
+			       vma_compute_subtree_gap(vma)), bug = 1;
 		i++;
 		pn = nd;
 		prev = vma->vm_start;
 		pend = vma->vm_end;
 	}
 	j = 0;
-	for (nd = pn; nd; nd = rb_prev(nd)) {
+	for (nd = pn; nd; nd = rb_prev(nd))
 		j++;
-	}
 	if (i != j)
-		printk("backwards %d, forwards %d\n", j, i), i = 0;
-	return i;
+		printk("backwards %d, forwards %d\n", j, i), bug = 1;
+	return bug ? -1 : i;
 }
 
 void validate_mm(struct mm_struct *mm)
 {
 	int bug = 0;
 	int i = 0;
+	unsigned long highest_address = 0;
 	struct vm_area_struct *vma = mm->mmap;
 	while (vma) {
 		struct anon_vma_chain *avc;
@@ -403,11 +407,15 @@ void validate_mm(struct mm_struct *mm)
 		list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 			anon_vma_interval_tree_verify(avc);
 		anon_vma_unlock(vma->anon_vma);
+		highest_address = vma->vm_end;
 		vma = vma->vm_next;
 		i++;
 	}
 	if (i != mm->map_count)
 		printk("map_count %d vm_next %d\n", mm->map_count, i), bug = 1;
+	if (highest_address != mm->highest_vm_end)
+		printk("mm->highest_vm_end %lx, found %lx\n",
+		       mm->highest_vm_end, highest_address), bug = 1;
 	i = browse_rb(&mm->mm_rb);
 	if (i != mm->map_count)
 		printk("map_count %d rb %d\n", mm->map_count, i), bug = 1;
-- 
1.7.7.3

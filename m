From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 16 Dec 2016 18:35:33 +0000
Subject: [RFC PATCH 10/14] mm: add shared context to vm_area_struct
Message-Id: <1481913337-9331-11-git-send-email-mike.kravetz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1481913337-9331-1-git-send-email-mike.kravetz@oracle.com>
In-Reply-To: <1481913337-9331-1-git-send-email-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Bob Picco <bob.picco@oracle.com>, Nitin Gupta <nitin.m.gupta@oracle.com>, Vijay Kumar <vijay.ac.kumar@oracle.com>, Julian Calaby <julian.calaby@gmail.com>, Adam Buchbinder <adam.buchbinder@gmail.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Mike Kravetz <mike.kravetz@oracle.com>

Shared context usage is reflected in a vm area (vma).  To handle this,
a new flag (VM_SHARED_CTX) is added anlng with a pointer to a shared
context structure (vm_shared_mmu_ctx).

This commit does not contain the method by which a vma is marked for
shared context.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 include/linux/mm.h       |  1 +
 include/linux/mm_types.h | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a92c8d7..9d82028 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -182,6 +182,7 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 #define VM_NORESERVE	0x00200000	/* should the VM suppress accounting */
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
+#define VM_SHARED_CTX	0x00800000	/* Shared TLB context */
 #define VM_ARCH_1	0x01000000	/* Architecture-specific flag */
 #define VM_ARCH_2	0x02000000
 #define VM_DONTDUMP	0x04000000	/* Do not include in the core dump */
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 4a8aced..0c30d43 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -291,6 +291,18 @@ struct vm_userfaultfd_ctx {
 struct vm_userfaultfd_ctx {};
 #endif /* CONFIG_USERFAULTFD */
 
+#ifdef CONFIG_SHARED_MMU_CTX
+#define NULL_VM_SHARED_MMU_CTX ((struct vm_shared_mmu_ctx) { NULL, })
+struct vm_shared_mmu_ctx {
+	struct shared_mmu_ctx *ctx;
+};
+#define vma_shared_ctx_val(vma)					\
+	((vma)->vm_shared_mmu_ctx.ctx ?				\
+	 (vma)->vm_shared_mmu_ctx.ctx->shared_ctx_val : 0UL)
+#else /* CONFIG_SHARED__MMU_CTX */
+struct vm_shared_mmu_ctx {};
+#endif /* CONFIG_SHARED_MMU_CTX */
+
 /*
  * This struct defines a memory VMM memory area. There is one of these
  * per VM-area/task.  A VM area is any part of the process virtual memory
@@ -358,6 +370,7 @@ struct vm_area_struct {
 	struct mempolicy *vm_policy;	/* NUMA policy for the VMA */
 #endif
 	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
+	struct vm_shared_mmu_ctx vm_shared_mmu_ctx;
 };
 
 struct core_thread {
-- 
2.7.4


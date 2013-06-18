From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Tue, 18 Jun 2013 14:05:36 +0000
Subject: [PATCH] sparc: tsb must be flushed before tlb
Message-Id: <51C06930.3050800@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This fixes a race where a cpu may re-load a tlb from a stale tsb right
after it has been flushed by a remote function call.

I still see some instability when stressing the system with parallel
kernel builds while creating memory pressure by writing to
/proc/sys/vm/nr_hugepages, but this patch improves the stability
significantly.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Acked-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/mm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 83d89bc..37e7bc4 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -85,8 +85,8 @@ static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
 	}
 
 	if (!tb->active) {
-		global_flush_tlb_page(mm, vaddr);
 		flush_tsb_user_page(mm, vaddr);
+		global_flush_tlb_page(mm, vaddr);
 		goto out;
 	}
 
-- 
1.8.3.1


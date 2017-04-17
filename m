From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Mon, 17 Apr 2017 22:46:41 +0000
Subject: [PATCH] sparc64: Fix hugepage page table free
Message-Id: <1492469211-228826-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, Mike Kravetz <mike.kravetz@oracle.com>, Ingo Molnar <mingo@kernel.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Make sure the start adderess is aligned to PMD_SIZE
boundary when freeing page table backing a hugepage
region. The issue was causing segfaults when a region
backed by 64K pages was unmapped since such a region
is in general not PMD_SIZE aligned.

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/mm/hugetlbpage.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index ee5273a..7c29d38 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -461,6 +461,22 @@ void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 	pgd_t *pgd;
 	unsigned long next;
 
+	addr &= PMD_MASK;
+	if (addr < floor) {
+		addr += PMD_SIZE;
+		if (!addr)
+			return;
+	}
+	if (ceiling) {
+		ceiling &= PMD_MASK;
+		if (!ceiling)
+			return;
+	}
+	if (end - 1 > ceiling - 1)
+		end -= PMD_SIZE;
+	if (addr > end - 1)
+		return;
+
 	pgd = pgd_offset(tlb->mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
-- 
2.9.2


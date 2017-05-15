From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Mon, 15 May 2017 23:28:17 +0000
Subject: [PATCH] sparc64: Fix mapping of 64k pages with MAP_FIXED
Message-Id: <1494890909-247009-1-git-send-email-nitin.m.gupta@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Nitin Gupta <nitin.m.gupta@oracle.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

An incorrect huge page alignment check caused
mmap failure for 64K pages when MAP_FIXED is used
with address not aligned to HPAGE_SIZE.

Orabug: 25885991

Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
---
 arch/sparc/include/asm/hugetlb.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index dcbf985..d1f837d 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -24,9 +24,11 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 static inline int prepare_hugepage_range(struct file *file,
 			unsigned long addr, unsigned long len)
 {
-	if (len & ~HPAGE_MASK)
+	struct hstate *h = hstate_file(file);
+
+	if (len & ~huge_page_mask(h))
 		return -EINVAL;
-	if (addr & ~HPAGE_MASK)
+	if (addr & ~huge_page_mask(h))
 		return -EINVAL;
 	return 0;
 }
-- 
2.9.2


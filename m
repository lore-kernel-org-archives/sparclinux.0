From: Sasha Levin <sashal@kernel.org>
Date: Mon, 08 Jun 2020 23:05:16 +0000
Subject: [PATCH AUTOSEL 5.6 191/606] sparc32: fix page table traversal in srmmu_nocache_init()
Message-Id: <20200608231211.3363633-191-sashal@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Mike Rapoport <rppt@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Anatoly Pugachev <matorola@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sparclinux@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

commit 0cfc8a8d70dcd51db783e8e87917e02149c71458 upstream.

The srmmu_nocache_init() uses __nocache_fix() macro to add an offset to
page table entry to access srmmu_nocache_pool.

But since sparc32 has only three actual page table levels, pgd, p4d and
pud are essentially the same thing and pgd_offset() and p4d_offset() are
no-ops, the __nocache_fix() should be done only at PUD level.

Remove __nocache_fix() for p4d_offset() and pud_offset() and keep it
only for PUD and lower levels.

Fixes: c2bc26f7ca1f ("sparc32: use PUD rather than PGD to get PMD in srmmu_nocache_init()")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Anatoly Pugachev <matorola@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sparc/mm/srmmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 083ba02c94e6..80061bc93bdc 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -331,8 +331,8 @@ static void __init srmmu_nocache_init(void)
 
 	while (vaddr < srmmu_nocache_end) {
 		pgd = pgd_offset_k(vaddr);
-		p4d = p4d_offset(__nocache_fix(pgd), vaddr);
-		pud = pud_offset(__nocache_fix(p4d), vaddr);
+		p4d = p4d_offset(pgd, vaddr);
+		pud = pud_offset(p4d, vaddr);
 		pmd = pmd_offset(__nocache_fix(pud), vaddr);
 		pte = pte_offset_kernel(__nocache_fix(pmd), vaddr);
 
-- 
2.25.1

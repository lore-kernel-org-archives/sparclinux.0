From: Will Deacon <will@kernel.org>
Date: Tue, 14 Apr 2020 21:40:11 +0000
Subject: [RESEND PATCH 4/4] sparc32: mm: Reduce allocation size for PMD and PTE tables
Message-Id: <20200414214011.2699-5-will@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200414214011.2699-1-will@kernel.org>
In-Reply-To: <20200414214011.2699-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <ndesaulniers@google.com>, Matt Fleming <matt@codeblueprint.co.uk>, sparclinux@vger.kernel.org, kernel-team@android.com

Now that the page table allocator can free page table allocations
smaller than PAGE_SIZE, reduce the size of the PMD and PTE allocations
to avoid needlessly wasting memory.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/sparc/include/asm/pgtsrmmu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
index 58ea8e8c6ee7..7708d015712b 100644
--- a/arch/sparc/include/asm/pgtsrmmu.h
+++ b/arch/sparc/include/asm/pgtsrmmu.h
@@ -17,8 +17,8 @@
 /* Number of contexts is implementation-dependent; 64k is the most we support */
 #define SRMMU_MAX_CONTEXTS	65536
 
-#define SRMMU_PTE_TABLE_SIZE		(PAGE_SIZE)
-#define SRMMU_PMD_TABLE_SIZE		(PAGE_SIZE)
+#define SRMMU_PTE_TABLE_SIZE		(PTRS_PER_PTE*4)
+#define SRMMU_PMD_TABLE_SIZE		(PTRS_PER_PMD*4)
 #define SRMMU_PGD_TABLE_SIZE		(PTRS_PER_PGD*4)
 
 /* Definition of the values in the ET field of PTD's and PTE's */
-- 
2.26.0.110.g2183baf09c-goog

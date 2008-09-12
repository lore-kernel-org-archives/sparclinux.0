From: David Miller <davem@davemloft.net>
Date: Fri, 12 Sep 2008 21:49:36 +0000
Subject: [PATCH 13/16]: sparc64: Remove explicit initialization of
Message-Id: <20080912.144936.192761075.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Remove explicit initialization of mmu_gathers

This was just needed to work around an ancient gcc bug that
we don't care about any more.

It was also causing a sparse warnings:

arch/sparc64/mm/tlb.c:22:52: warning: Using plain integer as NULL pointer

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/mm/tlb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc64/mm/tlb.c b/arch/sparc64/mm/tlb.c
index ae24919..d8f21e2 100644
--- a/arch/sparc64/mm/tlb.c
+++ b/arch/sparc64/mm/tlb.c
@@ -19,7 +19,7 @@
 
 /* Heavily inspired by the ppc64 code.  */
 
-DEFINE_PER_CPU(struct mmu_gather, mmu_gathers) = { 0, };
+DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 void flush_tlb_pending(void)
 {
-- 
1.5.6.5.GIT


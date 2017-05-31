From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 31 May 2017 15:25:20 +0000
Subject: [v1 1/6] sparc64: reset mm cpumask after wrap
Message-Id: <1496244325-180257-2-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

After a wrap (getting a new context version) a process must get a new
context id, which means that we would need to flush the context id from
the TLB before running for the first time with this ID on every CPU. But,
we use mm_cpumask to determine if this process has been running on this CPU
before, and this mask is not reset after a wrap. So, there are two possible
fixes for this issue:

1. Clear mm cpumask whenever mm gets a new context id
2. Unconditionally flush context every time process is running on a CPU

This patch implements the first solution

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Bob Picco <bob.picco@oracle.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
---
 arch/sparc/mm/init_64.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 0cda653..e679b14 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -758,6 +758,8 @@ void get_new_mmu_context(struct mm_struct *mm)
 			goto out;
 		}
 	}
+	if (mm->context.sparc64_ctx_val)
+		cpumask_clear(mm_cpumask(mm));
 	mmu_context_bmap[new_ctx>>6] |= (1UL << (new_ctx & 63));
 	new_ctx |= (tlb_context_cache & CTX_VERSION_MASK);
 out:
-- 
1.7.1


From: Peter Xu <peterx@redhat.com>
Date: Tue, 07 Jul 2020 22:50:16 +0000
Subject: [PATCH v5 20/25] mm/sparc32: Use general page fault accounting
Message-Id: <20200707225021.200906-21-peterx@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200707225021.200906-1-peterx@redhat.com>
In-Reply-To: <20200707225021.200906-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, David Rientjes <rientjes@google.com>, John Hubbard <jhubbard@nvidia.com>, Michael Ellerman <mpe@ellerman.id.au>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

CC: David S. Miller <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sparc/mm/fault_32.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 06af03db4417..8071bfd72349 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -234,7 +234,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -250,15 +250,6 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	}
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			current->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ,
-				      1, regs, address);
-		} else {
-			current->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN,
-				      1, regs, address);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2

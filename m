From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 Jun 2020 16:13:48 +0000
Subject: [PATCH 21/26] mm/sparc64: Use general page fault accounting
Message-Id: <20200619161348.9811-1-peterx@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200619160538.8641-1-peterx@redhat.com>
In-Reply-To: <20200619160538.8641-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Peter Xu <peterx@redhat.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Linus Torvalds <torvalds@linux-foundation.org>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

CC: David S. Miller <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sparc/mm/fault_64.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 6b702a0a8155..fe8854d447ed 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -423,7 +423,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 			goto bad_area;
 	}
 
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (fault_signal_pending(fault, regs))
 		goto exit_exception;
@@ -439,15 +439,6 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
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

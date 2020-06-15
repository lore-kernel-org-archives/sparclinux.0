From: Peter Xu <peterx@redhat.com>
Date: Mon, 15 Jun 2020 22:23:16 +0000
Subject: [PATCH 21/25] mm/sparc32: Use mm_fault_accounting()
Message-Id: <20200615222316.8551-1-peterx@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200615221607.7764-1-peterx@redhat.com>
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Peter Xu <peterx@redhat.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Use the new mm_fault_accounting() helper for page fault accounting.

Avoid doing page fault accounting multiple times if the page fault is retried.

CC: David S. Miller <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sparc/mm/fault_32.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index f6e0e601f857..299e6e241a1c 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -167,7 +167,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	unsigned long g2;
 	int from_user = !(regs->psr & PSR_PS);
 	int code;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
 	if (text_fault)
@@ -192,9 +192,6 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 */
 	if (pagefault_disabled() || !mm)
 		goto no_context;
-
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-
 retry:
 	down_read(&mm->mmap_sem);
 
@@ -236,6 +233,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault_signal_pending(fault, regs))
 		return;
@@ -251,15 +249,6 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
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
 
@@ -273,6 +262,7 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
 	}
 
 	up_read(&mm->mmap_sem);
+	mm_fault_accounting(current, regs, address, major);
 	return;
 
 	/*
-- 
2.26.2

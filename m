From: Peter Xu <peterx@redhat.com>
Date: Mon, 15 Jun 2020 22:23:19 +0000
Subject: [PATCH 22/25] mm/sparc64: Use mm_fault_accounting()
Message-Id: <20200615222319.8601-1-peterx@redhat.com>
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
 arch/sparc/mm/fault_64.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index c0c0dd471b6b..61be0a0d79c6 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -269,7 +269,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	struct vm_area_struct *vma;
 	unsigned int insn = 0;
 	int si_code, fault_code;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 	unsigned long address, mm_rss;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
 
@@ -317,8 +317,6 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	if (faulthandler_disabled() || !mm)
 		goto intr_or_no_mm;
 
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
-
 	if (!down_read_trylock(&mm->mmap_sem)) {
 		if ((regs->tstate & TSTATE_PRIV) &&
 		    !search_exception_tables(regs->tpc)) {
@@ -424,6 +422,7 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	}
 
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 
 	if (fault_signal_pending(fault, regs))
 		goto exit_exception;
@@ -439,15 +438,6 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
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
 
@@ -461,6 +451,8 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	}
 	up_read(&mm->mmap_sem);
 
+	mm_fault_accounting(current, regs, address, major);
+
 	mm_rss = get_mm_rss(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE)
 	mm_rss -= (mm->context.thp_pte_count * (HPAGE_SIZE / PAGE_SIZE));
-- 
2.26.2

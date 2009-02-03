From: David Miller <davem@davemloft.net>
Date: Tue, 03 Feb 2009 06:09:08 +0000
Subject: [PATCH]: sparc64: Validate kernel generated fault addresses on
Message-Id: <20090202.220908.168045940.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I just committed the following debugging aid for sparc64.

--------------------

sparc64: Validate kernel generated fault addresses on sparc64.

In order to handle all of the cases of address calculation overflow
properly, we run sparc 32-bit processes in "address masking" mode
when running on a 64-bit kernel.

Address masking mode zeros out the top 32-bits of the address
calculated for every load and store instruction.

However, when we're in privileged mode we have to run with that
address masking mode disabled even when accessing userspace from
the kernel.

To "simulate" the address masking mode we clear the top-bits by
hand for 32-bit processes in the fault handler.

It is the responsibility of code in the compat layer to properly
zero extend addresses used to access userspace.  If this isn't
followed properly we can get into a fault loop.

Say that the user address is 0xf0000000 but for whatever reason
the kernel code sign extends this to 64-bit, and then the kernel
tries to access the result.

In such a case we'll fault on address 0xfffffffff0000000 but the fault
handler will process that fault as if it were to address 0xf0000000.
We'll loop faulting forever because the fault never gets satisfied.

So add a check specifically for this case, when the kernel is faulting
on a user address access and the addresses don't match up.

This code path is sufficiently slow path, and this bug is sufficiently
painful to diagnose, that this kind of bug check is warranted.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/fault_64.c |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index a9e474b..1a786ab 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
+#include <linux/percpu.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -244,8 +245,14 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	    (fault_code & FAULT_CODE_DTLB))
 		BUG();
 
+	if (test_thread_flag(TIF_32BIT)) {
+		if (!(regs->tstate & TSTATE_PRIV))
+			regs->tpc &= 0xffffffff;
+		address &= 0xffffffff;
+	}
+
 	if (regs->tstate & TSTATE_PRIV) {
-		unsigned long tpc = regs->tpc;
+		unsigned long eaddr, tpc = regs->tpc;
 
 		/* Sanity check the PC. */
 		if ((tpc >= KERNBASE && tpc < (unsigned long) __init_end) ||
@@ -255,6 +262,16 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 			bad_kernel_pc(regs, address);
 			return;
 		}
+
+		insn = get_fault_insn(regs, insn);
+		eaddr = compute_effective_address(regs, insn, 0);
+		if (WARN_ON_ONCE((eaddr & PAGE_MASK) != (address & PAGE_MASK))){
+			printk(KERN_ERR "FAULT: Mismatch kernel fault "
+			       "address: addr[%lx] eaddr[%lx] TPC[%lx]\n",
+			       address, eaddr, tpc);
+			show_regs(regs);
+			goto handle_kernel_fault;
+		}
 	}
 
 	/*
@@ -264,12 +281,6 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 	if (in_atomic() || !mm)
 		goto intr_or_no_mm;
 
-	if (test_thread_flag(TIF_32BIT)) {
-		if (!(regs->tstate & TSTATE_PRIV))
-			regs->tpc &= 0xffffffff;
-		address &= 0xffffffff;
-	}
-
 	if (!down_read_trylock(&mm->mmap_sem)) {
 		if ((regs->tstate & TSTATE_PRIV) &&
 		    !search_exception_tables(regs->tpc)) {
-- 
1.6.1.2.253.ga34a


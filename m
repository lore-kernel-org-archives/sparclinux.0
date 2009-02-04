From: David Miller <davem@davemloft.net>
Date: Wed, 04 Feb 2009 00:30:38 +0000
Subject: [PATCH]: sparc64: Kill bogus TPC/address truncation during 32-bit
Message-Id: <20090203.163038.141261513.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


After some more auditing and data mining, I checked in the
following patch which simplifies bug checks and removes bogus
address truncation done by the fault handler.

sparc64: Kill bogus TPC/address truncation during 32-bit faults.

This builds upon eeabac7386ca13bfe1a58afeb04326a9e1a3a20e
("sparc64: Validate kernel generated fault addresses on sparc64.")

Upon further consideration, we actually should never see any
fault addresses for 32-bit tasks with the upper 32-bits set.

If it does every happen, by definition it's a bug.  Whatever
context created that fault would only have that fault satisfied
if we used the full 64-bit address.  If we truncate it, we'll
always fault the wrong address and we'll always loop faulting
forever.

So catch such conditions and mark them as errors always.  Log
the error and fail the fault.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/fault_64.c |   49 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 1a786ab..4ab8993 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -225,6 +225,30 @@ cannot_handle:
 	unhandled_fault (address, current, regs);
 }
 
+static void noinline bogus_32bit_fault_tpc(struct pt_regs *regs)
+{
+	static int times;
+
+	if (times++ < 10)
+		printk(KERN_ERR "FAULT[%s:%d]: 32-bit process reports "
+		       "64-bit TPC [%lx]\n",
+		       current->comm, current->pid,
+		       regs->tpc);
+	show_regs(regs);
+}
+
+static void noinline bogus_32bit_fault_address(struct pt_regs *regs,
+					       unsigned long addr)
+{
+	static int times;
+
+	if (times++ < 10)
+		printk(KERN_ERR "FAULT[%s:%d]: 32-bit process "
+		       "reports 64-bit fault address [%lx]\n",
+		       current->comm, current->pid, addr);
+	show_regs(regs);
+}
+
 asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 {
 	struct mm_struct *mm = current->mm;
@@ -246,13 +270,20 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 		BUG();
 
 	if (test_thread_flag(TIF_32BIT)) {
-		if (!(regs->tstate & TSTATE_PRIV))
-			regs->tpc &= 0xffffffff;
-		address &= 0xffffffff;
+		if (!(regs->tstate & TSTATE_PRIV)) {
+			if (unlikely((regs->tpc >> 32) != 0)) {
+				bogus_32bit_fault_tpc(regs);
+				goto intr_or_no_mm;
+			}
+		}
+		if (unlikely((address >> 32) != 0)) {
+			bogus_32bit_fault_address(regs, address);
+			goto intr_or_no_mm;
+		}
 	}
 
 	if (regs->tstate & TSTATE_PRIV) {
-		unsigned long eaddr, tpc = regs->tpc;
+		unsigned long tpc = regs->tpc;
 
 		/* Sanity check the PC. */
 		if ((tpc >= KERNBASE && tpc < (unsigned long) __init_end) ||
@@ -262,16 +293,6 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 			bad_kernel_pc(regs, address);
 			return;
 		}
-
-		insn = get_fault_insn(regs, insn);
-		eaddr = compute_effective_address(regs, insn, 0);
-		if (WARN_ON_ONCE((eaddr & PAGE_MASK) != (address & PAGE_MASK))){
-			printk(KERN_ERR "FAULT: Mismatch kernel fault "
-			       "address: addr[%lx] eaddr[%lx] TPC[%lx]\n",
-			       address, eaddr, tpc);
-			show_regs(regs);
-			goto handle_kernel_fault;
-		}
 	}
 
 	/*
-- 
1.6.1.2.253.ga34a


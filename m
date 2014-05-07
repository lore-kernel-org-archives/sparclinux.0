From: David Miller <davem@davemloft.net>
Date: Wed, 07 May 2014 04:28:27 +0000
Subject: [PATCH] sparc64: Don't bark so loudly about 32-bit tasks generating 64-bit fault addresses.
Message-Id: <20140507.002827.797116082220962664.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This was found using Dave Jone's trinity tool.

When a user process which is 32-bit performs a load or a store, the
cpu chops off the top 32-bits of the effective address before
translating it.

This is because we run 32-bit tasks with the PSTATE_AM (address
masking) bit set.

We can't run the kernel with that bit set, so when the kernel accesses
userspace no address masking occurs.

Since a 32-bit process will have no mappings in that region we will
properly fault, so we don't try to handle this using access_ok(),
which can safely just be a NOP on sparc64.

Real faults from 32-bit processes should never generate such addresses
so a bug check was added long ago, and it barks in the logs if this
happens.

But it also barks when a kernel user access causes this condition, and
that _can_ happen.  For example, if a pointer passed into a system call
is "0xfffffffc" and the kernel access 4 bytes offset from that pointer.

Just handle such faults normally via the exception entries.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/fault_64.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index a8ff0d1..4ced3fc 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -281,18 +281,6 @@ static void noinline __kprobes bogus_32bit_fault_tpc(struct pt_regs *regs)
 	show_regs(regs);
 }
 
-static void noinline __kprobes bogus_32bit_fault_address(struct pt_regs *regs,
-							 unsigned long addr)
-{
-	static int times;
-
-	if (times++ < 10)
-		printk(KERN_ERR "FAULT[%s:%d]: 32-bit process "
-		       "reports 64-bit fault address [%lx]\n",
-		       current->comm, current->pid, addr);
-	show_regs(regs);
-}
-
 asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
@@ -322,10 +310,8 @@ asmlinkage void __kprobes do_sparc64_fault(struct pt_regs *regs)
 				goto intr_or_no_mm;
 			}
 		}
-		if (unlikely((address >> 32) != 0)) {
-			bogus_32bit_fault_address(regs, address);
+		if (unlikely((address >> 32) != 0))
 			goto intr_or_no_mm;
-		}
 	}
 
 	if (regs->tstate & TSTATE_PRIV) {
-- 
1.8.1.2


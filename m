From: David Miller <davem@davemloft.net>
Date: Sat, 12 Dec 2009 06:55:33 +0000
Subject: [PATCH 3/10]: sparc64: Add some missing __kprobes annotations to
Message-Id: <20091211.225533.104035837.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/fault_64.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 0aa50b2..6081936 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -31,7 +31,7 @@
 #include <asm/sections.h>
 #include <asm/mmu_context.h>
 
-static inline int notify_page_fault(struct pt_regs *regs)
+static inline __kprobes int notify_page_fault(struct pt_regs *regs)
 {
 	int ret = 0;
 
@@ -66,7 +66,7 @@ static void __kprobes unhandled_fault(unsigned long address,
 	die_if_kernel("Oops", regs);
 }
 
-static void bad_kernel_pc(struct pt_regs *regs, unsigned long vaddr)
+static void __kprobes bad_kernel_pc(struct pt_regs *regs, unsigned long vaddr)
 {
 	printk(KERN_CRIT "OOPS: Bogus kernel PC [%016lx] in fault handler\n",
 	       regs->tpc);
@@ -163,8 +163,9 @@ static unsigned int get_fault_insn(struct pt_regs *regs, unsigned int insn)
 	return insn;
 }
 
-static void do_kernel_fault(struct pt_regs *regs, int si_code, int fault_code,
-			    unsigned int insn, unsigned long address)
+static void __kprobes do_kernel_fault(struct pt_regs *regs, int si_code,
+				      int fault_code, unsigned int insn,
+				      unsigned long address)
 {
 	unsigned char asi = ASI_P;
  
@@ -218,7 +219,7 @@ cannot_handle:
 	unhandled_fault (address, current, regs);
 }
 
-static void noinline bogus_32bit_fault_tpc(struct pt_regs *regs)
+static void noinline __kprobes bogus_32bit_fault_tpc(struct pt_regs *regs)
 {
 	static int times;
 
@@ -230,8 +231,8 @@ static void noinline bogus_32bit_fault_tpc(struct pt_regs *regs)
 	show_regs(regs);
 }
 
-static void noinline bogus_32bit_fault_address(struct pt_regs *regs,
-					       unsigned long addr)
+static void noinline __kprobes bogus_32bit_fault_address(struct pt_regs *regs,
+							 unsigned long addr)
 {
 	static int times;
 
-- 
1.6.5


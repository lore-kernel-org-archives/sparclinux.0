From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Mon, 16 Jan 2017 18:12:14 +0000
Subject: [PATCH v2 2/2] sparc64: Handle PIO & MEM non-resumable errors.
Message-Id: <1484590334-15668-3-git-send-email-Liam.Howlett@Oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

User processes trying to access an invalid memory address via PIO will
receive a SIGBUS signal instead of causing a panic.  Memory errors will
receive a SIGKILL since a SIGBUS may result in a coredump which may
attempt to repeat the faulting access.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/sparc/kernel/traps_64.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 496fa92..82ecc56 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2051,6 +2051,74 @@ void sun4v_resum_overflow(struct pt_regs *regs)
 	atomic_inc(&sun4v_resum_oflow_cnt);
 }
 
+/* Given a set of registers, get the virtual addressi that was being accessed
+ * by the faulting instructions at tpc.
+ */
+static unsigned long sun4v_get_vaddr(struct pt_regs *regs)
+{
+	unsigned int insn;
+
+	if (!copy_from_user(&insn, (void __user *)regs->tpc, 4)) {
+		return compute_effective_address(regs, insn, (insn >> 25) &
+				0x1f);
+	}
+	return 0;
+}
+
+/* Attempt to handle non-resumable errors generated from userspace.
+ * Returns true if the signal was handled, false otherwise.
+ */
+bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
+				  struct sun4v_error_entry *ent) {
+
+	unsigned int attrs = ent->err_attrs;
+
+	if (attrs & SUN4V_ERR_ATTRS_MEMORY) {
+		unsigned long addr = ent->err_raddr;
+		siginfo_t info;
+
+		if (addr = ~(u64)0) {
+			/* This seems highly unlikely to ever occur */
+			pr_emerg("SUN4V NON-RECOVERABLE ERROR: Memory error detected in unknown location!\n");
+		} else {
+			unsigned long page_cnt = DIV_ROUND_UP(ent->err_size,
+							      PAGE_SIZE);
+
+
+			/* Break the unfortunate news. */
+			pr_emerg("SUN4V NON-RECOVERABLE ERROR: Memory failed at %016lX\n",
+				 addr);
+			pr_emerg("SUN4V NON-RECOVERABLE ERROR:   Claiming %lu ages.\n",
+				 page_cnt);
+
+			while (page_cnt-- > 0) {
+				if (pfn_valid(addr >> PAGE_SHIFT))
+					get_page(pfn_to_page(addr >> PAGE_SHIFT));
+				addr += PAGE_SIZE;
+			}
+		}
+		info.si_signo = SIGKILL;
+		info.si_errno = 0;
+		info.si_trapno = 0;
+		force_sig_info(info.si_signo, &info, current);
+
+		return true;
+	}
+	if (attrs & SUN4V_ERR_ATTRS_PIO) {
+		siginfo_t info;
+
+		info.si_signo = SIGBUS;
+		info.si_code = BUS_ADRERR;
+		info.si_addr = (void __user *)sun4v_get_vaddr(regs);
+		force_sig_info(info.si_signo, &info, current);
+
+		return true;
+	}
+
+	/* Default to doing nothing */
+	return false;
+}
+
 /* We run with %pil set to PIL_NORMAL_MAX and PSTATE_IE enabled in %pstate.
  * Log the event, clear the first word of the entry, and die.
  */
@@ -2075,6 +2143,12 @@ void sun4v_nonresum_error(struct pt_regs *regs, unsigned long offset)
 
 	put_cpu();
 
+	if (!(regs->tstate & TSTATE_PRIV) &&
+	    sun4v_nonresum_error_user_handled(regs, &local_copy)) {
+		/* DON'T PANIC: This userspace error was handled. */
+		return;
+	}
+
 #ifdef CONFIG_PCI
 	/* Check for the special PCI poke sequence. */
 	if (pci_poke_in_progress && pci_poke_cpu = cpu) {
-- 
2.1.4


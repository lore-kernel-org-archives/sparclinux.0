From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Fri, 06 Jan 2017 19:38:59 +0000
Subject: [PATCH 1/2] sparc64: Don't panic on user mode non-resumable errors
Message-Id: <1483731540-8055-2-git-send-email-Liam.Howlett@Oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Send a SIGBUS to the offending process on all userspace non-resumable
traps.  This prevents userspace applications from creating a kernel
panic.  The siginfo will return the code BUS_ADRERR and a valid address
if possible.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/sparc/kernel/traps_64.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 496fa92..3a0c153 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2075,6 +2075,27 @@ void sun4v_nonresum_error(struct pt_regs *regs, unsigned long offset)
 
 	put_cpu();
 
+	if (!(regs->tstate & TSTATE_PRIV)) {
+		/* DON'T PANIC.  This error was from userspace. */
+		siginfo_t info;
+		unsigned int insn;
+
+		info.si_signo = SIGBUS;
+		info.si_code = BUS_ADRERR;
+		info.si_errno = 0;
+		info.si_trapno = 0;
+		info.si_addr = 0;
+
+		if (!copy_from_user(&insn, (void __user *)regs->tpc, 4)) {
+			info.si_addr = (void __user *)
+				compute_effective_address(regs, insn,
+						(insn >> 25) & 0x1f);
+		}
+
+		force_sig_info(SIGBUS, &info, current);
+		return;
+	}
+
 #ifdef CONFIG_PCI
 	/* Check for the special PCI poke sequence. */
 	if (pci_poke_in_progress && pci_poke_cpu = cpu) {
-- 
2.1.4


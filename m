From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Fri, 20 Oct 2017 16:57:58 +0000
Subject: [PATCH v9 05/10] sparc64: Add handler for "Memory Corruption Detected" trap
Message-Id: <c11f0c1aae51a7bd3e5e212c28e6d15088789c08.1508364660.git.khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1508364660.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1508364660.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, dan.carpenter@oracle.com, Liam.Howlett@oracle.com, mhocko@suse.com, mingo@kernel.org, paul.gortmaker@windriver.com, vegard.nossum@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

M7 and newer processors add a "Memory corruption Detected" trap with
the addition of ADI feature. This trap is vectored into kernel by HV
through resumable error trap with error attribute for the resumable
error set to 0x00000800.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
---
v7:
	- new patch split off from patch 4/4 in v6

 arch/sparc/kernel/traps_64.c | 59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 7775d011691c..565e3c2836aa 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -1825,6 +1825,7 @@ struct sun4v_error_entry {
 #define SUN4V_ERR_ATTRS_ASI		0x00000080
 #define SUN4V_ERR_ATTRS_PRIV_REG	0x00000100
 #define SUN4V_ERR_ATTRS_SPSTATE_MSK	0x00000600
+#define SUN4V_ERR_ATTRS_MCD		0x00000800
 #define SUN4V_ERR_ATTRS_SPSTATE_SHFT	9
 #define SUN4V_ERR_ATTRS_MODE_MSK	0x03000000
 #define SUN4V_ERR_ATTRS_MODE_SHFT	24
@@ -2022,6 +2023,56 @@ static void sun4v_log_error(struct pt_regs *regs, struct sun4v_error_entry *ent,
 	}
 }
 
+/* Handle memory corruption detected error which is vectored in
+ * through resumable error trap.
+ */
+void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
+{
+	siginfo_t info;
+
+	if (notify_die(DIE_TRAP, "MCD error", regs, 0, 0x34,
+		       SIGSEGV) = NOTIFY_STOP)
+		return;
+
+	if (regs->tstate & TSTATE_PRIV) {
+		/* MCD exception could happen because the task was
+		 * running a system call with MCD enabled and passed a
+		 * non-versioned pointer or pointer with bad version
+		 * tag to the system call. In such cases, hypervisor
+		 * places the address of offending instruction in the
+		 * resumable error report. This is a deferred error,
+		 * so the read/write that caused the trap was potentially
+		 * retired long time back and we may have no choice
+		 * but to send SIGSEGV to the process.
+		 */
+		const struct exception_table_entry *entry;
+
+		entry = search_exception_tables(regs->tpc);
+		if (entry) {
+			/* Looks like a bad syscall parameter */
+#ifdef DEBUG_EXCEPTIONS
+			pr_emerg("Exception: PC<%016lx> faddr<UNKNOWN>\n",
+				 regs->tpc);
+			pr_emerg("EX_TABLE: insn<%016lx> fixup<%016lx>\n",
+				 ent.err_raddr, entry->fixup);
+#endif
+			regs->tpc = entry->fixup;
+			regs->tnpc = regs->tpc + 4;
+			return;
+		}
+	}
+
+	/* Send SIGSEGV to the userspace process with the right signal
+	 * code
+	 */
+	info.si_signo = SIGSEGV;
+	info.si_errno = 0;
+	info.si_code = SEGV_ADIDERR;
+	info.si_addr = (void __user *)ent.err_raddr;
+	info.si_trapno = 0;
+	force_sig_info(SIGSEGV, &info, current);
+}
+
 /* We run with %pil set to PIL_NORMAL_MAX and PSTATE_IE enabled in %pstate.
  * Log the event and clear the first word of the entry.
  */
@@ -2059,6 +2110,14 @@ void sun4v_resum_error(struct pt_regs *regs, unsigned long offset)
 		goto out;
 	}
 
+	/* If this is a memory corruption detected error vectored in
+	 * by HV through resumable error trap, call the handler
+	 */
+	if (local_copy.err_attrs & SUN4V_ERR_ATTRS_MCD) {
+		do_mcd_err(regs, local_copy);
+		return;
+	}
+
 	sun4v_log_error(regs, &local_copy, cpu,
 			KERN_ERR "RESUMABLE ERROR",
 			&sun4v_resum_oflow_cnt);
-- 
2.11.0


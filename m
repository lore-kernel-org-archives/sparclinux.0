From: David Miller <davem@davemloft.net>
Date: Thu, 11 Oct 2012 00:26:29 +0000
Subject: [PATCH] sparc64: Fix deficiencies in sun4v error reporting.
Message-Id: <20121010.202629.483316787777960261.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Missing error types, attributes, and report fields.  Pad out
to 64-bytes.

Make string reporting cleaner and easier to extend in the future using
"const char *" arrays that index by either bit position, or absolute
field value.

Report the raw 64-byte error report as a sequence of u64s before the
annotated version.

Only report fields which are valid, given the context and the
attribute bits which are set.

For shutdown requests, use the local copy of the error report not the
one we just freed up back to the queue.  Also, use orderly_poweroff()
just like the Domain Services shutdown request code does.

If the real-address reported is "-1" (unknown) try to disassemble the
instruction to report the effective address of the access.  Only do
this in privileged mode.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/uaccess_64.h |   5 +
 arch/sparc/kernel/traps_64.c        | 263 +++++++++++++++++++++++++++---------
 arch/sparc/mm/fault_64.c            |   2 -
 3 files changed, 207 insertions(+), 63 deletions(-)

diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index 7c831d8..73083e1 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -265,6 +265,11 @@ extern __must_check long strnlen_user(const char __user *str, long n);
 #define __copy_to_user_inatomic ___copy_to_user
 #define __copy_from_user_inatomic ___copy_from_user
 
+struct pt_regs;
+extern unsigned long compute_effective_address(struct pt_regs *,
+					       unsigned int insn,
+					       unsigned int rd);
+
 #endif  /* __ASSEMBLY__ */
 
 #endif /* _ASM_UACCESS_H */
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index fa1f1d3..b66a779 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -1,6 +1,6 @@
 /* arch/sparc64/kernel/traps.c
  *
- * Copyright (C) 1995,1997,2008,2009 David S. Miller (davem@davemloft.net)
+ * Copyright (C) 1995,1997,2008,2009,2012 David S. Miller (davem@davemloft.net)
  * Copyright (C) 1997,1999,2000 Jakub Jelinek (jakub@redhat.com)
  */
 
@@ -18,6 +18,7 @@
 #include <linux/init.h>
 #include <linux/kdebug.h>
 #include <linux/ftrace.h>
+#include <linux/reboot.h>
 #include <linux/gfp.h>
 
 #include <asm/smp.h>
@@ -1760,85 +1761,223 @@ void cheetah_plus_parity_error(int type, struct pt_regs *regs)
 }
 
 struct sun4v_error_entry {
-	u64		err_handle;
-	u64		err_stick;
+	/* Unique error handle */
+/*0x00*/u64		err_handle;
 
-	u32		err_type;
+	/* %stick value at the time of the error */
+/*0x08*/u64		err_stick;
+
+/*0x10*/u8		reserved_1[3];
+
+	/* Error type */
+/*0x13*/u8		err_type;
 #define SUN4V_ERR_TYPE_UNDEFINED	0
 #define SUN4V_ERR_TYPE_UNCORRECTED_RES	1
 #define SUN4V_ERR_TYPE_PRECISE_NONRES	2
 #define SUN4V_ERR_TYPE_DEFERRED_NONRES	3
-#define SUN4V_ERR_TYPE_WARNING_RES	4
+#define SUN4V_ERR_TYPE_SHUTDOWN_RQST	4
+#define SUN4V_ERR_TYPE_DUMP_CORE	5
+#define SUN4V_ERR_TYPE_SP_STATE_CHANGE	6
+#define SUN4V_ERR_TYPE_NUM		7
 
-	u32		err_attrs;
+	/* Error attributes */
+/*0x14*/u32		err_attrs;
 #define SUN4V_ERR_ATTRS_PROCESSOR	0x00000001
 #define SUN4V_ERR_ATTRS_MEMORY		0x00000002
 #define SUN4V_ERR_ATTRS_PIO		0x00000004
 #define SUN4V_ERR_ATTRS_INT_REGISTERS	0x00000008
 #define SUN4V_ERR_ATTRS_FPU_REGISTERS	0x00000010
-#define SUN4V_ERR_ATTRS_USER_MODE	0x01000000
-#define SUN4V_ERR_ATTRS_PRIV_MODE	0x02000000
+#define SUN4V_ERR_ATTRS_SHUTDOWN_RQST	0x00000020
+#define SUN4V_ERR_ATTRS_ASR		0x00000040
+#define SUN4V_ERR_ATTRS_ASI		0x00000080
+#define SUN4V_ERR_ATTRS_PRIV_REG	0x00000100
+#define SUN4V_ERR_ATTRS_SPSTATE_MSK	0x00000600
+#define SUN4V_ERR_ATTRS_SPSTATE_SHFT	9
+#define SUN4V_ERR_ATTRS_MODE_MSK	0x03000000
+#define SUN4V_ERR_ATTRS_MODE_SHFT	24
 #define SUN4V_ERR_ATTRS_RES_QUEUE_FULL	0x80000000
 
-	u64		err_raddr;
-	u32		err_size;
-	u16		err_cpu;
-	u16		err_pad;
+#define SUN4V_ERR_SPSTATE_FAULTED	0
+#define SUN4V_ERR_SPSTATE_AVAILABLE	1
+#define SUN4V_ERR_SPSTATE_NOT_PRESENT	2
+
+#define SUN4V_ERR_MODE_USER		1
+#define SUN4V_ERR_MODE_PRIV		2
+
+	/* Real address of the memory region or PIO transaction */
+/*0x18*/u64		err_raddr;
+
+	/* Size of the operation triggering the error, in bytes */
+/*0x20*/u32		err_size;
+
+	/* ID of the CPU */
+/*0x24*/u16		err_cpu;
+
+	/* Grace periof for shutdown, in seconds */
+/*0x26*/u16		err_secs;
+
+	/* Value of the %asi register */
+/*0x28*/u8		err_asi;
+
+/*0x29*/u8		reserved_2;
+
+	/* Value of the ASR register number */
+/*0x2a*/u16		err_asr;
+#define SUN4V_ERR_ASR_VALID		0x8000
+
+/*0x2c*/u32		reserved_3;
+/*0x30*/u64		reserved_4;
+/*0x38*/u64		reserved_5;
 };
 
 static atomic_t sun4v_resum_oflow_cnt = ATOMIC_INIT(0);
 static atomic_t sun4v_nonresum_oflow_cnt = ATOMIC_INIT(0);
 
-static const char *sun4v_err_type_to_str(u32 type)
-{
-	switch (type) {
-	case SUN4V_ERR_TYPE_UNDEFINED:
-		return "undefined";
-	case SUN4V_ERR_TYPE_UNCORRECTED_RES:
-		return "uncorrected resumable";
-	case SUN4V_ERR_TYPE_PRECISE_NONRES:
-		return "precise nonresumable";
-	case SUN4V_ERR_TYPE_DEFERRED_NONRES:
-		return "deferred nonresumable";
-	case SUN4V_ERR_TYPE_WARNING_RES:
-		return "warning resumable";
-	default:
-		return "unknown";
+static const char *sun4v_err_type_to_str(u8 type)
+{
+	static const char *types[SUN4V_ERR_TYPE_NUM] = {
+		"undefined",
+		"uncorrected resumable",
+		"precise nonresumable",
+		"deferred nonresumable",
+		"shutdown request",
+		"dump core",
+		"SP state change",
+	};
+
+	if (type < SUN4V_ERR_TYPE_NUM)
+		return types[type];
+
+	return "unknown";
+}
+
+static void sun4v_emit_err_attr_strings(u32 attrs)
+{
+	static const char *attr_names[] = {
+		"processor",
+		"memory",
+		"PIO",
+		"int-registers",
+		"fpu-registers",
+		"shutdown-request",
+		"ASR",
+		"ASI",
+		"priv-reg",
+	};
+	static const char *sp_states[] = {
+		"sp-faulted",
+		"sp-available",
+		"sp-not-present",
+		"sp-state-reserved",
+	};
+	static const char *modes[] = {
+		"mode-reserved0",
+		"user",
+		"priv",
+		"mode-reserved1",
+	};
+	u32 sp_state, mode;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(attr_names); i++) {
+		if (attrs & (1U << i)) {
+			const char *s = attr_names[i];
+
+			pr_cont("%s ", s);
+		}
 	}
+
+	sp_state = ((attrs & SUN4V_ERR_ATTRS_SPSTATE_MSK) >>
+		    SUN4V_ERR_ATTRS_SPSTATE_SHFT);
+	pr_cont("%s ", sp_states[sp_state]);
+
+	mode = ((attrs & SUN4V_ERR_ATTRS_MODE_MSK) >>
+		SUN4V_ERR_ATTRS_MODE_SHFT);
+	pr_cont("%s ", modes[mode]);
+
+	if (attrs & SUN4V_ERR_ATTRS_RES_QUEUE_FULL)
+		pr_cont("res-queue-full ");
 }
 
-static void sun4v_log_error(struct pt_regs *regs, struct sun4v_error_entry *ent, int cpu, const char *pfx, atomic_t *ocnt)
+/* When the report contains a real-address of "-1" it means that the
+ * hardware did not provide the address.  So we compute the effective
+ * address of the load or store instruction at regs->tpc and report
+ * that.  Usually when this happens it's a PIO and in such a case we
+ * are using physical addresses with bypass ASIs anyways, so what we
+ * report here is exactly what we want.
+ */
+static void sun4v_report_real_raddr(const char *pfx, struct pt_regs *regs)
 {
+	unsigned int insn;
+	u64 addr;
+
+	if (!(regs->tstate & TSTATE_PRIV))
+		return;
+
+	insn = *(unsigned int *) regs->tpc;
+
+	addr = compute_effective_address(regs, insn, 0);
+
+	printk("%s: insn effective address [0x%016llx]\n",
+	       pfx, addr);
+}
+
+static void sun4v_log_error(struct pt_regs *regs, struct sun4v_error_entry *ent,
+			    int cpu, const char *pfx, atomic_t *ocnt)
+{
+	u64 *raw_ptr = (u64 *) ent;
+	u32 attrs;
 	int cnt;
 
 	printk("%s: Reporting on cpu %d\n", pfx, cpu);
-	printk("%s: err_handle[%llx] err_stick[%llx] err_type[%08x:%s]\n",
-	       pfx,
-	       ent->err_handle, ent->err_stick,
-	       ent->err_type,
-	       sun4v_err_type_to_str(ent->err_type));
-	printk("%s: err_attrs[%08x:%s %s %s %s %s %s %s %s]\n",
-	       pfx,
-	       ent->err_attrs,
-	       ((ent->err_attrs & SUN4V_ERR_ATTRS_PROCESSOR) ?
-		"processor" : ""),
-	       ((ent->err_attrs & SUN4V_ERR_ATTRS_MEMORY) ?
-		"memory" : ""),
-	       ((ent->err_attrs & SUN4V_ERR_ATTRS_PIO) ?
-		"pio" : ""),
-	       ((ent->err_attrs & SUN4V_ERR_ATTRS_INT_REGISTERS) ?
-		"integer-regs" : ""),
-	       ((ent->err_attrs & SUN4V_ERR_ATTRS_FPU_REGISTERS) ?
-		"fpu-regs" : ""),
-	       ((ent->err_attrs & SUN4V_ERR_ATTRS_USER_MODE) ?
-		"user" : ""),
-	       ((ent->err_attrs & SUN4V_ERR_ATTRS_PRIV_MODE) ?
-		"privileged" : ""),
-	       ((ent->err_attrs & SUN4V_ERR_ATTRS_RES_QUEUE_FULL) ?
-		"queue-full" : ""));
-	printk("%s: err_raddr[%016llx] err_size[%u] err_cpu[%u]\n",
-	       pfx,
-	       ent->err_raddr, ent->err_size, ent->err_cpu);
+	printk("%s: TPC [0x%016lx] <%pS>\n",
+	       pfx, regs->tpc, (void *) regs->tpc);
+
+	printk("%s: RAW [%016llx:%016llx:%016llx:%016llx\n",
+	       pfx, raw_ptr[0], raw_ptr[1], raw_ptr[2], raw_ptr[3]);
+	printk("%s:      %016llx:%016llx:%016llx:%016llx]\n",
+	       pfx, raw_ptr[4], raw_ptr[5], raw_ptr[6], raw_ptr[7]);
+
+	printk("%s: handle [0x%016llx] stick [0x%016llx]\n",
+	       pfx, ent->err_handle, ent->err_stick);
+
+	printk("%s: type [%s]\n", pfx, sun4v_err_type_to_str(ent->err_type));
+
+	attrs = ent->err_attrs;
+	printk("%s: attrs [0x%08x] < ", pfx, attrs);
+	sun4v_emit_err_attr_strings(attrs);
+	pr_cont(">\n");
+
+	/* Various fields in the error report are only valid if
+	 * certain attribute bits are set.
+	 */
+	if (attrs & (SUN4V_ERR_ATTRS_MEMORY |
+		     SUN4V_ERR_ATTRS_PIO |
+		     SUN4V_ERR_ATTRS_ASI)) {
+		printk("%s: raddr [0x%016llx]\n", pfx, ent->err_raddr);
+
+		if (ent->err_raddr = ~(u64)0)
+			sun4v_report_real_raddr(pfx, regs);
+	}
+
+	if (attrs & (SUN4V_ERR_ATTRS_MEMORY | SUN4V_ERR_ATTRS_ASI))
+		printk("%s: size [0x%x]\n", pfx, ent->err_size);
+
+	if (attrs & (SUN4V_ERR_ATTRS_PROCESSOR |
+		     SUN4V_ERR_ATTRS_INT_REGISTERS |
+		     SUN4V_ERR_ATTRS_FPU_REGISTERS |
+		     SUN4V_ERR_ATTRS_PRIV_REG))
+		printk("%s: cpu[%u]\n", pfx, ent->err_cpu);
+
+	if (attrs & SUN4V_ERR_ATTRS_ASI)
+		printk("%s: asi [0x%02x]\n", pfx, ent->err_asi);
+
+	if ((attrs & (SUN4V_ERR_ATTRS_INT_REGISTERS |
+		      SUN4V_ERR_ATTRS_FPU_REGISTERS |
+		      SUN4V_ERR_ATTRS_PRIV_REG)) &&
+	    (ent->err_asr & SUN4V_ERR_ASR_VALID) != 0)
+		printk("%s: reg [0x%04x]\n",
+		       pfx, ent->err_asr & ~SUN4V_ERR_ASR_VALID);
 
 	show_regs(regs);
 
@@ -1874,13 +2013,15 @@ void sun4v_resum_error(struct pt_regs *regs, unsigned long offset)
 
 	put_cpu();
 
-	if (ent->err_type = SUN4V_ERR_TYPE_WARNING_RES) {
-		/* If err_type is 0x4, it's a powerdown request.  Do
-		 * not do the usual resumable error log because that
-		 * makes it look like some abnormal error.
+	if (local_copy.err_type = SUN4V_ERR_TYPE_SHUTDOWN_RQST) {
+		/* We should really take the seconds field of
+		 * the error report and use it for the shutdown
+		 * invocation, but for now do the same thing we
+		 * do for a DS shutdown request.
 		 */
-		printk(KERN_INFO "Power down request...\n");
-		kill_cad_pid(SIGINT, 1);
+		pr_info("Shutdown request, %u seconds...\n",
+			local_copy.err_secs);
+		orderly_poweroff(true);
 		return;
 	}
 
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 2976dba..097aee7 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -151,8 +151,6 @@ show_signal_msg(struct pt_regs *regs, int sig, int code,
 	printk(KERN_CONT "\n");
 }
 
-extern unsigned long compute_effective_address(struct pt_regs *, unsigned int, unsigned int);
-
 static void do_fault_siginfo(int code, int sig, struct pt_regs *regs,
 			     unsigned int insn, int fault_code)
 {
-- 
1.7.12.2.dirty


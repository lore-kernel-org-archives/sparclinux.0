From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 21 Feb 2018 17:15:45 +0000
Subject: [PATCH v12 03/11] sparc64: Add support for ADI register fields, ASIs and traps
Message-Id: <919fe74b146b0ba8a156212254c46d752902a079.1519227112.git.khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1519227112.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1519227112.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, mhocko@suse.com, mingo@kernel.org, gregkh@linuxfoundation.org, akpm@linux-foundation.org, tglx@linutronix.de, kstewart@linuxfoundation.org, vijay.ac.kumar@oracle.com, kirill.shutemov@linux.intel.com, nitin.m.gupta@oracle.com, tom.hromatka@oracle.com, allen.pais@oracle.com, rob.gardner@oracle.com, david.j.aldridge@oracle.com, bob.picco@oracle.com, steven.sistare@oracle.com, pasha.tatashin@oracle.com, vegard.nossum@oracle.com, pombredanne@nexb.com, ebiederm@xmission.com, jane.chu@oracle.com, anthony.yznaga@oracle.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

SPARC M7 processor adds new control register fields, ASIs and a new
trap to support the ADI (Application Data Integrity) feature. This
patch adds definitions for these register fields, ASIs and a handler
for the new precise memory corruption detected trap.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Cc: Khalid Aziz <khalid@gonehiking.org>
Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
v10:
	- Updated copyright
v8:
	- Minor print formatting change as suggested by checkpatch
v6:
	- Added a missing nop in the delay slot in sun4v_mcd_detect_precise

v5:
	- Fixed indentation issues in assembly code

v4:
	- Broke patch up into smaller patches

v3:
	- Removed CONFIG_SPARC_ADI
	- Replaced prctl commands with mprotect
	- Added auxiliary vectors for ADI parameters
	- Enabled ADI for swappable pages

v2:
	- Fixed a build error

 arch/sparc/include/asm/hypervisor.h  |  2 ++
 arch/sparc/include/asm/pgtable_64.h  |  2 ++
 arch/sparc/include/asm/ttable.h      | 10 +++++++
 arch/sparc/include/uapi/asm/asi.h    |  5 ++++
 arch/sparc/include/uapi/asm/pstate.h | 10 +++++++
 arch/sparc/kernel/entry.h            |  3 ++
 arch/sparc/kernel/head_64.S          |  1 +
 arch/sparc/kernel/sun4v_mcd.S        | 18 ++++++++++++
 arch/sparc/kernel/traps_64.c         | 54 ++++++++++++++++++++++++++++++++++++
 arch/sparc/kernel/ttable_64.S        |  6 ++--
 10 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100644 arch/sparc/kernel/sun4v_mcd.S

diff --git a/arch/sparc/include/asm/hypervisor.h b/arch/sparc/include/asm/hypervisor.h
index ab9c6b027b75..08650d503cc2 100644
--- a/arch/sparc/include/asm/hypervisor.h
+++ b/arch/sparc/include/asm/hypervisor.h
@@ -570,6 +570,8 @@ struct hv_fault_status {
 #define HV_FAULT_TYPE_RESV1	13
 #define HV_FAULT_TYPE_UNALIGNED	14
 #define HV_FAULT_TYPE_INV_PGSZ	15
+#define HV_FAULT_TYPE_MCD	17
+#define HV_FAULT_TYPE_MCD_DIS	18
 /* Values 16 --> -2 are reserved.  */
 #define HV_FAULT_TYPE_MULTIPLE	-1
 
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 339920fdf9ed..619332a44402 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -164,6 +164,8 @@ bool kern_addr_valid(unsigned long addr);
 #define _PAGE_E_4V	  _AC(0x0000000000000800,UL) /* side-Effect          */
 #define _PAGE_CP_4V	  _AC(0x0000000000000400,UL) /* Cacheable in P-Cache */
 #define _PAGE_CV_4V	  _AC(0x0000000000000200,UL) /* Cacheable in V-Cache */
+/* Bit 9 is used to enable MCD corruption detection instead on M7 */
+#define _PAGE_MCD_4V      _AC(0x0000000000000200,UL) /* Memory Corruption    */
 #define _PAGE_P_4V	  _AC(0x0000000000000100,UL) /* Privileged Page      */
 #define _PAGE_EXEC_4V	  _AC(0x0000000000000080,UL) /* Executable Page      */
 #define _PAGE_W_4V	  _AC(0x0000000000000040,UL) /* Writable             */
diff --git a/arch/sparc/include/asm/ttable.h b/arch/sparc/include/asm/ttable.h
index ede2b66cf4a0..8f6469408019 100644
--- a/arch/sparc/include/asm/ttable.h
+++ b/arch/sparc/include/asm/ttable.h
@@ -219,6 +219,16 @@
 	nop;						\
 	nop;
 
+#define SUN4V_MCD_PRECISE				\
+	ldxa	[%g0] ASI_SCRATCHPAD, %g2;		\
+	ldx	[%g2 + HV_FAULT_D_ADDR_OFFSET], %g4;	\
+	ldx	[%g2 + HV_FAULT_D_CTX_OFFSET], %g5;	\
+	ba,pt	%xcc, etrap;				\
+	 rd	%pc, %g7;				\
+	ba,pt	%xcc, sun4v_mcd_detect_precise;		\
+	 nop;						\
+	nop;
+
 /* Before touching these macros, you owe it to yourself to go and
  * see how arch/sparc64/kernel/winfixup.S works... -DaveM
  *
diff --git a/arch/sparc/include/uapi/asm/asi.h b/arch/sparc/include/uapi/asm/asi.h
index d371b269571a..fbb30a5b082f 100644
--- a/arch/sparc/include/uapi/asm/asi.h
+++ b/arch/sparc/include/uapi/asm/asi.h
@@ -145,6 +145,8 @@
  * ASIs, "(4V)" designates SUN4V specific ASIs.  "(NG4)" designates SPARC-T4
  * and later ASIs.
  */
+#define ASI_MCD_PRIV_PRIMARY	0x02 /* (NG7) Privileged MCD version VA	*/
+#define ASI_MCD_REAL		0x05 /* (NG7) Privileged MCD version PA	*/
 #define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cachable		*/
 #define ASI_PHYS_BYPASS_EC_E	0x15 /* PADDR, E-bit			*/
 #define ASI_BLK_AIUP_4V		0x16 /* (4V) Prim, user, block ld/st	*/
@@ -245,6 +247,9 @@
 #define ASI_UDBL_CONTROL_R	0x7f /* External UDB control regs rd low*/
 #define ASI_INTR_R		0x7f /* IRQ vector dispatch read	*/
 #define ASI_INTR_DATAN_R	0x7f /* (III) In irq vector data reg N	*/
+#define ASI_MCD_PRIMARY		0x90 /* (NG7) MCD version load/store	*/
+#define ASI_MCD_ST_BLKINIT_PRIMARY	\
+				0x92 /* (NG7) MCD store BLKINIT primary	*/
 #define ASI_PIC			0xb0 /* (NG4) PIC registers		*/
 #define ASI_PST8_P		0xc0 /* Primary, 8 8-bit, partial	*/
 #define ASI_PST8_S		0xc1 /* Secondary, 8 8-bit, partial	*/
diff --git a/arch/sparc/include/uapi/asm/pstate.h b/arch/sparc/include/uapi/asm/pstate.h
index b6999c9e7e86..ceca96e685c2 100644
--- a/arch/sparc/include/uapi/asm/pstate.h
+++ b/arch/sparc/include/uapi/asm/pstate.h
@@ -11,7 +11,12 @@
  * -----------------------------------------------------------------------
  *  63  12  11   10    9     8    7   6   5     4     3     2     1    0
  */
+/* IG on V9 conflicts with MCDE on M7. PSTATE_MCDE will only be used on
+ * processors that support ADI which do not use IG, hence there is no
+ * functional conflict
+ */
 #define PSTATE_IG   _AC(0x0000000000000800,UL) /* Interrupt Globals.	*/
+#define PSTATE_MCDE _AC(0x0000000000000800,UL) /* MCD Enable		*/
 #define PSTATE_MG   _AC(0x0000000000000400,UL) /* MMU Globals.		*/
 #define PSTATE_CLE  _AC(0x0000000000000200,UL) /* Current Little Endian.*/
 #define PSTATE_TLE  _AC(0x0000000000000100,UL) /* Trap Little Endian.	*/
@@ -48,7 +53,12 @@
 #define TSTATE_ASI	_AC(0x00000000ff000000,UL) /* AddrSpace ID.	*/
 #define TSTATE_PIL	_AC(0x0000000000f00000,UL) /* %pil (Linux traps)*/
 #define TSTATE_PSTATE	_AC(0x00000000000fff00,UL) /* PSTATE.		*/
+/* IG on V9 conflicts with MCDE on M7. TSTATE_MCDE will only be used on
+ * processors that support ADI which do not support IG, hence there is
+ * no functional conflict
+ */
 #define TSTATE_IG	_AC(0x0000000000080000,UL) /* Interrupt Globals.*/
+#define TSTATE_MCDE	_AC(0x0000000000080000,UL) /* MCD enable.       */
 #define TSTATE_MG	_AC(0x0000000000040000,UL) /* MMU Globals.	*/
 #define TSTATE_CLE	_AC(0x0000000000020000,UL) /* CurrLittleEndian.	*/
 #define TSTATE_TLE	_AC(0x0000000000010000,UL) /* TrapLittleEndian.	*/
diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
index 7378567b601f..c746c0fd5d6b 100644
--- a/arch/sparc/kernel/entry.h
+++ b/arch/sparc/kernel/entry.h
@@ -160,6 +160,9 @@ void sun4v_resum_overflow(struct pt_regs *regs);
 void sun4v_nonresum_error(struct pt_regs *regs,
 			  unsigned long offset);
 void sun4v_nonresum_overflow(struct pt_regs *regs);
+void sun4v_mem_corrupt_detect_precise(struct pt_regs *regs,
+				      unsigned long addr,
+				      unsigned long context);
 
 extern unsigned long sun4v_err_itlb_vaddr;
 extern unsigned long sun4v_err_itlb_ctx;
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index a41e6e16eb36..540bfc98472c 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -897,6 +897,7 @@ sparc64_boot_end:
 #include "syscalls.S"
 #include "helpers.S"
 #include "sun4v_tlb_miss.S"
+#include "sun4v_mcd.S"
 #include "sun4v_ivec.S"
 #include "ktlb.S"
 #include "tsb.S"
diff --git a/arch/sparc/kernel/sun4v_mcd.S b/arch/sparc/kernel/sun4v_mcd.S
new file mode 100644
index 000000000000..d6c69ebca110
--- /dev/null
+++ b/arch/sparc/kernel/sun4v_mcd.S
@@ -0,0 +1,18 @@
+/* sun4v_mcd.S: Sun4v memory corruption detected precise exception handler
+ *
+ * Copyright (c) 2015 Oracle and/or its affiliates. All rights reserved.
+ * Authors: Bob Picco <bob.picco@oracle.com>,
+ *          Khalid Aziz <khalid.aziz@oracle.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ */
+	.text
+	.align 32
+
+sun4v_mcd_detect_precise:
+	mov	%l4, %o1
+	mov 	%l5, %o2
+	call	sun4v_mem_corrupt_detect_precise
+	 add	%sp, PTREGS_OFF, %o0
+	ba,a,pt	%xcc, rtrap
+	 nop
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 0a56dc257cb9..fc73baa588f6 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2656,6 +2656,60 @@ void sun4v_do_mna(struct pt_regs *regs, unsigned long addr, unsigned long type_c
 	force_sig_info(SIGBUS, &info, current);
 }
 
+/* sun4v_mem_corrupt_detect_precise() - Handle precise exception on an ADI
+ * tag mismatch.
+ *
+ * ADI version tag mismatch on a load from memory always results in a
+ * precise exception. Tag mismatch on a store to memory will result in
+ * precise exception if MCDPER or PMCDPER is set to 1.
+ */
+void sun4v_mem_corrupt_detect_precise(struct pt_regs *regs, unsigned long addr,
+				      unsigned long context)
+{
+	siginfo_t info;
+
+	if (notify_die(DIE_TRAP, "memory corruption precise exception", regs,
+		       0, 0x8, SIGSEGV) = NOTIFY_STOP)
+		return;
+
+	if (regs->tstate & TSTATE_PRIV) {
+		/* MCD exception could happen because the task was running
+		 * a system call with MCD enabled and passed a non-versioned
+		 * pointer or pointer with bad version tag to  the system
+		 * call.
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
+				 regs->tpc, entry->fixup);
+#endif
+			regs->tpc = entry->fixup;
+			regs->tnpc = regs->tpc + 4;
+			return;
+		}
+		pr_emerg("%s: ADDR[%016lx] CTX[%lx], going.\n",
+			 __func__, addr, context);
+		die_if_kernel("MCD precise", regs);
+	}
+
+	if (test_thread_flag(TIF_32BIT)) {
+		regs->tpc &= 0xffffffff;
+		regs->tnpc &= 0xffffffff;
+	}
+	info.si_signo = SIGSEGV;
+	info.si_code = SEGV_ADIPERR;
+	info.si_errno = 0;
+	info.si_addr = (void __user *) addr;
+	info.si_trapno = 0;
+	force_sig_info(SIGSEGV, &info, current);
+}
+
 void do_privop(struct pt_regs *regs)
 {
 	enum ctx_state prev_state = exception_enter();
diff --git a/arch/sparc/kernel/ttable_64.S b/arch/sparc/kernel/ttable_64.S
index 18685fe69b91..86e737e59c7e 100644
--- a/arch/sparc/kernel/ttable_64.S
+++ b/arch/sparc/kernel/ttable_64.S
@@ -26,8 +26,10 @@ tl0_ill:	membar #Sync
 		TRAP_7INSNS(do_illegal_instruction)
 tl0_privop:	TRAP(do_privop)
 tl0_resv012:	BTRAP(0x12) BTRAP(0x13) BTRAP(0x14) BTRAP(0x15) BTRAP(0x16) BTRAP(0x17)
-tl0_resv018:	BTRAP(0x18) BTRAP(0x19) BTRAP(0x1a) BTRAP(0x1b) BTRAP(0x1c) BTRAP(0x1d)
-tl0_resv01e:	BTRAP(0x1e) BTRAP(0x1f)
+tl0_resv018:	BTRAP(0x18) BTRAP(0x19)
+tl0_mcd:	SUN4V_MCD_PRECISE
+tl0_resv01b:	BTRAP(0x1b)
+tl0_resv01c:	BTRAP(0x1c) BTRAP(0x1d)	BTRAP(0x1e) BTRAP(0x1f)
 tl0_fpdis:	TRAP_NOSAVE(do_fpdis)
 tl0_fpieee:	TRAP_SAVEFPU(do_fpieee)
 tl0_fpother:	TRAP_NOSAVE(do_fpother_check_fitos)
-- 
2.11.0


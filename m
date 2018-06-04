From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Mon, 04 Jun 2018 15:54:20 +0000
Subject: [RFC PATCH -tip v5 12/27] sparc64: kprobes: Remove jprobe implementation
Message-Id: <152812765990.10068.4986702684441309090.stgit@devbox>
List-Id: <sparclinux.vger.kernel.org>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
In-Reply-To: <152812730943.10068.5166429445118734697.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Remove arch dependent setjump/longjump functions
and unused fields in kprobe_ctlblk for jprobes
from arch/sparc.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/kprobes.h |    1 -
 arch/sparc/kernel/kprobes.c      |   47 --------------------------------------
 2 files changed, 48 deletions(-)

diff --git a/arch/sparc/include/asm/kprobes.h b/arch/sparc/include/asm/kprobes.h
index 3704490b4488..bfcaa6326c20 100644
--- a/arch/sparc/include/asm/kprobes.h
+++ b/arch/sparc/include/asm/kprobes.h
@@ -44,7 +44,6 @@ struct kprobe_ctlblk {
 	unsigned long kprobe_status;
 	unsigned long kprobe_orig_tnpc;
 	unsigned long kprobe_orig_tstate_pil;
-	struct pt_regs jprobe_saved_regs;
 	struct prev_kprobe prev_kprobe;
 };
 
diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index ab4ba4347941..f555711da8f1 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -441,53 +441,6 @@ asmlinkage void __kprobes kprobe_trap(unsigned long trap_level,
 	exception_exit(prev_state);
 }
 
-/* Jprobes support.  */
-int __kprobes setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	struct jprobe *jp = container_of(p, struct jprobe, kp);
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	memcpy(&(kcb->jprobe_saved_regs), regs, sizeof(*regs));
-
-	regs->tpc  = (unsigned long) jp->entry;
-	regs->tnpc = ((unsigned long) jp->entry) + 0x4UL;
-	regs->tstate |= TSTATE_PIL;
-
-	return 1;
-}
-
-void __kprobes jprobe_return(void)
-{
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-	register unsigned long orig_fp asm("g1");
-
-	orig_fp = kcb->jprobe_saved_regs.u_regs[UREG_FP];
-	__asm__ __volatile__("\n"
-"1:	cmp		%%sp, %0\n\t"
-	"blu,a,pt	%%xcc, 1b\n\t"
-	" restore\n\t"
-	".globl		jprobe_return_trap_instruction\n"
-"jprobe_return_trap_instruction:\n\t"
-	"ta		0x70"
-	: /* no outputs */
-	: "r" (orig_fp));
-}
-
-extern void jprobe_return_trap_instruction(void);
-
-int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
-{
-	u32 *addr = (u32 *) regs->tpc;
-	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
-
-	if (addr = (u32 *) jprobe_return_trap_instruction) {
-		memcpy(regs, &(kcb->jprobe_saved_regs), sizeof(*regs));
-		preempt_enable_no_resched();
-		return 1;
-	}
-	return 0;
-}
-
 /* The value stored in the return address register is actually 2
  * instructions before where the callee will return to.
  * Sequences usually look something like this


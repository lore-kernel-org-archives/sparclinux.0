From: David Miller <davem@davemloft.net>
Date: Sun, 28 Oct 2012 20:17:19 +0000
Subject: [PATCH] sparc64: Improvde documentation and readability of atomic backoff code.
Message-Id: <20121028.161719.169284944959004709.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Document what's going on in asm/backoff.h with a large and descriptive
comment.  Refer to it above the cpu_relax() definition in
asm/processor_64.h

Rename the pause patching section to have "3insn" in it's name like
the other patching sections do.

Based upon feedback from Sam Ravnborg.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/backoff.h      | 42 ++++++++++++++++++++++++++++++++++-
 arch/sparc/include/asm/processor_64.h |  7 +++++-
 arch/sparc/kernel/entry.h             |  4 ++--
 arch/sparc/kernel/setup_64.c          |  4 ++--
 arch/sparc/kernel/vmlinux.lds.S       |  8 +++----
 5 files changed, 55 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/backoff.h b/arch/sparc/include/asm/backoff.h
index 20f01df..4e02086 100644
--- a/arch/sparc/include/asm/backoff.h
+++ b/arch/sparc/include/asm/backoff.h
@@ -1,6 +1,46 @@
 #ifndef _SPARC64_BACKOFF_H
 #define _SPARC64_BACKOFF_H
 
+/* The macros in this file implement an exponential backoff facility
+ * for atomic operations.
+ *
+ * When multiple threads compete on an atomic operation, it is
+ * possible for one thread to be continually denied a successful
+ * completion of the compare-and-swap instruction.  Heavily
+ * threaded cpu implementations like Niagara can compound this
+ * problem even further.
+ *
+ * When an atomic operation fails and needs to be retried, we spin a
+ * certain number of times.  At each subsequent failure of the same
+ * operation we double the spin count, realizing an exponential
+ * backoff.
+ *
+ * When we spin, we try to use an operation that will cause the
+ * current cpu strand to block, and therefore make the core fully
+ * available to any other other runnable strands.  There are two
+ * options, based upon cpu capabilities.
+ *
+ * On all cpus prior to SPARC-T4 we do three dummy reads of the
+ * condition code register.  Each read blocks the strand for something
+ * between 40 and 50 cpu cycles.
+ *
+ * For SPARC-T4 and later we have a special "pause" instruction
+ * available.  This is implemented using writes to register %asr27.
+ * The cpu will block the number of cycles written into the register,
+ * unless a disrupting trap happens first.  SPARC-T4 specifically
+ * implements pause with a granularity of 8 cycles.  Each strand has
+ * an internal pause counter which decrements every 8 cycles.  So the
+ * chip shifts the %asr27 value down by 3 bits, and writes the result
+ * into the pause counter.  If a value smaller than 8 is written, the
+ * chip blocks for 1 cycle.
+ *
+ * To achieve the same amount of backoff as the three %ccr reads give
+ * on earlier chips, we shift the backoff value up by 7 bits.  (Three
+ * %ccr reads block for about 128 cycles, 1 << 7 = 128) We write the
+ * whole amount we want to block into the pause register, rather than
+ * loop writing 128 each time.
+ */
+
 #define BACKOFF_LIMIT	(4 * 1024)
 
 #ifdef CONFIG_SMP
@@ -16,7 +56,7 @@
 88:	rd		%ccr, %g0;		\
 	rd		%ccr, %g0;		\
 	rd		%ccr, %g0;		\
-	.section	.pause_patch,"ax";	\
+	.section	.pause_3insn_patch,"ax";\
 	.word		88b;			\
 	sllx		tmp, 7, tmp;		\
 	wr		tmp, 0, %asr27;		\
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/processor_64.h
index 9cdf52e..721e25f 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -196,11 +196,16 @@ extern unsigned long get_wchan(struct task_struct *task);
 #define KSTK_EIP(tsk)  (task_pt_regs(tsk)->tpc)
 #define KSTK_ESP(tsk)  (task_pt_regs(tsk)->u_regs[UREG_FP])
 
+/* Please see the commentary in asm/backoff.h for a description of
+ * what these instructions are doing and how they have been choosen.
+ * To make a long story short, we are trying to yield the current cpu
+ * strand during busy loops.
+ */
 #define cpu_relax()	asm volatile("\n99:\n\t"			\
 				     "rd	%%ccr, %%g0\n\t"	\
 				     "rd	%%ccr, %%g0\n\t"	\
 				     "rd	%%ccr, %%g0\n\t"	\
-				     ".section	.pause_patch,\"ax\"\n\t"\
+				     ".section	.pause_3insn_patch,\"ax\"\n\t"\
 				     ".word	99b\n\t"		\
 				     "wr	%%g0, 128, %%asr27\n\t"	\
 				     "nop\n\t"				\
diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
index 51742df..cc3c5cb 100644
--- a/arch/sparc/kernel/entry.h
+++ b/arch/sparc/kernel/entry.h
@@ -63,8 +63,8 @@ struct pause_patch_entry {
 	unsigned int	addr;
 	unsigned int	insns[3];
 };
-extern struct pause_patch_entry __pause_patch,
-	__pause_patch_end;
+extern struct pause_patch_entry __pause_3insn_patch,
+	__pause_3insn_patch_end;
 
 extern void __init per_cpu_patch(void);
 extern void sun4v_patch_1insn_range(struct sun4v_1insn_patch_entry *,
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index b45cff4..0eaf005 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -320,8 +320,8 @@ static void __init pause_patch(void)
 {
 	struct pause_patch_entry *p;
 
-	p = &__pause_patch;
-	while (p < &__pause_patch_end) {
+	p = &__pause_3insn_patch;
+	while (p < &__pause_3insn_patch_end) {
 		unsigned long i, addr = p->addr;
 
 		for (i = 0; i < 3; i++) {
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 847f9f7..0bacceb 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -132,10 +132,10 @@ SECTIONS
 		*(.popc_6insn_patch)
 		__popc_6insn_patch_end = .;
 	}
-	.pause_patch : {
-		__pause_patch = .;
-		*(.pause_patch)
-		__pause_patch_end = .;
+	.pause_3insn_patch : {
+		__pause_3insn_patch = .;
+		*(.pause_3insn_patch)
+		__pause_3insn_patch_end = .;
 	}
 	PERCPU_SECTION(SMP_CACHE_BYTES)
 
-- 
1.7.12.2.dirty


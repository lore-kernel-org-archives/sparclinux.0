From: David Miller <davem@davemloft.net>
Date: Thu, 04 Oct 2012 21:48:12 +0000
Subject: [RESEND PATCH 1/2] sparc64: Rearrange thread info to cheaply clear syscall noerror state.
Message-Id: <20121004.174812.706050126936137696.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


[ Resending as it didn't hit the list the first time for whatever reason ]

From: Al Viro <viro@zeniv.linux.org.uk>

After fixing a couple of brainos, it even seems to work.  What's done here
is move of ->syscall_noerror right before FPDEPTH byte in ->flags and
using sth to [%g6 + TI_SYS_NOERROR] instead of stb to [%g6 + TI_FPDEPTH] in
both branches of etrap_save.  AFAICS, that ought to be solid.  Again,
deciding what to do with now unused delay slot of branch on ->syscall_noerror
and dealing with the order of tests in ret_from_sys is a separate question,
but at least that way we don't have to clean ->syscall_noerror in there at
all.  AFAICS, it ought to be a clear win - sth is not going to cost more than
stb on etrap_64.S side of things, and we are losing write on syscalls.S one.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/ptrace.h         |    4 +---
 arch/sparc/include/asm/thread_info_64.h |   16 ++++++++++------
 arch/sparc/kernel/etrap_64.S            |    8 ++++++--
 arch/sparc/kernel/syscalls.S            |    4 ++--
 arch/sparc/kernel/traps_64.c            |    2 --
 5 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/include/asm/ptrace.h b/arch/sparc/include/asm/ptrace.h
index fd9c3f2..eeed804 100644
--- a/arch/sparc/include/asm/ptrace.h
+++ b/arch/sparc/include/asm/ptrace.h
@@ -202,9 +202,7 @@ struct global_reg_snapshot {
 };
 extern struct global_reg_snapshot global_reg_snapshot[NR_CPUS];
 
-#define force_successful_syscall_return()	    \
-do {	current_thread_info()->syscall_noerror = 1; \
-} while (0)
+#define force_successful_syscall_return() set_thread_noerror(1)
 #define user_mode(regs) (!((regs)->tstate & TSTATE_PRIV))
 #define instruction_pointer(regs) ((regs)->tpc)
 #define instruction_pointer_set(regs, val) ((regs)->tpc = (val))
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index cfa8c38..8511e5f 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -18,10 +18,12 @@
 #define TI_FLAG_CWP_SHIFT		40
 #define TI_FLAG_BYTE_CURRENT_DS		3
 #define TI_FLAG_CURRENT_DS_SHIFT	32
-#define TI_FLAG_BYTE_FPDEPTH		4
-#define TI_FLAG_FPDEPTH_SHIFT		24
-#define TI_FLAG_BYTE_WSAVED		5
-#define TI_FLAG_WSAVED_SHIFT		16
+#define TI_FLAG_BYTE_NOERROR		4
+#define TI_FLAG_BYTE_NOERROR_SHIFT	24
+#define TI_FLAG_BYTE_FPDEPTH		5
+#define TI_FLAG_FPDEPTH_SHIFT		16
+#define TI_FLAG_BYTE_WSAVED		6
+#define TI_FLAG_WSAVED_SHIFT		8
 
 #include <asm/page.h>
 
@@ -47,7 +49,7 @@ struct thread_info {
 	struct exec_domain	*exec_domain;
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 	__u8			new_child;
-	__u8			syscall_noerror;
+	__u8			__pad;
 	__u16			cpu;
 
 	unsigned long		*utraps;
@@ -77,6 +79,7 @@ struct thread_info {
 #define TI_CURRENT_DS	(TI_FLAGS + TI_FLAG_BYTE_CURRENT_DS)
 #define TI_FPDEPTH	(TI_FLAGS + TI_FLAG_BYTE_FPDEPTH)
 #define TI_WSAVED	(TI_FLAGS + TI_FLAG_BYTE_WSAVED)
+#define TI_SYS_NOERROR	(TI_FLAGS + TI_FLAG_BYTE_NOERROR)
 #define TI_FPSAVED	0x00000010
 #define TI_KSP		0x00000018
 #define TI_FAULT_ADDR	0x00000020
@@ -84,7 +87,6 @@ struct thread_info {
 #define TI_EXEC_DOMAIN	0x00000030
 #define TI_PRE_COUNT	0x00000038
 #define TI_NEW_CHILD	0x0000003c
-#define TI_SYS_NOERROR	0x0000003d
 #define TI_CPU		0x0000003e
 #define TI_UTRAPS	0x00000040
 #define TI_REG_WINDOW	0x00000048
@@ -155,6 +157,8 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define set_thread_cwp(val)		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_CWP] = (val))
 #define get_thread_current_ds()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_CURRENT_DS])
 #define set_thread_current_ds(val)	(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_CURRENT_DS] = (val))
+#define get_thread_noerror()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_NOERROR])
+#define set_thread_noerror(val)		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_NOERROR] = (val))
 #define get_thread_fpdepth()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_FPDEPTH])
 #define set_thread_fpdepth(val)		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_FPDEPTH] = (val))
 #define get_thread_wsaved()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_WSAVED])
diff --git a/arch/sparc/kernel/etrap_64.S b/arch/sparc/kernel/etrap_64.S
index 786b185..1276ca2 100644
--- a/arch/sparc/kernel/etrap_64.S
+++ b/arch/sparc/kernel/etrap_64.S
@@ -92,8 +92,10 @@ etrap_save:	save	%g2, -STACK_BIAS, %sp
 		rdpr	%wstate, %g2
 		wrpr	%g0, 0, %canrestore
 		sll	%g2, 3, %g2
+
+		/* Set TI_SYS_FPDEPTH to 1 and clear TI_SYS_NOERROR.  */
 		mov	1, %l5
-		stb	%l5, [%l6 + TI_FPDEPTH]
+		sth	%l5, [%l6 + TI_SYS_NOERROR]
 
 		wrpr	%g3, 0, %otherwin
 		wrpr	%g2, 0, %wstate
@@ -152,7 +154,9 @@ etrap_save:	save	%g2, -STACK_BIAS, %sp
 		add	%l6, TI_FPSAVED + 1, %l4
 		srl	%l5, 1, %l3
 		add	%l5, 2, %l5
-		stb	%l5, [%l6 + TI_FPDEPTH]
+
+		/* Set TI_SYS_FPDEPTH to %l5 and clear TI_SYS_NOERROR.  */
+		sth	%l5, [%l6 + TI_SYS_NOERROR]
 		ba,pt	%xcc, 2b
 		 stb	%g0, [%l4 + %l3]
 		nop
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index 1d7e274..ed277e2 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -221,8 +221,8 @@ ret_sys_call:
 	 * was invoked.
 	 */
 	ldub	[%g6 + TI_SYS_NOERROR], %l2
-	brnz,a,pn %l2, 80f
-	 stb	%g0, [%g6 + TI_SYS_NOERROR]
+	brnz,pn %l2, 80f
+	 nop
 
 	cmp	%o0, -ERESTART_RESTARTBLOCK
 	bgeu,pn	%xcc, 1f
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index fa1f1d3..82af591 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2547,8 +2547,6 @@ void __init trap_init(void)
 		     TI_PRE_COUNT != offsetof(struct thread_info,
 					      preempt_count) ||
 		     TI_NEW_CHILD != offsetof(struct thread_info, new_child) ||
-		     TI_SYS_NOERROR != offsetof(struct thread_info,
-						syscall_noerror) ||
 		     TI_RESTART_BLOCK != offsetof(struct thread_info,
 						  restart_block) ||
 		     TI_KUNA_REGS != offsetof(struct thread_info,
-- 
1.7.10.4


From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Sat, 06 Oct 2012 06:06:09 +0000
Subject: Re: [RESEND PATCH 1/2] sparc64: Rearrange thread info to cheaply clear syscall noerror state.
Message-Id: <20121006060608.GF2616@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20121004.174812.706050126936137696.davem@davemloft.net>
In-Reply-To: <20121004.174812.706050126936137696.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Oct 05, 2012 at 10:43:43PM -0400, David Miller wrote:
> From: Al Viro <viro@ZenIV.linux.org.uk>
> Date: Sat, 6 Oct 2012 00:26:51 +0100
> 
> > On Fri, Oct 05, 2012 at 05:48:42PM -0400, David Miller wrote:
> >> 
> >> Al, this change turns out to be broken.
> >> 
> >> If you move the WSAVED byte down past bit 16, it runs into the bit
> >> mask we for the _TI_* flag bits down lower in the file.
> > 
> > Umm...  Right you are.  I wonder why I hadn't stepped into that while
> > testing that sucker... 
> 
> I tested it for 20 hours and didn't hit any problems, so don't feel
> bad. :-)

OK, that seems to work; wsaved left where it was.  One potential side
benefit is in switch_to(), but I hadn't tried to exploit it; the thing
is, thread_info->cpu and thread_info->current_ds are next to each other,
so we could, in principle, try to exploit that.  It doesn't help with
dcache footprint (we need cwp and ->task, so the context switch still
hits both thread_info..thread_info+31 and thread_info+32..thread_info+63
anyway), but it looks like it could be made slightly shorter.  Hell
knows; we have lduh and ldub from addresses next to each other (62 and 61
from the current_thread_info(), resp.), so the first one will preload
dcache from the second...

commit 7f41e733823032a8425477cd38c8718fd81a7c00
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed Sep 26 01:21:14 2012 -0400

    sparc64: clear syscall_noerror on the entry to syscall, not on the exit
    
    Move that sucker to just before TI_FPDEPTH and replace stb with sth in
    etrap_save().  Take current_ds to its old place, so that we don't push
    wsaved into TI_... flags.  That allows to lose clearing syscall_noerror
    on return from syscall.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

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
diff --git a/arch/sparc/include/asm/switch_to_64.h b/arch/sparc/include/asm/switch_to_64.h
index 7923c4a..cad36f5 100644
--- a/arch/sparc/include/asm/switch_to_64.h
+++ b/arch/sparc/include/asm/switch_to_64.h
@@ -23,7 +23,7 @@ do {	flush_tlb_pending();						\
 	/* If you are tempted to conditionalize the following */	\
 	/* so that ASI is only written if it changes, think again. */	\
 	__asm__ __volatile__("wr %%g0, %0, %%asi"			\
-	: : "r" (__thread_flag_byte_ptr(task_thread_info(next))[TI_FLAG_BYTE_CURRENT_DS]));\
+	: : "r" (task_thread_info(next)->current_ds));\
 	trap_block[current_thread_info()->cpu].thread =			\
 		task_thread_info(next);					\
 	__asm__ __volatile__(						\
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index cfa8c38..389c1e7 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -14,12 +14,12 @@
 #define TI_FLAG_FAULT_CODE_SHIFT	56
 #define TI_FLAG_BYTE_WSTATE		1
 #define TI_FLAG_WSTATE_SHIFT		48
-#define TI_FLAG_BYTE_CWP		2
-#define TI_FLAG_CWP_SHIFT		40
-#define TI_FLAG_BYTE_CURRENT_DS		3
-#define TI_FLAG_CURRENT_DS_SHIFT	32
-#define TI_FLAG_BYTE_FPDEPTH		4
-#define TI_FLAG_FPDEPTH_SHIFT		24
+#define TI_FLAG_BYTE_NOERROR		2
+#define TI_FLAG_BYTE_NOERROR_SHIFT	40
+#define TI_FLAG_BYTE_FPDEPTH		3
+#define TI_FLAG_FPDEPTH_SHIFT		32
+#define TI_FLAG_BYTE_CWP		4
+#define TI_FLAG_CWP_SHIFT		24
 #define TI_FLAG_BYTE_WSAVED		5
 #define TI_FLAG_WSAVED_SHIFT		16
 
@@ -47,7 +47,7 @@ struct thread_info {
 	struct exec_domain	*exec_domain;
 	int			preempt_count;	/* 0 => preemptable, <0 => BUG */
 	__u8			new_child;
-	__u8			syscall_noerror;
+	__u8			current_ds;
 	__u16			cpu;
 
 	unsigned long		*utraps;
@@ -74,9 +74,9 @@ struct thread_info {
 #define TI_FAULT_CODE	(TI_FLAGS + TI_FLAG_BYTE_FAULT_CODE)
 #define TI_WSTATE	(TI_FLAGS + TI_FLAG_BYTE_WSTATE)
 #define TI_CWP		(TI_FLAGS + TI_FLAG_BYTE_CWP)
-#define TI_CURRENT_DS	(TI_FLAGS + TI_FLAG_BYTE_CURRENT_DS)
 #define TI_FPDEPTH	(TI_FLAGS + TI_FLAG_BYTE_FPDEPTH)
 #define TI_WSAVED	(TI_FLAGS + TI_FLAG_BYTE_WSAVED)
+#define TI_SYS_NOERROR	(TI_FLAGS + TI_FLAG_BYTE_NOERROR)
 #define TI_FPSAVED	0x00000010
 #define TI_KSP		0x00000018
 #define TI_FAULT_ADDR	0x00000020
@@ -84,7 +84,7 @@ struct thread_info {
 #define TI_EXEC_DOMAIN	0x00000030
 #define TI_PRE_COUNT	0x00000038
 #define TI_NEW_CHILD	0x0000003c
-#define TI_SYS_NOERROR	0x0000003d
+#define TI_CURRENT_DS	0x0000003d
 #define TI_CPU		0x0000003e
 #define TI_UTRAPS	0x00000040
 #define TI_REG_WINDOW	0x00000048
@@ -121,7 +121,7 @@ struct thread_info {
 #define INIT_THREAD_INFO(tsk)				\
 {							\
 	.task		=	&tsk,			\
-	.flags		= ((unsigned long)ASI_P) << TI_FLAG_CURRENT_DS_SHIFT,	\
+	.current_ds	=	ASI_P,			\
 	.exec_domain	=	&default_exec_domain,	\
 	.preempt_count	=	INIT_PREEMPT_COUNT,	\
 	.restart_block	= {				\
@@ -153,13 +153,12 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define set_thread_wstate(val)		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_WSTATE] = (val))
 #define get_thread_cwp()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_CWP])
 #define set_thread_cwp(val)		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_CWP] = (val))
-#define get_thread_current_ds()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_CURRENT_DS])
-#define set_thread_current_ds(val)	(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_CURRENT_DS] = (val))
+#define get_thread_noerror()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_NOERROR])
+#define set_thread_noerror(val)		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_NOERROR] = (val))
 #define get_thread_fpdepth()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_FPDEPTH])
 #define set_thread_fpdepth(val)		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_FPDEPTH] = (val))
 #define get_thread_wsaved()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_WSAVED])
 #define set_thread_wsaved(val)		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_WSAVED] = (val))
-
 #endif /* !(__ASSEMBLY__) */
 
 /*
diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index 7c831d8..3eef541 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -38,14 +38,14 @@
 #define VERIFY_READ	0
 #define VERIFY_WRITE	1
 
-#define get_fs() ((mm_segment_t) { get_thread_current_ds() })
+#define get_fs() ((mm_segment_t){(current_thread_info()->current_ds)})
 #define get_ds() (KERNEL_DS)
 
 #define segment_eq(a,b)  ((a).seg = (b).seg)
 
 #define set_fs(val)								\
 do {										\
-	set_thread_current_ds((val).seg);					\
+	current_thread_info()->current_ds =(val).seg;				\
 	__asm__ __volatile__ ("wr %%g0, %0, %%asi" : : "r" ((val).seg));	\
 } while(0)
 
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
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index aff0c72..aa6d72c 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -557,9 +557,8 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 			    (THREAD_SIZE - child_stack_sz));
 	memcpy(child_trap_frame, parent_sf, child_stack_sz);
 
-	t->flags = (t->flags & ~((0xffUL << TI_FLAG_CWP_SHIFT) |
-				 (0xffUL << TI_FLAG_CURRENT_DS_SHIFT))) |
-		(((regs->tstate + 1) & TSTATE_CWP) << TI_FLAG_CWP_SHIFT);
+	__thread_flag_byte_ptr(t)[TI_FLAG_BYTE_CWP] = 
+		(regs->tstate + 1) & TSTATE_CWP;
 	t->new_child = 1;
 	t->ksp = ((unsigned long) child_trap_frame) - STACK_BIAS;
 	t->kregs = (struct pt_regs *) (child_trap_frame +
@@ -575,7 +574,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 		t->kregs->u_regs[UREG_FP]  		  ((unsigned long) child_sf) - STACK_BIAS;
 
-		t->flags |= ((long)ASI_P << TI_FLAG_CURRENT_DS_SHIFT);
+		t->current_ds = ASI_P;
 		t->kregs->u_regs[UREG_G6] = (unsigned long) t;
 		t->kregs->u_regs[UREG_G4] = (unsigned long) t->task;
 	} else {
@@ -584,7 +583,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
 			regs->u_regs[UREG_FP] &= 0x00000000ffffffffUL;
 		}
 		t->kregs->u_regs[UREG_FP] = sp;
-		t->flags |= ((long)ASI_AIUS << TI_FLAG_CURRENT_DS_SHIFT);
+		t->current_ds = ASI_AIUS;
 		if (sp != regs->u_regs[UREG_FP]) {
 			unsigned long csp;
 
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
index 3b05e66..b3c337c 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2547,8 +2547,8 @@ void __init trap_init(void)
 		     TI_PRE_COUNT != offsetof(struct thread_info,
 					      preempt_count) ||
 		     TI_NEW_CHILD != offsetof(struct thread_info, new_child) ||
-		     TI_SYS_NOERROR != offsetof(struct thread_info,
-						syscall_noerror) ||
+		     TI_CURRENT_DS != offsetof(struct thread_info,
+						current_ds) ||
 		     TI_RESTART_BLOCK != offsetof(struct thread_info,
 						  restart_block) ||
 		     TI_KUNA_REGS != offsetof(struct thread_info,
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 696bb09..ce32e9f 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -615,7 +615,8 @@ static void __init inherit_prom_mappings(void)
 void prom_world(int enter)
 {
 	if (!enter)
-		set_fs((mm_segment_t) { get_thread_current_ds() });
+		__asm__ __volatile__ ("wr %%g0, %0, %%asi" : :
+			"r" (current_thread_info()->current_ds ));
 
 	__asm__ __volatile__("flushw");
 }

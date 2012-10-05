From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Fri, 05 Oct 2012 23:26:51 +0000
Subject: Re: [RESEND PATCH 1/2] sparc64: Rearrange thread info to cheaply clear syscall noerror state.
Message-Id: <20121005232651.GC2616@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20121004.174812.706050126936137696.davem@davemloft.net>
In-Reply-To: <20121004.174812.706050126936137696.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Oct 05, 2012 at 05:48:42PM -0400, David Miller wrote:
> 
> Al, this change turns out to be broken.
> 
> If you move the WSAVED byte down past bit 16, it runs into the bit
> mask we for the _TI_* flag bits down lower in the file.

Umm...  Right you are.  I wonder why I hadn't stepped into that while
testing that sucker...  Could we simply move current_ds at the place
we'd cleared from noerror and take wsaved at its place?  AFAICS, that
ought to work without any penalties.  IOW, something like this:

sparc64: clear syscall_noerror on the entry to syscall, not on the exit
    
Move that sucker to just before TI_FPDEPTH and replace stb with sth in
etrap_save().  Take current_ds to its old place, so that we don't push
wsaved into TI_... flags.  That allows to lose clearing syscall_noerror
on return from syscall.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/arch/sparc/include/asm/ptrace.h b/arch/sparc/include/asm/ptrace.h
index fd9c3f2..22142aa 100644
--- a/arch/sparc/include/asm/ptrace.h
+++ b/arch/sparc/include/asm/ptrace.h
@@ -203,7 +203,7 @@ struct global_reg_snapshot {
 extern struct global_reg_snapshot global_reg_snapshot[NR_CPUS];
 
 #define force_successful_syscall_return()	    \
-do {	current_thread_info()->syscall_noerror = 1; \
+do {	((u8 *)&current_thread_info()->flags)[TI_FLAG_BYTE_NOERROR] = 1; \
 } while (0)
 #define user_mode(regs) (!((regs)->tstate & TSTATE_PRIV))
 #define instruction_pointer(regs) ((regs)->tpc)
diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index cfa8c38..8531205 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -16,12 +16,12 @@
 #define TI_FLAG_WSTATE_SHIFT		48
 #define TI_FLAG_BYTE_CWP		2
 #define TI_FLAG_CWP_SHIFT		40
-#define TI_FLAG_BYTE_CURRENT_DS		3
-#define TI_FLAG_CURRENT_DS_SHIFT	32
-#define TI_FLAG_BYTE_FPDEPTH		4
-#define TI_FLAG_FPDEPTH_SHIFT		24
-#define TI_FLAG_BYTE_WSAVED		5
-#define TI_FLAG_WSAVED_SHIFT		16
+#define TI_FLAG_BYTE_WSAVED		3
+#define TI_FLAG_WSAVED_SHIFT		32
+#define TI_FLAG_BYTE_NOERROR		4
+#define TI_FLAG_BYTE_NOERROR_SHIFT	24
+#define TI_FLAG_BYTE_FPDEPTH		5
+#define TI_FLAG_FPDEPTH_SHIFT		16
 
 #include <asm/page.h>
 
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
@@ -153,8 +153,8 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define set_thread_wstate(val)		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_WSTATE] = (val))
 #define get_thread_cwp()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_CWP])
 #define set_thread_cwp(val)		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_CWP] = (val))
-#define get_thread_current_ds()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_CURRENT_DS])
-#define set_thread_current_ds(val)	(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_CURRENT_DS] = (val))
+#define get_thread_current_ds()		(current_thread_info()->current_ds)
+#define set_thread_current_ds(val)	(current_thread_info()->current_ds = (val))
 #define get_thread_fpdepth()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_FPDEPTH])
 #define set_thread_fpdepth(val)		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_FPDEPTH] = (val))
 #define get_thread_wsaved()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_WSAVED])
diff --git a/arch/sparc/kernel/etrap_64.S b/arch/sparc/kernel/etrap_64.S
index 786b185..759a2d3 100644
--- a/arch/sparc/kernel/etrap_64.S
+++ b/arch/sparc/kernel/etrap_64.S
@@ -93,7 +93,7 @@ etrap_save:	save	%g2, -STACK_BIAS, %sp
 		wrpr	%g0, 0, %canrestore
 		sll	%g2, 3, %g2
 		mov	1, %l5
-		stb	%l5, [%l6 + TI_FPDEPTH]
+		sth	%l5, [%l6 + TI_SYS_NOERROR]	! set fpdepth, clear noerror
 
 		wrpr	%g3, 0, %otherwin
 		wrpr	%g2, 0, %wstate
@@ -152,7 +152,7 @@ etrap_save:	save	%g2, -STACK_BIAS, %sp
 		add	%l6, TI_FPSAVED + 1, %l4
 		srl	%l5, 1, %l3
 		add	%l5, 2, %l5
-		stb	%l5, [%l6 + TI_FPDEPTH]
+		sth	%l5, [%l6 + TI_SYS_NOERROR]	! set fpdepth, clear noerror
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

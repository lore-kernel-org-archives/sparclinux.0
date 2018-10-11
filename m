From: David Miller <davem@davemloft.net>
Date: Thu, 11 Oct 2018 04:19:48 +0000
Subject: [PATCH WIP 1/2] sparc: Add rseq support.
Message-Id: <20181010.211948.351460348799253220.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

    
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e6f2a38d2e61..1ee5721c6874 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -33,6 +33,7 @@ config SPARC
 	select HAVE_CBPF_JIT if SPARC32
 	select HAVE_EBPF_JIT if SPARC64
 	select HAVE_DEBUG_BUGVERBOSE
+	select HAVE_RSEQ
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_STRNCPY_FROM_USER
diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index 45b4bf1875e6..0e6d7a062db7 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -428,8 +428,9 @@
 #define __NR_pwritev2		359
 #define __NR_statx		360
 #define __NR_io_pgetevents	361
+#define __NR_rseq		362
 
-#define NR_syscalls		362
+#define NR_syscalls		363
 
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 4d3696973325..4f49626fa90e 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -1018,6 +1018,11 @@ do_syscall:
 	st	%o0, [%sp + STACKFRAME_SZ + PT_I0]
 
 ret_sys_call:
+#ifdef CONFIG_DEBUG_RSEQ
+	call	rseq_syscall
+	 add	%sp, STACKFRAME_SZ, %o0
+	ld	[%sp + STACKFRAME_SZ + PT_I0], %o0
+#endif	
 	ld	[%curptr + TI_FLAGS], %l6
 	cmp	%o0, -ERESTART_RESTARTBLOCK
 	ld	[%sp + STACKFRAME_SZ + PT_PSR], %g3
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index 44d379db3f64..6a713c99c935 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -614,6 +614,8 @@ static inline void handle_signal32(struct ksignal *ksig,
 	sigset_t *oldset = sigmask_to_save();
 	int err;
 
+	rseq_signal_deliver(ksig, regs);
+
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
 		err = setup_rt_frame32(ksig, regs, oldset);
 	else
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 5665261cee37..9e5c75cd16ee 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -422,6 +422,8 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	sigset_t *oldset = sigmask_to_save();
 	int err;
 
+	rseq_signal_deliver(ksig, regs);
+
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
 		err = setup_rt_frame(ksig, regs, oldset);
 	else
@@ -527,6 +529,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0,
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
+		rseq_handle_notify_resume(NULL, regs);
 	}
 }
 
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 48366e5eb5b2..8129f5bc2cbb 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -355,6 +355,8 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	int wsaved, err, sf_size;
 	void __user *tail;
 
+	rseq_signal_deliver(ksig, regs);
+
 	/* 1. Make sure everything is clean */
 	synchronize_user_stack();
 	save_and_clear_fpu();
@@ -550,6 +552,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0, unsigned long
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
+		rseq_handle_notify_resume(NULL, regs);
 	}
 	user_enter();
 }
diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
index db42b4fb3708..52a9eae74f12 100644
--- a/arch/sparc/kernel/syscalls.S
+++ b/arch/sparc/kernel/syscalls.S
@@ -255,6 +255,11 @@ linux_sparc_syscall:
 
 3:	stx	%o0, [%sp + PTREGS_OFF + PT_V9_I0]
 ret_sys_call:
+#ifdef CONFIG_DEBUG_RSEQ
+	call	rseq_syscall
+	 add	%sp, PTREGS_OFF, %o0
+	ldx	[%sp + PTREGS_OFF + PT_V9_I0], %o0
+#endif	
 	ldx	[%sp + PTREGS_OFF + PT_V9_TSTATE], %g3
 	mov	%ulo(TSTATE_XCARRY | TSTATE_ICARRY), %g2
 	sllx	%g2, 32, %g2
diff --git a/arch/sparc/kernel/systbls_32.S b/arch/sparc/kernel/systbls_32.S
index 621a363098ec..89deba8a7264 100644
--- a/arch/sparc/kernel/systbls_32.S
+++ b/arch/sparc/kernel/systbls_32.S
@@ -90,4 +90,4 @@ sys_call_table:
 /*345*/	.long sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.long sys_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
 /*355*/	.long sys_setsockopt, sys_mlock2, sys_copy_file_range, sys_preadv2, sys_pwritev2
-/*360*/	.long sys_statx, sys_io_pgetevents
+/*360*/	.long sys_statx, sys_io_pgetevents, sys_rseq
diff --git a/arch/sparc/kernel/systbls_64.S b/arch/sparc/kernel/systbls_64.S
index bb68c805b891..f9eccfd54eff 100644
--- a/arch/sparc/kernel/systbls_64.S
+++ b/arch/sparc/kernel/systbls_64.S
@@ -173,4 +173,4 @@ sys_call_table:
 	.word sys_renameat2, sys_seccomp, sys_getrandom, sys_memfd_create, sys_bpf
 /*350*/	.word sys64_execveat, sys_membarrier, sys_userfaultfd, sys_bind, sys_listen
 	.word sys_setsockopt, sys_mlock2, sys_copy_file_range, sys_preadv2, sys_pwritev2
-/*360*/	.word sys_statx, sys_io_pgetevents
+/*360*/	.word sys_statx, sys_io_pgetevents, sys_rseq

Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF82BE629;
	Mon, 26 Jan 2026 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447019; cv=none; b=gmCbzPYaLyQZGP8gYb4wY4V12wlUuCbxW92qinkZ4JCInSAu1079YbV43uAj0PaNRazsASQATCaQZPBMGwvm4R4qS3tKkf3avv1eUphPSCavhtEAZ1f+Ul9x0C4ln3EQyP0FNHiOUE0bEqRi+QZ1dGLt/EDRRGg8nyeOVNLBBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447019; c=relaxed/simple;
	bh=rw7KIPsO8h4GQPE7GIE9WZXrP0bY9EfrcCnalVL4YZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hECqOAQ833j/BFF93ZxY/XlcB+0MA9kenW5Wt3ZL1mlg1Pe0eIe5zmKdpYlcPUu+TOIoHPj9F+PikKKsic1hzM7lWMoviyg+FDDQd5CnJG2DFCwvY4+eBU2uD3v7fChO5Pcyz9yTfYeOAN1s7Yg3fNCQ//NXJFpCZJ+nA6Bnto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Wg07S4fw reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Wg07S4fw"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f0FHD0h6Fz1DHpY;
	Mon, 26 Jan 2026 18:03:36 +0100 (CET)
Received: from [10.10.15.30] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f0FHC3Mpqz1DHbd;
	Mon, 26 Jan 2026 18:03:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769447015;
	bh=mEJOibruBiv6vNISyE0Rc0M4DfURwzmVFuaa5JQVwTo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Wg07S4fw4kUOsowsuPzs34ED0/xMOQZIu0rMh5g/Jzkgb4fBEZ9Dfp9zDL3H2RI3R
	 DUqktSlyIpj5mXhBLB8eH1q+UzGm0BoDGweL112OH+Csqtua3qBM0aajJPHL+Jp4Us
	 zQEql9OfLgZWHVC8MX9Hv0PSKJRXaX9r0Dst+nfCpA0/UvqnES+MtkyR7FjN5Tnhk0
	 xJRsBOkYxEulwIkCOYI+A11BzWA/YpPra7CbYHmhSh8mlFOxX+ADS/udC30cntY66W
	 w29I11WZdxmbh0k3hwzhgndv1y0cNV8pnSn+oRY6DXXH2DbOChGqfgnwyUHB4D2R25
	 iWH4sTDyPpeww==
Message-ID: <a270f924-22ca-450f-b3f6-826e3d2676d2@gaisler.com>
Date: Mon, 26 Jan 2026 18:03:34 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] sparc: Add architecture support for clone3
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>, davem@davemloft.net,
 brauner@kernel.org, shuah@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de, glaubitz@physik.fu-berlin.de,
 geert@linux-m68k.org, schuster.simon@siemens-energy.com, jrtc27@jrtc27.com
References: <20260119144753.27945-1-ludwig.rydberg@gaisler.com>
 <20260119144753.27945-3-ludwig.rydberg@gaisler.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260119144753.27945-3-ludwig.rydberg@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-19 15:47, Ludwig Rydberg wrote:
> Add support for the clone3 system call to the SPARC architectures.
> 
> The implementation follows the pattern of the original clone syscall.
> However, instead of explicitly calling kernel_clone, the clone3
> handler calls the generic sys_clone3 handler in kernel/fork.
> In case no stack is provided, the parents stack is reused.
> 
> The return value convention for clone3 follows the regular kernel return
> value convention (in contrast to the original clone/fork on SPARC).
> 
> Closes: https://github.com/sparclinux/issues/issues/10
> Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
> ---
>  arch/sparc/include/asm/syscalls.h      |  1 +
>  arch/sparc/include/asm/unistd.h        |  2 --
>  arch/sparc/kernel/entry.S              | 15 ++++++++++++++
>  arch/sparc/kernel/kernel.h             |  1 +
>  arch/sparc/kernel/process.c            | 14 +++++++++++++
>  arch/sparc/kernel/process_32.c         | 23 ++++++++++++++++------
>  arch/sparc/kernel/process_64.c         | 27 ++++++++++++++++++++------
>  arch/sparc/kernel/syscalls.S           |  8 ++++++++
>  arch/sparc/kernel/syscalls/syscall.tbl |  2 +-
>  9 files changed, 78 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/syscalls.h b/arch/sparc/include/asm/syscalls.h
> index 35575fbfb9dc..282e62b66518 100644
> --- a/arch/sparc/include/asm/syscalls.h
> +++ b/arch/sparc/include/asm/syscalls.h
> @@ -7,5 +7,6 @@ struct pt_regs;
>  asmlinkage long sparc_fork(struct pt_regs *regs);
>  asmlinkage long sparc_vfork(struct pt_regs *regs);
>  asmlinkage long sparc_clone(struct pt_regs *regs);
> +asmlinkage long sparc_clone3(struct pt_regs *regs);
>  
>  #endif /* _SPARC64_SYSCALLS_H */
> diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
> index 3380411a4537..d6bc76706a7a 100644
> --- a/arch/sparc/include/asm/unistd.h
> +++ b/arch/sparc/include/asm/unistd.h
> @@ -49,8 +49,6 @@
>  #define __ARCH_WANT_COMPAT_STAT
>  #endif
>  
> -#define __ARCH_BROKEN_SYS_CLONE3
> -
>  #ifdef __32bit_syscall_numbers__
>  /* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
>   * it never had the plain ones and there is no value to adding those
> diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
> index a3fdee4cd6fa..ea51ef52c952 100644
> --- a/arch/sparc/kernel/entry.S
> +++ b/arch/sparc/kernel/entry.S
> @@ -907,6 +907,21 @@ flush_patch_four:
>  	jmpl	%l1 + %lo(sparc_vfork), %g0
>  	 add	%sp, STACKFRAME_SZ, %o0
>  
> +	.globl	__sys_clone3, flush_patch_five
> +__sys_clone3:
> +	mov	%o7, %l5
> +flush_patch_five:
> +	FLUSH_ALL_KERNEL_WINDOWS;
> +	ld	[%curptr + TI_TASK], %o4
> +	rd	%psr, %g4
> +	WRITE_PAUSE
> +	rd	%wim, %g5
> +	WRITE_PAUSE
> +	std	%g4, [%o4 + AOFF_task_thread + AOFF_thread_fork_kpsr]
> +	add	%sp, STACKFRAME_SZ, %o0
> +	call	sparc_clone3
> +	 mov	%l5, %o7
> +
>          .align  4
>  linux_sparc_ni_syscall:
>  	sethi   %hi(sys_ni_syscall), %l7
> diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
> index 8328a3b78a44..4ee85051521a 100644
> --- a/arch/sparc/kernel/kernel.h
> +++ b/arch/sparc/kernel/kernel.h
> @@ -18,6 +18,7 @@ extern int ncpus_probed;
>  asmlinkage long sparc_clone(struct pt_regs *regs);
>  asmlinkage long sparc_fork(struct pt_regs *regs);
>  asmlinkage long sparc_vfork(struct pt_regs *regs);
> +asmlinkage long sparc_clone3(struct pt_regs *regs);
>  
>  #ifdef CONFIG_SPARC64
>  /* setup_64.c */
> diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
> index 7d69877511fa..d72fa0665943 100644
> --- a/arch/sparc/kernel/process.c
> +++ b/arch/sparc/kernel/process.c
> @@ -12,6 +12,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/signal.h>
> +#include <linux/syscalls.h>
>  
>  #include "kernel.h"
>  
> @@ -118,3 +119,16 @@ asmlinkage long sparc_clone(struct pt_regs *regs)
>  
>  	return ret;
>  }
> +
> +asmlinkage long sparc_clone3(struct pt_regs *regs)
> +{
> +	unsigned long sz;
> +	struct clone_args __user *cl_args;
> +
> +	synchronize_user_stack();
> +
> +	cl_args = (struct clone_args __user *)regs->u_regs[UREG_I0];
> +	sz = regs->u_regs[UREG_I1];
> +
> +	return sys_clone3(cl_args, sz);
> +}
> diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
> index 5a28c0e91bf1..dd8c6c02b0f1 100644
> --- a/arch/sparc/kernel/process_32.c
> +++ b/arch/sparc/kernel/process_32.c
> @@ -247,6 +247,8 @@ clone_stackframe(struct sparc_stackf __user *dst,
>   * Parent -->  %o0 == childs  pid, %o1 == 0
>   * Child  -->  %o0 == parents pid, %o1 == 1
>   *
> + * clone3() - Uses regular kernel return value conventions
> + *
>   * NOTE: We have a separate fork kpsr/kwim because
>   *       the parent could change these values between
>   *       sys_fork invocation and when we reach here
> @@ -261,11 +263,11 @@ extern void ret_from_kernel_thread(void);
>  int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  {
>  	u64 clone_flags = args->flags;
> -	unsigned long sp = args->stack;
>  	unsigned long tls = args->tls;
>  	struct thread_info *ti = task_thread_info(p);
>  	struct pt_regs *childregs, *regs = current_pt_regs();
>  	char *new_stack;
> +	unsigned long sp = args->stack ? args->stack : regs->u_regs[UREG_FP];
>  
>  #ifndef CONFIG_SMP
>  	if(last_task_used_math == current) {
> @@ -350,13 +352,22 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  	childregs->psr &= ~PSR_EF;
>  	clear_tsk_thread_flag(p, TIF_USEDFPU);
>  #endif
> +	/* Handle return value conventions */
> +	if (regs->u_regs[UREG_G1] == __NR_clone3) {
> +		/* clone3() - use regular kernel return value convention */
> +
> +		/* Set the return value for the child. */
> +		childregs->u_regs[UREG_I0] = 0;
> +	} else {
> +		/* clone()/fork() - use SunOS return value convention */
>  
> -	/* Set the return value for the child. */
> -	childregs->u_regs[UREG_I0] = current->pid;
> -	childregs->u_regs[UREG_I1] = 1;
> +		/* Set the return value for the child. */
> +		childregs->u_regs[UREG_I0] = current->pid;
> +		childregs->u_regs[UREG_I1] = 1;
>  
> -	/* Set the return value for the parent. */
> -	regs->u_regs[UREG_I1] = 0;
> +		/* Set the return value for the parent. */
> +		regs->u_regs[UREG_I1] = 0;
> +	}
>  
>  	if (clone_flags & CLONE_SETTLS)
>  		childregs->u_regs[UREG_G7] = tls;
> diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
> index 25781923788a..e889da8e4835 100644
> --- a/arch/sparc/kernel/process_64.c
> +++ b/arch/sparc/kernel/process_64.c
> @@ -564,17 +564,19 @@ void fault_in_user_windows(struct pt_regs *regs)
>   * under SunOS are nothing short of bletcherous:
>   * Parent -->  %o0 == childs  pid, %o1 == 0
>   * Child  -->  %o0 == parents pid, %o1 == 1
> + *
> + * clone3() - Uses regular kernel return value conventions
>   */
>  int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  {
>  	u64 clone_flags = args->flags;
> -	unsigned long sp = args->stack;
>  	unsigned long tls = args->tls;
>  	struct thread_info *t = task_thread_info(p);
>  	struct pt_regs *regs = current_pt_regs();
>  	struct sparc_stackf *parent_sf;
>  	unsigned long child_stack_sz;
>  	char *child_trap_frame;
> +	unsigned long sp = args->stack ? args->stack : regs->u_regs[UREG_FP];
>  
>  	/* Calculate offset to stack_frame & pt_regs */
>  	child_stack_sz = (STACKFRAME_SZ + TRACEREG_SZ);
> @@ -616,12 +618,25 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  	if (t->utraps)
>  		t->utraps[0]++;
>  
> -	/* Set the return value for the child. */
> -	t->kregs->u_regs[UREG_I0] = current->pid;
> -	t->kregs->u_regs[UREG_I1] = 1;
> +	/* Handle return value conventions */
> +	if (regs->u_regs[UREG_G1] == __NR_clone3) {
> +		/* clone3() - use regular kernel return value convention */
> +
> +		/* Set the return value for the child. */
> +		t->kregs->u_regs[UREG_I0] = 0;
> +
> +		/* Clear g1 to indicate user thread */
> +		t->kregs->u_regs[UREG_G1] = 0;
> +	} else {
> +		/* clone()/fork() - use SunOS return value convention */
> +
> +		/* Set the return value for the child. */
> +		t->kregs->u_regs[UREG_I0] = current->pid;
> +		t->kregs->u_regs[UREG_I1] = 1;
>  
> -	/* Set the second return value for the parent. */
> -	regs->u_regs[UREG_I1] = 0;
> +		/* Set the second return value for the parent. */
> +		regs->u_regs[UREG_I1] = 0;
> +	}
>  
>  	if (clone_flags & CLONE_SETTLS)
>  		t->kregs->u_regs[UREG_G7] = tls;
> diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
> index 0e8ab0602c36..96fe8763d70c 100644
> --- a/arch/sparc/kernel/syscalls.S
> +++ b/arch/sparc/kernel/syscalls.S
> @@ -103,6 +103,12 @@ sys_clone:
>  	ba,pt	%xcc, sparc_clone
>  	 add	%sp, PTREGS_OFF, %o0
>  
> +	.align	32
> +__sys_clone3:
> +	flushw
> +	ba,pt	%xcc, sparc_clone3
> +	 add	%sp, PTREGS_OFF, %o0
> +
>  	.globl	ret_from_fork
>  ret_from_fork:
>  	/* Clear current_thread_info()->new_child. */
> @@ -113,6 +119,8 @@ ret_from_fork:
>  	brnz,pt	%o0, ret_sys_call
>  	 ldx	[%g6 + TI_FLAGS], %l0
>  	ldx	[%sp + PTREGS_OFF + PT_V9_G1], %l1
> +	brz,pt	%l1, ret_sys_call
> +	 nop
>  	call	%l1
>  	 ldx	[%sp + PTREGS_OFF + PT_V9_G2], %o0
>  	ba,pt	%xcc, ret_sys_call
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
> index 39aa26b6a50b..c0307bb09892 100644
> --- a/arch/sparc/kernel/syscalls/syscall.tbl
> +++ b/arch/sparc/kernel/syscalls/syscall.tbl
> @@ -480,7 +480,7 @@
>  432	common	fsmount				sys_fsmount
>  433	common	fspick				sys_fspick
>  434	common	pidfd_open			sys_pidfd_open
> -# 435 reserved for clone3
> +435	common	clone3				__sys_clone3
>  436	common	close_range			sys_close_range
>  437	common	openat2			sys_openat2
>  438	common	pidfd_getfd			sys_pidfd_getfd

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Thanks,
Andreas


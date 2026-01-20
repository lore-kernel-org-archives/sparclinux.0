Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4255844D012;
	Tue, 20 Jan 2026 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934190; cv=none; b=qUT9K6+eJhFO20aL50/wPIUOxGOvryg2XK8YVT3A+Kmu0fz5FLGiRHoUTUoEK468DtPiiyXk83ZEH3LjR+bX4nuBP7njsYTC0ZBhjdlr5t779/WBn5TJa/539odv/IBqJZWiVZG+LcKBtoYi1ik+/C44BeMzSDdwMOf2isSlg+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934190; c=relaxed/simple;
	bh=Q0gh/+qP9d73ycX7K9fMug1nHr0xoM54Ue18v9RVVtM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BBXR+DtdwNGx+195gArNxBT1xkutP/+y0u1PvLjX9BD2vOLbzVM7ADpqxnBR2sPCvDqPyS88unXiApWbtNi6kvtmGfX/ldS9dKFLfnf2bAoE76pdeWFsQ2YZvVtG6k4slTeaJ96cKRZEW2i4jDvWeQVe88z+pZbdv67tu4L1wcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=h1w9faK7; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="h1w9faK7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=tF2zg7A3WHXcnOcrAAObHYY8FOEWr9D49EvwtJpgfVM=; t=1768934187;
	x=1769538987; b=h1w9faK72SO4DQshKiu8R1qbeoEghhcI+ZpCi6bX4+VcwA2nbyOw7ZVZE2nTp
	tVXfHH1nHgYt5OdFyCaDICqW6SF0makkRg99W8kHcVkkBMhHPSLekTfQssno3CZ+d+zLnxEHKovQM
	u9BL9zV3PRMBb5Kv5172sgqBf6cFh9tZqRbK9I7SVpVW5Miz6p0P1lB2tv9ofTIXaRyy9oQ3KrnXe
	j2bUHefZmjlB860FoTpbp+Ek9awh4a1qD8Y4dJfrb22C5pvhbxTClZGLkLdS+eGW1O2Wk+PNRUzKU
	lHUJP+wbqHPf/XvOYNez+Kgbe33n40Q8QXrNLp0pEbm+0+kTmA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1viGaV-00000003yUo-0f7B; Tue, 20 Jan 2026 19:36:23 +0100
Received: from p5dc55f29.dip0.t-ipconnect.de ([93.197.95.41] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1viGaU-00000000QG9-3gPv; Tue, 20 Jan 2026 19:36:23 +0100
Message-ID: <19a5e4418565e6b2aa3fac7bacf91f7a04d1df47.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 2/2] sparc: Add architecture support for clone3
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>, davem@davemloft.net, 
	andreas@gaisler.com, brauner@kernel.org, shuah@kernel.org
Cc: sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, arnd@arndb.de, geert@linux-m68k.org, 
	schuster.simon@siemens-energy.com, jrtc27@jrtc27.com
Date: Tue, 20 Jan 2026 19:36:21 +0100
In-Reply-To: <20260119144753.27945-3-ludwig.rydberg@gaisler.com>
References: <20260119144753.27945-1-ludwig.rydberg@gaisler.com>
	 <20260119144753.27945-3-ludwig.rydberg@gaisler.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ludwig,

On Mon, 2026-01-19 at 15:47 +0100, Ludwig Rydberg wrote:
> Add support for the clone3 system call to the SPARC architectures.
>=20
> The implementation follows the pattern of the original clone syscall.
> However, instead of explicitly calling kernel_clone, the clone3
> handler calls the generic sys_clone3 handler in kernel/fork.
> In case no stack is provided, the parents stack is reused.
>=20
> The return value convention for clone3 follows the regular kernel return
> value convention (in contrast to the original clone/fork on SPARC).
>=20
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
>=20
> diff --git a/arch/sparc/include/asm/syscalls.h b/arch/sparc/include/asm/s=
yscalls.h
> index 35575fbfb9dc..282e62b66518 100644
> --- a/arch/sparc/include/asm/syscalls.h
> +++ b/arch/sparc/include/asm/syscalls.h
> @@ -7,5 +7,6 @@ struct pt_regs;
>  asmlinkage long sparc_fork(struct pt_regs *regs);
>  asmlinkage long sparc_vfork(struct pt_regs *regs);
>  asmlinkage long sparc_clone(struct pt_regs *regs);
> +asmlinkage long sparc_clone3(struct pt_regs *regs);
> =20
>  #endif /* _SPARC64_SYSCALLS_H */
> diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/uni=
std.h
> index 3380411a4537..d6bc76706a7a 100644
> --- a/arch/sparc/include/asm/unistd.h
> +++ b/arch/sparc/include/asm/unistd.h
> @@ -49,8 +49,6 @@
>  #define __ARCH_WANT_COMPAT_STAT
>  #endif
> =20
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
> =20
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
> =20
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
> =20
>  #include "kernel.h"
> =20
> @@ -118,3 +119,16 @@ asmlinkage long sparc_clone(struct pt_regs *regs)
> =20
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
> +	cl_args =3D (struct clone_args __user *)regs->u_regs[UREG_I0];
> +	sz =3D regs->u_regs[UREG_I1];
> +
> +	return sys_clone3(cl_args, sz);
> +}
> diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_3=
2.c
> index 5a28c0e91bf1..dd8c6c02b0f1 100644
> --- a/arch/sparc/kernel/process_32.c
> +++ b/arch/sparc/kernel/process_32.c
> @@ -247,6 +247,8 @@ clone_stackframe(struct sparc_stackf __user *dst,
>   * Parent -->  %o0 =3D=3D childs  pid, %o1 =3D=3D 0
>   * Child  -->  %o0 =3D=3D parents pid, %o1 =3D=3D 1
>   *
> + * clone3() - Uses regular kernel return value conventions
> + *
>   * NOTE: We have a separate fork kpsr/kwim because
>   *       the parent could change these values between
>   *       sys_fork invocation and when we reach here
> @@ -261,11 +263,11 @@ extern void ret_from_kernel_thread(void);
>  int copy_thread(struct task_struct *p, const struct kernel_clone_args *a=
rgs)
>  {
>  	u64 clone_flags =3D args->flags;
> -	unsigned long sp =3D args->stack;
>  	unsigned long tls =3D args->tls;
>  	struct thread_info *ti =3D task_thread_info(p);
>  	struct pt_regs *childregs, *regs =3D current_pt_regs();
>  	char *new_stack;
> +	unsigned long sp =3D args->stack ? args->stack : regs->u_regs[UREG_FP];
> =20
>  #ifndef CONFIG_SMP
>  	if(last_task_used_math =3D=3D current) {
> @@ -350,13 +352,22 @@ int copy_thread(struct task_struct *p, const struct=
 kernel_clone_args *args)
>  	childregs->psr &=3D ~PSR_EF;
>  	clear_tsk_thread_flag(p, TIF_USEDFPU);
>  #endif
> +	/* Handle return value conventions */
> +	if (regs->u_regs[UREG_G1] =3D=3D __NR_clone3) {
> +		/* clone3() - use regular kernel return value convention */
> +
> +		/* Set the return value for the child. */
> +		childregs->u_regs[UREG_I0] =3D 0;
> +	} else {
> +		/* clone()/fork() - use SunOS return value convention */
> =20
> -	/* Set the return value for the child. */
> -	childregs->u_regs[UREG_I0] =3D current->pid;
> -	childregs->u_regs[UREG_I1] =3D 1;
> +		/* Set the return value for the child. */
> +		childregs->u_regs[UREG_I0] =3D current->pid;
> +		childregs->u_regs[UREG_I1] =3D 1;
> =20
> -	/* Set the return value for the parent. */
> -	regs->u_regs[UREG_I1] =3D 0;
> +		/* Set the return value for the parent. */
> +		regs->u_regs[UREG_I1] =3D 0;
> +	}
> =20
>  	if (clone_flags & CLONE_SETTLS)
>  		childregs->u_regs[UREG_G7] =3D tls;
> diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_6=
4.c
> index 25781923788a..e889da8e4835 100644
> --- a/arch/sparc/kernel/process_64.c
> +++ b/arch/sparc/kernel/process_64.c
> @@ -564,17 +564,19 @@ void fault_in_user_windows(struct pt_regs *regs)
>   * under SunOS are nothing short of bletcherous:
>   * Parent -->  %o0 =3D=3D childs  pid, %o1 =3D=3D 0
>   * Child  -->  %o0 =3D=3D parents pid, %o1 =3D=3D 1
> + *
> + * clone3() - Uses regular kernel return value conventions
>   */
>  int copy_thread(struct task_struct *p, const struct kernel_clone_args *a=
rgs)
>  {
>  	u64 clone_flags =3D args->flags;
> -	unsigned long sp =3D args->stack;
>  	unsigned long tls =3D args->tls;
>  	struct thread_info *t =3D task_thread_info(p);
>  	struct pt_regs *regs =3D current_pt_regs();
>  	struct sparc_stackf *parent_sf;
>  	unsigned long child_stack_sz;
>  	char *child_trap_frame;
> +	unsigned long sp =3D args->stack ? args->stack : regs->u_regs[UREG_FP];
> =20
>  	/* Calculate offset to stack_frame & pt_regs */
>  	child_stack_sz =3D (STACKFRAME_SZ + TRACEREG_SZ);
> @@ -616,12 +618,25 @@ int copy_thread(struct task_struct *p, const struct=
 kernel_clone_args *args)
>  	if (t->utraps)
>  		t->utraps[0]++;
> =20
> -	/* Set the return value for the child. */
> -	t->kregs->u_regs[UREG_I0] =3D current->pid;
> -	t->kregs->u_regs[UREG_I1] =3D 1;
> +	/* Handle return value conventions */
> +	if (regs->u_regs[UREG_G1] =3D=3D __NR_clone3) {
> +		/* clone3() - use regular kernel return value convention */
> +
> +		/* Set the return value for the child. */
> +		t->kregs->u_regs[UREG_I0] =3D 0;
> +
> +		/* Clear g1 to indicate user thread */
> +		t->kregs->u_regs[UREG_G1] =3D 0;
> +	} else {
> +		/* clone()/fork() - use SunOS return value convention */
> +
> +		/* Set the return value for the child. */
> +		t->kregs->u_regs[UREG_I0] =3D current->pid;
> +		t->kregs->u_regs[UREG_I1] =3D 1;
> =20
> -	/* Set the second return value for the parent. */
> -	regs->u_regs[UREG_I1] =3D 0;
> +		/* Set the second return value for the parent. */
> +		regs->u_regs[UREG_I1] =3D 0;
> +	}
> =20
>  	if (clone_flags & CLONE_SETTLS)
>  		t->kregs->u_regs[UREG_G7] =3D tls;
> diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
> index 0e8ab0602c36..96fe8763d70c 100644
> --- a/arch/sparc/kernel/syscalls.S
> +++ b/arch/sparc/kernel/syscalls.S
> @@ -103,6 +103,12 @@ sys_clone:
>  	ba,pt	%xcc, sparc_clone
>  	 add	%sp, PTREGS_OFF, %o0
> =20
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
> diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/s=
yscalls/syscall.tbl
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

I can confirm that this patch passes both the clone3 selftest from within t=
he
kernel sources in ./tools/testing/selftests/clone3:

root@raverin:/usr/src/linux/tools/testing/selftests/clone3# uname -a
Linux raverin 6.19.0-rc6+ #21 Tue Jan 20 12:41:03 UTC 2026 sparc64 GNU/Linu=
x
root@raverin:/usr/src/linux/tools/testing/selftests/clone3# ./clone3
TAP version 13
1..19
# clone3() syscall supported
# Running test 'simple clone3()'
# [1495] Trying clone3() with flags 0 (size 0)
# I am the parent (1495). My child's pid is 1496
# I am the child, my PID is 1496
# [1495] clone3() with flags says: 0 expected 0
ok 1 simple clone3()
# Running test 'clone3() in a new PID_NS'
# [1495] Trying clone3() with flags 0x20000000 (size 0)
# I am the parent (1495). My child's pid is 1497
# I am the child, my PID is 1
# [1495] clone3() with flags says: 0 expected 0
ok 2 clone3() in a new PID_NS
# Running test 'CLONE_ARGS_SIZE_VER0'
# [1495] Trying clone3() with flags 0 (size 64)
# I am the parent (1495). My child's pid is 1498
# I am the child, my PID is 1498
# [1495] clone3() with flags says: 0 expected 0
ok 3 CLONE_ARGS_SIZE_VER0
# Running test 'CLONE_ARGS_SIZE_VER0 - 8'
# [1495] Trying clone3() with flags 0 (size 56)
# Invalid argument - Failed to create new process
# [1495] clone3() with flags says: -22 expected -22
ok 4 CLONE_ARGS_SIZE_VER0 - 8
# Running test 'sizeof(struct clone_args) + 8'
# [1495] Trying clone3() with flags 0 (size 96)
# I am the parent (1495). My child's pid is 1499
# I am the child, my PID is 1499
# [1495] clone3() with flags says: 0 expected 0
ok 5 sizeof(struct clone_args) + 8
# Running test 'exit_signal with highest 32 bits non-zero'
# [1495] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [1495] clone3() with flags says: -22 expected -22
ok 6 exit_signal with highest 32 bits non-zero
# Running test 'negative 32-bit exit_signal'
# [1495] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [1495] clone3() with flags says: -22 expected -22
ok 7 negative 32-bit exit_signal
# Running test 'exit_signal not fitting into CSIGNAL mask'
# [1495] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [1495] clone3() with flags says: -22 expected -22
ok 8 exit_signal not fitting into CSIGNAL mask
# Running test 'NSIG < exit_signal < CSIG'
# [1495] Trying clone3() with flags 0 (size 0)
# Invalid argument - Failed to create new process
# [1495] clone3() with flags says: -22 expected -22
ok 9 NSIG < exit_signal < CSIG
# Running test 'Arguments sizeof(struct clone_args) + 8'
# [1495] Trying clone3() with flags 0 (size 96)
# I am the parent (1495). My child's pid is 1500
# I am the child, my PID is 1500
# [1495] clone3() with flags says: 0 expected 0
ok 10 Arguments sizeof(struct clone_args) + 8
# Running test 'Arguments sizeof(struct clone_args) + 16'
# [1495] Trying clone3() with flags 0 (size 104)
# Argument list too long - Failed to create new process
# [1495] clone3() with flags says: -7 expected -7
ok 11 Arguments sizeof(struct clone_args) + 16
# Running test 'Arguments sizeof(struct clone_arg) * 2'
# [1495] Trying clone3() with flags 0 (size 104)
# Argument list too long - Failed to create new process
# [1495] clone3() with flags says: -7 expected -7
ok 12 Arguments sizeof(struct clone_arg) * 2
# Running test 'Arguments > page size'
# [1495] Trying clone3() with flags 0 (size 8200)
# Argument list too long - Failed to create new process
# [1495] clone3() with flags says: -7 expected -7
ok 13 Arguments > page size
# Running test 'CLONE_ARGS_SIZE_VER0 in a new PID NS'
# [1495] Trying clone3() with flags 0x20000000 (size 64)
# I am the parent (1495). My child's pid is 1501
# I am the child, my PID is 1
# [1495] clone3() with flags says: 0 expected 0
ok 14 CLONE_ARGS_SIZE_VER0 in a new PID NS
# Running test 'CLONE_ARGS_SIZE_VER0 - 8 in a new PID NS'
# [1495] Trying clone3() with flags 0x20000000 (size 56)
# Invalid argument - Failed to create new process
# [1495] clone3() with flags says: -22 expected -22
ok 15 CLONE_ARGS_SIZE_VER0 - 8 in a new PID NS
# Running test 'sizeof(struct clone_args) + 8 in a new PID NS'
# [1495] Trying clone3() with flags 0x20000000 (size 96)
# I am the parent (1495). My child's pid is 1502
# I am the child, my PID is 1
# [1495] clone3() with flags says: 0 expected 0
ok 16 sizeof(struct clone_args) + 8 in a new PID NS
# Running test 'Arguments > page size in a new PID NS'
# [1495] Trying clone3() with flags 0x20000000 (size 8200)
# Argument list too long - Failed to create new process
# [1495] clone3() with flags says: -7 expected -7
ok 17 Arguments > page size in a new PID NS
# Time namespaces are not supported
ok 18 # SKIP New time NS
# Running test 'exit signal (SIGCHLD) in flags'
# [1495] Trying clone3() with flags 0x14 (size 0)
# Invalid argument - Failed to create new process
# [1495] clone3() with flags says: -22 expected -22
ok 19 exit signal (SIGCHLD) in flags
# 1 skipped test(s) detected. Consider enabling relevant config options to =
improve coverage.
# Totals: pass:18 fail:0 xfail:0 xpass:0 skip:1 error:0
root@raverin:/usr/src/linux/tools/testing/selftests/clone3#

and the libcamera build and testsuite:

Ok:                38
Expected Fail:     1
Fail:              0
Skipped:           31

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

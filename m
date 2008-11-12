From: David Miller <davem@davemloft.net>
Date: Wed, 12 Nov 2008 21:49:20 +0000
Subject: Re: [PATCH] sparc64: add function save_stack_trace_tsk()
Message-Id: <20081112.134920.37006534.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081112134749.GD12456@orion>
In-Reply-To: <20081112134749.GD12456@orion>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: a.beregalov@gmail.com
Cc: sparclinux@vger.kernel.org, linux-next@vger.kernel.org, kenchen@google.com, mingo@elte.hu, adobriyan@gmail.com

From: Alexander Beregalov <a.beregalov@gmail.com>
Date: Wed, 12 Nov 2008 16:47:49 +0300

> Current -next does not build on sparc64:
>   LD      .tmp_vmlinux1
>   fs/built-in.o: In function `proc_pid_stack':
>   /home/alexb/linux-2.6/fs/proc/base.c:360: undefined reference to
>   `save_stack_trace_tsk'
> 
> ---
> 
>   Add function save_stack_trace_tsk() on sparc64.
> 
> 
> Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>

This won't work as-is.

The save_stack_trace() function starts with the actual frame-pointer
register in the current cpu to start winding back the stack.  So
when 'tsk' is not 'current' nothing will be saved.  That's what this
bit of code is doing:

	__asm__ __volatile__(
		"mov	%%fp, %0"
		: "=r" (ksp)
	);

	fp = ksp + STACK_BIAS;

Also, "stack_trace_flush()" should only be run when current = tsk.

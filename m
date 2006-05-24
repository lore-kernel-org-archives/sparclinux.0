From: David Miller <davem@davemloft.net>
Date: Wed, 24 May 2006 21:21:09 +0000
Subject: Re: sigreturn on sparc64
Message-Id: <20060524.142109.41635091.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <e5270r$q83$1@terminus.zytor.com>
In-Reply-To: <e5270r$q83$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 24 May 2006 11:00:59 -0700 (PDT)

> I'm having an issue with klibc on sparc64 (i.e. a 64-bit userspace
> binary), which doesn't appear on sparc32:
> 
> If I leave the signal restorer function as NULL, I get a SIGSEGV on
> attempting to return from the signal handler.
> 
> If I generate a system call stub for rt_sigreturn, and pass that in as
> the restorer, then the process will loop forever on signal handler
> return.
> 
> A lot of architectures have ugly corners in this area (i386, for
> example, needs to drop one word from the stack before calling the
> sigreturn system call.)  However, I simply don't understand the SPARC
> architecture well enough to understand if/what I'm supposed to do
> here, or if this is simply a bug.

GLIBC is the source of all knowledge :-)

libc/sysdeps/unix/sysv/linux/sparc/sparc64/sigaction.c

In there you'll see that you have to set the sa_restorer
to NULL and pass in the "stub" address minus 8, as the
4th argument to rt_sigation system call.

The "stub" is simply:

stub:
	mov	__NR_rt_sigreturn
	ta	0x6d

on sparc64.  So:

	sys_rt_sigation(signr, &action, &old_action, &stub - 0x8, _NSIG/8);

Hope this helps.

From: David Miller <davem@davemloft.net>
Date: Tue, 10 Mar 2009 00:06:37 +0000
Subject: Re: Signal handler arguments
Message-Id: <20090309.170637.66134349.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49B543AF.4090902@users.sourceforge.net>
In-Reply-To: <49B543AF.4090902@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Elad Lahav <elad_lahav@users.sourceforge.net>
Date: Mon, 09 Mar 2009 12:28:31 -0400

> According to the man page (which, I believe, conforms to the POSIX standard), the third argument in a signal handler should be a pointer to a ucontext structure (assuming the SA_SIGINFO flag was passed to sigaction). However, under Sparc64, the kernel passes a pointer to a sigcontext structure (see line 472 in arch/sparc64/kernel/signal.c). This incompatibility should be either fixed or documented.

It's passing a siginfo_t as both the second and third argument:

struct rt_signal_frame {
	struct sparc_stackf	ss;
	siginfo_t		info;
    ...
static inline void
setup_rt_frame(struct k_sigaction *ka, struct pt_regs *regs,
	       int signo, sigset_t *oldset, siginfo_t *info)
{
    ...
	struct rt_signal_frame __user *sf;
    ...
	regs->u_regs[UREG_I0] = signo;
	regs->u_regs[UREG_I1] = (unsigned long) &sf->info;
	/* The sigcontext is passed in this way because of how it
	 * is defined in GLIBC's /usr/include/bits/sigcontext.h
	 * for sparc64.  It includes the 128 bytes of siginfo_t.
	 */
	regs->u_regs[UREG_I2] = (unsigned long) &sf->info;

The sigaction man page says:

              struct sigaction {
                  void     (*sa_handler)(int);
                  void     (*sa_sigaction)(int, siginfo_t *, void *);
                  sigset_t   sa_mask;
                  int        sa_flags;
                  void     (*sa_restorer)(void);
              }

The actual type of the third argument is architecture independant,
that is why it is defined as "void *" rather than a specific type.

Which is effectively a "sigcontext" which on sparc64 is defined as a
structure containing a siginfo_t then the register information.  See
/usr/include/bits/sigcontext.h

Yes it says ucontext_t and sparc is the lone-wolf out here.

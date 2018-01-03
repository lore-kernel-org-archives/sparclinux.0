From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 03 Jan 2018 22:49:52 +0000
Subject: Re: sending SIGFPE via kill() returns wrong values in si_pid and si_uid
Message-Id: <87k1wyy2un.fsf@xmission.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1942316.IfptgDaGPd@eto>
In-Reply-To: <1942316.IfptgDaGPd@eto>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Rolf Eike Beer <eike-kernel@sf-tec.de> writes:

> This originally came up as a failure in the testsuite of strace on Gentoo 
> (T5120, 64 bit kernel, 32 bit userspace) and was reported here: 
> https://bugs.gentoo.org/643060. This was then reported upstream here: 
> https://github.com/strace/strace/issues/21 . I'll paste the relevant parts of
> those bugs here.
>
> The test program is as follows (done by Dmitry V. Levin): 
>
> #include <assert.h>
> #include <signal.h>
> #include <stdio.h>
> #include <unistd.h>
>
> static void
> handler(int sig, siginfo_t *info, void *ucontext)
> {
>
> fprintf(stderr, "sig=%d, si_signo=%d, si_pid=%d, si_uid=%d\n",
> 	sig, info->si_signo, info->si_pid, info->si_uid);
> }
>
> static void
> setup(int sig, sigset_t *mask)
> {
>
> static const struct sigaction act = { .sa_sigaction = handler, .sa_flags = SA_SIGINFO };
> assert(!sigaction(sig, &act, NULL));
> assert(!sigaddset(mask, sig));
> }
>
> static void
> test(int sig)
> {
>
> assert(!raise(sig));
> assert(!kill(getpid(), sig));
> }
>
> int
> main(void)
> {
>
> sigset_t mask;
> assert(!sigemptyset(&mask));
>
> setup(SIGFPE, &mask);
> setup(SIGTERM, &mask);
>
> assert(!sigprocmask(SIG_UNBLOCK, &mask, NULL));
>
> test(SIGFPE);
> test(SIGTERM);
>
> return 0;
> }
>
> Running this on sparc64 userspace works fine:
>
> sig=8, si_signo=8, si_pid5186, si_uid08
> sig=8, si_signo=8, si_pid5186, si_uid08
> sig, si_signo, si_pid5186, si_uid08
> sig, si_signo, si_pid5186, si_uid08
>
> However, on sparc32 things go wrong:
>
> sig=8, si_signo=8, si_pid5192, si_uid08
> sig=8, si_signo=8, si_pid08, si_uid=0
> sig, si_signo, si_pid5192, si_uid08
> sig, si_signo, si_pid5192, si_uid08
>
> When digging the code up and down I came up with this patch, which fixes the 
> issue for me:
>
> diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
> index 54a6159b9cd8..a05e271e0924 100644
> --- a/arch/sparc/kernel/signal32.c
> +++ b/arch/sparc/kernel/signal32.c
> @@ -87,7 +87,7 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, 
>         err = __put_user(from->si_signo, &to->si_signo);
>         err |= __put_user(from->si_errno, &to->si_errno);
>         err |= __put_user(from->si_code, &to->si_code);
> -       if (from->si_code < 0)
> +       if (SI_FROMUSER(from))
>                 err |= __copy_to_user(&to->_sifields._pad, &from->_sifields._pad, SI_PAD_SIZE);
>         else {
>                 switch (siginfo_layout(from->si_signo, from->si_code)) {
>
> I suspect it was broken by cc731525f26af85a1c3537da41e0abd1d35e0bdb as it is 
> reported that it worked in 4.5.0. Looking at that commit other archs (at least 
> arm64, mips, parisc, powerpc, s390, tile, x86) have the same code, but 
> different default-cases. From a quick glance arm64, parisc, and x86 do not 
> have a default case anymore since that commit, while the others do not seem to 
> have changed their default case. However it could be that siginfo_layout() 
> behaves slightly different than the mask code used before in the switch 
> statements. I'm currently building a 4.14.9 kernel for my HP C8000, will 
> report the test results once that is done.

That is definitely the wrong fix.
However it does verify that your si_code is SI_USER.

The issue is that sparc has ambiguous signal handling, and
si_code of 0 combined with the signal SIGFPE could be either
a real floating point signal or a signal sent with kill.

As it is pointless to send yourself a signal with kill I choose to
preserve the floating point signal.   That is the test is not actually
testing floating point SIGFPE so I don't know that it makes much sense.

I do have some further fixes that I was planning on testing and applying
but I ran out of time to finish last year so I will see about digging
those up.  It is definitely wrong to allow sending SIGFPE to yourself
whent si_code = SI_USER when SIGFPE_FIXME is defined.  I should fix
that as well.

Ideally someone will go through sparc and look at
arch/sparc/kernel/traps_32.c:do_fpe_trap and
arch/sparc/kernel/traps_64.c:do_fpe_common and see if they can remove
the need for FPE_FIXME (aka SI_USER, aka 0).

Eric

From: David Miller <davem@davemloft.net>
Date: Wed, 09 Jan 2008 11:46:36 +0000
Subject: Re: Compile-time error with gcc-4.3 on sparc64
Message-Id: <20080109.034636.115329743.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <e02b4fed0801090131h40b0e236t49cc0ae4ac147d5c@mail.gmail.com>
In-Reply-To: <e02b4fed0801090131h40b0e236t49cc0ae4ac147d5c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: taldmd@gmail.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: "David Martin" <taldmd@gmail.com>
Date: Wed, 9 Jan 2008 10:31:45 +0100

Please report sparc problems to the Sparc mailing list,
sparclinux@vger.kernel.org, thanks.

> I get the following error compiling latest kernel from git on sparc64
> using gcc-4.3:
>=20
>   CC      arch/sparc64/kernel/signal.o
> cc1: warnings being treated as errors
> arch/sparc64/kernel/signal.c: En la funci=F3n 'do_notify_resume':
> include/asm/uaccess.h:233: error: el sub=EDndice de la matriz est=E1 por
> arriba de los l=EDmites de la matriz
> make[1]: *** [arch/sparc64/kernel/signal.o] Error 1
> make: *** [arch/sparc64/kernel] Error 2
>=20
> ("On function 'do_notify resume: error: matrix subindex is over matrix li=
mits")

I think you mean "array" instead of "matrix" in your translation.

In fact, you should rerun should build failures with "LANG=3DC"
for the benefit of people reading your report.

Something is very wrong with the compiler, do_notify_resume() reads:

void do_notify_resume(struct pt_regs *regs, unsigned long orig_i0, int rest=
art_syscall,
		      unsigned long thread_info_flags)
{
	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK))
		do_signal(regs, orig_i0, restart_syscall);
}

uaccess.h, line 233 is:

static inline unsigned long __must_check
copy_to_user(void __user *to, const void *from, unsigned long size)
{
	unsigned long ret =3D ___copy_to_user(to, from, size);
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

copy_to_user() isn't being called in do_notify_resume() at all.

Perhaps it's probably warning about some call to copy_to_user() that
results from the inline expansion of do_signal() and all sub-calls.

But it's a bug that GCC isn't indicating exactly where the problem is,
and in what specific function.  My guess is that it's losing context
during all of the inline expansions.

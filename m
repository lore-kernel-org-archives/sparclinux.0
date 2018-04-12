From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Thu, 12 Apr 2018 12:19:49 +0000
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via kill() returns wrong values in 
Message-Id: <20180412121949.GD16141@n2100.armlinux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk>
 <20180412110314.GA28070@altlinux.org>
In-Reply-To: <20180412110314.GA28070@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Apr 12, 2018 at 02:03:14PM +0300, Dmitry V. Levin wrote:
> On Thu, Apr 12, 2018 at 10:58:11AM +0100, Russell King - ARM Linux wrote:
> > On Thu, Apr 12, 2018 at 04:34:35AM +0300, Dmitry V. Levin wrote:
> > > A similar commit v4.16-rc1~159^2~37
> > > ("signal/arm: Document conflicts with SI_USER and SIGFPE") must have
> > > introduced a similar ABI regression to compat arm.
> > 
> > So, could you explain how can this change cause a regression?
> > 
> > +#define FPE_FIXME      0
> > -               vfp_raise_sigfpe(0, regs);
> > +               vfp_raise_sigfpe(FPE_FIXME, regs);
> 
> No, this hunk hasn't caused the regression, but another one did:
> 
> diff --git a/arch/arm/include/uapi/asm/siginfo.h b/arch/arm/include/uapi/asm/siginfo.h
> new file mode 100644
> index 0000000..d051388
> --- /dev/null
> +++ b/arch/arm/include/uapi/asm/siginfo.h
> @@ -0,0 +1,13 @@
> +#ifndef __ASM_SIGINFO_H
> +#define __ASM_SIGINFO_H
> +
> +#include <asm-generic/siginfo.h>
> +
> +/*
> + * SIGFPE si_codes
> + */
> +#ifdef __KERNEL__
> +#define FPE_FIXME      0       /* Broken dup of SI_USER */
> +#endif /* __KERNEL__ */
> +
> +#endif
> 
> This is due to FPE_FIXME handling in kernel/signal.c

Building strace 4.22 on ARM and running the test suite reveals no
problems with the signal_receive test, tested on both 4.14 and 4.16
kernels - there's no "KERNEL BUG" reports in any of the test results.
However, stock strace 4.22 source doesn't appear to contain the
"KERNEL BUG" string anywhere, so this may be a Suse specific addition
to the test:

~/src/strace-4.22$ grep -ri 'KERNEL BUG' .
./strace.1:Arguably, every instance of such behavior is a kernel bug.)
./strace.1.in:Arguably, every instance of such behavior is a kernel bug.)
./NEWS:  * Worked around a kernel bug in tracing privileged executables.
./ChangeLog:    aarch64: workaround gcc+kernel bug.
./ChangeLog:    tests: workaround kernel bugs in seccomp-strict.test and prctl-seccomp-strict.test
./ChangeLog:    instead.  We don't want the testsuite failing due to kernel bugs.
./ChangeLog:    First guess is that it's a workaround for old kernel bugs:
./ChangeLog:    This kernel bug is fixed long ago. This change removes the workaround.

Any ideas where the "KERNEL BUG" in Suse builds is coming from?  Any
ideas how to test it on other architectures (iow, where can we get
source that contains this test?)

Based on previous experience, unfortunately folk don't tend to report
user ABI regressions to kernel developers, so we'd probably never know
that there's a problem - I do think the safer thing would've been to
leave it well alone, and just accept that we'll end up copying more
words to userspace than is actually intended.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

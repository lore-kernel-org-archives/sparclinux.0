From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Fri, 13 Apr 2018 09:42:11 +0000
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via kill() returns wrong values in 
Message-Id: <20180413094211.GN16141@n2100.armlinux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk>
 <20180412110314.GA28070@altlinux.org>
 <20180412121949.GD16141@n2100.armlinux.org.uk>
 <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk>
 <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
 <20180412172051.GK16141@n2100.armlinux.org.uk>
 <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
In-Reply-To: <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Apr 12, 2018 at 10:22:15AM -0700, Linus Torvalds wrote:
> On Thu, Apr 12, 2018 at 10:20 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > This file was created to contain FPE_FIXME, by the "signal/arm: Document
> > conflicts with SI_USER and SIGFPE" commit so if we're removing it, it
> > would be better to remove the whole file.
> 
> Fair enough. I'm not going to commit that anyway since I can't test
> it, but yes, if it tests ok that sounds like the right thing to do.

Yes, it does solve the problem at hand with strace - the exact patch I
tested against 4.16 is below.

Testing this exact code path (exceptions set to VFP_EXCEPTION_ERROR)
is something that can only happen if the hardware does something stupid,
and I don't have a way of making it do that, so the code path can't be
tested.

However, FPE_FLTUNK is not defined in older kernels, so while we can
fix it this way for the current merge window, that doesn't help 4.16.
How we solve that depends what happens with Eric's patch (266da65e9156
("signal: Add FPE_FLTUNK si_code for undiagnosable fp exceptions"))
that introduces FPE_FLTUNK - and there's also the problem of NSIGFPE,
which kernel/signal.c uses in the path that selects the siginfo layout.

Given that the path we're talking about is unlikely to happen (as
mentioned in my second paragraph) I still think reverting Eric's patch
is the right way forward for older kernels.

(Note, my previous comment about the si_code initialiser was incorrect.)

diff --git a/arch/arm/include/uapi/asm/siginfo.h b/arch/arm/include/uapi/asm/siginfo.h
deleted file mode 100644
index d0513880be21..000000000000
--- a/arch/arm/include/uapi/asm/siginfo.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __ASM_SIGINFO_H
-#define __ASM_SIGINFO_H
-
-#include <asm-generic/siginfo.h>
-
-/*
- * SIGFPE si_codes
- */
-#ifdef __KERNEL__
-#define FPE_FIXME	0	/* Broken dup of SI_USER */
-#endif /* __KERNEL__ */
-
-#endif
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 4c375e11ae95..8a1a5e6048d2 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -28,6 +28,10 @@
 #include <asm/thread_notify.h>
 #include <asm/vfp.h>
 
+#ifndef FPE_FLTUNK
+#define FPE_FLTUNK 14
+#endif
+
 #include "vfpinstr.h"
 #include "vfp.h"
 
@@ -257,7 +261,7 @@ static void vfp_raise_exceptions(u32 exceptions, u32 inst, u32 fpscr, struct pt_
 
 	if (exceptions = VFP_EXCEPTION_ERROR) {
 		vfp_panic("unhandled bounce", inst);
-		vfp_raise_sigfpe(FPE_FIXME, regs);
+		vfp_raise_sigfpe(FPE_FLTUNK, regs);
 		return;
 	}
 


-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

From: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 18 Nov 2015 00:23:19 +0000
Subject: Re: [powerpc:test 7/8] include/math-emu/quad.h:72:1: error: unable to emulate 'TF'
Message-Id: <1447806199.10464.2.camel@ellerman.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <201511171656.yqpXMbFx%fengguang.wu@intel.com>
 <alpine.DEB.2.10.1511171542010.14808@digraph.polyomino.org.uk>
In-Reply-To: <alpine.DEB.2.10.1511171542010.14808@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joseph Myers <joseph@codesourcery.com>, kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org

Hi Joseph,

On Tue, 2015-11-17 at 15:55 +0000, Joseph Myers wrote:

> On Tue, 17 Nov 2015, kbuild test robot wrote:

> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git test
> > head:   e37d8480fbd6b9ad3665ac85a903098413ba67ae
> > commit: 71fa67f178c6c3c338d0b99644bce808f2f0965e [7/8] sparc/math-emu: Move sparc from math-emu-old to math-emu
> > config: sparc-defconfig (attached as .config)
> > reproduce:
> >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 71fa67f178c6c3c338d0b99644bce808f2f0965e
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=sparc 
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from arch/sparc/math-emu/math_32.c:77:0:

> > > > include/math-emu/quad.h:72:1: error: unable to emulate 'TF'
> >     typedef float TFtype __attribute__ ((mode (TF)));
> 
> Is this with a compiler that defaults to -mlong-double-64 (which is, I 
> think, now an unusual configuration on SPARC - it might arise for 
> bootstrap compilers, but any normal distribution compiler should default 
> to -mlong-double-128)?

FWIW this built OK with my sparc compiler which is 4.6.3, I don't know what
compiler the robot is using:

http://kisskb.ellerman.id.au/kisskb/buildresult/12549136/

> If so, the old code would have been quietly building with a union that 
> contains the "wrong" long double type, when using such a compiler.  And 
> actually I think that because of the particular subset of macros used, 
> this would have worked; the long double member of the union wouldn't have 
> been used in this code.
> 
> My inclination would be to use
> 
> CFLAGS_math_32.o = -mlong-double-128
> CFLAGS_math_64.o = -mlong-double-128
> 
> in arch/sparc/math-emu/Makefile to fix this properly (the "unable to 
> emulate" error is for modes that fail GCC's scalar_mode_supported_p hook, 
> which by default allows the modes for all standard types, hence an error 
> for -mlong-double-64 when TFmode isn't used by a standard type).  Untested 
> incremental patch follows.
> 
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>

> diff --git a/arch/sparc/math-emu/Makefile b/arch/sparc/math-emu/Makefile
> index 825dbee..6df8769 100644
> --- a/arch/sparc/math-emu/Makefile
> +++ b/arch/sparc/math-emu/Makefile
> @@ -5,4 +5,9 @@
>  # suppress all warnings - as math.c produces a lot!
>  ccflags-y := -w
>  
> +# Emulation of quad instructions requires -mlong-double-128 for
> +# __attribute__ ((mode (TF))) to be accepted.
> +CFLAGS_math_32.o = -mlong-double-128
> +CFLAGS_math_64.o = -mlong-double-128
> +
>  obj-y    := math_$(BITS).o

Thanks. I'll take this patch for now and repush the branch to see if it fixes
the build error.

I cobbled together a commit message which is hopefully vaguely correct:

    sparc/math-emu: Use -mlong-double-128

    The updated math-emu code requires -mlong-double-128 in order to
    compile, otherwise on some compilers we see errors:

        In file included from arch/sparc/math-emu/math_32.c:77:0:
        include/math-emu/quad.h:72:1: error: unable to emulate 'TF'
        typedef float TFtype __attribute__ ((mode (TF)));

    Add -mlong-double-128 in arch/sparc/math-emu/Makefile to fix this
    properly (the "unable to emulate" error is for modes that fail GCC's
    scalar_mode_supported_p hook, which by default allows the modes for all
    standard types, hence an error for -mlong-double-64 when TFmode isn't
    used by a standard type).

    Signed-off-by: Joseph Myers <joseph@codesourcery.com>


cheers


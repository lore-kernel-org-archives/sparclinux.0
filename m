From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Fri, 12 May 2006 12:33:27 +0000
Subject: Re: [PATCH] sparc: cannot load any modules with 2.6.17-rc3
Message-Id: <20060512123326.GA19248@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20060511180731.GB16957@palantir8>
In-Reply-To: <20060511180731.GB16957@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, May 11, 2006 at 12:21:00PM -0700, David S. Miller wrote:
> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Thu, 11 May 2006 19:07:32 +0100
> 
> > +		case R_SPARC_UA32:	/* Like R_SPARC_32 but unaligned */
> > +			uv = (u8 *) v;
> > +			location[0] = uv[0];
> > +			location[1] = uv[1];
> > +			location[2] = uv[2];
> > +			location[3] = uv[3];
> > +			break;
> > +
> 
> This is not correct.
> 
> The relocation puts "value v" at "location" not "data at address v" at
> "location", the latter of which is what your patch is trying to do.

Hmm, yeah. It did not feel right after a night's sleep.

> Simply adding "case R_SPARC_UA32:" right under "case R_SPARC_32:"
> would work just fine since the R_SPARC_32 code already handles
> arbitrary alignment of "location" which is the crucial difference
> between R_SPARC_32 and R_SPARC_UA32.
> 
> I still wonder where you're getting that relocation from.  It must be
> emitted by some dwarf2 frame unwind stuff.  It's a shame that such
> bloat is aparently being emitted into objects by default.

I've checked the .ko files, R_SPARC_UA32 is only used in the '.rela.eh_frame'
section.

The build command is:
  gcc -Wp,-MD,lib/.crc32.o.d  -nostdinc -isystem /usr/lib/gcc-lib/sparc-linux/3.3.5/include -D__KERNEL__ 
-Iinclude  -include include/linux/autoconf.h -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs 
-fno-strict-aliasing -fno-common -O2 -fomit-frame-pointer -fasynchronous-unwind-tables -m32 -pipe -mno-fpu 
-fcall-used-g5 -fcall-used-g7     -DMODULE -D"KBUILD_STR(s)=#s" -D"KBUILD_BASENAME=KBUILD_STR(crc32)"  
-D"KBUILD_MODNAME=KBUILD_STR(crc32)" -c -o lib/crc32.o lib/crc32.c

The -fasynchronous-unwind-tables caught my eye. Leaving it out caused the
'.rela.eh_frame' section not to be generated at all (module loads ok as well).
I've tried -funwind-tables, but that generated the same '.rela.eh_frame'
section as with -fasynchronous-unwind-tables.

> Can you send me a sample object that has such a relocation again?  I
> don't want to add support for this relocation if it really is not
> needed.  I'm hoping we can add a compiler option that will make this
> cruft not get output by the compiler since it is superfluous and of
> no use in the kernel build.

I've uploaded the following to http://www.mph.eclipse.co.uk/pub/linux/
crc32.o
crc32.ko
crc32.2
these are all generated using the standard build options (without any
modifications by me).

-- 
Martin

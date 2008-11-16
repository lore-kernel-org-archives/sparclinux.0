From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 16 Nov 2008 10:45:28 +0000
Subject: Re: [PATCH] sparc,sparc64: add BITS to arch Makefile
Message-Id: <20081116104528.GA12911@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1226825821-10125-2-git-send-email-sam@ravnborg.org>
In-Reply-To: <1226825821-10125-2-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Nov 16, 2008 at 09:17:08PM +1100, Julian Calaby wrote:
> On Sun, Nov 16, 2008 at 19:56, Sam Ravnborg <sam@ravnborg.org> wrote:
> > BITS will be used to simplify unified Makefiles
> >
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > ---
> >  arch/sparc/Makefile   |    7 ++++---
> >  arch/sparc64/Makefile |    4 ++--
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
> > index 9592889..c5f3d6f 100644
> > --- a/arch/sparc/Makefile
> > +++ b/arch/sparc/Makefile
> > @@ -11,9 +11,10 @@
> >  # Uncomment the first KBUILD_CFLAGS if you are doing kgdb source level
> >  # debugging of the kernel to get the proper debugging information.
> >
> > -AS              := $(AS) -32
> > -LDFLAGS                := -m elf32_sparc
> > -CHECKFLAGS     += -D__sparc__
> > +AS             := $(AS) -32
> > +LDFLAGS        := -m elf32_sparc
> > +CHECKFLAGS     += -D__sparc__
> 
> Is there any actual change with these lines? - I can't see any.

The assignments are aligned nicely.

> 
> > +export BITS    := 32
> >
> >  #KBUILD_CFLAGS += -g -pipe -fcall-used-g5 -fcall-used-g7
> >  KBUILD_CFLAGS += -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
> > diff --git a/arch/sparc64/Makefile b/arch/sparc64/Makefile
> > index c7214ab..51bc33a 100644
> > --- a/arch/sparc64/Makefile
> > +++ b/arch/sparc64/Makefile
> > @@ -12,8 +12,8 @@ CHECKFLAGS    += -D__sparc__ -D__sparc_v9__ -D__arch64__ -m64
> >  # Undefine sparc when processing vmlinux.lds - it is used
> >  # And teach CPP we are doing 64 bit builds (for this case)
> >  CPPFLAGS_vmlinux.lds += -m64 -Usparc
> > -
> > -LDFLAGS                := -m elf64_sparc
> > +LDFLAGS              := -m elf64_sparc
> 
> Ditto.

Same goes here.

	Sam

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 03 Apr 2019 12:20:04 +0000
Subject: Re: [PATCH] sparc: vdso: add FORCE to the build rule of %.so
Message-Id: <CAK7LNARbmuCKjkMP-_ZNLUm1XBjxG7RoMJf5-xcNjnv5rVwVOw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1554280344-10741-1-git-send-email-yamada.masahiro@socionext.com> <CAKwvOdkrMB-pvjhuFXPCb-v-6nRkRcm+y5iApNcJHiTd=bdeaw@mail.gmail.com>
In-Reply-To: <CAKwvOdkrMB-pvjhuFXPCb-v-6nRkRcm+y5iApNcJHiTd=bdeaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, Ingo Molnar <mingo@kernel.org>

On Wed, Apr 3, 2019 at 7:36 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> $ grep -r 'call if_changed,' -B
>
> shows a few more FWIW:
>
> drivers/scsi/Makefile
> drivers/gpu/drm/radeon/Makefile
> arch/c6x/boot/Makefile
> arch/arm64/kernel/vdso/Makefile
> arch/x86/entry/vdso/Makefile
> arch/x86/entry/syscalls/Makefile
> arch/powerpc/platforms/cell/spufs/Makefile
> arch/powerpc/kernel/syscalls/Makefile
> arch/alpha/kernel/syscalls/Makefile
> arch/sparc/boot/Makefile
> arch/sparc/kernel/syscalls/Makefile
> arch/mips/kernel/syscalls/Makefile
> arch/h8300/boot/Makefile
> arch/nios2/boot/Makefile
> arch/ia64/kernel/syscalls/Makefile
> arch/microblaze/boot/dts/Makefile
> arch/microblaze/kernel/syscalls/Makefile
> arch/csky/boot/Makefile
> arch/xtensa/kernel/syscalls/Makefile
> arch/sh/boot/Makefile
> arch/sh/kernel/syscalls/Makefile
> arch/parisc/boot/compressed/Makefile
> arch/parisc/kernel/syscalls/Makefile
> arch/m68k/kernel/syscalls/Makefile
>

I sent patches for vdso Makefiles, but
lots of Makefiles are still wrong.

Your contribution is appreciated.  :)


> On Wed, Apr 3, 2019 at 3:32 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > $(call if_changed,...) must have FORCE as a prerequisite.
>
> According to Documentation/kbuild/makefiles.txt#L1064:
> ```
> Note: It is a typical mistake to forget the FORCE prerequisite.
> ```

Yeah, people often miss to add this.

There is one more thing people often miss:

 "Any target that utilises if_changed must be listed in $(targets),
  otherwise the command line check will fail, and the target will
  always be built."





> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/sparc/vdso/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> > index 74e97f7..83c4b46 100644
> > --- a/arch/sparc/vdso/Makefile
> > +++ b/arch/sparc/vdso/Makefile
> > @@ -68,7 +68,7 @@ CFLAGS_REMOVE_vdso-note.o = -pg
> >  CFLAGS_REMOVE_vclock_gettime.o = -pg
> >
> >  $(obj)/%.so: OBJCOPYFLAGS := -S
> > -$(obj)/%.so: $(obj)/%.so.dbg
> > +$(obj)/%.so: $(obj)/%.so.dbg FORCE
> >         $(call if_changed,objcopy)
> >
> >  CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
> > --
> > 2.7.4
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--
Best Regards

Masahiro Yamada
